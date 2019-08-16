From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 24/63] Input: atmel_mxt_ts - check firmware format before entering bootloader
Date: Fri, 16 Aug 2019 17:32:59 +0900
Message-ID: <20190816083338.18685-5-jiada_wang@mentor.com>
References: <20190816083338.18685-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816083338.18685-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nick@shmanahar.org, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com, george_davis@mentor.com
List-Id: linux-input@vger.kernel.org

From: Nick Dyer <nick.dyer@itdev.co.uk>

Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
(cherry picked from ndyer/linux/for-upstream commit d691d3ee6c6de84b38464a423207b3e23cb9dc3a)
Signed-off-by: George G. Davis <george_davis@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index ca882231ab41..a7805df83af2 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3347,12 +3347,12 @@ static int mxt_load_fw(struct device *dev)
 		return ret;
 	}
 
-	ret = mxt_enter_bootloader(data);
+	/* Check for incorrect enc file */
+	ret = mxt_check_firmware_format(dev, f.fw);
 	if (ret)
 		goto release_firmware;
 
-	/* Check for incorrect enc file */
-	ret = mxt_check_firmware_format(dev, f.fw);
+	ret = mxt_enter_bootloader(data);
 	if (ret)
 		goto release_firmware;
 
-- 
2.19.2
