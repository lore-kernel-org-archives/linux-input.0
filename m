From: <sonic.zhang@analog.com>
Subject: [PATCH] input: rotary: Init wake according to platform pm_wakeup flag.
Date: Wed, 16 May 2012 16:36:23 +0800
Message-ID: <1337157383-13631-1-git-send-email-sonic.zhang@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>
List-Id: linux-input@vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Rotary can't be used as a wakeup source in all Blackfin processors.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/input/misc/bfin_rotary.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index 1c4146f..bb1971c 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -182,7 +182,7 @@ static int __devinit bfin_rotary_probe(struct platform_device *pdev)
 	bfin_write_CNT_CONFIG(bfin_read_CNT_CONFIG() | CNTE);
 
 	platform_set_drvdata(pdev, rotary);
-	device_init_wakeup(&pdev->dev, 1);
+	device_init_wakeup(&pdev->dev, pdata->pm_wakeup);
 
 	return 0;
 
-- 
1.7.0.4
