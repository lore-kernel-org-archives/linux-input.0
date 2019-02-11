From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] HID: roccat: Mark expected switch fall-through
Date: Mon, 11 Feb 2019 15:53:34 -0600
Message-ID: <20190211215334.GA6216@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-input@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

drivers/hid/hid-roccat-kone.c: In function ‘kone_keep_values_up_to_date’:
drivers/hid/hid-roccat-kone.c:784:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
   kone->actual_dpi = kone->profiles[event->value - 1].
   ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     startup_dpi;
     ~~~~~~~~~~~
drivers/hid/hid-roccat-kone.c:786:2: note: here
  case kone_mouse_event_osd_profile:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hid/hid-roccat-kone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index bf4675a27396..c4dd6162c1d6 100644
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
2.20.1
