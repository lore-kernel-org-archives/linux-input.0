From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: [PATCH v6 7/8, needs improvement] hid: add suspend/resume hooks for
 hid drivers
Date: Tue, 30 Mar 2010 22:42:30 +0200
Message-ID: <20100330224230.7b84df75@neptune.home>
References: <20100324233707.7243b04d@neptune.home>
	<20100324234022.0361bd80@neptune.home>
	<20100326065656.GC26602@core.coreip.homeip.net>
	<20100326102951.3b9ecda1@neptune.home>
	<alpine.LNX.2.00.1003262156280.24576@pobox.suse.cz>
	<20100327012245.0ace6a09@neptune.home>
	<alpine.LNX.2.00.1003291144350.24576@pobox.suse.cz>
	<20100329121611.0c22dcaf@pluto.restena.lu>
	<alpine.LNX.2.00.1003301010410.24576@pobox.suse.cz>
	<20100330223224.18fe4f3e@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100330223224.18fe4f3e@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Rick L. Vinyard Jr." <rvinyard@cs.nmsu.edu>, Nicu Pavel <npavel@ituner.com>, Oliver Neukum <oliver@neukum.org>, Jaya Kumar <jayakumar.lkml@gmail.com>
List-Id: linux-input@vger.kernel.org

Add suspend/resume hooks for HID drivers so these can do some
additional state adjustment when device gets suspended/resumed.

This patch calls these hooks from usbhid suspend/resume functions,
only calling suspend on plain suspend, not autosuspend.
(it might be worth adding an autosuspend parameter to suspend
hook and calling suspend in both cases)

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
---

Note:
  this patch needs improvements as mentionned by Olivier Neukum:
  - suspend hook for both system suspend and autosuspend
  - no call of hook on USB-HID-resume failure


 drivers/hid/usbhid/hid-core.c |   19 ++++++++++++++++++-
 include/linux/hid.h           |    8 ++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
index 3e7909b..9acf573 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1298,6 +1298,11 @@ static int hid_suspend(struct usb_interface *int=
f, pm_message_t message)
 		}
=20
 	} else {
+		if (hid->driver && hid->driver->suspend) {
+			status =3D hid->driver->suspend(hid);
+			if (status < 0)
+				return status;
+		}
 		spin_lock_irq(&usbhid->lock);
 		set_bit(HID_REPORTED_IDLE, &usbhid->iofl);
 		spin_unlock_irq(&usbhid->lock);
@@ -1352,6 +1357,11 @@ static int hid_resume(struct usb_interface *intf=
)
 		hid_io_error(hid);
 	usbhid_restart_queues(usbhid);
=20
+	if (hid->driver && hid->driver->resume) {
+		int ret =3D hid->driver->resume(hid);
+		if (ret < 0 && status =3D=3D 0)
+			status =3D ret;
+	}
 	dev_dbg(&intf->dev, "resume status %d\n", status);
 	return 0;
 }
@@ -1360,9 +1370,16 @@ static int hid_reset_resume(struct usb_interface=
 *intf)
 {
 	struct hid_device *hid =3D usb_get_intfdata(intf);
 	struct usbhid_device *usbhid =3D hid->driver_data;
+	int status;
=20
 	clear_bit(HID_REPORTED_IDLE, &usbhid->iofl);
-	return hid_post_reset(intf);
+	status =3D hid_post_reset(intf);
+	if (hid->driver && hid->driver->reset_resume) {
+		int ret =3D hid->driver->reset_resume(hid);
+		if (ret < 0 && status =3D=3D 0)
+			status =3D ret;
+	}
+	return status;
 }
=20
 #endif /* CONFIG_PM */
diff --git a/include/linux/hid.h b/include/linux/hid.h
index b1344ec..fcf3e5c 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -589,6 +589,9 @@ struct hid_usage_id {
  * @report_fixup: called before report descriptor parsing (NULL means =
nop)
  * @input_mapping: invoked on input registering before mapping an usag=
e
  * @input_mapped: invoked on input registering after mapping an usage
+ * @suspend: invoked on suspend (NULL means nop)
+ * @resume: invoked on resume if device was not reset (NULL means nop)
+ * @reset_resume: invoked on resume if device was reset (NULL means no=
p)
  *
  * raw_event and event should return 0 on no action performed, 1 when =
no
  * further processing should be done and negative on error
@@ -629,6 +632,11 @@ struct hid_driver {
 	int (*input_mapped)(struct hid_device *hdev,
 			struct hid_input *hidinput, struct hid_field *field,
 			struct hid_usage *usage, unsigned long **bit, int *max);
+#ifdef CONFIG_PM
+	int (*suspend)(struct hid_device *hdev);
+	int (*resume)(struct hid_device *hdev);
+	int (*reset_resume)(struct hid_device *hdev);
+#endif
 /* private: */
 	struct device_driver driver;
 };
--=20
1.6.4.4
