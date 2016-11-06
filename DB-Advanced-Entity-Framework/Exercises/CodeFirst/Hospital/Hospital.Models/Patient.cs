namespace Hospital.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public class Patient
    {
        private ICollection<Visitation> visitations;
        private ICollection<Diagnosis> diagnoses;
        private ICollection<Medicament> medicaments;

        public Patient()
        {
            this.visitations = new HashSet<Visitation>();
            this.diagnoses = new HashSet<Diagnosis>();
            this.medicaments = new HashSet<Medicament>();
        }

        public int Id { get; set; }

        [Required]
        [MaxLength(50)]
        public string FirstName { get; set; }

        [Required]
        [MaxLength(50)]
        public string LastName { get; set; }

        [MaxLength(100)]
        public string Address { get; set; }

        [MaxLength(50)]
        public string Email { get; set; }

        DateTime? DateOfBirth { get; set; }

        [Required]
        public bool HasInsurance { get; set; }

        public int GeneralPhysicianID { get; set; }

        public virtual GeneralPhysician GP { get; set; }

        public virtual ICollection<Visitation> Visitations
        {
            get { return this.visitations; }
            set { this.visitations = value; }
        }

        public virtual ICollection<Diagnosis> Diagnoses
        {
            get { return this.diagnoses; }
            set { this.diagnoses = value; }
        }

        public virtual ICollection<Medicament> Medicaments
        {
            get { return this.medicaments; }
            set { this.medicaments = value; }
        }
    }
}