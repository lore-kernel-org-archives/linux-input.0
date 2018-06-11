From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to support hibernation
Date: Sun, 10 Jun 2018 18:56:50 -0700
Message-ID: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
List-Id: linux-input@vger.kernel.org

From: Even Xu <even.xu@intel.com>

Current ish driver only register resume/suspend PM callbacks which
don't support hibernation (suspend to disk). Now use the
SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
The suspend and resume functions will now be used for both suspend
to RAM and hibernation.

If power management is disable, SIMPLE_DEV_PM_OPS will do nothing,
the suspend and resume related functions won't be used, so mark them
as __maybe_unused to clarify that this is intended behavior, and
remove #ifdefs for power management.

Signed-off-by: Even Xu <even.xu@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 582e449be9fe..a2c53ea3b5ed 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -205,8 +205,7 @@ static void ish_remove(struct pci_dev *pdev)
 	kfree(ishtp_dev);
 }
 
-#ifdef CONFIG_PM
-static struct device *ish_resume_device;
+static struct device __maybe_unused *ish_resume_device;
 
 /* 50ms to get resume response */
 #define WAIT_FOR_RESUME_ACK_MS		50
@@ -220,7 +219,7 @@ static struct device *ish_resume_device;
  * in that case a simple resume message is enough, others we need
  * a reset sequence.
  */
-static void ish_resume_handler(struct work_struct *work)
+static void __maybe_unused ish_resume_handler(struct work_struct *work)
 {
 	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -262,7 +261,7 @@ static void ish_resume_handler(struct work_struct *work)
  *
  * Return: 0 to the pm core
  */
-static int ish_suspend(struct device *device)
+static int __maybe_unused ish_suspend(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -288,7 +287,7 @@ static int ish_suspend(struct device *device)
 	return 0;
 }
 
-static DECLARE_WORK(resume_work, ish_resume_handler);
+static __maybe_unused DECLARE_WORK(resume_work, ish_resume_handler);
 /**
  * ish_resume() - ISH resume callback
  * @device:	device pointer
@@ -297,7 +296,7 @@ static DECLARE_WORK(resume_work, ish_resume_handler);
  *
  * Return: 0 to the pm core
  */
-static int ish_resume(struct device *device)
+static int __maybe_unused ish_resume(struct device *device)
 {
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
@@ -311,21 +310,14 @@ static int ish_resume(struct device *device)
 	return 0;
 }
 
-static const struct dev_pm_ops ish_pm_ops = {
-	.suspend = ish_suspend,
-	.resume = ish_resume,
-};
-#define ISHTP_ISH_PM_OPS	(&ish_pm_ops)
-#else
-#define ISHTP_ISH_PM_OPS	NULL
-#endif /* CONFIG_PM */
+static SIMPLE_DEV_PM_OPS(ish_pm_ops, ish_suspend, ish_resume);
 
 static struct pci_driver ish_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = ish_pci_tbl,
 	.probe = ish_probe,
 	.remove = ish_remove,
-	.driver.pm = ISHTP_ISH_PM_OPS,
+	.driver.pm = &ish_pm_ops,
 };
 
 module_pci_driver(ish_driver);
-- 
2.13.6
