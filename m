From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: HID blacklist for the Apple IR sensor
Date: Wed, 11 Jul 2007 08:52:49 +0200
Message-ID: <20070711065249.GA30552@dose.home.local>
References: <20070710182636.GA12522@dose.home.local> <Pine.LNX.4.64.0707102227020.31463@twin.jikos.cz> <20070711060016.GA27746@dose.home.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <20070711060016.GA27746@dose.home.local>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Soeren Sonnenburg <kernel@nn7.de>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2007 at 08:00:16 +0200, Tino Keitel wrote:

[...]

> See the attachment.

Now you really can. :-)

--yrj/dFKFPuw6o+aM
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="remove_Apple_IR_from_hiddev_blacklist.diff"

Author: Tino Keitel <tino.keitel@tikei.de>
Date:   Wed Jul 11 07:52:11 +0200

    HID: remove the Applie IR sensor from the hid_blacklist
    
    The IR sensor in some newer Apple computers has no other
    driver in the kernel, yet. However, the macmini driver in lirc
    requires a HID device for the IR sensor.
    
    Signed-off-by: Tino Keitel <tino.keitel@tikei.de>

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index f6c4145..62569e7 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -300,7 +300,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_AIPTEK, USB_DEVICE_ID_AIPTEK_24, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_AIRCABLE, USB_DEVICE_ID_AIRCABLE1, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_ALCOR, USB_DEVICE_ID_ALCOR_USBRS232, HID_QUIRK_IGNORE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_IR, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_BERKSHIRE, USB_DEVICE_ID_BERKSHIRE_PCWD, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_CIDC, 0x0103, HID_QUIRK_IGNORE },
 	{ USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_HIDCOM, HID_QUIRK_IGNORE },

--yrj/dFKFPuw6o+aM--
