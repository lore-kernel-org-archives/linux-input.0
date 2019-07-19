From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] Input: touchscreen - Use dev_get_drvdata
Date: Fri, 19 Jul 2019 19:53:08 +0800
Message-ID: <20190719115307.22124-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: linux-input@vger.kernel.org

dev_get_drvdata is a simpler implementation comparing
to to_platform_device + platform_get_drvdata.
This makes the code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index e04eecd65bbb..655652f449ec 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -507,8 +507,7 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 
 static int __maybe_unused imx6ul_tsc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx6ul_tsc *tsc = platform_get_drvdata(pdev);
+	struct imx6ul_tsc *tsc = dev_get_drvdata(dev);
 	struct input_dev *input_dev = tsc->input;
 
 	mutex_lock(&input_dev->mutex);
@@ -527,8 +526,7 @@ static int __maybe_unused imx6ul_tsc_suspend(struct device *dev)
 
 static int __maybe_unused imx6ul_tsc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx6ul_tsc *tsc = platform_get_drvdata(pdev);
+	struct imx6ul_tsc *tsc = dev_get_drvdata(dev);
 	struct input_dev *input_dev = tsc->input;
 	int retval = 0;
 
-- 
2.20.1
