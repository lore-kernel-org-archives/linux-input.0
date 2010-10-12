From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH 1/2] Add acer wmi hotkey events support
Date: Mon, 11 Oct 2010 19:56:41 -0600
Message-ID: <4CB45B090200002300021A60@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part1E33EC49.4__="
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: Takashi Iwai <tiwai@novell.com>, Thomas Renninger <trenn@novell.com>, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part1E33EC49.4__=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Hi Dmitry,

於 五，2010-10-01 於 09:58 -0700，Dmitry Torokhov 提到：
> Hi Lee,
> 
> On Fri, Oct 01, 2010 at 09:51:27PM +0800, Lee, Chun-Yi wrote:
> > +
> > +struct key_entry {
> > +	char type;	/* See KE_* below */
> > +	u16 code;
> > +	u16 keycode;
> > +};
> > +
> > +enum { KE_KEY, KE_END };
> > +
> 
> Like Corentin said, please use sparse_keymap, it will cut the code in
> half.
> 

Thank's for your and Corentin's suggestion, I already used sparse keymap
framework.

> > +
> > +	set_bit(EV_SW, acer_wmi_input_dev->evbit);
> > +
> 
> I do not see you sending SW_* events...
> 
> > +	err = input_register_device(acer_wmi_input_dev);
> > +
> > +	if (err) {
> > +		input_free_device(acer_wmi_input_dev);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * debugfs functions
> >   */
> > @@ -1327,6 +1518,18 @@ static int __init acer_wmi_init(void)
> >  		       "generic video driver\n");
> >  	}
> >  
> > +	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
> > +		err = wmi_install_notify_handler(ACERWMID_EVENT_GUID,
> > +						acer_wmi_notify, NULL);
> > +		if (ACPI_FAILURE(err))
> > +			return -EINVAL;
> > +		err = acer_wmi_input_setup();
> 
> You really want to set up the device first and install notify handler
> later. What will happen if event will fire up while input device has not
> been created yet?
> 
> > +		if (err) {
> > +			wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
> > +			return err;
> > +		}
> > +	}
> > +
> >  	err = platform_driver_register(&acer_platform_driver);
> >  	if (err) {
> >  		printk(ACER_ERR "Unable to register platform driver.\n");
> > @@ -1368,11 +1571,21 @@ error_device_add:
> >  error_device_alloc:
> >  	platform_driver_unregister(&acer_platform_driver);
> >  error_platform_register:
> > +	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
> > +		input_unregister_device(acer_wmi_input_dev);
> > +		wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
> 
> Same here, first shut off notified, then remove the device.
> 
> > +	}
> > +
> >  	return err;
> >  }
> >  
> >  static void __exit acer_wmi_exit(void)
> >  {
> > +	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
> > +		wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
> > +		input_unregister_device(acer_wmi_input_dev);
> 
> Same here.
> 
> Thanks.
> 

Thank's for your review, I modified 2 patches like the following. I also
attached those 2 patches on this mail.

Thank's a lot
Joey Lee

>From 0e6f011a9a2219a47c93aa68433ba457ae1068e5 Mon Sep 17 00:00:00 2001
From: Lee, Chun-Yi <jlee@novell.com>
Date: Tue, 12 Oct 2010 09:26:29 +0800
Subject: [PATCH 1/2] Add acer wmi hotkey events support

Add acer wmi hotkey event support. Install a wmi notify handler to
transfer wmi event key to key code, then send out keycode through acer
wmi input device to userland.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/Kconfig    |    2 +
 drivers/platform/x86/acer-wmi.c |  139
+++++++++++++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index cff7cc2..c242fdd 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -23,7 +23,9 @@ config ACER_WMI
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on SERIO_I8042
 	depends on RFKILL || RFKILL = n
+	depends on INPUT
 	select ACPI_WMI
+	select INPUT_SPARSEKMAP
 	---help---
 	  This is a driver for newer Acer (and Wistron) laptops. It adds
 	  wireless radio and bluetooth control, and on some laptops,
diff --git a/drivers/platform/x86/acer-wmi.c
b/drivers/platform/x86/acer-wmi.c
index 2badee2..32285f4 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -37,6 +37,8 @@
 #include <linux/workqueue.h>
 #include <linux/debugfs.h>
 #include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -48,6 +50,7 @@ MODULE_LICENSE("GPL");
 #define ACER_ERR KERN_ERR ACER_LOGPREFIX
 #define ACER_NOTICE KERN_NOTICE ACER_LOGPREFIX
 #define ACER_INFO KERN_INFO ACER_LOGPREFIX
+#define ACER_WARNING KERN_WARNING ACER_LOGPREFIX
 
 /*
  * Magic Number
@@ -83,8 +86,39 @@ MODULE_LICENSE("GPL");
 #define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
 #define WMID_GUID2		"95764E09-FB56-4e83-B31A-37761F60994A"
 
+/*
+ * Acer ACPI event GUIDs
+ */
+#define ACERWMID_EVENT_GUID "676AA15E-6A47-4D9F-A2CC-1E6D18D14026"
+
 MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");
 MODULE_ALIAS("wmi:6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3");
+MODULE_ALIAS("wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");
+
+enum acer_wmi_event_ids {
+	WMID_HOTKEY_EVENT = 0x1,
+};
+
+static const struct key_entry acer_wmi_keymap[] = {
+	{KE_KEY, 0x01, {KEY_WLAN} },     /* WiFi */
+	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */
+	{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */
+	{KE_KEY, 0x22, {KEY_PROG2} },    /* Aracade */
+	{KE_KEY, 0x23, {KEY_PROG3} },    /* P_Key */
+	{KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_Key */
+	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */
+	{KE_KEY, 0x82, {KEY_F22} },      /* Touch Pad On/Off */
+	{KE_END, 0}
+};
+
+static struct input_dev *acer_wmi_input_dev;
+
+struct event_return_value {
+	u8 function;
+	u8 key_num;
+	u16 device_state;
+	u32 reserved;
+} __attribute__((packed));
 
 /*
  * Interface capability flags
@@ -1085,6 +1119,99 @@ static ssize_t show_interface(struct device *dev,
struct device_attribute *attr,
 
 static DEVICE_ATTR(interface, S_IRUGO, show_interface, NULL);
 
+static void acer_wmi_notify(u32 value, void *context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *obj;
+	struct event_return_value return_value;
+	acpi_status status;
+
+	status = wmi_get_event_data(value, &response);
+	if (status != AE_OK) {
+		printk(ACER_WARNING "bad event status 0x%x\n", status);
+		return;
+	}
+
+	obj = (union acpi_object *)response.pointer;
+
+	if (!obj)
+		return;
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		printk(ACER_WARNING "Unknown response received %d\n",
+			obj->type);
+		kfree(obj);
+		return;
+	}
+	if (obj->buffer.length != 8) {
+		printk(ACER_WARNING "Unknown buffer length %d\n",
+			obj->buffer.length);
+		kfree(obj);
+		return;
+	}
+
+	return_value = *((struct event_return_value *)obj->buffer.pointer);
+	kfree(obj);
+
+	switch (return_value.function) {
+	case WMID_HOTKEY_EVENT:
+		if (!sparse_keymap_report_event(acer_wmi_input_dev,
+				return_value.key_num, 1, true))
+			printk(ACER_WARNING "Unknown key number - 0x%x\n",
+				return_value.key_num);
+		break;
+	default:
+		printk(ACER_WARNING "Unknown function number - %d - %d\n",
+			return_value.function, return_value.key_num);
+		break;
+	}
+}
+
+static int __init acer_wmi_input_setup(void)
+{
+	acpi_status status;
+	int err;
+
+	acer_wmi_input_dev = input_allocate_device();
+	if (!acer_wmi_input_dev)
+		return -ENOMEM;
+
+	acer_wmi_input_dev->name = "Acer WMI hotkeys";
+	acer_wmi_input_dev->phys = "wmi/input0";
+	acer_wmi_input_dev->id.bustype = BUS_HOST;
+
+	err = sparse_keymap_setup(acer_wmi_input_dev, acer_wmi_keymap, NULL);
+	if (err)
+		goto err_free_dev;
+
+	err = input_register_device(acer_wmi_input_dev);
+	if (err)
+		goto err_free_keymap;
+
+	status = wmi_install_notify_handler(ACERWMID_EVENT_GUID,
+						acer_wmi_notify, NULL);
+	if (ACPI_FAILURE(status)) {
+		err = -EIO;
+		goto err_unregister_input;
+	}
+
+	return 0;
+
+err_unregister_input:
+	input_unregister_device(acer_wmi_input_dev);
+err_free_keymap:
+	sparse_keymap_free(acer_wmi_input_dev);
+err_free_dev:
+	input_free_device(acer_wmi_input_dev);
+	return err;
+}
+
+static void acer_wmi_input_destroy(void)
+{
+	wmi_remove_notify_handler(ACERWMID_EVENT_GUID);
+	sparse_keymap_free(acer_wmi_input_dev);
+	input_unregister_device(acer_wmi_input_dev);
+}
+
 /*
  * debugfs functions
  */
@@ -1327,6 +1454,12 @@ static int __init acer_wmi_init(void)
 		       "generic video driver\n");
 	}
 
+	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
+		err = acer_wmi_input_setup();
+		if (err)
+			return err;
+	}
+
 	err = platform_driver_register(&acer_platform_driver);
 	if (err) {
 		printk(ACER_ERR "Unable to register platform driver.\n");
@@ -1368,11 +1501,17 @@ error_device_add:
 error_device_alloc:
 	platform_driver_unregister(&acer_platform_driver);
 error_platform_register:
+	if (wmi_has_guid(ACERWMID_EVENT_GUID))
+		acer_wmi_input_destroy();
+
 	return err;
 }
 
 static void __exit acer_wmi_exit(void)
 {
+	if (wmi_has_guid(ACERWMID_EVENT_GUID))
+		acer_wmi_input_destroy();
+
 	remove_sysfs(acer_platform_device);
 	remove_debugfs();
 	platform_device_unregister(acer_platform_device);
-- 
1.6.0.2

>From 1957b6b7cd071de95c0e1fb0e35cd5c9c9332630 Mon Sep 17 00:00:00 2001
From: Lee, Chun-Yi <jlee@novell.com>
Date: Tue, 12 Oct 2010 09:27:23 +0800
Subject: [PATCH 2/2] Support enable Acer Launch Manager mode

Add a launch_manager parameter for support to enable Acer Launch Manager
mode. After enable it, the communication key will stop the default
behavior to control WLAN/Bluetooth/WWAN rfkill state. It leave usernland
application to handle the rfkill state changed.

Signed-off-by: Lee, Chun-Yi <jlee@novell.com>
---
 drivers/platform/x86/acer-wmi.c |   74
+++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c
b/drivers/platform/x86/acer-wmi.c
index 32285f4..a28a775 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -85,6 +85,7 @@ MODULE_LICENSE("GPL");
 #define AMW0_GUID2		"431F16ED-0C2B-444C-B267-27DEB140CF9C"
 #define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
 #define WMID_GUID2		"95764E09-FB56-4e83-B31A-37761F60994A"
+#define WMID_GUID3		"61EF69EA-865C-4BC3-A502-A0DEBA0CB531"
 
 /*
  * Acer ACPI event GUIDs
@@ -120,6 +121,20 @@ struct event_return_value {
 	u32 reserved;
 } __attribute__((packed));
 
+struct lm_input_params {
+	u8 function_num;	/* Function Number */
+	u16 commun_devices;	/* Communication type devices default status */
+	u16 devices;		/* Other type devices default status */
+	u8 lm_status;		/* Launch Manager Status */
+	u16 reserved;
+} __attribute__((packed));
+
+struct lm_return_value {
+	u8 error_code;		/* Error Code */
+	u8 ec_return_value;	/* EC Return Value */
+	u16 reserved;
+} __attribute__((packed));
+
 /*
  * Interface capability flags
  */
@@ -150,15 +165,18 @@ static int mailled = -1;
 static int brightness = -1;
 static int threeg = -1;
 static int force_series;
+static bool launch_manager;
 
 module_param(mailled, int, 0444);
 module_param(brightness, int, 0444);
 module_param(threeg, int, 0444);
 module_param(force_series, int, 0444);
+module_param(launch_manager, bool, 0444);
 MODULE_PARM_DESC(mailled, "Set initial state of Mail LED");
 MODULE_PARM_DESC(brightness, "Set initial LCD backlight brightness");
 MODULE_PARM_DESC(threeg, "Set initial state of 3G hardware");
 MODULE_PARM_DESC(force_series, "Force a different laptop series");
+MODULE_PARM_DESC(launch_manager, "Enable Acer Launch Manager mode");
 
 struct acer_data {
 	int mailled;
@@ -1393,6 +1411,53 @@ error_debugfs:
 	return -ENOMEM;
 }
 
+static int acer_wmi_enable_lm(void)
+{
+	struct lm_return_value return_value;
+	acpi_status status;
+	union acpi_object *obj;
+	struct lm_input_params params = {
+		.function_num = 0x1,
+		.commun_devices = 0x0041,	/* WiFi on, 3G on, BT off */
+		.devices = 0xFFFF,
+		.lm_status = 0x41,		/* Launch Manager Active */
+	};
+
+	struct acpi_buffer input = { sizeof(struct lm_input_params),
&params };
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+
+	status = wmi_evaluate_method(WMID_GUID3, 0, 0x1, &input, &output);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	obj = output.pointer;
+
+	if (!obj)
+		return -EINVAL;
+	else if (obj->type != ACPI_TYPE_BUFFER) {
+		kfree(obj);
+		return -EINVAL;
+	}
+	if (obj->buffer.length != 4) {
+		printk(ACER_WARNING "Unknown buffer length %d\n",
+			obj->buffer.length);
+		kfree(obj);
+		return -EINVAL;
+	}
+
+	return_value = *((struct lm_return_value *)obj->buffer.pointer);
+	kfree(obj);
+
+	if (return_value.error_code || return_value.ec_return_value)
+		printk(ACER_WARNING "Enabling Launch Manager failed: "
+			"0x%x - 0x%x\n", return_value.error_code,
+			return_value.ec_return_value);
+	else
+		printk(ACER_INFO "Enabled Launch Manager");
+
+	return status;
+}
+
 static int __init acer_wmi_init(void)
 {
 	int err;
@@ -1454,6 +1519,15 @@ static int __init acer_wmi_init(void)
 		       "generic video driver\n");
 	}
 
+	if (wmi_has_guid(WMID_GUID3) && launch_manager) {
+		if (ACPI_FAILURE(acer_wmi_enable_lm())) {
+			printk(ACER_ERR "Cannot enable Launch Manager mode\n");
+			return -ENODEV;
+		}
+	} else if (!wmi_has_guid(WMID_GUID3) && launch_manager) {
+		printk(ACER_INFO "No WMID launch manager enable method\n");
+	}
+
 	if (wmi_has_guid(ACERWMID_EVENT_GUID)) {
 		err = acer_wmi_input_setup();
 		if (err)
-- 
1.6.0.2






--=__Part1E33EC49.4__=
Content-Type: text/plain; name="0001-Add-acer-wmi-hotkey-events-support.PATCH"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0001-Add-acer-wmi-hotkey-events-support.PATCH"

>From 0e6f011a9a2219a47c93aa68433ba457ae1068e5 Mon Sep 17 00:00:00 =
2001=0AFrom: Lee, Chun-Yi <jlee@novell.com>=0ADate: Tue, 12 Oct 2010 =
09:26:29 +0800=0ASubject: [PATCH 1/2] Add acer wmi hotkey events support=0A=
=0AAdd acer wmi hotkey event support. Install a wmi notify handler =
to=0Atransfer wmi event key to key code, then send out keycode through =
acer=0Awmi input device to userland.=0A=0ASigned-off-by: Lee, Chun-Yi =
<jlee@novell.com>=0A---=0A drivers/platform/x86/Kconfig    |    2 +=0A =
drivers/platform/x86/acer-wmi.c |  139 ++++++++++++++++++++++++++++++++++++=
+++=0A 2 files changed, 141 insertions(+), 0 deletions(-)=0A=0Adiff --git =
a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig=0Aindex =
cff7cc2..c242fdd 100644=0A--- a/drivers/platform/x86/Kconfig=0A+++ =
b/drivers/platform/x86/Kconfig=0A@@ -23,7 +23,9 @@ config ACER_WMI=0A 	=
depends on BACKLIGHT_CLASS_DEVICE=0A 	depends on SERIO_I8042=0A 	=
depends on RFKILL || RFKILL =3D n=0A+	depends on INPUT=0A 	select =
ACPI_WMI=0A+	select INPUT_SPARSEKMAP=0A 	---help---=0A 	  This is =
a driver for newer Acer (and Wistron) laptops. It adds=0A 	  wireless =
radio and bluetooth control, and on some laptops,=0Adiff --git a/drivers/pl=
atform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c=0Aindex 2badee2..32=
285f4 100644=0A--- a/drivers/platform/x86/acer-wmi.c=0A+++ b/drivers/platfo=
rm/x86/acer-wmi.c=0A@@ -37,6 +37,8 @@=0A #include <linux/workqueue.h>=0A =
#include <linux/debugfs.h>=0A #include <linux/slab.h>=0A+#include =
<linux/input.h>=0A+#include <linux/input/sparse-keymap.h>=0A =0A #include =
<acpi/acpi_drivers.h>=0A =0A@@ -48,6 +50,7 @@ MODULE_LICENSE("GPL");=0A =
#define ACER_ERR KERN_ERR ACER_LOGPREFIX=0A #define ACER_NOTICE KERN_NOTICE=
 ACER_LOGPREFIX=0A #define ACER_INFO KERN_INFO ACER_LOGPREFIX=0A+#define =
ACER_WARNING KERN_WARNING ACER_LOGPREFIX=0A =0A /*=0A  * Magic Number=0A@@ =
-83,8 +86,39 @@ MODULE_LICENSE("GPL");=0A #define WMID_GUID1		=
"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"=0A #define WMID_GUID2		=
"95764E09-FB56-4e83-B31A-37761F60994A"=0A =0A+/*=0A+ * Acer ACPI event =
GUIDs=0A+ */=0A+#define ACERWMID_EVENT_GUID "676AA15E-6A47-4D9F-A2CC-1E6D18=
D14026"=0A+=0A MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");=0A=
 MODULE_ALIAS("wmi:6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3");=0A+MODULE_ALIAS(=
"wmi:676AA15E-6A47-4D9F-A2CC-1E6D18D14026");=0A+=0A+enum acer_wmi_event_ids=
 {=0A+	WMID_HOTKEY_EVENT =3D 0x1,=0A+};=0A+=0A+static const struct =
key_entry acer_wmi_keymap[] =3D {=0A+	{KE_KEY, 0x01, {KEY_WLAN} },     =
/* WiFi */=0A+	{KE_KEY, 0x12, {KEY_BLUETOOTH} },	/* BT */=0A+	=
{KE_KEY, 0x21, {KEY_PROG1} },    /* Backup */=0A+	{KE_KEY, 0x22, =
{KEY_PROG2} },    /* Aracade */=0A+	{KE_KEY, 0x23, {KEY_PROG3} },    =
/* P_Key */=0A+	{KE_KEY, 0x24, {KEY_PROG4} },    /* Social networking_Key =
*/=0A+	{KE_KEY, 0x64, {KEY_SWITCHVIDEOMODE} },	/* Display Switch */=0A+	=
{KE_KEY, 0x82, {KEY_F22} },      /* Touch Pad On/Off */=0A+	{KE_END, =
0}=0A+};=0A+=0A+static struct input_dev *acer_wmi_input_dev;=0A+=0A+struct =
event_return_value {=0A+	u8 function;=0A+	u8 key_num;=0A+	=
u16 device_state;=0A+	u32 reserved;=0A+} __attribute__((packed));=0A =0A =
/*=0A  * Interface capability flags=0A@@ -1085,6 +1119,99 @@ static =
ssize_t show_interface(struct device *dev, struct device_attribute =
*attr,=0A =0A static DEVICE_ATTR(interface, S_IRUGO, show_interface, =
NULL);=0A =0A+static void acer_wmi_notify(u32 value, void *context)=0A+{=0A=
+	struct acpi_buffer response =3D { ACPI_ALLOCATE_BUFFER, NULL =
};=0A+	union acpi_object *obj;=0A+	struct event_return_value =
return_value;=0A+	acpi_status status;=0A+=0A+	status =3D =
wmi_get_event_data(value, &response);=0A+	if (status !=3D AE_OK) =
{=0A+		printk(ACER_WARNING "bad event status 0x%x\n", status);=0A+=
		return;=0A+	}=0A+=0A+	obj =3D (union acpi_object =
*)response.pointer;=0A+=0A+	if (!obj)=0A+		return;=0A+	if =
(obj->type !=3D ACPI_TYPE_BUFFER) {=0A+		printk(ACER_WARNING =
"Unknown response received %d\n",=0A+			obj->type);=0A+		=
kfree(obj);=0A+		return;=0A+	}=0A+	if (obj->buffer.length =
!=3D 8) {=0A+		printk(ACER_WARNING "Unknown buffer length =
%d\n",=0A+			obj->buffer.length);=0A+		=
kfree(obj);=0A+		return;=0A+	}=0A+=0A+	return_value =3D =
*((struct event_return_value *)obj->buffer.pointer);=0A+	kfree(obj);=
=0A+=0A+	switch (return_value.function) {=0A+	case WMID_HOTKEY_EV=
ENT:=0A+		if (!sparse_keymap_report_event(acer_wmi_input_dev,=
=0A+				return_value.key_num, 1, true))=0A+		=
	printk(ACER_WARNING "Unknown key number - 0x%x\n",=0A+			=
	return_value.key_num);=0A+		break;=0A+	default:=0A=
+		printk(ACER_WARNING "Unknown function number - %d - =
%d\n",=0A+			return_value.function, return_value.key_num=
);=0A+		break;=0A+	}=0A+}=0A+=0A+static int __init acer_wmi_in=
put_setup(void)=0A+{=0A+	acpi_status status;=0A+	int err;=0A+=0A+	=
acer_wmi_input_dev =3D input_allocate_device();=0A+	if (!acer_wmi_input=
_dev)=0A+		return -ENOMEM;=0A+=0A+	acer_wmi_input_dev->name =
=3D "Acer WMI hotkeys";=0A+	acer_wmi_input_dev->phys =3D "wmi/input0";=
=0A+	acer_wmi_input_dev->id.bustype =3D BUS_HOST;=0A+=0A+	err =3D =
sparse_keymap_setup(acer_wmi_input_dev, acer_wmi_keymap, NULL);=0A+	if =
(err)=0A+		goto err_free_dev;=0A+=0A+	err =3D input_regis=
ter_device(acer_wmi_input_dev);=0A+	if (err)=0A+		goto =
err_free_keymap;=0A+=0A+	status =3D wmi_install_notify_handler(ACERW=
MID_EVENT_GUID,=0A+						acer_wmi_no=
tify, NULL);=0A+	if (ACPI_FAILURE(status)) {=0A+		err =3D =
-EIO;=0A+		goto err_unregister_input;=0A+	}=0A+=0A+	=
return 0;=0A+=0A+err_unregister_input:=0A+	input_unregister_device(ace=
r_wmi_input_dev);=0A+err_free_keymap:=0A+	sparse_keymap_free(acer_wmi=
_input_dev);=0A+err_free_dev:=0A+	input_free_device(acer_wmi_input_de=
v);=0A+	return err;=0A+}=0A+=0A+static void acer_wmi_input_destroy(void)=0A=
+{=0A+	wmi_remove_notify_handler(ACERWMID_EVENT_GUID);=0A+	sparse_keym=
ap_free(acer_wmi_input_dev);=0A+	input_unregister_device(acer_wmi_in=
put_dev);=0A+}=0A+=0A /*=0A  * debugfs functions=0A  */=0A@@ -1327,6 =
+1454,12 @@ static int __init acer_wmi_init(void)=0A 		       =
"generic video driver\n");=0A 	}=0A =0A+	if (wmi_has_guid(ACERWMID_E=
VENT_GUID)) {=0A+		err =3D acer_wmi_input_setup();=0A+		=
if (err)=0A+			return err;=0A+	}=0A+=0A 	err =3D =
platform_driver_register(&acer_platform_driver);=0A 	if (err) {=0A 		=
printk(ACER_ERR "Unable to register platform driver.\n");=0A@@ -1368,11 =
+1501,17 @@ error_device_add:=0A error_device_alloc:=0A 	platform_dr=
iver_unregister(&acer_platform_driver);=0A error_platform_register:=0A+	if =
(wmi_has_guid(ACERWMID_EVENT_GUID))=0A+		acer_wmi_input_destroy();=
=0A+=0A 	return err;=0A }=0A =0A static void __exit acer_wmi_exit(vo=
id)=0A {=0A+	if (wmi_has_guid(ACERWMID_EVENT_GUID))=0A+		=
acer_wmi_input_destroy();=0A+=0A 	remove_sysfs(acer_platform_device);=
=0A 	remove_debugfs();=0A 	platform_device_unregister(acer_platform_de=
vice);=0A-- =0A1.6.0.2=0A=0A
--=__Part1E33EC49.4__=
Content-Type: text/plain; name="0002-Support-enable-Acer-Launch-Manager-mode.PATCH"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="0002-Support-enable-Acer-Launch-Manager-mode.PATCH"

>From 1957b6b7cd071de95c0e1fb0e35cd5c9c9332630 Mon Sep 17 00:00:00 =
2001=0AFrom: Lee, Chun-Yi <jlee@novell.com>=0ADate: Tue, 12 Oct 2010 =
09:27:23 +0800=0ASubject: [PATCH 2/2] Support enable Acer Launch Manager =
mode=0A=0AAdd a launch_manager parameter for support to enable Acer Launch =
Manager=0Amode. After enable it, the communication key will stop the =
default=0Abehavior to control WLAN/Bluetooth/WWAN rfkill state. It leave =
usernland=0Aapplication to handle the rfkill state changed.=0A=0ASigned-off=
-by: Lee, Chun-Yi <jlee@novell.com>=0A---=0A drivers/platform/x86/acer-wmi.=
c |   74 +++++++++++++++++++++++++++++++++++++++=0A 1 files changed, 74 =
insertions(+), 0 deletions(-)=0A=0Adiff --git a/drivers/platform/x86/acer-w=
mi.c b/drivers/platform/x86/acer-wmi.c=0Aindex 32285f4..a28a775 100644=0A--=
- a/drivers/platform/x86/acer-wmi.c=0A+++ b/drivers/platform/x86/acer-wmi.c=
=0A@@ -85,6 +85,7 @@ MODULE_LICENSE("GPL");=0A #define AMW0_GUID2		=
"431F16ED-0C2B-444C-B267-27DEB140CF9C"=0A #define WMID_GUID1		=
"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"=0A #define WMID_GUID2		=
"95764E09-FB56-4e83-B31A-37761F60994A"=0A+#define WMID_GUID3		=
"61EF69EA-865C-4BC3-A502-A0DEBA0CB531"=0A =0A /*=0A  * Acer ACPI event =
GUIDs=0A@@ -120,6 +121,20 @@ struct event_return_value {=0A 	u32 =
reserved;=0A } __attribute__((packed));=0A =0A+struct lm_input_params =
{=0A+	u8 function_num;	/* Function Number */=0A+	u16 =
commun_devices;	/* Communication type devices default status */=0A+	=
u16 devices;		/* Other type devices default status */=0A+	u8 =
lm_status;		/* Launch Manager Status */=0A+	u16 reserved;=0A+} =
__attribute__((packed));=0A+=0A+struct lm_return_value {=0A+	u8 =
error_code;		/* Error Code */=0A+	u8 ec_return_value;	/* =
EC Return Value */=0A+	u16 reserved;=0A+} __attribute__((packed));=0A+=0A =
/*=0A  * Interface capability flags=0A  */=0A@@ -150,15 +165,18 @@ static =
int mailled =3D -1;=0A static int brightness =3D -1;=0A static int threeg =
=3D -1;=0A static int force_series;=0A+static bool launch_manager;=0A =0A =
module_param(mailled, int, 0444);=0A module_param(brightness, int, =
0444);=0A module_param(threeg, int, 0444);=0A module_param(force_series, =
int, 0444);=0A+module_param(launch_manager, bool, 0444);=0A MODULE_PARM_DES=
C(mailled, "Set initial state of Mail LED");=0A MODULE_PARM_DESC(brightness=
, "Set initial LCD backlight brightness");=0A MODULE_PARM_DESC(threeg, =
"Set initial state of 3G hardware");=0A MODULE_PARM_DESC(force_series, =
"Force a different laptop series");=0A+MODULE_PARM_DESC(launch_manager, =
"Enable Acer Launch Manager mode");=0A =0A struct acer_data {=0A 	=
int mailled;=0A@@ -1393,6 +1411,53 @@ error_debugfs:=0A 	return =
-ENOMEM;=0A }=0A =0A+static int acer_wmi_enable_lm(void)=0A+{=0A+	=
struct lm_return_value return_value;=0A+	acpi_status status;=0A+	=
union acpi_object *obj;=0A+	struct lm_input_params params =3D {=0A+		=
.function_num =3D 0x1,=0A+		.commun_devices =3D 0x0041,	/* =
WiFi on, 3G on, BT off */=0A+		.devices =3D 0xFFFF,=0A+		=
.lm_status =3D 0x41,		/* Launch Manager Active */=0A+	};=0A+=0A+	=
struct acpi_buffer input =3D { sizeof(struct lm_input_params), &params =
};=0A+	struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL =
};=0A+=0A+	status =3D wmi_evaluate_method(WMID_GUID3, 0, 0x1, &input, =
&output);=0A+	if (ACPI_FAILURE(status))=0A+		return status;=0A+=
=0A+	obj =3D output.pointer;=0A+=0A+	if (!obj)=0A+		return =
-EINVAL;=0A+	else if (obj->type !=3D ACPI_TYPE_BUFFER) {=0A+		=
kfree(obj);=0A+		return -EINVAL;=0A+	}=0A+	if (obj->buffer.len=
gth !=3D 4) {=0A+		printk(ACER_WARNING "Unknown buffer length =
%d\n",=0A+			obj->buffer.length);=0A+		=
kfree(obj);=0A+		return -EINVAL;=0A+	}=0A+=0A+	return_valu=
e =3D *((struct lm_return_value *)obj->buffer.pointer);=0A+	kfree(obj);=
=0A+=0A+	if (return_value.error_code || return_value.ec_return_value=
)=0A+		printk(ACER_WARNING "Enabling Launch Manager failed: "=0A+	=
		"0x%x - 0x%x\n", return_value.error_code,=0A+			=
return_value.ec_return_value);=0A+	else=0A+		printk(ACER=
_INFO "Enabled Launch Manager");=0A+=0A+	return status;=0A+}=0A+=0A =
static int __init acer_wmi_init(void)=0A {=0A 	int err;=0A@@ -1454,6 =
+1519,15 @@ static int __init acer_wmi_init(void)=0A 		       =
"generic video driver\n");=0A 	}=0A =0A+	if (wmi_has_guid(WMID_GUID3=
) && launch_manager) {=0A+		if (ACPI_FAILURE(acer_wmi_enable_lm=
())) {=0A+			printk(ACER_ERR "Cannot enable Launch =
Manager mode\n");=0A+			return -ENODEV;=0A+		=
}=0A+	} else if (!wmi_has_guid(WMID_GUID3) && launch_manager) {=0A+		=
printk(ACER_INFO "No WMID launch manager enable method\n");=0A+	}=0A+=0A 	=
if (wmi_has_guid(ACERWMID_EVENT_GUID)) {=0A 		err =3D acer_wmi_in=
put_setup();=0A 		if (err)=0A-- =0A1.6.0.2=0A=0A
--=__Part1E33EC49.4__=--
