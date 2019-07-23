From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] HID: intel-ish-hid: Use dev_get_drvdata where possible
Date: Tue, 23 Jul 2019 19:10:49 +0800
Message-ID: <20190723111049.11067-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-input@vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index aa80b4d3b740..7047c14516c9 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -204,8 +204,7 @@ static struct device __maybe_unused *ish_resume_device;
  */
 static void __maybe_unused ish_resume_handler(struct work_struct *work)
 {
-	struct pci_dev *pdev = to_pci_dev(ish_resume_device);
-	struct ishtp_device *dev = pci_get_drvdata(pdev);
+	struct ishtp_device *dev = dev_get_drvdata(ish_resume_device);
 	uint32_t fwsts;
 	int ret;
 
-- 
2.20.1
