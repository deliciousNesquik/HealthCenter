﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Application.Database
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class HealthCenterEntities : DbContext
    {
        public HealthCenterEntities()
            : base("name=HealthCenterEntities")
        {
        }

        private static HealthCenterEntities _context;
        public static HealthCenterEntities GetContext()
        {
            if (_context == null)
            {
                _context = new HealthCenterEntities();
            }
            return _context;
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Departments> Departments { get; set; }
        public virtual DbSet<Diagnoses> Diagnoses { get; set; }
        public virtual DbSet<Employee> Employee { get; set; }
        public virtual DbSet<Genders> Genders { get; set; }
        public virtual DbSet<MedicalHistory> MedicalHistory { get; set; }
        public virtual DbSet<Patients> Patients { get; set; }
        public virtual DbSet<TypeOfTreatments> TypeOfTreatments { get; set; }
    }
}
