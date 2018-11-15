From: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH RESEND] hyper-v: Fix wakeup from suspend-to-idle
Date: Thu, 15 Nov 2018 19:09:33 +0100
Message-ID: <20181115180933.396-1-vkuznets@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

It makes little sense but still possible to put Hyper-V guests into
suspend-to-idle state. To wake them up two wakeup sources were registered
in the past: hyperv-keyboard and hid-hyperv. However, since
commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
to pm_wakeup_hard_event() API as these devices are actually the only
possible way to wakeup Hyper-V guests.

Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- It seems the patch slipped through the cracks, resending.
---
 drivers/hid/hid-hyperv.c              | 2 +-
 drivers/input/serio/hyperv-keyboard.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index b372854cf38d..704049e62d58 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -309,7 +309,7 @@ static void mousevsc_on_receive(struct hv_device *device,
 		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
 				 input_dev->input_buf, len, 1);
 
-		pm_wakeup_event(&input_dev->device->device, 0);
+		pm_wakeup_hard_event(&input_dev->device->device);
 
 		break;
 	default:
diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 47a0e81a2989..a8b9be3e28db 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -177,7 +177,7 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 		 * state because the Enter-UP can trigger a wakeup at once.
 		 */
 		if (!(info & IS_BREAK))
-			pm_wakeup_event(&hv_dev->device, 0);
+			pm_wakeup_hard_event(&hv_dev->device);
 
 		break;
 
-- 
2.17.2
