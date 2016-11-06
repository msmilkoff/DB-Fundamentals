namespace Hospital.Models
{
    using System;
    using System.ComponentModel.DataAnnotations;

    public class Visitation
    {
        public int Id { get; set; }

        [Required]
        public DateTime? Date { get; set; }

        [MaxLength(500)]
        public string Comments { get; set; }

        public int PatientId { get; set; }

        public virtual Patient Patient { get; set; }
    }
}