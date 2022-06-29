package models;

public class KhachHang {
    private String name;
    private String ngaySinh;
    private String diaChi;
    private String anh;

    public KhachHang() {
    }

    public KhachHang(String name, String ngaySinh, String diaChi, String anh) {
        this.name = name;
        this.ngaySinh = ngaySinh;
        this.diaChi = diaChi;
        this.anh = anh;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(String ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getAnh() {
        return anh;
    }

    public void setAnh(String anh) {
        this.anh = anh;
    }
}
