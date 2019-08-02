From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH] HID: sony: Fix race condition between rumble and device remove.
Date: Fri,  2 Aug 2019 15:50:19 -0700
Message-ID: <20190802225019.2418-1-roderick@gaikai.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: svv@google.com, pgriffais@valvesoftware.com, Roderick Colenbrander <roderick@gaikai.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Valve reported a kernel crash on Ubuntu 18.04 when disconnecting a DS4
gamepad while rumble is enabled. This issue is reproducible with a
frequency of 1 in 3 times in the game Borderlands 2 when using an
automatic weapon, which triggers many rumble operations.

We found the issue to be a race condition between sony_remove and the
final device destruction by the HID / input system. The problem was
that sony_remove didn't clean some of its work_item state in
"struct sony_sc". After sony_remove work, the corresponding evdev
node was around for sufficient time for applications to still queue
rumble work after "sony_remove".

On pre-4.19 kernels the race condition caused a kernel crash due to a
NULL-pointer dereference as "sc->output_report_dmabuf" got freed during
sony_remove. On newer kernels this crash doesn't happen due the buffer
now being allocated using devm_kzalloc. However we can still queue work,
while the driver is an undefined state.

This patch fixes the described problem, by guarding the work_item
"state_worker" with an initialized variable, which we are setting back
to 0 on cleanup.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
CC: stable@vger.kernel.org
---
 drivers/hid/hid-sony.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9671a4bad643..31f1023214d3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -587,10 +587,14 @@ static void sony_set_leds(struct sony_sc *sc);
 static inline void sony_schedule_work(struct sony_sc *sc,
 				      enum sony_worker which)
 {
+	unsigned long flags;
+
 	switch (which) {
 	case SONY_WORKER_STATE:
-		if (!sc->defer_initialization)
+		spin_lock_irqsave(&sc->lock, flags);
+		if (!sc->defer_initialization && sc->state_worker_initialized)
 			schedule_work(&sc->state_worker);
+		spin_unlock_irqrestore(&sc->lock, flags);
 		break;
 	case SONY_WORKER_HOTPLUG:
 		if (sc->hotplug_worker_initialized)
@@ -2553,13 +2557,18 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
 static inline void sony_cancel_work_sync(struct sony_sc *sc)
 {
+	unsigned long flags;
+
 	if (sc->hotplug_worker_initialized)
 		cancel_work_sync(&sc->hotplug_worker);
-	if (sc->state_worker_initialized)
+	if (sc->state_worker_initialized) {
+		spin_lock_irqsave(&sc->lock, flags);
+		sc->state_worker_initialized = 0;
+		spin_unlock_irqrestore(&sc->lock, flags);
 		cancel_work_sync(&sc->state_worker);
+	}
 }
 
-
 static int sony_input_configured(struct hid_device *hdev,
 					struct hid_input *hidinput)
 {
-- 
2.21.0
