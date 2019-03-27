From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 103/123] HID: intel-ish: ipc: handle PIMR before ish_wakeup also clear PISR busy_clear bit
Date: Wed, 27 Mar 2019 14:16:07 -0400
Message-ID: <20190327181628.15899-103-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Song Hongyan <hongyan.song@intel.com>, Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Song Hongyan <hongyan.song@intel.com>

[ Upstream commit 2edefc056e4f0e6ec9508dd1aca2c18fa320efef ]

Host driver should handle interrupt mask register earlier than wake up ish FW
else there will be conditions when FW interrupt comes, host PIMR register still
not set ready, so move the interrupt mask setting before ish_wakeup.

Clear PISR busy_clear bit in ish_irq_handler. If not clear, there will be
conditions host driver received a busy_clear interrupt (before the busy_clear
mask bit is ready), it will return IRQ_NONE after check_generated_interrupt,
the interrupt will never be cleared, causing the DEVICE not sending following
IRQ.

Since PISR clear should not be called for the CHV device we do this change.
After the change, both ISH2HOST interrupt and busy_clear interrupt will be
considered as interrupt from ISH, busy_clear interrupt will return IRQ_HANDLED
from IPC_IS_BUSY check.

Signed-off-by: Song Hongyan <hongyan.song@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ipc/ipc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/ipc.c b/drivers/hid/intel-ish-hid/ipc/ipc.c
index 9a60ec13cb10..a3106fcc2253 100644
--- a/drivers/hid/intel-ish-hid/ipc/ipc.c
+++ b/drivers/hid/intel-ish-hid/ipc/ipc.c
@@ -91,7 +91,10 @@ static bool check_generated_interrupt(struct ishtp_device *dev)
 			IPC_INT_FROM_ISH_TO_HOST_CHV_AB(pisr_val);
 	} else {
 		pisr_val = ish_reg_read(dev, IPC_REG_PISR_BXT);
-		interrupt_generated = IPC_INT_FROM_ISH_TO_HOST_BXT(pisr_val);
+		interrupt_generated = !!pisr_val;
+		/* only busy-clear bit is RW, others are RO */
+		if (pisr_val)
+			ish_reg_write(dev, IPC_REG_PISR_BXT, pisr_val);
 	}
 
 	return interrupt_generated;
@@ -843,11 +846,11 @@ int ish_hw_start(struct ishtp_device *dev)
 {
 	ish_set_host_rdy(dev);
 
+	set_host_ready(dev);
+
 	/* After that we can enable ISH DMA operation and wakeup ISHFW */
 	ish_wakeup(dev);
 
-	set_host_ready(dev);
-
 	/* wait for FW-initiated reset flow */
 	if (!dev->recvd_hw_ready)
 		wait_event_interruptible_timeout(dev->wait_hw_ready,
-- 
2.19.1
