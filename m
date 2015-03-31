From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/3] Input: synaptics - allocate 3 slots to keep stability in image sensors
Date: Tue, 31 Mar 2015 11:07:37 -0400
Message-ID: <1427814457-30120-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1427814457-30120-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427814457-30120-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When slowly dropping 1, 2 and then 3 fingers on an image sensor touchpad,
we can see that the first finger gets reassigned a new slot while it did
not move. This is due to the kernel tracking algorithm which can not
assign correctly the 3 touches, being out of slots.

Declaring that we support 3 slots allows to actually forward:
slot 0 -> down, slot 1 -> up, slot 2 -> down

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
---

changes in v2:
- acked by Hans

 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 02a12b694..b4c6717 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1194,7 +1194,7 @@ static void set_input_params(struct psmouse *psmouse,
 					ABS_MT_POSITION_Y);
 		/* Image sensors can report per-contact pressure */
 		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
-		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
+		input_mt_init_slots(dev, 3, INPUT_MT_POINTER | INPUT_MT_TRACK);
 
 		/* Image sensors can signal 4 and 5 finger clicks */
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
-- 
2.3.4
