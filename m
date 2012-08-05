From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH 1/2] input: usb: hid: Bump maximum global item tag report size to 128 bytes
Date: Sun,  5 Aug 2012 23:57:14 +0200
Message-ID: <1344203835-8308-1-git-send-email-marex@denx.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Chen Peter <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The Freescale i.MX28 BootROM USB recovery mode implements the USB HID
protocol, yet the global item tag report size is 128. Linux checks if
this is 96 as of now, see [1]. This causes Linux to refuse to communicate
with this device, making it impossible to use the recovery mode.

This is not a standard HID device per se, but rather a software emulation
implemented within the BootROM code and realized through USB OTG-capable
port switched to device mode present on the device.

Previous attempt to discuss this issue dates back to 2011, see [2]. There
has been not much response. Also noteworthy is the [3], where there seems
to be a pointing device that has issue similar to this one.

The tool making use of the USB recovery mode is available at [4].

[1] http://comments.gmane.org/gmane.linux.kernel.input/22328
[2] http://www.spinics.net/lists/linux-usb/msg43463.html
[3] https://bbs.archlinux.org/viewtopic.php?pid=1141340
[4] http://git.bfuser.eu/?p=marex/mxsldr.git;a=summary

Signed-off-by: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Chen Peter <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
---
 drivers/hid/hid-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 60ea284..2b9dd76 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -374,7 +374,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 
 	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
 		parser->global.report_size = item_udata(item);
-		if (parser->global.report_size > 96) {
+		if (parser->global.report_size > 128) {
 			hid_err(parser->device, "invalid report_size %d\n",
 					parser->global.report_size);
 			return -1;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
