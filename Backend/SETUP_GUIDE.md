# ébeere Games Admin Panel - Setup Guide

Complete installation and configuration guide for the ébeere Games admin panel.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation Steps](#installation-steps)
3. [Database Setup](#database-setup)
4. [Configuration](#configuration)
5. [Theme Customization](#theme-customization)
6. [Firebase Integration](#firebase-integration)
7. [Mobile App Connection](#mobile-app-connection)
8. [Testing](#testing)
9. [Going Live](#going-live)
10. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Server Requirements

**Minimum:**
- PHP 7.4+
- MySQL 5.7+ or MariaDB 10.2+
- Apache 2.4+ with mod_rewrite
- 2GB RAM
- 5GB storage

**Recommended:**
- PHP 8.0+
- MySQL 8.0+
- 4GB RAM
- 10GB storage
- SSL certificate

### PHP Extensions Required

```bash
php -m | grep -E "mysqli|gd|curl|mbstring|json|xml|zip"
```

All should be installed and enabled.

### Domain Setup

- Domain or subdomain pointing to server (e.g., `admin.ebeeregames.com`)
- SSL certificate configured
- DNS properly configured

---

## Installation Steps

### Step 1: Upload Files

**Option A: Via FTP/SFTP**
```bash
# Upload all files to your web root
# Example: /home/username/public_html/admin/
```

**Option B: Via Git (if repository access)**
```bash
cd /var/www/html
git clone https://github.com/Arsalion-24/Ibree-admin.git admin
cd admin
```

**Option C: Via cPanel File Manager**
1. Upload ZIP file
2. Extract to desired location
3. Delete ZIP file after extraction

### Step 2: Set File Permissions

```bash
cd /path/to/admin

# Set directory permissions
find . -type d -exec chmod 755 {} \;

# Set file permissions
find . -type f -exec chmod 644 {} \;

# Writable directories
chmod 755 application/cache
chmod 755 application/logs
chmod 755 images
chmod 755 images/questions
chmod 755 images/categories
chmod 755 images/sliders
chmod 755 images/web-settings
chmod 755 images/branding

# Create index.html in writable directories for security
touch application/cache/index.html
touch application/logs/index.html
```

### Step 3: Create Configuration Files

```bash
cd application/config

# Copy template files
cp database.php.template database.php
cp config.php.template config.php

# Edit with your settings
nano database.php
nano config.php
```

---

## Database Setup

### Step 1: Create Database

**Via phpMyAdmin:**
1. Open phpMyAdmin
2. Click "New" in left sidebar
3. Enter database name: `ebeere_admin`
4. Select collation: `utf8mb4_unicode_ci`
5. Click "Create"

**Via MySQL Command Line:**
```sql
CREATE DATABASE ebeere_admin CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'ebeere_user'@'localhost' IDENTIFIED BY 'strong_password_here';
GRANT ALL PRIVILEGES ON ebeere_admin.* TO 'ebeere_user'@'localhost';
FLUSH PRIVILEGES;
```

### Step 2: Import Database

**Option A: phpMyAdmin**
1. Select your database
2. Click "Import" tab
3. Choose SQL file
4. Click "Go"

**Option B: Command Line**
```bash
mysql -u ebeere_user -p ebeere_admin < database/ebeere_admin.sql
```

**Option C: Using Installer (if provided)**
1. Navigate to `http://yourdomain.com/admin/install`
2. Follow on-screen instructions
3. Delete `install/` folder after completion

### Step 3: Verify Import

```sql
USE ebeere_admin;
SHOW TABLES;
-- Should show 40+ tables
SELECT * FROM tbl_settings LIMIT 5;
-- Should show settings data
```

---

## Configuration

### Database Configuration

Edit `application/config/database.php`:

```php
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$active_group = 'default';
$query_builder = TRUE;

$db['default'] = array(
    'dsn'   => '',
    'hostname' => 'localhost',           // Usually 'localhost'
    'username' => 'ebeere_user',         // Your database username
    'password' => 'your_password_here',  // Your database password
    'database' => 'ebeere_admin',        // Your database name
    'dbdriver' => 'mysqli',
    'dbprefix' => '',
    'pconnect' => FALSE,
    'db_debug' => (ENVIRONMENT !== 'production'),
    'cache_on' => FALSE,
    'cachedir' => '',
    'char_set' => 'utf8mb4',
    'dbcollat' => 'utf8mb4_unicode_ci',
    'swap_pre' => '',
    'encrypt' => FALSE,
    'compress' => FALSE,
    'stricton' => FALSE,
    'failover' => array(),
    'save_queries' => TRUE
);
```

### Application Configuration

Edit `application/config/config.php`:

```php
<?php
defined('BASEPATH') OR exit('No direct script access allowed');

// Base URL - VERY IMPORTANT!
$config['base_url'] = 'https://admin.ebeeregames.com/';  // Your actual domain

// Encryption Key - Generate a random 32-character string
$config['encryption_key'] = 'your_32_character_random_key_here';

// Session Configuration
$config['sess_cookie_name'] = 'ebeere_session';
$config['sess_expiration'] = 7200; // 2 hours
$config['sess_save_path'] = sys_get_temp_dir();
$config['sess_match_ip'] = FALSE;
$config['sess_time_to_update'] = 300;
$config['sess_regenerate_destroy'] = FALSE;

// Cookie Configuration
$config['cookie_prefix'] = 'ebeere_';
$config['cookie_domain'] = '';
$config['cookie_path'] = '/';
$config['cookie_secure'] = TRUE; // TRUE if using HTTPS
$config['cookie_httponly'] = TRUE;

// CSRF Protection
$config['csrf_protection'] = TRUE;
$config['csrf_token_name'] = 'csrf_token';
$config['csrf_cookie_name'] = 'csrf_cookie';
$config['csrf_expire'] = 7200;
$config['csrf_regenerate'] = TRUE;
$config['csrf_exclude_uris'] = array('api/*'); // Exclude API calls

// URL Suffix
$config['url_suffix'] = '';
$config['index_page'] = ''; // Remove index.php from URLs

// Timezone
date_default_timezone_set('Africa/Lagos'); // Set your timezone
```

### Generate Encryption Key

```bash
# Generate a secure random key
php -r "echo bin2hex(random_bytes(16));" && echo
# Copy the output to encryption_key in config.php
```

### .htaccess Configuration

Ensure `.htaccess` exists in root directory:

```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    
    # Remove index.php from URLs
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule ^(.*)$ index.php/$1 [L]
    
    # Force HTTPS
    RewriteCond %{HTTPS} off
    RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
</IfModule>

# Disable directory browsing
Options -Indexes

# Protect config files
<FilesMatch "^(database|config)\.php$">
    Order allow,deny
    Deny from all
</FilesMatch>

# Set default charset
AddDefaultCharset UTF-8

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript
</IfModule>

# Browser caching
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
</IfModule>
```

---

## Theme Customization

### Using ébeere Games Theme

The custom theme is already applied via `assets/css/ibeere-theme.css`.

### Customizing Colors

Edit `assets/css/ibeere-theme.css`:

```css
:root {
    /* Change these to your preferred colors */
    --primary-purple: #8B5CF6;    /* Main brand color */
    --secondary-teal: #14B8A6;    /* Secondary brand color */
    --accent-purple: #A78BFA;     /* Accent color */
    --dark-purple: #6D28D9;       /* Dark variant */
    
    /* Or create custom gradients */
    --gradient-primary: linear-gradient(135deg, #8B5CF6 0%, #14B8A6 100%);
}
```

### Updating Logos

1. **Prepare Logo Files:**
   - Full logo (PNG/SVG): 600x200px, transparent background
   - Half logo/Icon (PNG): 200x200px, transparent background
   - Favicon (PNG/ICO): 32x32px

2. **Upload via Admin Panel:**
   - Login to admin panel
   - Go to **System Configuration** → **Web Settings**
   - Upload Full Logo and Half Logo
   - Upload Favicon

3. **Or Manually:**
   ```bash
   cp your-full-logo.png images/branding/ebeere-logo-full.png
   cp your-half-logo.png images/branding/ebeere-logo-half.png
   cp your-favicon.png images/branding/favicon.png
   ```

4. **Update Database:**
   ```sql
   UPDATE tbl_settings SET message='ebeere-logo-full.png' WHERE type='full_logo';
   UPDATE tbl_settings SET message='ebeere-logo-half.png' WHERE type='half_logo';
   ```

---

## Firebase Integration

### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Name: "ébeere Games" or similar
4. Enable Google Analytics (optional)
5. Create project

### Step 2: Get Server Key

1. In Firebase Console, click gear icon → Project Settings
2. Go to "Cloud Messaging" tab
3. Copy "Server key"

### Step 3: Configure in Admin Panel

1. Login to admin panel
2. Go to **System Configuration** → **Firebase Configurations**
3. Enter Server Key
4. Save settings

### Step 4: Enable Required Services

In Firebase Console:
- **Authentication:** Enable Email, Google, Apple, Phone
- **Firestore:** Create database (for real-time features)
- **Storage:** Enable (for file uploads)
- **Cloud Messaging:** Already enabled

---

## Mobile App Connection

### Step 1: Update API Endpoint in Mobile App

In Flutter app (`lib/utils/api_utils.dart` or similar):

```dart
class ApiUtils {
  static const String baseUrl = 'https://admin.ebeeregames.com/Api/';
  
  // Update all API endpoints
  static const String userSignup = '${baseUrl}user_signup';
  static const String getQuestions = '${baseUrl}get_questions';
  // ... etc
}
```

### Step 2: Test API Connection

```bash
# Test basic API endpoint
curl https://admin.ebeeregames.com/Api/get_settings

# Should return JSON with app settings
```

### Step 3: Sync Firebase Config

Ensure both admin panel and mobile app use the SAME Firebase project.

### Step 4: Update Image URLs

Mobile app will fetch images from:
```
https://admin.ebeeregames.com/images/questions/
https://admin.ebeeregames.com/images/categories/
https://admin.ebeeregames.com/images/profiles/
```

Ensure these directories are publicly accessible.

---

## Testing

### Checklist

**Basic Access:**
- [ ] Can access `https://admin.ebeeregames.com/`
- [ ] Login page loads without errors
- [ ] Can login with credentials
- [ ] Dashboard displays correctly

**Theme & Branding:**
- [ ] Purple-teal gradient visible
- [ ] Logo displays correctly
- [ ] All pages use new theme
- [ ] Mobile responsive

**Functionality:**
- [ ] Can create new category
- [ ] Can create new question
- [ ] Can upload images
- [ ] Can send notification
- [ ] Can view users list
- [ ] Can view leaderboards

**API Testing:**
- [ ] `/Api/get_settings` returns data
- [ ] `/Api/get_categories` returns data
- [ ] `/Api/get_questions` returns data
- [ ] Mobile app can connect

**Security:**
- [ ] HTTPS working
- [ ] Login requires authentication
- [ ] SQL injection protected
- [ ] XSS protected
- [ ] CSRF tokens working

### Test Accounts

Create test accounts:
```sql
-- Test admin user
INSERT INTO tbl_authenticate (email, password, role, status) 
VALUES ('test@ebeeregames.com', MD5('TestPass123'), '1', '1');
```

---

## Going Live

### Pre-Launch Checklist

**Security:**
- [ ] Changed default admin password
- [ ] Set ENVIRONMENT to 'production' in `index.php`
- [ ] Disabled error display
- [ ] Enabled CSRF protection
- [ ] HTTPS configured and forced
- [ ] Strong database passwords
- [ ] Firewall configured

**Performance:**
- [ ] PHP OpCache enabled
- [ ] Database indexed
- [ ] Image optimization enabled
- [ ] Gzip compression enabled
- [ ] Browser caching configured

**Backup:**
- [ ] Automated database backup configured
- [ ] File backup system in place
- [ ] Backup restoration tested

**Monitoring:**
- [ ] Server monitoring setup
- [ ] Error logging enabled
- [ ] Uptime monitoring configured

### Final Steps

1. **Set to Production Mode**

Edit `index.php`:
```php
define('ENVIRONMENT', 'production');
```

2. **Disable Error Display**

Edit `php.ini` or `.htaccess`:
```ini
display_errors = Off
log_errors = On
error_log = /path/to/error.log
```

3. **Clear All Caches**
```bash
rm -rf application/cache/*
```

4. **Test Everything Again**

5. **Monitor for 24 Hours**

---

## Troubleshooting

### Common Issues & Solutions

**1. Blank White Page**

```bash
# Enable error reporting temporarily
# Edit index.php
error_reporting(E_ALL);
ini_set('display_errors', 1);

# Check PHP error log
tail -f /var/log/php-error.log

# Check Apache error log
tail -f /var/log/apache2/error.log
```

**2. 404 on All Pages (except home)**

```bash
# Enable mod_rewrite
sudo a2enmod rewrite
sudo systemctl restart apache2

# Check .htaccess exists and is readable
ls -la .htaccess
```

**3. Database Connection Error**

- Verify credentials in `config/database.php`
- Check MySQL is running: `sudo systemctl status mysql`
- Test connection: `mysql -u username -p database_name`
- Check MySQL user permissions

**4. Images Not Uploading**

```bash
# Check permissions
chmod 755 images/
chmod 755 images/questions/
chmod 755 images/categories/

# Check PHP upload settings
php -i | grep upload_max_filesize
php -i | grep post_max_size

# Increase if needed in php.ini
upload_max_filesize = 10M
post_max_size = 10M
```

**5. Sessions Not Working**

```bash
# Check session save path
php -i | grep session.save_path

# Ensure directory exists and is writable
ls -ld /tmp
chmod 1777 /tmp

# Or set custom path in config.php
$config['sess_save_path'] = '/path/to/writable/directory';
```

**6. API Returns 404**

- Check `.htaccess` in root
- Verify base_url in `config.php`
- Test: `curl https://admin.ebeeregames.com/Api/get_settings`
- Check Apache rewrite logs

**7. Login Loop (keeps redirecting to login)**

- Clear browser cookies
- Check session configuration in `config.php`
- Verify database authentication table
- Check `$config['sess_save_path']` is writable

**8. CSS Not Loading / Broken Layout**

- Clear browser cache (Ctrl+Shift+R)
- Check base_url in `config.php` ends with `/`
- Verify CSS files exist in `assets/css/`
- Check console for 404 errors
- Check file permissions: `chmod 644 assets/css/*`

---

## Need Help?

### Support Resources

1. **Documentation:** See README.md
2. **Error Logs:** Check `application/logs/`
3. **CodeIgniter Docs:** https://codeigniter.com/userguide3/
4. **Elite Quiz Docs:** See original documentation zip

### Contact

For technical support, contact the ébeere Games development team.

---

**Installation Complete!** Your ébeere Games admin panel should now be fully operational.

Next Steps:
1. Configure app settings via admin panel
2. Add initial categories and questions
3. Test with mobile app
4. Train administrators on system usage
5. Monitor and optimize performance
