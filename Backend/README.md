# ébeere Games Admin Panel

Admin panel for ébeere Games quiz and mini-games platform. This is a PHP-based (CodeIgniter 3) admin dashboard for managing users, questions, categories, contests, and all aspects of the ébeere Games mobile application.

## Overview

This admin panel controls the backend of the ébeere Games mobile app, allowing administrators to:
- Manage quiz questions, categories, and subcategories
- Create and monitor contests
- Handle user management and statistics
- Configure app settings and system configurations
- Process payment requests and transactions
- Monitor leaderboards and battle statistics
- Manage mini-games content
- Send notifications and announcements

## Technology Stack

- **Framework:** CodeIgniter 3.x
- **Language:** PHP 7.4+
- **Database:** MySQL 5.7+ / MariaDB 10.2+
- **Frontend:** Bootstrap 4, jQuery, Stisla Admin Template
- **Additional:** CKEditor, Bootstrap Table, Chart.js, Select2

## Theme & Design

The admin panel has been redesigned to match the ébeere Games mobile app branding:

### Brand Colors
- **Primary Purple:** `#8B5CF6` (violet-500)
- **Secondary Teal:** `#14B8A6` (teal-500)
- **Accent Purple:** `#A78BFA` (violet-400)
- **Dark Purple:** `#6D28D9` (violet-700)
- **Gradient:** Purple to Teal (135deg)

### Design Features
- Modern gradient-based UI
- Purple-teal color scheme throughout
- Smooth animations and transitions
- Custom-styled cards, buttons, and tables
- Responsive mobile-first design
- Custom scrollbars and loading states

## Requirements

### Server Requirements
- **PHP:** 7.4 or higher
- **MySQL:** 5.7+ or MariaDB 10.2+
- **Apache:** 2.4+ (with mod_rewrite enabled)
- **PHP Extensions:**
  - mysqli
  - gd
  - curl
  - mbstring
  - json
  - xml
  - zip

### Recommended Server Specifications
- **RAM:** 2GB minimum, 4GB recommended
- **Storage:** 5GB minimum
- **PHP Memory Limit:** 256MB minimum
- **Max Execution Time:** 300 seconds

## Installation

### 1. Upload Files

Upload all files to your web server (e.g., `public_html/admin` or `admin.yourdomain.com`).

### 2. Database Setup

1. Create a new MySQL database
2. Import the SQL file (located in `database/` folder if provided, or use the installer)
3. Note your database credentials

### 3. Configuration

Edit `application/config/database.php`:

```php
$db['default'] = array(
    'hostname' => 'localhost',
    'username' => 'your_db_username',
    'password' => 'your_db_password',
    'database' => 'your_db_name',
    'dbdriver' => 'mysqli',
);
```

Edit `application/config/config.php`:

```php
$config['base_url'] = 'https://yourdomain.com/admin/';
$config['encryption_key'] = 'your_32_character_random_key';
```

### 4. File Permissions

Set proper permissions:

```bash
chmod 755 application/cache
chmod 755 application/logs
chmod 755 images
chmod 755 assets
```

### 5. Default Login

Access the admin panel at: `https://yourdomain.com/admin`

**Default Credentials:**
- Username: `admin@admin.com`
- Password: Check documentation or contact support

**⚠️ IMPORTANT:** Change the default password immediately after first login!

## Directory Structure

```
admin-panel/
├── application/           # CodeIgniter application files
│   ├── config/           # Configuration files
│   ├── controllers/      # Application controllers
│   ├── models/           # Database models
│   ├── views/            # View templates
│   └── libraries/        # Custom libraries
├── assets/               # Frontend assets
│   ├── css/             # Stylesheets (including ibeere-theme.css)
│   ├── js/              # JavaScript files
│   ├── bootstrap-table/ # DataTables plugin
│   ├── ckeditor/        # Rich text editor
│   └── fontawesome/     # Icons
├── images/               # Uploaded images & media
│   ├── branding/        # ébeere Games logos
│   ├── questions/       # Question images
│   ├── categories/      # Category images
│   └── web-settings/    # General settings images
├── system/               # CodeIgniter system files
└── index.php            # Application entry point
```

## Key Features

### Quiz Management
- Create and manage quiz categories
- Add subcategories with multiple levels
- Create questions with images, audio, and video
- Import questions via CSV
- Multi-match questions
- Math questions with LaTeX support
- Guess the word questions
- Audio questions

### Contest System
- Create time-limited contests
- Set entry fees and prizes
- Monitor contest participants
- View contest leaderboards
- Manage contest questions

### Exam Module
- Create comprehensive exams
- Set exam duration and rules
- Track exam results
- Generate certificates

### User Management
- View all registered users
- Monitor user statistics
- Manage user coins and scores
- Handle payment requests
- Track user activity

### Leaderboards
- Daily leaderboard
- Monthly leaderboard
- Global leaderboard
- Battle statistics
- User rankings

### System Configuration
- App settings and preferences
- Firebase configuration
- Payment gateway settings
- Advertisement settings
- In-app purchase configuration
- Authentication settings (Google, Apple, Phone)

### Content Management
- Manage static pages (About, Privacy Policy, Terms)
- Create and manage sliders
- Send notifications
- Manage system languages
- Configure web home settings

## Theme Customization

### Custom Theme File

The ébeere Games theme is applied via `assets/css/ibeere-theme.css`. This file overrides the default Stisla theme colors and styles.

### Updating Brand Colors

To change brand colors, edit `/assets/css/ibeere-theme.css`:

```css
:root {
    --primary-purple: #8B5CF6;
    --secondary-teal: #14B8A6;
    --accent-purple: #A78BFA;
    --dark-purple: #6D28D9;
    /* ... other variables ... */
}
```

### Logo Update

1. Replace logos in `images/branding/` directory
2. Update logo references in `tbl_settings` database table
3. Clear cache if needed

### Color Configuration in Database

Some colors can be configured via the admin panel:
1. Go to **System Configuration** → **Web Settings**
2. Update theme color, navbar color, etc.
3. Changes are stored in `tbl_settings` table

## API Integration

The admin panel provides REST APIs for the mobile app located in `application/controllers/Api.php`.

### API Endpoint
```
https://yourdomain.com/admin/Api/{METHOD_NAME}
```

### Key API Methods
- User authentication and profile management
- Question fetching (by category, level, type)
- Leaderboard data
- Contest information
- Coin and score management
- Battle room operations
- Notifications

See `api-docs.txt` for complete API documentation.

## Database Tables

Key database tables:
- `tbl_users` - User accounts
- `tbl_questions` - Quiz questions
- `tbl_category` - Main categories
- `tbl_subcategory` - Subcategories
- `tbl_contest` - Contests
- `tbl_leaderboard_monthly` - Monthly rankings
- `tbl_leaderboard_daily` - Daily rankings
- `tbl_settings` - System settings
- `tbl_notifications` - Push notifications
- `tbl_users_statistics` - User stats

## Security

### Best Practices

1. **Change Default Credentials:** Always change default admin password
2. **Database Security:** Use strong database passwords
3. **File Permissions:** Set proper chmod permissions
4. **HTTPS:** Always use SSL certificate
5. **Backups:** Regular database and file backups
6. **Updates:** Keep CodeIgniter and PHP updated
7. **Environment:** Set `ENVIRONMENT` to `production` in `index.php`

### Security Settings

Edit `application/config/config.php`:

```php
$config['sess_cookie_name'] = 'ebeere_session';
$config['csrf_protection'] = TRUE;
$config['csrf_token_name'] = 'csrf_token';
$config['csrf_cookie_name'] = 'csrf_cookie';
```

## Troubleshooting

### Common Issues

**1. Blank Page / 500 Error**
- Check PHP error logs
- Verify file permissions (755 for directories, 644 for files)
- Check database connection in `config/database.php`
- Enable error reporting temporarily:
  ```php
  error_reporting(E_ALL);
  ini_set('display_errors', 1);
  ```

**2. Images Not Loading**
- Check `images/` folder permissions
- Verify `base_url` in `config/config.php`
- Check `.htaccess` file exists

**3. Login Not Working**
- Clear browser cache and cookies
- Check database connection
- Verify session settings in `config/config.php`
- Check `application/cache` permissions

**4. Questions Not Appearing**
- Check database tables exist
- Verify API endpoint is accessible
- Check Firebase configuration

**5. CSS Not Loading**
- Clear browser cache
- Check file paths in view files
- Verify `base_url()` is correct
- Check `.htaccess` rewrite rules

### Debug Mode

Enable debug mode by editing `index.php`:

```php
define('ENVIRONMENT', 'development');
```

**⚠️ Remember to set back to `production` after debugging!**

## Maintenance

### Regular Tasks

1. **Database Backup:** Daily automated backups recommended
2. **Log Monitoring:** Check `application/logs/` regularly
3. **User Activity:** Monitor suspicious activities
4. **Performance:** Optimize database queries periodically
5. **Updates:** Check for CodeIgniter security updates

### Clearing Cache

```bash
rm -rf application/cache/*
```

Or via admin panel: **System Configuration** → **System Utilities** → **Clear Cache**

## Updates & Upgrades

### Updating the Panel

1. **Backup Everything:** Database and files
2. **Download Update:** Get latest version from source
3. **Extract Files:** Upload new files (don't replace `config/`)
4. **Run Update Script:** Access via System Updates section
5. **Test Thoroughly:** Check all features work
6. **Update Mobile App:** Ensure app compatibility

### Version History

- **v2.3.7** - Latest Elite Quiz version (base)
- **v1.0.0** - ébeere Games rebrand and theme update

## Support & Documentation

### Resources

- Original Documentation: Located in `Elite Quiz - Doc - v2.3.7.zip`
- API Documentation: See `api-docs.txt`
- Online Documentation: Check CodeCanyon page for Elite Quiz

### Getting Help

For technical support:
1. Check this README first
2. Review error logs in `application/logs/`
3. Search CodeIgniter 3 documentation
4. Contact development team

## Mobile App Integration

This admin panel is designed to work with the ébeere Games mobile app (Flutter).

### Mobile App Repository
```
https://github.com/Arsalion-24/Ibree-app
```

### Integration Points

1. **API Endpoint:** Configure in mobile app's API settings
2. **Firebase:** Shared Firebase project for both admin and mobile
3. **Storage:** Image URLs point to admin panel's `images/` folder
4. **Real-time:** Use Firebase for real-time battle features

### Syncing Changes

When updating:
- Admin panel colors → No mobile app changes needed
- API changes → May require mobile app update
- Database schema changes → Requires both updates

## Performance Optimization

### Recommended Optimizations

1. **Enable OpCache:**
   ```ini
   opcache.enable=1
   opcache.memory_consumption=128
   opcache.max_accelerated_files=4000
   ```

2. **Database Indexing:** Ensure proper indexes on frequently queried columns

3. **Image Optimization:** Compress uploaded images automatically

4. **CDN:** Use CDN for static assets in production

5. **Caching:** Enable CodeIgniter caching for static content

## License

Proprietary - All rights reserved

Based on Elite Quiz v2.3.7 (CodeCanyon) with ébeere Games customizations.

## Credits

- **Base System:** Elite Quiz by WRTeam
- **Admin Template:** Stisla Bootstrap Admin Template
- **Framework:** CodeIgniter 3
- **Customization:** ébeere Games Development Team
- **Theme Design:** ébeere Games Brand Guidelines

## Version

**Current Version:** 1.0.0-ebeere  
**Base Version:** Elite Quiz 2.3.7  
**Last Updated:** December 2024

---

## Quick Start Checklist

- [ ] Upload files to server
- [ ] Create MySQL database
- [ ] Import database SQL file
- [ ] Configure `config/database.php`
- [ ] Set `base_url` in `config/config.php`
- [ ] Set file permissions (755/644)
- [ ] Access admin panel URL
- [ ] Login with default credentials
- [ ] **Change default password immediately**
- [ ] Upload ébeere Games logos
- [ ] Configure Firebase settings
- [ ] Set up payment gateway
- [ ] Test API endpoints with mobile app
- [ ] Configure HTTPS/SSL
- [ ] Set up automated backups
- [ ] Change ENVIRONMENT to 'production'

---

**Need Help?** Contact the ébeere Games development team or refer to the Elite Quiz documentation for detailed setup instructions.
