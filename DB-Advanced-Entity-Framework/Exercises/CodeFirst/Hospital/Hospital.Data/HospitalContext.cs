namespace Hospital.Data
{
    using System.Data.Entity;
    using Models;

    public class HospitalContext : DbContext
    {
        public HospitalContext()
            :base("Hospital")
        {
        }

        public IDbSet<Visitation> Visitations { get; set; }

        public IDbSet<Medicament> Medicaments { get; set; }

        public IDbSet<Diagnosis> Diagnoses { get; set; }

        public IDbSet<Patient> Patients { get; set; }

        public IDbSet<GeneralPhysician> GeneralPhysicians { get; set; }
    }
}