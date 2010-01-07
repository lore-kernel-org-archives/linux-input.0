From: Bastian Blank <waldi@debian.org>
Subject: [PATCH 3/7] Input: wacom - Set driver info for Wacom Penpartner
Date: Thu, 7 Jan 2010 19:29:42 +0100
Message-ID: <20100107182941.GA12938@wavehammer.waldi.eu.org>
References: <20100107182553.GA11236@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753474Ab0AGSkz@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100107182553.GA11236@wavehammer.waldi.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>
List-Id: linux-input@vger.kernel.org

Add define to set also driver info in the usb device ids, convert one
device.

Signed-off-by: Bastian Blank <waldi@debian.org>
---
 drivers/input/tablet/wacom_sys.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b0f3fc3..aa02fb1 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -665,8 +665,11 @@ static int wacom_reset_resume(struct usb_interface *intf)
 	return wacom_resume(intf);
 }
 
+static struct wacom_features wacom_features_0x00 =
+	{ "Wacom Penpartner",     WACOM_PKGLEN_PENPRTN,    5040,  3780,  255,  0, PENPARTNER };
+
 static struct wacom_features wacom_features[] = {
-	{ "Wacom Penpartner",     WACOM_PKGLEN_PENPRTN,    5040,  3780,  255,  0, PENPARTNER },
+	{ },
 	{ "Wacom Graphire",       WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511, 63, GRAPHIRE },
 	{ "Wacom Graphire2 4x5",  WACOM_PKGLEN_GRAPHIRE,  10206,  7422,  511, 63, GRAPHIRE },
 	{ "Wacom Graphire2 5x7",  WACOM_PKGLEN_GRAPHIRE,  13918, 10206,  511, 63, GRAPHIRE },
@@ -732,8 +735,12 @@ static struct wacom_features wacom_features[] = {
 	{ }
 };
 
+#define USB_DEVICE_WACOM(prod) \
+	USB_DEVICE(USB_VENDOR_ID_WACOM,prod), \
+	.driver_info = (uintptr_t)&wacom_features_##prod
+
 static struct usb_device_id wacom_ids[] = {
-	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x00) },
+	{ USB_DEVICE_WACOM(0x00) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x10) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x11) },
 	{ USB_DEVICE(USB_VENDOR_ID_WACOM, 0x12) },
-- 
1.6.5.7


-- 
Immortality consists largely of boredom.
		-- Zefrem Cochrane, "Metamorphosis", stardate 3219.8
