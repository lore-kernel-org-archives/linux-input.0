From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert,
 ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Mon, 20 Sep 2010 17:10:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009201708340.26813@pobox.suse.cz>
References: <4C96B9DB.8030403@turmel.org> <AANLkTi=1zh4hD-1uzpgjAsnKZBE=qi_ZAX-ug=2XMkW0@mail.gmail.com> <alpine.LNX.2.00.1009201440140.26813@pobox.suse.cz> <4C975F79.9060609@turmel.org> <alpine.LNX.2.00.1009201524340.26813@pobox.suse.cz>
 <AANLkTim6PBGEBz8_PVpK2YajgtejsbAgL11i+DMN-7jh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:47810 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008Ab0ITPK4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 11:10:56 -0400
In-Reply-To: <AANLkTim6PBGEBz8_PVpK2YajgtejsbAgL11i+DMN-7jh@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mat <jackdachef@gmail.com>
Cc: Guillaume Chazarain <guichaz@gmail.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Alan Ott <alan@signal11.us>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Andreas Bombe <aeb@debian.org>, Alex Riesen <raa.lkml@gmail.com>, Phil Turmel <philip@turmel.org>

On Mon, 20 Sep 2010, Mat wrote:

> >> >>> The USB mouse I use with my laptop is causing a BUG when inser=
ted. =A0It works at that
> >> >>> point, but if removed and re-inserted, it is ignored. =A0Also,=
 after the 2nd insert,
> >> >>> other USB devices (like my thumb drive) are also ignored.
> >> >>>
> >> >>> [ =A0 37.450777] BUG: unable to handle kernel NULL pointer der=
eference at (null)
> >> >>> [ =A0 37.451148] IP: [<ffffffff817d0991>] hiddev_open+0xc1/0x2=
20
> >> >>> [ =A0 37.452036] PGD 1131a0067 PUD 113036067 PMD 0
> >> >>> [ =A0 37.452924] Oops: 0000 [#1] PREEMPT SMP
> >> >>> [ =A0 37.453336] last sysfs file: /sys/devices/platform/toshib=
a_acpi/backlight/toshiba/max_brightness
> >> >>> [ =A0 37.453336] CPU 1
> >> >>> [ =A0 37.453336] Modules linked in: tpm_infineon iwlagn iwlcor=
e tifm_7xx1 tpm_tis toshiba_bluetooth toshiba_acpi tifm_core pcmcia sdh=
ci_pci yenta_socket sdhci [last unloaded: scsi_wait_scan]
> >> >>> [ =A0 37.453336]
> >> >>> [ =A0 37.453336] Pid: 3117, comm: hald-probe-hidd Not tainted =
2.6.36-rc4-00166-g151b6a5 #28 Portable PC/TECRA A9
> >> >>> [ =A0 37.453336] RIP: 0010:[<ffffffff817d0991>] =A0[<ffffffff8=
17d0991>] hiddev_open+0xc1/0x220
> >> >
> >> > Could please those of you who are able to reproduce the problem =
(from a
> >> > quick test seems that I am not) use 'addr2line' utility to conve=
rt the RIP
> >> > value (ffffffff817d0991 in this case) to the line number inside =
of
> >> > hiddev_open(), so that we can see whether it's something behind
> >> > usbhid_find_interface() causing NULL pointer dereference, or whe=
ther it is
> >> > intfdata being NULL and thus going to hid->hiddev faults?
>=20
> [snip]
>=20
> hope that's the information you need - I rebuilt a debug-kernel so if
> you need more information, just ask:
>=20
>=20
> ls -l /usr/src/linux-2.6.36-rc4_hiddev/vmlinux
> -rwxrwx--- 1 root root 174167283 Sep 20 15:17
> /usr/src/linux-2.6.36-rc4_hiddev/vmlinux
> wolf ~ # addr2line -e /usr/src/linux-2.6.36-rc4_hiddev/vmlinux -i
> ffffffff815a0815
> /usr/src/linux/drivers/hid/usbhid/hiddev.c:289
>=20
> the relevant line is marked "=3D=3D>	if (list->hiddev->exist) {"

Thanks Matt and Phill for confirming the line that triggers the oops. A=
s I=20
am not able to reproduce it myself, it's a bit tricky to track down wha=
t=20
went wrong.

Could you please apply the patch below? It's printing the hid <-> hidde=
v=20
<-> usb_interface connections at various stages of probing and open.=20
Hopefully it'll reveal a little bit what goes wrong and where.

Thanks.


diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3f72924..3159a63 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1155,6 +1155,8 @@ int hid_connect(struct hid_device *hdev, unsigned=
 int connect_mask)
 	unsigned int i;
 	int len;
=20
+	printk("HID debug: hid_connect() -- hid: %p\n", hdev);
+
 	if (hdev->quirks & HID_QUIRK_HIDDEV_FORCE)
 		connect_mask |=3D (HID_CONNECT_HIDDEV_FORCE | HID_CONNECT_HIDDEV);
 	if (hdev->quirks & HID_QUIRK_HIDINPUT_FORCE)
@@ -1169,8 +1171,11 @@ int hid_connect(struct hid_device *hdev, unsigne=
d int connect_mask)
 		hdev->claimed |=3D HID_CLAIMED_INPUT;
 	if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hiddev_connect &&
 			!hdev->hiddev_connect(hdev,
-				connect_mask & HID_CONNECT_HIDDEV_FORCE))
+				connect_mask & HID_CONNECT_HIDDEV_FORCE)) {
 		hdev->claimed |=3D HID_CLAIMED_HIDDEV;
+		printk("HID debug: hid_connect() -- after hiddev_connect(), hid: %p,=
 hiddev: %p\n",
+				hdev, hdev->hiddev);
+	}
 	if ((connect_mask & HID_CONNECT_HIDRAW) && !hidraw_connect(hdev))
 		hdev->claimed |=3D HID_CLAIMED_HIDRAW;
=20
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
index 599041a..d2491a1 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1148,6 +1148,7 @@ static int usbhid_probe(struct usb_interface *int=
f, const struct usb_device_id *
 	if (IS_ERR(hid))
 		return PTR_ERR(hid);
=20
+	printk("HID debug: usbhid_probe() -- set intfdata(%p, %p)\n", intf, h=
id);
 	usb_set_intfdata(intf, hid);
 	hid->ll_driver =3D &usb_hid_driver;
 	hid->hid_output_raw_report =3D usbhid_output_raw_report;
diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 681e620..9aab39a 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -282,6 +282,8 @@ static int hiddev_open(struct inode *inode, struct =
file *file)
 	list->hiddev =3D hiddev;
 	file->private_data =3D list;
=20
+	printk("HID debug: hiddev_open(): hid: %p, hiddev: %p, intf: %p\n",
+			hid, hiddev, intf);
 	/*
 	 * no need for locking because the USB major number
 	 * is shared which usbcore guards against disconnect
@@ -892,6 +894,8 @@ int hiddev_connect(struct hid_device *hid, unsigned=
 int force)
 	hid->hiddev =3D hiddev;
 	hiddev->hid =3D hid;
 	hiddev->exist =3D 1;
+	printk("HID debug: hiddev_connect() -- hid: %p, hiddev: %p, intf: %p\=
n",
+			hid, hiddev, usbhid->intf);
 	retval =3D usb_register_dev(usbhid->intf, &hiddev_class);
 	if (retval) {
 		err_hid("Not able to get a minor for this device.");
@@ -912,6 +916,8 @@ void hiddev_disconnect(struct hid_device *hid)
 	struct hiddev *hiddev =3D hid->hiddev;
 	struct usbhid_device *usbhid =3D hid->driver_data;
=20
+	printk("HID debug: hiddev_disconnect() -- hid: %p, usbhid: %p, hiddev=
: %p\n",
+			hid, usbhid, hiddev);
 	mutex_lock(&hiddev->existancelock);
 	hiddev->exist =3D 0;
 	mutex_unlock(&hiddev->existancelock);

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
