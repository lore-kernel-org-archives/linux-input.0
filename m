From: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
Subject: [PATCH] drivers/input/misc: fix max dup length for kstrndup
Date: Tue, 12 Dec 2017 17:33:48 +0800
Message-ID: <20171212093348.20786-1-mashimiao.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, o2g.org.ru@gmail.com, mitr@volny.cz, Henk.Vergonet@gmail.com, Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
List-Id: linux-input@vger.kernel.org

If source string longer than max, kstrndup will alloc max+1 space.
So, we should make sure the result will not over limit.

Signed-off-by: Ma Shimiao <mashimiao.fnst@cn.fujitsu.com>
---
 drivers/input/misc/uinput.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 39ddd9a73feb..f94c6a452025 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -468,7 +468,7 @@ static int uinput_dev_setup(struct uinput_device *udev,
 	udev->ff_effects_max = setup.ff_effects_max;
 
 	kfree(dev->name);
-	dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE, GFP_KERNEL);
+	dev->name = kstrndup(setup.name, UINPUT_MAX_NAME_SIZE - 1, GFP_KERNEL);
 	if (!dev->name)
 		return -ENOMEM;
 
@@ -543,7 +543,7 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
 	}
 
 	kfree(dev->name);
-	dev->name = kstrndup(user_dev->name, UINPUT_MAX_NAME_SIZE,
+	dev->name = kstrndup(user_dev->name, UINPUT_MAX_NAME_SIZE - 1,
 			     GFP_KERNEL);
 	if (!dev->name) {
 		retval = -ENOMEM;
-- 
2.13.6
