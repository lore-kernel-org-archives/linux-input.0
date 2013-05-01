From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao
	<fernando_b1@lab.ntt.co.jp>
Subject: [PATCH] HID: fix botched tree merge that disabled fix-up for
 certain Sony RF receivers
Date: Wed, 01 May 2013 09:26:23 +0900
Message-ID: <1367367983.4712.5.camel@nexus>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>
	 <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>
	 <50F52986.2080002@lab.ntt.co.jp>
	 <1358246448.4897.3.camel@nexus.lab.ntt.co.jp>
	 <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
	 <1367367906.4712.4.camel@nexus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1367367906.4712.4.camel@nexus>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-input@vger.kernel.org

It looks like the manual merge 0d69a3c731e120b05b7da9fb976830475a3fbc01 ("Merge
branches 'for-3.9/sony' and 'for-3.9/steelseries' into for-linus") accidentally
removed Sony RF receiver with USB product id 0x0374 from the "have special
driver" list, effectively nullifying a464918419f94a0043d2f549d6defb4c3f69f68a
("HID: add support for Sony RF receiver with USB product id 0x0374"). Add the
device back to the list.

Cc: stable@vger.kernel.org
Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
---

diff -urNp linux-3.9/drivers/hid/hid-core.c linux-3.9-fix/drivers/hid/hid-core.c
--- linux-3.9/drivers/hid/hid-core.c	2013-04-29 09:36:01.000000000 +0900
+++ linux-3.9-fix/drivers/hid/hid-core.c	2013-04-30 21:53:57.596269692 +0900
@@ -1702,6 +1702,7 @@ static const struct hid_device_id hid_ha
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_NAVIGATION_CONTROLLER) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS3_CONTROLLER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGX_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_VAIO_VGP_MOUSE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_STEELSERIES, USB_DEVICE_ID_STEELSERIES_SRWS1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SUNPLUS, USB_DEVICE_ID_SUNPLUS_WDESKTOP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },
