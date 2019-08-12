From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] HID: multitouch: do not filter mice nodes
Date: Mon, 12 Aug 2019 18:23:25 +0200
Message-ID: <20190812162326.14253-2-benjamin.tissoires@redhat.com>
References: <20190812162326.14253-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812162326.14253-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Fend <Matthias.Fend@wolfvision.net>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

It was a good idea at the time to not create a mouse node for the
multitouch touchscreens, but:
- touchscreens following the Win 8 protocol should not have this
  disturbing mouse node anymore, or if they have, it should be
  used for something else (like a joystick attached to the screen)
- touchpads have it, and they should not use it unless there is a bug,
  but when the laptop has a trackstick, the data are reported through this
  mouse node.

So instead of whitelisting all of the devices that have a need for the
mouse node, just export it.
hid-input.c will append a suffix to it ('Mouse'), so users will eventually
see if something goes wrong.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index b603c14d043b..0d190d93ca7c 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -263,7 +263,8 @@ static const struct mt_class mt_classes[] = {
 			MT_QUIRK_HOVERING |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_STICKY_FINGERS |
-			MT_QUIRK_WIN8_PTP_BUTTONS },
+			MT_QUIRK_WIN8_PTP_BUTTONS,
+		.export_all_inputs = true },
 	{ .name = MT_CLS_EXPORT_ALL_INPUTS,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
-- 
2.19.2
