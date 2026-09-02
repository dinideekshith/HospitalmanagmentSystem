<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Care | Premium Healthcare Services</title>
    <link rel="stylesheet" th:href="@{/css/style.css}">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Landing Page Specific CSS */
        :root {
            --primary-teal: #008080 !important;
            --primary-light: #00A3A3 !important;
        }
        html { scroll-behavior: smooth; }
        body { margin: 0; padding: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-image: none !important; background-color: #F0F6F6 !important; }
        body::before { display: none !important; }
        .navbar.landing-nav { backdrop-filter: none !important; -webkit-backdrop-filter: none !important; color: initial !important; }
        
        /* Transparent Navbar that becomes solid on scroll */
        .landing-nav {
            position: fixed; top: 0; left: 0; width: 100%; z-index: 1000;
            background: rgba(255, 255, 255, 0.95);
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .hero-section {
            position: relative;
            height: 100vh;
            background-image: linear-gradient(rgba(0, 128, 128, 0.8), rgba(0, 0, 0, 0.6)), url('/images/hero_banner.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            padding-top: 80px;
        }
        
        .hero-content {
            max-width: 800px;
            padding: 0 20px;
            animation: fadeInDown 1s ease-out;
        }
        
        .hero-title {
            font-size: 4rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .hero-subtitle {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        
        .hero-buttons {
            display: flex;
            gap: 1.5rem;
            justify-content: center;
        }
        
        .btn-large {
            padding: 1rem 2.5rem;
            font-size: 1.1rem;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }
        
        .section-padding { padding: 5rem 0; }
        
        .section-title {
            text-align: center;
            font-size: 2.5rem;
            color: var(--primary-teal);
            margin-bottom: 1rem;
        }
        .section-subtitle {
            text-align: center;
            color: var(--text-secondary);
            margin-bottom: 3rem;
            font-size: 1.1rem;
        }
        
        /* About Section */
        .about-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }
        .about-image {
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            width: 100%;
        }
        
        /* Services Grid */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }
        .service-box {
            background: white;
            padding: 2.5rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }
        .service-box:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,128,128,0.15);
        }
        .service-icon {
            font-size: 3rem;
            color: var(--primary-teal);
            margin-bottom: 1.5rem;
        }
        
        /* Doctors Grid */
        .doctors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
        }
        .doctor-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            text-align: center;
            transition: transform 0.3s;
        }
        .doctor-card:hover { transform: translateY(-5px); }
        .doctor-img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            background: #E8F4F4; /* Placeholder background */
        }
        .doctor-info { padding: 1.5rem; }
        
        /* Animations */
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Footer */
        .footer {
            background: #1A202C;
            color: white;
            padding: 4rem 0 2rem;
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar landing-nav">
        <div class="container" style="display: flex; justify-content: space-between; align-items: center;">
            <a href="#" class="nav-brand" style="color: var(--primary-teal);"><i class="fas fa-plus-square"></i> Hospital Care</a>
            <div style="display: flex; gap: 2rem; align-items: center;">
                <a href="#about" style="text-decoration: none; color: var(--text-primary); font-weight: 500;">About Us</a>
                <a href="#services" style="text-decoration: none; color: var(--text-primary); font-weight: 500;">Services</a>
                <a href="#doctors" style="text-decoration: none; color: var(--text-primary); font-weight: 500;">Doctors</a>
                <a href="#contact" style="text-decoration: none; color: var(--text-primary); font-weight: 500;">Contact</a>
                <a th:href="@{/login}" class="btn btn-primary" style="padding: 0.6rem 1.5rem;"><i class="fas fa-sign-in-alt"></i> Login</a>
                <a th:href="@{/register}" class="btn btn-outline" style="border-color: var(--primary-teal); color: var(--primary-teal);">Register</a>
            </div>
        </div>
    </nav>

    <!-- Hero Banner -->
    <section class="hero-section">
        <div class="hero-content">
            <h1 class="hero-title">World Class Health Care</h1>
            <p class="hero-subtitle">Providing advanced medical and surgical treatments with a compassionate touch. Your health is our priority.</p>
            <div class="hero-buttons">
                <a href="/login" class="btn btn-primary btn-large">Book an Appointment</a>
                <a href="#services" class="btn btn-outline btn-large" style="border-color: white; color: white;">Explore Services</a>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="section-padding bg-light">
        <div class="container">
            <div class="about-grid">
                <div>
                    <h2 class="section-title" style="text-align: left;">Welcome to Hospital Care</h2>
                    <p style="font-size: 1.1rem; color: var(--text-secondary); line-height: 1.8; margin-bottom: 1.5rem;">
                        Founded in 1995, Hospital Care is a state-of-the-art medical facility dedicated to providing top-tier healthcare services. We combine the latest medical technology with compassionate, patient-centered care.
                    </p>
                    <p style="font-size: 1.1rem; color: var(--text-secondary); line-height: 1.8; margin-bottom: 2rem;">
                        Our team of hundreds of expert doctors, nurses, and specialists are available 24/7 to ensure you receive the best treatment possible, from routine checkups to complex surgeries.
                    </p>
                    <div style="display: flex; gap: 2rem;">
                        <div>
                            <h3 style="color: var(--primary-teal); font-size: 2rem;">25+</h3>
                            <p class="text-secondary">Years of Excellence</p>
                        </div>
                        <div>
                            <h3 style="color: var(--primary-teal); font-size: 2rem;">150+</h3>
                            <p class="text-secondary">Specialist Doctors</p>
                        </div>
                        <div>
                            <h3 style="color: var(--primary-teal); font-size: 2rem;">50k+</h3>
                            <p class="text-secondary">Happy Patients</p>
                        </div>
                    </div>
                </div>
                <div>
                    <img src="/images/hero_banner.jpg" class="about-image" alt="Hospital Facility">
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="section-padding">
        <div class="container">
            <h2 class="section-title">Our Medical Services</h2>
            <p class="section-subtitle">Comprehensive healthcare solutions under one roof.</p>
            
            <div class="services-grid">
                <div class="service-box">
                    <i class="fas fa-heartbeat service-icon"></i>
                    <h3>Cardiology</h3>
                    <p class="text-secondary mt-1">Advanced heart care, diagnostics, and surgical interventions.</p>
                </div>
                <div class="service-box">
                    <i class="fas fa-brain service-icon"></i>
                    <h3>Neurology</h3>
                    <p class="text-secondary mt-1">Expert treatment for disorders of the brain and nervous system.</p>
                </div>
                <div class="service-box">
                    <i class="fas fa-bone service-icon"></i>
                    <h3>Orthopedics</h3>
                    <p class="text-secondary mt-1">Comprehensive care for bones, joints, and musculoskeletal issues.</p>
                </div>
                <div class="service-box">
                    <i class="fas fa-baby service-icon"></i>
                    <h3>Pediatrics</h3>
                    <p class="text-secondary mt-1">Specialized care for infants, children, and adolescents.</p>
                </div>
                <div class="service-box">
                    <i class="fas fa-x-ray service-icon"></i>
                    <h3>Radiology</h3>
                    <p class="text-secondary mt-1">State-of-the-art imaging services including MRI and CT scans.</p>
                </div>
                <div class="service-box">
                    <i class="fas fa-flask service-icon"></i>
                    <h3>Laboratory</h3>
                    <p class="text-secondary mt-1">24/7 advanced diagnostic laboratory testing and pathology.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Doctors Section -->
    <section id="doctors" class="section-padding bg-light">
        <div class="container">
            <h2 class="section-title">Meet Our Specialists</h2>
            <p class="section-subtitle">The best medical minds dedicated to your well-being.</p>
            
            <div class="doctors-grid">
                <div class="doctor-card">
                    <div class="doctor-img" style="display:flex; align-items:center; justify-content:center; background:#E8F4F4;">
                        <i class="fas fa-user-md" style="font-size: 5rem; color: var(--primary-teal); opacity: 0.5;"></i>
                    </div>
                    <div class="doctor-info">
                        <h3 style="color: var(--text-primary); margin-bottom: 0.5rem;">Dr. Sarah Jenkins</h3>
                        <p style="color: var(--primary-teal); font-weight: 500; margin-bottom: 0.5rem;">Chief Cardiologist</p>
                        <p class="text-secondary" style="font-size: 0.9rem;">MBBS, MD, FACC</p>
                    </div>
                </div>
                <div class="doctor-card">
                    <div class="doctor-img" style="display:flex; align-items:center; justify-content:center; background:#E8F4F4;">
                        <i class="fas fa-user-md" style="font-size: 5rem; color: var(--primary-teal); opacity: 0.5;"></i>
                    </div>
                    <div class="doctor-info">
                        <h3 style="color: var(--text-primary); margin-bottom: 0.5rem;">Dr. Michael Chen</h3>
                        <p style="color: var(--primary-teal); font-weight: 500; margin-bottom: 0.5rem;">Neurologist</p>
                        <p class="text-secondary" style="font-size: 0.9rem;">MBBS, MD, PhD</p>
                    </div>
                </div>
                <div class="doctor-card">
                    <div class="doctor-img" style="display:flex; align-items:center; justify-content:center; background:#E8F4F4;">
                        <i class="fas fa-user-md" style="font-size: 5rem; color: var(--primary-teal); opacity: 0.5;"></i>
                    </div>
                    <div class="doctor-info">
                        <h3 style="color: var(--text-primary); margin-bottom: 0.5rem;">Dr. Emily Roberts</h3>
                        <p style="color: var(--primary-teal); font-weight: 500; margin-bottom: 0.5rem;">Pediatrician</p>
                        <p class="text-secondary" style="font-size: 0.9rem;">MBBS, DCH</p>
                    </div>
                </div>
                <div class="doctor-card">
                    <div class="doctor-img" style="display:flex; align-items:center; justify-content:center; background:#E8F4F4;">
                        <i class="fas fa-user-md" style="font-size: 5rem; color: var(--primary-teal); opacity: 0.5;"></i>
                    </div>
                    <div class="doctor-info">
                        <h3 style="color: var(--text-primary); margin-bottom: 0.5rem;">Dr. James Wilson</h3>
                        <p style="color: var(--primary-teal); font-weight: 500; margin-bottom: 0.5rem;">Orthopedic Surgeon</p>
                        <p class="text-secondary" style="font-size: 0.9rem;">MBBS, MS Ortho</p>
                    </div>
                </div>
            </div>
            <div style="text-align: center; margin-top: 3rem;">
                <a href="/login" class="btn btn-outline" style="border-width: 2px;">View All Doctors &rarr;</a>
            </div>
        </div>
    </section>

    <!-- Footer / Contact -->
    <footer id="contact" class="footer">
        <div class="container">
            <div style="display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 3rem; margin-bottom: 3rem;">
                <div>
                    <h3 style="font-size: 1.5rem; margin-bottom: 1rem;"><i class="fas fa-plus-square text-primary"></i> Hospital Care</h3>
                    <p style="color: rgba(255,255,255,0.7); line-height: 1.8;">Providing world-class medical facilities and comprehensive healthcare solutions with a compassionate approach.</p>
                </div>
                <div>
                    <h4 style="margin-bottom: 1.5rem;">Quick Links</h4>
                    <ul style="list-style: none; padding: 0; display: flex; flex-direction: column; gap: 0.8rem;">
                        <li><a href="#about" style="color: rgba(255,255,255,0.7); text-decoration: none;">About Us</a></li>
                        <li><a href="#services" style="color: rgba(255,255,255,0.7); text-decoration: none;">Services</a></li>
                        <li><a href="#doctors" style="color: rgba(255,255,255,0.7); text-decoration: none;">Our Doctors</a></li>
                        <li><a href="/login" style="color: rgba(255,255,255,0.7); text-decoration: none;">Patient Portal</a></li>
                    </ul>
                </div>
                <div>
                    <h4 style="margin-bottom: 1.5rem;">Contact Us</h4>
                    <ul style="list-style: none; padding: 0; display: flex; flex-direction: column; gap: 1rem; color: rgba(255,255,255,0.7);">
                        <li><i class="fas fa-map-marker-alt" style="color: var(--primary-teal); margin-right: 10px;"></i> 123 Healthcare Ave, Medical City, NY 10001</li>
                        <li><i class="fas fa-phone-alt" style="color: var(--primary-teal); margin-right: 10px;"></i> +1 (555) 123-4567</li>
                        <li><i class="fas fa-envelope" style="color: var(--primary-teal); margin-right: 10px;"></i> contact@hospitalcare.com</li>
                    </ul>
                </div>
                <div>
                    <h4 style="margin-bottom: 1.5rem;">Emergency</h4>
                    <div style="background: #E53E3E; padding: 1.5rem; border-radius: 10px; text-align: center;">
                        <i class="fas fa-ambulance" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                        <h3 style="margin-bottom: 0.5rem;">24/7 Service</h3>
                        <p style="font-size: 1.2rem; font-weight: bold;">Dial 911</p>
                    </div>
                </div>
            </div>
            <div style="border-top: 1px solid rgba(255,255,255,0.1); padding-top: 2rem; text-align: center; color: rgba(255,255,255,0.5);">
                &copy; 2026 Hospital Care Management System. All Rights Reserved.
            </div>
        </div>
    </footer>

</body>
</html>
