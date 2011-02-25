From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH v2 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Date: Fri, 25 Feb 2011 11:04:52 +0100
Message-ID: <1298628292-8842-4-git-send-email-ospite@studenti.unina.it>
References: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:33923 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932451Ab1BYKIQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Feb 2011 05:08:16 -0500
In-Reply-To: <1298628292-8842-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ospite@studenti.unina.it>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, "Pascal A . Brisset" <pascal44973@pabr.org>, Marcin Tolysz <tolysz@gmail.com>, Christian Birchinger <joker@netswarm.net>, Filipe Lopes <falktx@gmail.com>, Alan Ott <alan@signal11.us>, Mikko Virkkila <virkkila@kapsi.fi>

Add a plugin which handles the connection of a Sixaxis device, when a
new hidraw device is connected the plugin:
 - Filters udev events, and select the Sixaxis device
 - Sets LEDs to match the joystick system number (for USB and BT)
 - Sets the Master bluetooth address in the Sixaxis (USB pairing)
 - Adds the device to the database of the current default
   adapter (BT association)

Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---

Changes since previous version:
 - Use 'sixaxis' as plugin name because this is not a generic cable pairing
   mechanism.
 - Drop dependency on libusb, we can now use hidraw to send feature reports,
   since this patch has been accepted:
   https://patchwork.kernel.org/patch/485671/
 - Other autotools cleanups (use UDEV_LIBS, check for the needed hidraw
   ioctls)
 - Rebase on latest bluez (s/debug/DBG/, use adapter_get_device(), etc.)
 - Misc fixes: change indentation, reorder includes and functions, etc.
 - Add support for setting LEDs according to the joystick system number.
 - Address some of Marcel's comments from the previous submission:
   http://marc.info/?l=linux-bluetooth&m=125525415718147&w=2
   + Use hidraw
   + separate check for UDEV in the autotools changes

A description of the udev part of the plugin can be found here:
http://article.gmane.org/gmane.linux.kernel.input/18435


 Makefile.am       |    9 +-
 acinclude.m4      |   39 ++++
 configure.ac      |    1 +
 plugins/sixaxis.c |  506 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 553 insertions(+), 2 deletions(-)
 create mode 100644 plugins/sixaxis.c

diff --git a/Makefile.am b/Makefile.am
index adf6c84..f72ca19 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -202,6 +202,11 @@ builtin_sources += health/hdp_main.c health/hdp_types.h \
 			health/hdp_util.h health/hdp_util.c
 endif
 
+if SIXAXISPLUGIN
+builtin_modules += sixaxis
+builtin_sources += plugins/sixaxis.c
+endif
+
 builtin_modules += hciops mgmtops
 builtin_sources += plugins/hciops.c plugins/mgmtops.c
 
@@ -247,7 +252,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/dbus-common.c src/dbus-common.h \
 			src/event.h src/event.c
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
-							@CAPNG_LIBS@ -ldl -lrt
+							@CAPNG_LIBS@ @UDEV_LIBS@ -ldl -lrt
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
@@ -363,7 +368,7 @@ EXTRA_DIST += doc/manager-api.txt \
 
 AM_YFLAGS = -d
 
-AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
+AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ @UDEV_CFLAGS@ \
 		-DBLUETOOTH_PLUGIN_BUILTIN -DPLUGINDIR=\""$(plugindir)"\"
 
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
diff --git a/acinclude.m4 b/acinclude.m4
index 91e0956..5437816 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -147,6 +147,35 @@ AC_DEFUN([AC_PATH_USB], [
 			[Define to 1 if you need the usb_interrupt_read() function.]))
 ])
 
+AC_DEFUN([AC_PATH_SIXAXIS], [
+	PKG_CHECK_MODULES(UDEV, libudev, udev_found=yes, udev_found=no)
+	AC_SUBST(UDEV_CFLAGS)
+	AC_SUBST(UDEV_LIBS)
+
+	AC_CACHE_CHECK([for HIDIOCSFEATURE and HIDIOCGFEATURE (for Sixaxis plugin)],
+		[ac_cv_have_HIDIOCxFEATURE],
+		[AC_COMPILE_IFELSE(
+			[AC_LANG_PROGRAM([[
+				#include <sys/ioctl.h>
+				#include <linux/hidraw.h>
+				#if ! (defined(HIDIOCSFEATURE) && defined(HIDIOCGFEATURE))
+				#error "HIDIOCSFEATURE and HIDIOCGFEATURE are required (linux-libc-dev >= 2.6.3x)"
+				#endif
+				]],
+				[]
+			)],[
+				ac_cv_have_HIDIOCxFEATURE=yes
+			],[
+				ac_cv_have_HIDIOCxFEATURE="no, get linux-libc-dev >= 2.6.3x"
+			]
+		)]
+	)
+
+	if ( test "${udev_found}" = "yes" && test "${ac_cv_have_HIDIOCxFEATURE}" = "yes" ); then
+		sixaxis_plugin_deps_found=yes
+	fi
+])
+
 AC_DEFUN([AC_PATH_SNDFILE], [
 	PKG_CHECK_MODULES(SNDFILE, sndfile, sndfile_found=yes, sndfile_found=no)
 	AC_SUBST(SNDFILE_CFLAGS)
@@ -178,6 +207,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	sndfile_enable=${sndfile_found}
 	hal_enable=no
 	usb_enable=${usb_found}
+	sixaxis_enable=${sixaxis_plugin_deps_found}
 	alsa_enable=${alsa_found}
 	gstreamer_enable=${gstreamer_found}
 	audio_enable=yes
@@ -260,6 +290,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		usb_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(sixaxis, AC_HELP_STRING([--enable-sixaxis], [enable Sixaxis plugin]), [
+		sixaxis_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(tracer, AC_HELP_STRING([--enable-tracer], [install Tracing daemon]), [
 		tracer_enable=${enableval}
 	])
@@ -351,6 +385,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		AC_DEFINE(HAVE_LIBUSB, 1, [Define to 1 if you have USB library.])
 	fi
 
+	if (test "${sixaxis_enable}" = "yes" && test "${sixaxis_plugin_deps_found}" = "yes"); then
+		AC_DEFINE(HAVE_SIXAXIS_PLUGIN, 1, [Define to 1 if you have sixaxis plugin.])
+	fi
+
 	AM_CONDITIONAL(SNDFILE, test "${sndfile_enable}" = "yes" && test "${sndfile_found}" = "yes")
 	AM_CONDITIONAL(USB, test "${usb_enable}" = "yes" && test "${usb_found}" = "yes")
 	AM_CONDITIONAL(SBC, test "${alsa_enable}" = "yes" || test "${gstreamer_enable}" = "yes" ||
@@ -383,4 +421,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(UDEVRULES, test "${udevrules_enable}" = "yes")
 	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
 	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
+	AM_CONDITIONAL(SIXAXISPLUGIN, test "${sixaxis_enable}" = "yes" && test "${sixaxis_plugin_deps_found}" = "yes")
 ])
diff --git a/configure.ac b/configure.ac
index 8564e2b..09af33e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,6 +40,7 @@ AC_PATH_GLIB
 AC_PATH_ALSA
 AC_PATH_GSTREAMER
 AC_PATH_USB
+AC_PATH_SIXAXIS
 AC_PATH_SNDFILE
 AC_PATH_OUI
 AC_PATH_READLINE
diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
new file mode 100644
index 0000000..4f7b3c2
--- /dev/null
+++ b/plugins/sixaxis.c
@@ -0,0 +1,506 @@
+/*
+ * sixaxis plugin: do cable association for Sixaxis controller
+ *
+ * Copyright (C) 2009  Bastien Nocera <hadess@hadess.net>
+ * Copyright (C) 2010  Antonio Ospite <ospite@studenti.unina.it>
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+/*
+ * In the following this terminology is used:
+ *
+ *  - controller: a Sixaxis joypad.
+ *  - adapter: the bluetooth dongle on the host system.
+ *  - adapter_bdaddr: the bdaddr of the bluetooth adapter.
+ *  - device_bdaddr: the bdaddr of the Sixaxis controller.
+ *  - master_bdaddr: the bdaddr of the adapter to be configured into the
+ *    Sixaxis controller
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <glib.h>
+#include <linux/hidraw.h>
+
+#define LIBUDEV_I_KNOW_THE_API_IS_SUBJECT_TO_CHANGE 1
+#include <libudev.h>
+
+#include "plugin.h"
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+#include "manager.h"
+#include "storage.h"
+#include "sdp_lib.h"
+
+#define BDADDR_STR_SIZE 18 /* strlen("00:00:00:00:00:00") + 1 */
+
+/* Vendor and product ID for the Sixaxis PS3 controller */
+#define VENDOR 0x054c
+#define PRODUCT 0x0268
+#define SIXAXIS_NAME "PLAYSTATION(R)3 Controller"
+#define SIXAXIS_PNP_RECORD "3601920900000A000100000900013503191124090004350D35061901000900113503190011090006350909656E09006A0901000900093508350619112409010009000D350F350D350619010009001335031900110901002513576972656C65737320436F6E74726F6C6C65720901012513576972656C65737320436F6E74726F6C6C6572090102251B536F6E7920436F6D707574657220456E7465727461696E6D656E740902000901000902010901000902020800090203082109020428010902052801090206359A35980822259405010904A101A102850175089501150026FF00810375019513150025013500450105091901291381027501950D0600FF8103150026FF0005010901A10075089504350046FF0009300931093209358102C0050175089527090181027508953009019102750895300901B102C0A1028502750895300901B102C0A10285EE750895300901B102C0A10285EF750895300901B102C0C0090207350835060904090901000902082800090209280109020A280109020
 B09010009020C093E8009020D280009020E2800"
+#define HID_UUID "00001124-0000-1000-8000-00805f9b34fb"
+
+static struct btd_device *create_sixaxis_association(struct btd_adapter *adapter,
+                                                     const char *name,
+                                                     const char *address,
+                                                     guint32 vendor_id,
+                                                     guint32 product_id,
+                                                     const char *pnp_record)
+{
+	DBusConnection *conn;
+	sdp_record_t *rec;
+	struct btd_device *device;
+	bdaddr_t src, dst;
+	char srcaddr[18];
+
+	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (conn == NULL) {
+		DBG("Failed to get on the bus");
+		return NULL;
+	}
+
+	device = adapter_get_device(conn, adapter, address);
+	if (device != NULL) {
+		device_set_temporary(device, FALSE);
+		device_set_name(device, name);
+	}
+
+	str2ba(address, &dst);
+	adapter_get_address(adapter, &src);
+	ba2str(&src, srcaddr);
+
+	write_device_name(&dst, &src, (char *) name);
+
+	/* Store the device's SDP record */
+	rec = record_from_string(pnp_record);
+	store_record(srcaddr, address, rec);
+	sdp_record_free(rec);
+	/* Set the device id */
+	store_device_id(srcaddr, address, 0xffff, vendor_id, product_id, 0);
+	/* Don't write a profile, it will be updated when the device connects */
+
+	write_trust(srcaddr, address, "[all]", TRUE);
+
+	dbus_connection_unref(conn);
+	return device;
+}
+
+
+/* Usb cable pairing section */
+static unsigned char *get_feature_report(int fd, uint8_t report_number, unsigned int len)
+{
+	unsigned char *buf;
+	int ret;
+
+	buf = calloc(len, sizeof(*buf));
+	if (buf == NULL) {
+		error("%s: calloc failed", __func__);
+		return NULL;
+	}
+
+	buf[0] = report_number;
+
+	ret = ioctl(fd, HIDIOCGFEATURE(len), buf);
+	if (ret < 0) {
+		error("%s: HIDIOCGFEATURE ret = %d", __func__, ret);
+		return NULL;
+	}
+
+	return buf;
+}
+
+static int set_feature_report(int fd, uint8_t *report, int len)
+{
+	int ret;
+
+	ret = ioctl(fd, HIDIOCSFEATURE(len), report);
+	if (ret < 0)
+		error("%s: HIDIOCSFEATURE ret = %d", __func__, ret);
+
+	return ret;
+}
+
+static char *get_device_bdaddr(int fd)
+{
+	unsigned char *buf;
+	char *address;
+
+	buf = get_feature_report(fd, 0xf2, 18);
+	if (buf == NULL) {
+		error("%s: cannot get feature report", __func__);
+		return NULL;
+	}
+
+	address = calloc(BDADDR_STR_SIZE, sizeof(*address));
+	if (address == NULL) {
+		error("%s: calloc failed", __func__);
+		free(buf);
+		return NULL;
+	}
+
+	/* XXX: if we put lowercase hex digits here bluez refuses to associate */
+	snprintf(address, BDADDR_STR_SIZE,
+#if 1
+	         "%02X:%02X:%02X:%02X:%02X:%02X",
+#else
+	         "%02x:%02x:%02x:%02x:%02x:%02x",
+#endif
+	         buf[4], buf[5], buf[6], buf[7], buf[8], buf[9]);
+
+	free(buf);
+	return address;
+}
+
+static gboolean set_master_bdaddr(int fd, char *adapter_bdaddr)
+{
+	uint8_t *report;
+	uint8_t addr[6];
+	int ret;
+
+	ret = sscanf(adapter_bdaddr, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
+	             &addr[0], &addr[1], &addr[2], &addr[3], &addr[4], &addr[5]);
+	if (ret != 6) {
+
+		error("%s: Parsing the bt address failed", __func__);
+		return FALSE;
+	}
+
+	report = malloc(8);
+	if (report == NULL) {
+		error("%s: malloc failed", __func__);
+		return FALSE;
+	}
+
+	report[0] = 0xf5;
+	report[1] = 0x01;
+
+	report[2] = addr[0];
+	report[3] = addr[1];
+	report[4] = addr[2];
+	report[5] = addr[3];
+	report[6] = addr[4];
+	report[7] = addr[5];
+
+	ret = set_feature_report(fd, report, 8);
+	if (ret < 0)
+		error("%s: cannot set feature report", __func__);
+
+	DBG("New Master Bluetooth address: %s", adapter_bdaddr);
+
+	free(report);
+
+	return (ret >= 0);
+}
+
+static int sixpair(int fd, struct btd_adapter *adapter)
+{
+	char *device_bdaddr;
+	char adapter_bdaddr[18];
+	struct btd_device *device;
+	bdaddr_t dst;
+
+	adapter_get_address(adapter, &dst);
+	ba2str(&dst, adapter_bdaddr);
+	DBG("Adapter bdaddr %s", adapter_bdaddr);
+
+	if (set_master_bdaddr(fd, adapter_bdaddr) == FALSE) {
+		DBG("Failed to set the master Bluetooth address");
+		return -1;
+	}
+
+	device_bdaddr = get_device_bdaddr(fd);
+	if (device_bdaddr == NULL) {
+		DBG("Failed to get the Bluetooth address from the device");
+		return -1;
+	}
+
+	DBG("Device bdaddr %s", device_bdaddr);
+
+	device = create_sixaxis_association(adapter,
+	                                    SIXAXIS_NAME,
+	                                    device_bdaddr,
+	                                    VENDOR, PRODUCT, SIXAXIS_PNP_RECORD);
+	if (device)
+		btd_device_add_uuid(device, HID_UUID);
+
+	free(device_bdaddr);
+	return 0;
+}
+
+
+/* Led setting section */
+#define LED_1 (0x01 << 1)
+#define LED_2 (0x01 << 2)
+#define LED_3 (0x01 << 3)
+#define LED_4 (0x01 << 4)
+
+#define LED_STATUS_OFF 0
+#define LED_STATUS_ON  1
+
+static int set_leds(int fd, unsigned char leds_status[4])
+{
+	int ret;
+
+	/*
+	 * the total time the led is active (0xff means forever)
+	 * |     duty_length: how long a cycle is in deciseconds (0 means "blink really fast")
+	 * |     |     ??? (Some form of phase shift or duty_length multiplier?)
+	 * |     |     |     % of duty_length the led is off (0xff means 100%)
+	 * |     |     |     |     % of duty_length the led is on (0xff mean 100%)
+	 * |     |     |     |     |
+	 * 0xff, 0x27, 0x10, 0x00, 0x32,
+	 */
+	unsigned char leds_report[] = {
+		0x01,
+		0x00, 0x00, 0x00, 0x00, 0x00, /* rumble values TBD */
+		0x00, 0x00, 0x00, 0x00, 0x1e, /* LED_1 = 0x02, LED_2 = 0x04, ... */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_4 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_3 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_2 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED_1 */
+		0x00, 0x00, 0x00, 0x00, 0x00,
+	};
+
+	int leds = 0;
+	if (leds_status[0])
+		leds |= LED_1;
+	if (leds_status[1])
+		leds |= LED_2;
+	if (leds_status[2])
+		leds |= LED_3;
+	if (leds_status[3])
+		leds |= LED_4;
+	
+	leds_report[10] = leds;
+
+	ret = write(fd, leds_report, sizeof(leds_report));
+	if (ret < (ssize_t) sizeof(leds_report))
+		perror("Unable to write to hidraw device");
+
+	return ret;
+}
+
+static int set_controller_number(int fd, unsigned int n)
+{
+	unsigned char leds_status[4] = {0, 0, 0, 0};
+
+	switch (n) {
+	case 0:
+		break;
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		leds_status[n - 1] = LED_STATUS_ON;
+		break;
+	case 5:
+	case 6:
+	case 7:
+		leds_status[4 - 1] = LED_STATUS_ON;
+		leds_status[n - 4 - 1] = LED_STATUS_ON;
+		break;
+	default:
+		error("Only 7 controllers supported for now.");
+		return -1;
+	}
+
+	return set_leds(fd, leds_status);
+}
+
+
+static void handle_device_plug(struct udev_device *udevice)
+{
+	struct udev_device *hid_parent;
+	struct udev_enumerate *enumerate;
+	struct udev_list_entry *devices, *dev_list_entry;
+	const char *hid_phys;
+	const char *hidraw_node;
+	unsigned char is_usb = FALSE;
+	int js_num = 0;
+	int fd;
+
+	hid_parent = udev_device_get_parent_with_subsystem_devtype(udevice, "hid", NULL);
+	if (!hid_parent) {
+		error("cannot get parent hid device.");
+		return;
+	}
+
+	if (g_str_has_suffix(udev_device_get_property_value(hid_parent, "HID_NAME"),
+	                     "PLAYSTATION(R)3 Controller") == FALSE)
+		return;
+
+	DBG("Found a Sixaxis device");
+
+	hidraw_node = udev_device_get_devnode(udevice);
+
+	hid_phys = udev_device_get_property_value(hid_parent, "HID_PHYS");
+
+	/* looking for joysticks */
+	enumerate = udev_enumerate_new(udev_device_get_udev(udevice));
+	udev_enumerate_add_match_sysname(enumerate, "js*");
+	udev_enumerate_scan_devices(enumerate);
+
+	devices = udev_enumerate_get_list_entry(enumerate);
+	udev_list_entry_foreach(dev_list_entry, devices) {
+		const char *devname;
+		struct udev_device *js_dev;
+		struct udev_device *input_parent;
+		const char *input_phys;
+
+		devname = udev_list_entry_get_name(dev_list_entry);
+		js_dev = udev_device_new_from_syspath(udev_device_get_udev(udevice), devname);
+
+		input_parent = udev_device_get_parent_with_subsystem_devtype(js_dev, "input", NULL);
+		if (!input_parent) {
+			error("cannot get parent input device.");
+			continue;
+		}
+
+		/* check this is the joystick relative to the hidraw device above */
+		input_phys = udev_device_get_sysattr_value(input_parent, "phys");
+		if (g_strcmp0(input_phys, hid_phys) == 0) {
+			js_num = atoi(udev_device_get_sysnum(js_dev)) + 1;
+			DBG("joypad device_num: %d\n", js_num);
+			DBG("hidraw_node: %s\n", hidraw_node);
+			DBG("driver: %s\n",
+			     udev_device_get_property_value(js_dev, "ID_USB_DRIVER"));
+
+			if (g_strcmp0(udev_device_get_property_value(js_dev, "ID_USB_DRIVER"),
+			              "usbhid") == 0)
+				is_usb = TRUE;
+		}
+
+		udev_device_unref(js_dev);
+	}
+
+	udev_enumerate_unref(enumerate);
+
+	fd = open(hidraw_node, O_RDWR);
+	if (fd < 0) {
+		error("%s: hidraw open", __func__);
+		return;
+	}
+
+	if (js_num > 0)
+		set_controller_number(fd, js_num);
+	if (is_usb) {
+		struct btd_adapter *adapter;
+
+		/* Look for the default adapter */
+		adapter = manager_get_default_adapter();
+		if (adapter == NULL) {
+			DBG("No adapters, exiting");
+			return;
+		}
+		sixpair(fd, adapter);
+	}
+
+	close(fd);
+}
+
+static gboolean device_event_idle(struct udev_device *udevice)
+{
+	handle_device_plug(udevice);
+	udev_device_unref(udevice);
+	return FALSE;
+}
+
+static struct udev *ctx = NULL;
+static struct udev_monitor *monitor = NULL;
+static guint watch_id = 0;
+
+static gboolean
+monitor_event(GIOChannel *source,
+              GIOCondition condition,
+              gpointer data)
+{
+	struct udev_device *udevice;
+
+	udevice = udev_monitor_receive_device(monitor);
+	if (udevice == NULL)
+		goto out;
+	if (g_strcmp0(udev_device_get_action(udevice), "add") != 0) {
+		udev_device_unref(udevice);
+		goto out;
+	}
+
+	g_timeout_add_seconds(1, (GSourceFunc) device_event_idle, udevice);
+
+out:
+	return TRUE;
+}
+
+
+static int sixaxis_init(void)
+{
+	GIOChannel *channel;
+
+	DBG("Setup Sixaxis cable plugin");
+
+	ctx = udev_new();
+	monitor = udev_monitor_new_from_netlink(ctx, "udev");
+	if (monitor == NULL) {
+		error("Could not get udev monitor");
+		return -1;
+	}
+
+	/* Listen for newly connected hidraw interfaces */
+	udev_monitor_filter_add_match_subsystem_devtype(monitor,
+	                                                "hidraw", NULL);
+	udev_monitor_enable_receiving(monitor);
+
+	channel = g_io_channel_unix_new(udev_monitor_get_fd(monitor));
+	watch_id = g_io_add_watch(channel, G_IO_IN, monitor_event, NULL);
+	g_io_channel_unref(channel);
+
+	return 0;
+}
+
+static void sixaxis_exit(void)
+{
+	DBG("Cleanup Sixaxis cable plugin");
+
+	if (watch_id != 0) {
+		g_source_remove(watch_id);
+		watch_id = 0;
+	}
+	if (monitor != NULL) {
+		udev_monitor_unref(monitor);
+		monitor = NULL;
+	}
+	if (ctx != NULL) {
+		udev_unref(ctx);
+		ctx = NULL;
+	}
+}
+
+BLUETOOTH_PLUGIN_DEFINE(sixaxis, VERSION,
+                        BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+                        sixaxis_init, sixaxis_exit)
-- 
1.7.4.1

