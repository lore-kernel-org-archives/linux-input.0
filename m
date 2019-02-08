From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
Date: Fri, 8 Feb 2019 19:25:52 +0900
Message-ID: <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rydberg@bitmath.org
Cc: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

syzbot is hitting use-after-free bug in uinput module [1]. This is because
uinput_destroy_device() sometimes kfree()s dev->name and dev->phys at
uinput_destroy_device() before dev_uevent() is triggered by dropping the
refcount to 0. Since the timing of triggering last input_put_device() is
uncontrollable, this patch prepares for such race by setting dev->name and
dev->phys to NULL before doing operations which might drop the refcount
to 0.

[1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Reported-by: syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/input/misc/uinput.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 8ec483e8688b..131591b5babd 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -300,7 +300,9 @@ static void uinput_destroy_device(struct uinput_device *udev)
 
 	if (dev) {
 		name = dev->name;
+		dev->name = NULL;
 		phys = dev->phys;
+		dev->phys = NULL;
 		if (old_state == UIST_CREATED) {
 			uinput_flush_requests(udev);
 			input_unregister_device(dev);
-- 
2.17.1
