From: "Shaun Jackman" <sjackman@gmail.com>
Subject: Re: USB: driver for CM109 chipset
Date: Wed, 29 Aug 2007 12:37:12 -0700
Message-ID: <7f45d9390708291237k168d8e16w2fb60f0dc010d482@mail.gmail.com>
References: <7f45d9390708252128p48c30b38we59ca2b6496997dd@mail.gmail.com>
	 <46D1CB97.5030000@db.org>
	 <7f45d9390708262257h2cddf51cva423b339a78ae554@mail.gmail.com>
	 <Pine.LNX.4.64.0708271143310.2460@twin.jikos.cz>
	 <7f45d9390708282238w7174d105i351e81cd19037d14@mail.gmail.com>
	 <Pine.LNX.4.64.0708291029350.2460@twin.jikos.cz>
	 <46D54385.4010704@db.org>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46D54385.4010704@db.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: "Alfred E. Heggestad" <aeh@db.org>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 8/29/07, Alfred E. Heggestad <aeh@db.org> wrote:
> here is an updated version of the CM109 driver, now supporting both KIP1000
...
> diff -uprN -X linux-2.6.22.5/Documentation/dontdiff linux-2.6.22.5-orig/drivers/hid/usbhid/hid-quirks.c
> linux-2.6.22.5/drivers/hid/usbhid/hid-quirks.c
> --- linux-2.6.22.5-orig/drivers/hid/usbhid/hid-quirks.c 2007-08-29 11:51:07.000000000 +0200
> +++ linux-2.6.22.5/drivers/hid/usbhid/hid-quirks.c      2007-08-27 21:21:01.000000000 +0200
> @@ -259,6 +259,9 @@
>   #define USB_VENDOR_ID_YEALINK         0x6993
>   #define USB_DEVICE_ID_YEALINK_P1K_P4K_B2K     0xb001
>
> +#define USB_VENDOR_ID_CMEDIA           0x0d8c
> +#define USB_DEVICE_ID_CM109            0x000e
> +
>   /*
>    * Alphabetically sorted blacklist by quirk type.
>    */
> @@ -405,6 +408,7 @@ static const struct hid_blacklist {
>         { USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_1_PHIDGETSERVO_20, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_8_8_4_IF_KIT, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K, HID_QUIRK_IGNORE },
> +       { USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM109, HID_QUIRK_IGNORE },
>
>         { USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_ACECAD_FLAIR, HID_QUIRK_IGNORE },
>         { USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_ACECAD_302, HID_QUIRK_IGNORE },

A minor detail, but the CMEDIA entry should be sorted alphabetically,
as the comment says. See below.

Cheers,
Shaun

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 6b21a21..a435f5b 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -90,6 +90,9 @@
 #define USB_DEVICE_ID_CODEMERCS_IOW_FIRST	0x1500
 #define USB_DEVICE_ID_CODEMERCS_IOW_LAST	0x15ff

+#define USB_VENDOR_ID_CMEDIA		0x0d8c
+#define USB_DEVICE_ID_CMEDIA_CM109	0x000e
+
 #define USB_VENDOR_ID_CYPRESS		0x04b4
 #define USB_DEVICE_ID_CYPRESS_MOUSE	0x0001
 #define USB_DEVICE_ID_CYPRESS_HIDCOM	0x5500
@@ -387,6 +390,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ASUS, USB_DEVICE_ID_ASUS_LCM, HID_QUIRK_IGNORE},
 	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_CIDC, 0x0103, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CMEDIA_CM109, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_ULTRAMOUSE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, HID_QUIRK_IGNORE },
