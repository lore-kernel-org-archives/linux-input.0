From: Zhang Lixu <lixu.zhang@intel.com>
Subject: [PATCH v2 3/3] HID: intel-ish-hid: ipc: check the NO_D3 flag to distinguish resume paths
Date: Thu,  8 Aug 2019 18:21:13 +0800
Message-ID: <20190808102113.27802-4-lixu.zhang@intel.com>
References: <20190808102113.27802-1-lixu.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808102113.27802-1-lixu.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: srinivas.pandruvada@linux.intel.com, linux-kernel@vger.kernel.org, lixu.zhang@intel.com
List-Id: linux-input@vger.kernel.org

The NO_D3 flag would be set if the ISH enter D0i3 in ish_suspend(),
The resume paths can be distinguished by checking the NO_D3 flag.
It's more reasonable than checking the FW status.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 34 +++++++++++--------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 35081f2cf781..f269852304e5 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -210,19 +210,11 @@ static void __maybe_unused ish_resume_handler(struct work_struct *work)
 {
 	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
-	uint32_t fwsts;
 	int ret;
 
-	pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
-
-	/* Get ISH FW status */
-	fwsts = IPC_GET_ISH_FWSTS(dev->ops->get_fw_status(dev));
-
-	/*
-	 * If currently, in ISH FW, sensor app is loaded or beyond that,
-	 * it means ISH isn't powered off, in this case, send a resume message.
-	 */
-	if (fwsts >= FWSTS_SENSOR_APP_LOADED) {
+	/* Check the NO_D3 flag to distinguish the resume paths */
+	if (pdev->dev_flags & PCI_DEV_FLAGS_NO_D3) {
+		pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
 		disable_irq_wake(pdev->irq);
 
 		ishtp_send_resume(dev);
@@ -232,16 +224,20 @@ static void __maybe_unused ish_resume_handler(struct work_struct *work)
 			ret = wait_event_interruptible_timeout(dev->resume_wait,
 				!dev->resume_flag,
 				msecs_to_jiffies(WAIT_FOR_RESUME_ACK_MS));
-	}
 
-	/*
-	 * If in ISH FW, sensor app isn't loaded yet, or no resume response.
-	 * That means this platform is not S0ix compatible, or something is
-	 * wrong with ISH FW. So on resume, full reboot of ISH processor will
-	 * happen, so need to go through init sequence again.
-	 */
-	if (dev->resume_flag)
+		/*
+		 * If the flag is not cleared, something is wrong with ISH FW.
+		 * So on resume, need to go through init sequence again.
+		 */
+		if (dev->resume_flag)
+			ish_init(dev);
+	} else {
+		/*
+		 * Resume from the D3, full reboot of ISH processor will happen,
+		 * so need to go through init sequence again.
+		 */
 		ish_init(dev);
+	}
 }
 
 /**
-- 
2.17.1
