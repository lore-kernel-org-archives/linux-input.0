From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] HID: roccat: Mark expected switch fall-through
Date: Mon, 2 Jul 2018 13:29:07 -0500
Message-ID: <20180702182907.GA22465@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-input@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hid/hid-roccat-kone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index bf4675a..c4dd616 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -783,6 +783,7 @@ static void kone_keep_values_up_to_date(struct kone_device *kone,
 	case kone_mouse_event_switch_profile:
 		kone->actual_dpi = kone->profiles[event->value - 1].
 				startup_dpi;
+		/* fall through */
 	case kone_mouse_event_osd_profile:
 		kone->actual_profile = event->value;
 		break;
-- 
2.7.4
