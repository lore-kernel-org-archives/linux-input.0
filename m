From: Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 11/25] input: mouse: Use dev_get_drvdata()
Date: Tue, 23 Apr 2019 15:50:06 +0800
Message-ID: <20190423075020.173734-12-wangkefeng.wang@huawei.com>
References: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Using dev_get_drvdata directly.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/input/mouse/navpoint.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/navpoint.c b/drivers/input/mouse/navpoint.c
index d6e8f58a1de3..3d83a79e14d9 100644
--- a/drivers/input/mouse/navpoint.c
+++ b/drivers/input/mouse/navpoint.c
@@ -320,8 +320,7 @@ static int navpoint_remove(struct platform_device *pdev)
 
 static int __maybe_unused navpoint_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct navpoint *navpoint = platform_get_drvdata(pdev);
+	struct navpoint *navpoint = dev_get_drvdata(dev);
 	struct input_dev *input = navpoint->input;
 
 	mutex_lock(&input->mutex);
@@ -334,8 +333,7 @@ static int __maybe_unused navpoint_suspend(struct device *dev)
 
 static int __maybe_unused navpoint_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct navpoint *navpoint = platform_get_drvdata(pdev);
+	struct navpoint *navpoint = dev_get_drvdata(dev);
 	struct input_dev *input = navpoint->input;
 
 	mutex_lock(&input->mutex);
-- 
2.20.1
