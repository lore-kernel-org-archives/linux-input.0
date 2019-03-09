From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] input: pm8xxx-vibrator: fix a potential NULL pointer dereference
Date: Fri,  8 Mar 2019 23:39:21 -0600
Message-ID: <20190309053922.22212-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In case of_device_get_match_data fails to find the matched data,
returns -ENODEV

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/input/misc/pm8xxx-vibrator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 7dd1c1fbe42a..740e59c11808 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -196,6 +196,8 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	vib->vib_input_dev = input_dev;
 
 	regs = of_device_get_match_data(&pdev->dev);
+	if (unlikely(!regs))
+		return -ENODEV;
 
 	/* operate in manual mode */
 	error = regmap_read(vib->regmap, regs->drv_addr, &val);
-- 
2.17.1
