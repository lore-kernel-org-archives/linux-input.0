From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
Date: Mon, 18 Feb 2019 19:10:23 +0900
Message-ID: <722c14a1-78cd-14b6-59ef-ba0d6fc82cb1@i-love.sakura.ne.jp>
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
 <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
 <20190217210713.GA145509@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190217210713.GA145509@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rydberg@bitmath.org, syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Thank you for responding.

On 2019/02/18 6:07, Dmitry Torokhov wrote:
> The commit tries to send final uevent for objects for which "add" uevent
> has been sent, but not "remove" event. However in uinput (and general
> input case) we always take care of sending uevent at unregister, and do
> not expect to have uevent sent out at the final "put" time.

Then, we want to keep dev->name and dev->phys when calling "unregister" time.

> 
> I believe the real fix is to have kobj->state_remove_uevent_sent be set
> to true as soon as we enter kobject_uevent(kobj, KOBJ_REMOVE) so that
> it is being set even if memory allocation fails. Doing anything else may
> violate expectations of subsystem owning the kobject.

If we want to keep dev->name and dev->phys when calling "unregister" time,
we could do something like below. Does calling kobject_uevent(KOBJ_REMOVE)
without dev->name and dev->phys (to some degree) help (compared to not
triggering kobject_uevent(KOBJ_REMOVE) at all) ?

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 3304aaa..da39a23 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1587,6 +1587,7 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 {
 	struct input_dev *dev = to_input_dev(device);
 
+	rcu_read_lock();
 	INPUT_ADD_HOTPLUG_VAR("PRODUCT=%x/%x/%x/%x",
 				dev->id.bustype, dev->id.vendor,
 				dev->id.product, dev->id.version);
@@ -1618,6 +1619,7 @@ static int input_dev_uevent(struct device *device, struct kobj_uevent_env *env)
 		INPUT_ADD_HOTPLUG_BM_VAR("SW=", dev->swbit, SW_MAX);
 
 	INPUT_ADD_HOTPLUG_MODALIAS_VAR(dev);
+	rcu_read_unlock();
 
 	return 0;
 }
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 26ec603f..6689312 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -308,9 +308,12 @@ static void uinput_destroy_device(struct uinput_device *udev)
 		} else {
 			input_free_device(dev);
 		}
+		dev->name = NULL;
+		dev->phys = NULL;
+		udev->dev = NULL;
+		synchronize_rcu();
 		kfree(name);
 		kfree(phys);
-		udev->dev = NULL;
 	}
 }
 
