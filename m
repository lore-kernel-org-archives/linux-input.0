From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH V1] elan_i2c: Increment wakeup count if wake source.
Date: Mon, 13 May 2019 15:06:10 -0700
Message-ID: <20190513220610.177489-1-ravisadineni@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, ravisadineni@chromium.org, kt.liao@emc.com.tw, benjamin.tissoires@redhat.com, abhishekbh@google.com, tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Notify the PM core that this dev is the wake source. This helps
userspace daemon tracking the wake source to identify the origin of the
wake.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 drivers/input/mouse/elan_i2c_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f9525d6f0bfe..2c0561e20b7f 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -981,6 +981,8 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	if (error)
 		goto out;
 
+	pm_wakeup_event(dev, 0);
+
 	switch (report[ETP_REPORT_ID_OFFSET]) {
 	case ETP_REPORT_ID:
 		elan_report_absolute(data, report);
-- 
2.20.1
