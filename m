From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] input : avoid too late kobject_uevent(KOBJ_REMOVE) call
Date: Mon, 18 Feb 2019 19:09:23 +0900
Message-ID: <1550484563-13217-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Kay Sievers <kay@vrfy.org>, syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
List-Id: linux-input@vger.kernel.org

syzbot is hitting use-after-free bug in uinput module [1]. This is because
kobject_uevent(KOBJ_REMOVE) is called again due to commit 0f4dafc0563c6c49
("Kobject: auto-cleanup on final unref") after memory allocation fault
injection made kobject_uevent(KOBJ_REMOVE) from device_del() from
input_unregister_device() fail, while uinput_destroy_device() is expecting
that kobject_uevent(KOBJ_REMOVE) is not called after device_del() from
input_unregister_device() completed.

Fix this problem by pretending as if kobject_uevent(KOBJ_REMOVE) from
device_del() from input_unregister_device() did not fail.

[1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Analyzed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kay Sievers <kay@vrfy.org>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/input/input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaaffe87..6df3c33ef3aa 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2032,6 +2032,19 @@ static void __input_unregister_device(struct input_dev *dev)
 	mutex_unlock(&input_mutex);
 
 	device_del(&dev->dev);
+	/*
+	 * Regarding input subsystem, we always take care of sending uevent at
+	 * "unregister" time, and we do not expect to have uevent sent out at
+	 * the final "put" time. Therefore, if we failed to send uevent at
+	 * "unregister" time (due to e.g. fault injection), complain it and
+	 * do not allow the final "put" time to send the remove uevent again.
+	 */
+	if (dev->dev.kobj.state_add_uevent_sent &&
+	    !dev->dev.kobj.state_remove_uevent_sent) {
+		dev->dev.kobj.state_remove_uevent_sent = 1;
+		pr_warn("Failed to send remove uevent for %s\n",
+			dev_name(&dev->dev));
+	}
 }
 
 static void devm_input_device_unregister(struct device *dev, void *res)
-- 
2.17.1
