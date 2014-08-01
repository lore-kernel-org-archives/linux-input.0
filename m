From: Dexuan Cui <decui@microsoft.com>
Subject: [PATCH] Input: hyperv-keyboard: register as a wakeup source
Date: Fri,  1 Aug 2014 07:28:24 -0700
Message-ID: <1406903304-7256-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, driverdev-devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com, jasowang@redhat.com
Cc: haiyangz@microsoft.com
List-Id: linux-input@vger.kernel.org

With this patch, we can press a key to wake up the VM after the VM executes
"echo freeze > /sys/power/state".

This addresses part of https://bugzilla.redhat.com/show_bug.cgi?id=1086100

Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/input/serio/hyperv-keyboard.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 6132619..e74e5d6 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -170,6 +170,15 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
 		}
 		spin_unlock_irqrestore(&kbd_dev->lock, flags);
+
+		/*
+		 * Only trigger a wakeup on key down, otherwise
+		 * "echo freeze > /sys/power/state" can't really enter the
+		 * state because the Enter-UP can trigger a wakeup at once.
+		 */
+		if (!(info & IS_BREAK))
+			pm_wakeup_event(&hv_dev->device, 0);
+
 		break;
 
 	default:
@@ -376,6 +385,9 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
 		goto err_close_vmbus;
 
 	serio_register_port(kbd_dev->hv_serio);
+
+	device_init_wakeup(&hv_dev->device, true);
+
 	return 0;
 
 err_close_vmbus:
@@ -390,6 +402,7 @@ static int hv_kbd_remove(struct hv_device *hv_dev)
 {
 	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(hv_dev);
 
+	device_init_wakeup(&hv_dev->device, false);
 	serio_unregister_port(kbd_dev->hv_serio);
 	vmbus_close(hv_dev->channel);
 	kfree(kbd_dev);
-- 
1.9.1
