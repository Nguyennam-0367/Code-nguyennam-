<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.mycompany.hotelmumanage.model.User"%>
<%
    User u = (User) session.getAttribute("user");
    boolean quanLy = u != null && "QUAN_LY".equals(u.getVaiTro());
    String ctx = request.getContextPath();
    String home = ctx + (quanLy ? "/quanly" : "/letan") + "/home";

    String[][] menu = {
        {"tongquan", quanLy ? "Dashboard" : "Trang chủ", quanLy ? "Bảng điều khiển quản lý" : "Quầy lễ tân"},
        {"phong", "Phòng", "Quản lý phòng"},
        {"datphong", "Đặt phòng", "Quản lý đặt phòng"},
        {"checkin", "Check-in / Check-out", "Check-in / Check-out"},
        {"khachhang", "Khách hàng", "Quản lý khách hàng"},
        {"dichvu", "Dịch vụ", "Quản lý dịch vụ"},
        {"hoadon", "Hoá đơn", "Hoá đơn và thanh toán"},
        {"nhanvien", "Nhân viên", "Quản lý nhân viên"}
    };

    String trang = request.getParameter("trang");
    boolean hopLe = false;
    for (String[] m : menu) {
        if (m[0].equals(trang) && !("nhanvien".equals(m[0]) && !quanLy)) hopLe = true;
    }
    if (!hopLe) trang = "tongquan";

    String title = "";
    for (String[] m : menu) { if (m[0].equals(trang)) title = m[2]; }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%= title %> - YOU'LL NEVER WALK ALONE HOTEL</title>
        <link rel="stylesheet" href="<%= ctx %>/static/css/style.css">
    </head>
    <body>
        <div class="app">

            <aside class="sidebar">
                <div class="brand">
                    <h1>YOU'LL NEVER WALK ALONE</h1>
                    <span>HOTEL</span>
                </div>
                <% for (String[] m : menu) { if ("nhanvien".equals(m[0]) && !quanLy) continue; %>
                    <a href="<%= home %>?trang=<%= m[0] %>" class="<%= m[0].equals(trang) ? "active" : "" %>"><%= m[1] %></a>
                <% } %>
            </aside>

            <div class="main">
                <div class="topbar">
                    <h2><%= title %></h2>
                    <div class="user">
                        <span><%= u.getTenDangNhap() %> (<%= quanLy ? "Quản lý" : "Lễ tân" %>)</span>
                        <a href="<%= ctx %>/logout" class="btn">ĐĂNG XUẤT</a>
                    </div>
                </div>

                <div class="content">

                <% if ("tongquan".equals(trang)) { %>

                    <% if (quanLy) { %>
                    <div class="stats">
                        <div class="stat"><div class="num">--</div><div class="label">Phòng trống</div></div>
                        <div class="stat"><div class="num">--</div><div class="label">Đang lưu trú</div></div>
                        <div class="stat"><div class="num">--</div><div class="label">Đặt phòng chờ xác nhận</div></div>
                        <div class="stat"><div class="num">--</div><div class="label">Doanh thu hôm nay</div></div>
                    </div>
                    <% } else { %>
                    <div class="stats">
                        <div class="stat"><div class="num">--</div><div class="label">Khách check-in hôm nay</div></div>
                        <div class="stat"><div class="num">--</div><div class="label">Khách check-out hôm nay</div></div>
                        <div class="stat"><div class="num">--</div><div class="label">Yêu cầu chờ xác nhận</div></div>
                    </div>
                    <% } %>

                    <div class="panel">
                        <h3>Thao tác nhanh</h3>
                        <div class="quick">
                            <a href="<%= home %>?trang=datphong">Tạo đặt phòng</a>
                            <a href="<%= home %>?trang=checkin">Check-in</a>
                            <a href="<%= home %>?trang=checkin">Check-out</a>
                            <a href="<%= home %>?trang=khachhang">Thêm khách hàng</a>
                            <a href="<%= home %>?trang=hoadon">Tạo hoá đơn</a>
                        </div>
                    </div>

                    <div class="panel">
                        <h3>Đặt phòng gần đây</h3>
                        <table>
                            <tr><th>Mã</th><th>Khách hàng</th><th>Phòng</th><th>Ngày đến</th><th>Trạng thái</th></tr>
                            <tr><td colspan="5" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } else if ("phong".equals(trang)) { %>

                    <div class="panel">
                        <div class="toolbar">
                            <input type="text" placeholder="Tìm số phòng, loại phòng...">
                            <div>
                                <% if (quanLy) { %>
                                    <a href="#" class="btn-sm">+ Thêm phòng</a>
                                    <a href="#" class="btn-sm">Loại phòng</a>
                                <% } else { %>
                                    <a href="#" class="btn-sm">Đổi trạng thái phòng</a>
                                <% } %>
                            </div>
                        </div>
                        <table>
                            <tr><th>Số phòng</th><th>Loại phòng</th><th>Giá / đêm</th><th>Tình trạng</th></tr>
                            <tr><td colspan="4" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } else if ("datphong".equals(trang)) { %>

                    <div class="panel">
                        <div class="toolbar">
                            <input type="text" placeholder="Tìm mã đặt phòng, tên khách...">
                            <div>
                                <% if (!quanLy) { %><a href="#" class="btn-sm">+ Tạo đặt phòng</a><% } %>
                            </div>
                        </div>
                        <table>
                            <tr><th>Mã</th><th>Khách hàng</th><th>Phòng</th><th>Ngày đến</th><th>Ngày đi</th><th>Trạng thái</th></tr>
                            <tr><td colspan="6" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } else if ("checkin".equals(trang)) { %>

                    <div class="panel">
                        <h3>Check-in hôm nay</h3>
                        <table>
                            <tr><th>Mã</th><th>Khách hàng</th><th>Phòng</th><th>Giờ đến</th></tr>
                            <tr><td colspan="4" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>
                    <div class="panel">
                        <h3>Check-out hôm nay</h3>
                        <table>
                            <tr><th>Mã</th><th>Khách hàng</th><th>Phòng</th><th>Giờ đi</th></tr>
                            <tr><td colspan="4" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } else if ("khachhang".equals(trang)) { %>

                    <div class="panel">
                        <div class="toolbar">
                            <input type="text" placeholder="Tìm tên, số điện thoại...">
                            <div><a href="#" class="btn-sm">+ Thêm khách hàng</a></div>
                        </div>
                        <table>
                            <tr><th>Mã</th><th>Họ tên</th><th>Số điện thoại</th><th>Email</th><th>Số lần lưu trú</th></tr>
                            <tr><td colspan="5" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } else if ("dichvu".equals(trang)) { %>

                    <div class="panel">
                        <div class="toolbar">
                            <input type="text" placeholder="Tìm dịch vụ...">
                            <div>
                                <% if (quanLy) { %>
                                    <a href="#" class="btn-sm">+ Thêm dịch vụ</a>
                                <% } else { %>
                                    <a href="#" class="btn-sm">+ Tạo yêu cầu cho khách</a>
                                <% } %>
                            </div>
                        </div>
                        <table>
                            <tr><th>Mã</th><th>Tên dịch vụ</th><th>Loại (spa, đưa đón, phòng họp)</th><th>Giá</th><th>Trạng thái</th></tr>
                            <tr><td colspan="5" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } else if ("hoadon".equals(trang)) { %>

                    <div class="panel">
                        <div class="toolbar">
                            <input type="text" placeholder="Tìm mã hoá đơn, tên khách...">
                            <div>
                                <% if (!quanLy) { %><a href="#" class="btn-sm">+ Tạo hoá đơn</a><% } %>
                            </div>
                        </div>
                        <table>
                            <tr><th>Mã</th><th>Khách hàng</th><th>Tổng tiền</th><th>Ngày lập</th><th>Thanh toán</th></tr>
                            <tr><td colspan="5" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } else if ("nhanvien".equals(trang)) { %>

                    <div class="panel">
                        <div class="toolbar">
                            <input type="text" placeholder="Tìm nhân viên...">
                            <div><a href="#" class="btn-sm">+ Thêm nhân viên</a></div>
                        </div>
                        <table>
                            <tr><th>Mã</th><th>Họ tên</th><th>Chức vụ</th><th>Tài khoản</th><th>Trạng thái</th></tr>
                            <tr><td colspan="5" class="empty">Chưa có dữ liệu</td></tr>
                        </table>
                    </div>

                <% } %>

                </div>
            </div>

        </div>
    </body>
</html>