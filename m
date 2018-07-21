From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 06/11] touchscreen: ili210x: Use octal permissions
Date: Sun, 22 Jul 2018 00:39:46 +0530
Message-ID: <20180721191029.25658-5-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, ili210x_calibrate);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/ili210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ili210x.c b/drivers/input/touchscreen/ili210x.c
index 6f76eeedf465..07526a6f2cb7 100644
--- a/drivers/input/touchscreen/ili210x.c
+++ b/drivers/input/touchscreen/ili210x.c
@@ -169,7 +169,7 @@ static ssize_t ili210x_calibrate(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(calibrate, S_IWUSR, NULL, ili210x_calibrate);
+static DEVICE_ATTR(calibrate, 0200, NULL, ili210x_calibrate);
 
 static struct attribute *ili210x_attributes[] = {
 	&dev_attr_calibrate.attr,
-- 
2.17.1
