From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] hid: intel-ish-hid: request_irq failure
Date: Sat, 15 Oct 2016 09:22:44 -0700
Message-ID: <1476548564-20202-5-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52682 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754342AbcJOQWu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 15 Oct 2016 12:22:50 -0400
In-Reply-To: <1476548564-20202-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On some platforms ISH interrupt is shared, which causes request_irq to
fail. This requires IRQF_SHARED irq flag.

But IRQF_NO_SUSPEND and IRQF_SHARED should not be used together, so
removed IRQF_NO_SUSPEND flag. Anyway this driver doesn't require
IRQF_NO_SUSPEND, as this interrupt is not required during "noirq" phases
of suspending and resuming devices as well as during the time when
nonboot CPUs are taken offline and brought back online.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 42f0bee..6fda0f9 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -146,7 +146,7 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
 
 	/* request and enable interrupt */
-	ret = request_irq(pdev->irq, ish_irq_handler, IRQF_NO_SUSPEND,
+	ret = request_irq(pdev->irq, ish_irq_handler, IRQF_SHARED,
 			  KBUILD_MODNAME, dev);
 	if (ret) {
 		dev_err(&pdev->dev, "ISH: request IRQ failure (%d)\n",
-- 
2.7.4

