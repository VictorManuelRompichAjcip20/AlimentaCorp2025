CREATE DATABASE AlimentaCorpDW;
USE AlimentaCorpDW;

-- Dimensión Tiempo
CREATE TABLE DimTiempo (
    TiempoKey INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATE NOT NULL,
    Anio INT,
    Mes INT,
    Trimestre INT,
    NombreMes VARCHAR(20),
    Dia INT,
    NombreDia VARCHAR(20),
    FinSemana BIT
);

-- Dimensión Producto
CREATE TABLE DimProducto (
    ProductoKey INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(100) NOT NULL,
    Nombre VARCHAR(300),
    Marca VARCHAR(200),
    Categoria VARCHAR(100)
);

-- Dimensión Cliente
CREATE TABLE DimCliente (
    ClienteKey INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(100) NOT NULL,
    Nombre VARCHAR(300),
    Tipo VARCHAR(100),
    Direccion VARCHAR(300),
    Numero VARCHAR(100)
);

-- Dimensión Proveedor  
CREATE TABLE DimProveedor (
    ProveedorKey INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(100) NOT NULL,
    Nombre VARCHAR(300),
    Direccion VARCHAR(300),
    Telefono VARCHAR(50)
);

-- Dimensión Sucursal
CREATE TABLE DimSucursal (
    SucursalKey INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(100) NOT NULL,
    Nombre VARCHAR(200),
    Direccion VARCHAR(300),
    Region VARCHAR(100),
    Departamento VARCHAR(300)
);

-- Dimensión Vendedor
CREATE TABLE DimVendedor (
    VendedorKey INT IDENTITY(1,1) PRIMARY KEY,
    Codigo VARCHAR(100) NOT NULL,
    Nombre VARCHAR(200),
    Vacacionista VARCHAR(200)
);

-- Tabla de Hechos - Ventas
CREATE TABLE FactVentas (
    VentaKey INT IDENTITY(1,1) PRIMARY KEY,
    TiempoKey INT,
    ProductoKey INT,
    ClienteKey INT,
    SucursalKey INT,
    VendedorKey INT,
    Unidades INT,
    Precio DECIMAL(10,2),
    Total AS (Unidades * Precio),
    FOREIGN KEY (TiempoKey) REFERENCES DimTiempo(TiempoKey),
    FOREIGN KEY (ProductoKey) REFERENCES DimProducto(ProductoKey),
    FOREIGN KEY (ClienteKey) REFERENCES DimCliente(ClienteKey),
    FOREIGN KEY (SucursalKey) REFERENCES DimSucursal(SucursalKey),
    FOREIGN KEY (VendedorKey) REFERENCES DimVendedor(VendedorKey)
);

-- Tabla de Hechos - Compras  
CREATE TABLE FactCompras (
    CompraKey INT IDENTITY(1,1) PRIMARY KEY,
    TiempoKey INT,
    ProductoKey INT,
    ProveedorKey INT,
    SucursalKey INT,
    Unidades INT,
    Precio DECIMAL(10,2),
    Total AS (Unidades * Precio),
    FOREIGN KEY (TiempoKey) REFERENCES DimTiempo(TiempoKey),
    FOREIGN KEY (ProductoKey) REFERENCES DimProducto(ProductoKey),
    FOREIGN KEY (ProveedorKey) REFERENCES DimProveedor(ProveedorKey),
    FOREIGN KEY (SucursalKey) REFERENCES DimSucursal(SucursalKey)
);