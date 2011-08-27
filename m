From: Stefan Achatz <erazor_de@users.sourceforge.net>
Subject: [PATCH 1/5] HID: roccat: Fixed false dpi reporting when using osd
 event
Date: Sat, 27 Aug 2011 15:24:36 +0200
Message-ID: <1314451476.24216.72.camel@neuromancer.tessier-ashpool>
Reply-To: erazor_de@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Actual dpi resolution was set on wrong occassion.

Signed-off-by: Stefan Achatz <erazor_de@users.sourceforge.net>
---
 drivers/hid/hid-roccat-kone.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
index 2b8f3a3..7847a5b 100644
--- a/drivers/hid/hid-roccat-kone.c
+++ b/drivers/hid/hid-roccat-kone.c
@@ -776,10 +776,10 @@ static void kone_keep_values_up_to_date(struct kone_device *kone,
 {
 	switch (event->event) {
 	case kone_mouse_event_switch_profile:
+		kone->actual_dpi = kone->profiles[event->value - 1].
+				startup_dpi;
 	case kone_mouse_event_osd_profile:
 		kone->actual_profile = event->value;
-		kone->actual_dpi = kone->profiles[kone->actual_profile - 1].
-				startup_dpi;
 		break;
 	case kone_mouse_event_switch_dpi:
 	case kone_mouse_event_osd_dpi:
-- 
1.7.3.4
