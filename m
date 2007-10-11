From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: GeneralTouch USB Touchscreen Support
Date: Thu, 11 Oct 2007 08:02:01 -0400
Message-ID: <200710110802.01953.dmitry.torokhov@gmail.com>
References: <f37dba8b0710080305t37b57e3dpe2fd7be231893ba5@mail.gmail.com> <d120d5000710080623o4a0be879w45d59be6ee025d40@mail.gmail.com> <Pine.LNX.4.64.0710081633330.25413@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0710081633330.25413@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: zeylienospam@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Jiri,

On Monday 08 October 2007, Jiri Kosina wrote:
> On Mon, 8 Oct 2007, Dmitry Torokhov wrote:
> 
> > The patch looks good, thanks a lot. Can I please have your 
> > "Signed-off-by:" so I can apply it?  Thanks!
> 
> Hi,
> 
> my only concern with this patch is -- could we please keep the entries in 
> hid_blacklist[] properly sorted? (i.e. first by quirk type, then by vendor 
> name).
> 
> Also, patch to hid-quirks seem to contain some whitespace changes, I'd 
> like to do this separately if possible.
> 
> Besides that, I am fine with that and you can add
> 
> 	Signed-off-by: Jiri Koisna <jkosina@suse.cz>
> 
> for the HID part of the patch if you want to.
> 

I'd rather HID part go through your tree. Here is is split out.

-- 
Dmitry

--------------------------------------------------------------------
Subject: HID: Add GeneralTouch touchscreen to the blacklist
From: Ilya Frolov <zeylie@gmail.com>

GeneralTouch touchscreens are handled by usbtouchscreen driver,
make sure HID ignores them.

Signed-off-by: Ilya Frolov <zeylie@gmail.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/hid/usbhid/hid-quirks.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: work/drivers/hid/usbhid/hid-quirks.c
===================================================================
--- work.orig/drivers/hid/usbhid/hid-quirks.c
+++ work/drivers/hid/usbhid/hid-quirks.c
@@ -110,6 +110,8 @@
 #define USB_VENDOR_ID_GAMERON		0x0810
 #define USB_DEVICE_ID_GAMERON_DUAL_PSX_ADAPTOR	0x0001
 
+#define USB_VENDOR_ID_GENERAL_TOUCH	0x0dfc
+
 #define USB_VENDOR_ID_GLAB		0x06c2
 #define USB_DEVICE_ID_4_PHIDGETSERVO_30	0x0038
 #define USB_DEVICE_ID_1_PHIDGETSERVO_30	0x0039
@@ -392,6 +394,10 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EARTHMATE, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0001, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0002, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0003, HID_QUIRK_IGNORE },
+	{ USB_VENDOR_ID_GENERAL_TOUCH, 0x0004, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_4_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_1_PHIDGETSERVO_30, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_GLAB, USB_DEVICE_ID_0_0_4_IF_KIT, HID_QUIRK_IGNORE },
