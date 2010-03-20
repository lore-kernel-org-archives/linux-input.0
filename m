From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH v2 6/6] hid: add experimental access to PicoLCD device's
 EEPROM and FLASH
Date: Sat, 20 Mar 2010 17:11:19 +0100
Message-ID: <20100320171119.193c5615@neptune.home>
References: <20100320170014.440959a8@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from legolas.restena.lu ([158.64.1.34]:42981 "EHLO
	legolas.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab0CTQPL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 12:15:11 -0400
In-Reply-To: <20100320170014.440959a8@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

The PicoLCD device has a small amount of EEPROM and also provides
access to its FLASH where firmware and splash image are saved.
In flasher mode FLASH access is the only active feature.

Give read/write access to both via debugfs files.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---
 drivers/hid/Kconfig       |    2 +-
 drivers/hid/hid-picolcd.c |  428 +++++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 412 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 90caaf3..2eec702 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -246,9 +246,9 @@ config HID_PICOLCD
 	  - Backlight control         (needs CONFIG_BACKLIGHT_CLASS_DEVICE)
 	  - Contrast control          (needs CONFIG_LCD_CLASS_DEVICE)
 	  - General purpose outputs   (needs CONFIG_LEDS_CLASS)
+	  - EEProm / Flash access     (via debugfs)
 	  Features that are not (yet) supported:
 	  - IR
-	  - EEProm / Flash access
=20
 config HID_SAMSUNG
 	tristate "Samsung" if EMBEDDED
diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
index f3d057c..3b9c7f4 100644
--- a/drivers/hid/hid-picolcd.c
+++ b/drivers/hid/hid-picolcd.c
@@ -169,6 +169,9 @@ struct picolcd_pending {
 struct picolcd_data {
 	struct hid_device *hdev;
 #ifdef CONFIG_DEBUG_FS
+	struct dentry *debug_reset;
+	struct dentry *debug_eeprom;
+	struct dentry *debug_flash;
 	int addr_sz;
 #endif
 	u8 version[2];
@@ -1219,6 +1222,337 @@ static DEVICE_ATTR(operation_mode, 0644, picolc=
d_operation_mode_show,
=20
 #ifdef CONFIG_DEBUG_FS
 /*
+ * The "reset" file
+ */
+static int picolcd_debug_reset_show(struct seq_file *f, void *p)
+{
+	if (picolcd_fbinfo((struct picolcd_data *)f->private))
+		seq_printf(f, "all fb\n");
+	else
+		seq_printf(f, "all\n");
+	return 0;
+}
+
+static ssize_t picolcd_debug_reset_open(struct inode *inode, struct fi=
le *f)
+{
+	return single_open(f, picolcd_debug_reset_show, inode->i_private);
+}
+
+static ssize_t picolcd_debug_reset_write(struct file *f, const char __=
user *user_buf,
+		size_t count, loff_t *ppos)
+{
+	struct picolcd_data *data =3D ((struct seq_file *)f->private_data)->p=
rivate;
+	char buf[32];
+	size_t cnt =3D min(count, sizeof(buf)-1);
+	if (copy_from_user(buf, user_buf, cnt))
+		return -EFAULT;
+
+	while (cnt > 0 && (buf[cnt-1] =3D=3D ' ' || buf[cnt-1] =3D=3D '\n'))
+		cnt--;
+	buf[cnt] =3D '\0';
+	if (strcmp(buf, "all") =3D=3D 0) {
+		picolcd_reset(data->hdev);
+		picolcd_fb_reset(data, 1);
+	} else if (strcmp(buf, "fb") =3D=3D 0) {
+		picolcd_fb_reset(data, 1);
+	} else {
+		return -EINVAL;
+	}
+	return count;
+}
+
+static const struct file_operations picolcd_debug_reset_fops =3D {
+	.owner    =3D THIS_MODULE,
+	.open     =3D picolcd_debug_reset_open,
+	.read     =3D seq_read,
+	.llseek   =3D seq_lseek,
+	.write    =3D picolcd_debug_reset_write,
+	.release  =3D single_release,
+};
+
+/*
+ * The "eeprom" file
+ */
+static int picolcd_debug_eeprom_open(struct inode *i, struct file *f)
+{
+	f->private_data =3D i->i_private;
+	return 0;
+}
+
+static ssize_t picolcd_debug_eeprom_read(struct file *f, char __user *=
u,
+		size_t s, loff_t *off)
+{
+	struct picolcd_data *data =3D f->private_data;
+	struct picolcd_pending *resp;
+	u8 raw_data[3];
+	ssize_t ret =3D -EIO;
+
+	if (s =3D=3D 0)
+		return -EINVAL;
+	if (*off > 0x0ff)
+		return 0;
+
+	/* prepare buffer with info about what we want to read (addr & len) *=
/
+	raw_data[0] =3D *off & 0xff;
+	raw_data[1] =3D (*off >> 8) && 0xff;
+	raw_data[2] =3D s < 20 ? s : 20;
+	if (*off + raw_data[2] > 0xff)
+		raw_data[2] =3D 0x100 - *off;
+	resp =3D picolcd_send_and_wait(data->hdev, REPORT_EE_READ, raw_data,
+			sizeof(raw_data));
+	if (!resp)
+		return -EIO;
+
+	if (resp->in_report && resp->in_report->id =3D=3D REPORT_EE_DATA) {
+		/* successful read :) */
+		ret =3D resp->raw_data[2];
+		if (ret > s)
+			ret =3D s;
+		if (copy_to_user(u, resp->raw_data+3, ret))
+			ret =3D -EFAULT;
+		else
+			*off +=3D ret;
+	} /* anything else is some kind of IO error */
+
+	kfree(resp);
+	return ret;
+}
+
+static ssize_t picolcd_debug_eeprom_write(struct file *f, const char _=
_user *u,
+		size_t s, loff_t *off)
+{
+	struct picolcd_data *data =3D f->private_data;
+	struct picolcd_pending *resp;
+	ssize_t ret =3D -EIO;
+	u8 raw_data[23];
+
+	if (s =3D=3D 0)
+		return -EINVAL;
+	if (*off > 0x0ff)
+		return -ENOSPC;
+
+	memset(raw_data, 0, sizeof(raw_data));
+	raw_data[0] =3D *off & 0xff;
+	raw_data[1] =3D (*off >> 8) && 0xff;
+	raw_data[2] =3D s < 20 ? s : 20;
+	if (*off + raw_data[2] > 0xff)
+		raw_data[2] =3D 0x100 - *off;
+
+	if (copy_from_user(raw_data+3, u, raw_data[2]))
+		return -EFAULT;
+	resp =3D picolcd_send_and_wait(data->hdev, REPORT_EE_WRITE, raw_data,
+			sizeof(raw_data));
+
+	if (!resp)
+		return -EIO;
+
+	if (resp->in_report && resp->in_report->id =3D=3D REPORT_EE_DATA) {
+		/* check if written data matches */
+		if (memcmp(raw_data, resp->raw_data, 3+raw_data[2]) =3D=3D 0) {
+			*off +=3D raw_data[2];
+			ret =3D raw_data[2];
+		}
+	}
+	kfree(resp);
+	return ret;
+}
+
+static const struct file_operations picolcd_debug_eeprom_fops =3D {
+	.owner    =3D THIS_MODULE,
+	.open     =3D picolcd_debug_eeprom_open,
+	.read     =3D picolcd_debug_eeprom_read,
+	.write    =3D picolcd_debug_eeprom_write,
+	.llseek   =3D generic_file_llseek,
+};
+
+/*
+ * The "flash" file
+ */
+static int picolcd_debug_flash_open(struct inode *i, struct file *f)
+{
+	f->private_data =3D i->i_private;
+	return 0;
+}
+
+/* record a flash address to buf (bounds check to be done by caller) *=
/
+static int _picolcd_flash_setaddr(struct picolcd_data *data, u8 *buf, =
long off)
+{
+	buf[0] =3D off & 0xff;
+	buf[1] =3D (off >> 8) & 0xff;
+	if (data->addr_sz =3D=3D 3)
+		buf[2] =3D (off >> 16) & 0xff;
+	return data->addr_sz =3D=3D 2 ? 2 : 3;
+}
+
+/* read a given size of data (bounds check to be done by caller) */
+static ssize_t _picolcd_flash_read(struct picolcd_data *data, int repo=
rt_id,
+		char __user *u, size_t s, loff_t *off)
+{
+	struct picolcd_pending *resp;
+	u8 raw_data[4];
+	ssize_t ret =3D 0;
+	int len_off, err =3D -EIO;
+
+	while (s > 0) {
+		err =3D -EIO;
+		len_off =3D _picolcd_flash_setaddr(data, raw_data, *off);
+		raw_data[len_off] =3D s > 32 ? 32 : s;
+		resp =3D picolcd_send_and_wait(data->hdev, report_id, raw_data, len_=
off+1);
+		if (!resp || !resp->in_report)
+			goto skip;
+		if (resp->in_report->id =3D=3D REPORT_MEMORY ||
+			resp->in_report->id =3D=3D REPORT_BL_READ_MEMORY) {
+			if (memcmp(raw_data, resp->raw_data, len_off+1) !=3D 0)
+				goto skip;
+			if (copy_to_user(u+ret, resp->raw_data+len_off+1, raw_data[len_off]=
)) {
+				err =3D -EFAULT;
+				goto skip;
+			}
+			*off +=3D raw_data[len_off];
+			s    -=3D raw_data[len_off];
+			ret  +=3D raw_data[len_off];
+			err   =3D 0;
+		}
+skip:
+		kfree(resp);
+		if (err)
+			return ret > 0 ? ret : err;
+	}
+	return ret;
+}
+
+static ssize_t picolcd_debug_flash_read(struct file *f, char __user *u=
,
+		size_t s, loff_t *off)
+{
+	struct picolcd_data *data =3D f->private_data;
+
+	if (s =3D=3D 0)
+		return -EINVAL;
+	if (*off > 0x05fff)
+		return 0;
+	if (*off + s > 0x05fff)
+		s =3D 0x06000 - *off;
+
+	if (data->status & PICOLCD_BOOTLOADER)
+		return _picolcd_flash_read(data, REPORT_BL_READ_MEMORY, u, s, off);
+	else
+		return _picolcd_flash_read(data, REPORT_READ_MEMORY, u, s, off);
+}
+
+/* erase block aligned to 64bytes boundary */
+static ssize_t _picolcd_flash_erase64(struct picolcd_data *data, int r=
eport_id,
+		loff_t *off)
+{
+	struct picolcd_pending *resp;
+	u8 raw_data[3];
+	int len_off;
+	ssize_t ret =3D -EIO;
+
+	if (*off & 0x3f)
+		return -EINVAL;
+
+	len_off =3D _picolcd_flash_setaddr(data, raw_data, *off);
+	resp =3D picolcd_send_and_wait(data->hdev, report_id, raw_data, len_o=
ff);
+	if (!resp || !resp->in_report)
+		goto skip;
+	if (resp->in_report->id =3D=3D REPORT_MEMORY ||
+		resp->in_report->id =3D=3D REPORT_BL_ERASE_MEMORY) {
+		if (memcmp(raw_data, resp->raw_data, len_off) !=3D 0)
+			goto skip;
+		ret =3D 0;
+	}
+skip:
+	kfree(resp);
+	return ret;
+}
+
+/* write a given size of data (bounds check to be done by caller) */
+static ssize_t _picolcd_flash_write(struct picolcd_data *data, int rep=
ort_id,
+		const char __user *u, size_t s, loff_t *off)
+{
+	struct picolcd_pending *resp;
+	u8 raw_data[36];
+	ssize_t ret =3D 0;
+	int len_off, err =3D -EIO;
+
+	while (s > 0) {
+		err =3D -EIO;
+		len_off =3D _picolcd_flash_setaddr(data, raw_data, *off);
+		raw_data[len_off] =3D s > 32 ? 32 : s;
+		if (copy_from_user(raw_data+len_off+1, u, raw_data[len_off])) {
+			err =3D -EFAULT;
+			goto skip;
+		}
+		resp =3D picolcd_send_and_wait(data->hdev, report_id, raw_data,
+				len_off+1+raw_data[len_off]);
+		if (!resp || !resp->in_report)
+			goto skip;
+		if (resp->in_report->id =3D=3D REPORT_MEMORY ||
+			resp->in_report->id =3D=3D REPORT_BL_WRITE_MEMORY) {
+			if (memcmp(raw_data, resp->raw_data, len_off+1+raw_data[len_off]) !=
=3D 0)
+				goto skip;
+			*off +=3D raw_data[len_off];
+			s    -=3D raw_data[len_off];
+			ret  +=3D raw_data[len_off];
+			err   =3D 0;
+		}
+skip:
+		kfree(resp);
+		if (err)
+			break;
+	}
+	return ret > 0 ? ret : err;
+}
+
+static ssize_t picolcd_debug_flash_write(struct file *f, const char __=
user *u,
+		size_t s, loff_t *off)
+{
+	struct picolcd_data *data =3D f->private_data;
+	ssize_t err, ret =3D 0;
+	int report_erase, report_write;
+
+	if (s =3D=3D 0)
+		return -EINVAL;
+	if (*off > 0x5fff)
+		return -ENOSPC;
+	if (s & 0x3f)
+		return -EINVAL;
+	if (*off & 0x3f)
+		return -EINVAL;
+
+	if (data->status & PICOLCD_BOOTLOADER) {
+		report_erase =3D REPORT_BL_ERASE_MEMORY;
+		report_write =3D REPORT_BL_WRITE_MEMORY;
+	} else {
+		report_erase =3D REPORT_ERASE_MEMORY;
+		report_write =3D REPORT_WRITE_MEMORY;
+	}
+	while (s > 0) {
+		err =3D _picolcd_flash_erase64(data, report_erase, off);
+		if (err)
+			break;
+		err =3D _picolcd_flash_write(data, report_write, u, 64, off);
+		if (err < 0)
+			break;
+		ret +=3D err;
+		*off +=3D err;
+		s -=3D err;
+		if (err !=3D 64)
+			break;
+	}
+	return ret > 0 ? ret : err;
+}
+
+static const struct file_operations picolcd_debug_flash_fops =3D {
+	.owner    =3D THIS_MODULE,
+	.open     =3D picolcd_debug_flash_open,
+	.read     =3D picolcd_debug_flash_read,
+	.write    =3D picolcd_debug_flash_write,
+	.llseek   =3D generic_file_llseek,
+};
+
+
+/*
  * Helper code for HID report level dumping/debugging
  */
 static const char *error_codes[] =3D {
@@ -1689,9 +2023,76 @@ static inline void picolcd_debug_raw_event(struc=
t picolcd_data *data,
 	wake_up_interruptible(&hdev->debug_wait);
 	kfree(buff);
 }
+
+static inline int picolcd_init_devfs(struct picolcd_data *data,
+		struct hid_report *eeprom_r, struct hid_report *eeprom_w,
+		struct hid_report *flash_r, struct hid_report *flash_w,
+		struct hid_report *reset)
+{
+	struct hid_device *hdev =3D data->hdev;
+
+	/* reset */
+	if (reset)
+		data->debug_reset =3D debugfs_create_file("reset", 0600,
+				hdev->debug_dir, data, &picolcd_debug_reset_fops);
+
+	/* eeprom */
+	if (eeprom_r || eeprom_w)
+		data->debug_eeprom =3D debugfs_create_file("eeprom",
+			(eeprom_w ? S_IWUSR : 0) | (eeprom_r ? S_IRUSR : 0),
+			hdev->debug_dir, data, &picolcd_debug_eeprom_fops);
+	if (eeprom_r && (eeprom_r->maxfield !=3D 1 ||
+			eeprom_r->field[0]->report_count !=3D 3 ||
+			eeprom_r->field[0]->report_size !=3D 8))
+		dev_warn(&hdev->dev, "Unsupported EEPROM data report (%d, %d, %d)\n"=
,
+				eeprom_r->maxfield, eeprom_r->field[0]->report_count,
+				eeprom_r->field[0]->report_size);
+
+	/* flash */
+	if (flash_r && flash_r->maxfield =3D=3D 1 && flash_r->field[0]->repor=
t_size =3D=3D 8)
+		data->addr_sz =3D flash_r->field[0]->report_count - 1;
+	else
+		data->addr_sz =3D -1;
+	if (data->addr_sz =3D=3D 2 || data->addr_sz =3D=3D 3)
+		data->debug_flash =3D debugfs_create_file("flash",=20
+			(flash_w ? S_IWUSR : 0) | (flash_r ? S_IRUSR : 0),
+			hdev->debug_dir, data, &picolcd_debug_flash_fops);
+	else if (flash_r || flash_w)
+		dev_warn(&hdev->dev, "Unexpected FLASH access reports, "
+				"please submit rdesc for review\n");
+	return 0;
+}
+
+static void picolcd_exit_devfs(struct picolcd_data *data)
+{
+	struct dentry *dent;
+
+	dent =3D data->debug_reset;
+	data->debug_reset =3D NULL;
+	if (dent)
+		debugfs_remove(dent);
+	dent =3D data->debug_eeprom;
+	data->debug_eeprom =3D NULL;
+	if (dent)
+		debugfs_remove(dent);
+	dent =3D data->debug_flash;
+	data->debug_flash =3D NULL;
+	if (dent)
+		debugfs_remove(dent);
+}
 #else
 #define picolcd_debug_raw_event(data, hdev, report, raw_data, size)
-#endif
+static inline int picolcd_init_devfs(struct picolcd_data *data,
+	struct hid_report *eeprom_r, struct hid_report *eeprom_w,
+	struct hid_report *flash_r, struct hid_report *flash_w,
+	struct hid_report *reset)
+{
+	return 0;
+}
+static void picolcd_exit_devfs(struct picolcd_data *data)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
=20
 /*
  * Handle raw report as sent by device
@@ -1842,7 +2243,6 @@ static void picolcd_exit_cir(struct picolcd_data =
*data)
 static inline int picolcd_probe_lcd(struct hid_device *hdev, struct pi=
colcd_data *data)
 {
 	struct picolcd_pending *verinfo;
-	struct hid_report *report;
 	int error;
=20
 	verinfo =3D picolcd_send_and_wait(hdev, REPORT_VERSION, NULL, 0);
@@ -1900,13 +2300,11 @@ static inline int picolcd_probe_lcd(struct hid_=
device *hdev, struct picolcd_data
 	if (error)
 		goto err;
=20
-#ifdef CONFIG_DEBUG_FS
-	report =3D picolcd_out_report(REPORT_READ_MEMORY, hdev);
-	if (report && report->maxfield =3D=3D 1 && report->field[0]->report_s=
ize =3D=3D 8)
-		data->addr_sz =3D report->field[0]->report_count - 1;
-	else
-		data->addr_sz =3D -1;
-#endif
+	picolcd_init_devfs(data, picolcd_out_report(REPORT_EE_READ, hdev),
+			picolcd_out_report(REPORT_EE_WRITE, hdev),
+			picolcd_out_report(REPORT_READ_MEMORY, hdev),
+			picolcd_out_report(REPORT_WRITE_MEMORY, hdev),
+			picolcd_out_report(REPORT_RESET, hdev));
 	return 0;
 err:
 	picolcd_exit_leds(data);
@@ -1921,7 +2319,6 @@ err:
 static inline int picolcd_probe_bootloader(struct hid_device *hdev, st=
ruct picolcd_data *data)
 {
 	struct picolcd_pending *verinfo;
-	struct hid_report *report;
=20
 	verinfo =3D picolcd_send_and_wait(hdev, REPORT_VERSION, NULL, 0);
 	if (!verinfo || !verinfo->in_report) {
@@ -1948,13 +2345,9 @@ static inline int picolcd_probe_bootloader(struc=
t hid_device *hdev, struct picol
 		return -ENODEV;
 	}
=20
-#ifdef CONFIG_DEBUG_FS
-	report =3D picolcd_out_report(REPORT_BL_READ_MEMORY, hdev);
-	if (report && report->maxfield =3D=3D 1 && report->field[0]->report_s=
ize =3D=3D 8)
-		data->addr_sz =3D report->field[0]->report_count - 1;
-	else
-		data->addr_sz =3D -1;
-#endif
+	picolcd_init_devfs(data, NULL, NULL,
+			picolcd_out_report(REPORT_BL_READ_MEMORY, hdev),
+			picolcd_out_report(REPORT_BL_WRITE_MEMORY, hdev), NULL);
 	return 0;
 }
=20
@@ -2047,6 +2440,7 @@ static void picolcd_remove(struct hid_device *hde=
v)
 	data->status |=3D PICOLCD_FAILED;
 	spin_unlock_irqrestore(&data->lock, flags);
=20
+	picolcd_exit_devfs(data);
 	sysfs_remove_file(&(hdev->dev.kobj), &dev_attr_operation_mode.attr);
 	hdev->ll_driver->close(hdev);
 	hid_hw_stop(hdev);
--=20
1.6.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
