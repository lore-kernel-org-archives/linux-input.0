From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 11/11] touchscreen: tsc200x: Use octal permissions
Date: Sun, 22 Jul 2018 00:39:51 +0530
Message-ID: <20180721191029.25658-10-harshitjain6751@gmail.com>
References: <20180721191029.25658-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180721191029.25658-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, Martin Kepplinger <martink@posteo.de>, Kees Cook <keescook@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);

Signed-off-by: dev-harsh1998 <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/tsc200x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index e0fde590df8e..daefeca101ff 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -336,7 +336,7 @@ static ssize_t tsc200x_selftest_show(struct device *dev,
 	return sprintf(buf, "%d\n", success);
 }
 
-static DEVICE_ATTR(selftest, S_IRUGO, tsc200x_selftest_show, NULL);
+static DEVICE_ATTR(selftest, 0444, tsc200x_selftest_show, NULL);
 
 static struct attribute *tsc200x_attrs[] = {
 	&dev_attr_selftest.attr,
-- 
2.17.1
