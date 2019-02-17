From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
Date: Sun, 17 Feb 2019 13:07:13 -0800
Message-ID: <20190217210713.GA145509@dtor-ws>
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
 <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: rydberg@bitmath.org, syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

Hi Tetsuo,

On Fri, Feb 08, 2019 at 07:25:52PM +0900, Tetsuo Handa wrote:
> syzbot is hitting use-after-free bug in uinput module [1]. This is because
> uinput_destroy_device() sometimes kfree()s dev->name and dev->phys at
> uinput_destroy_device() before dev_uevent() is triggered by dropping the
> refcount to 0. Since the timing of triggering last input_put_device() is
> uncontrollable, this patch prepares for such race by setting dev->name and
> dev->phys to NULL before doing operations which might drop the refcount
> to 0.
> 
> [1] https://syzkaller.appspot.com/bug?id=8b17c134fe938bbddd75a45afaa9e68af43a362d

Sorry it took me so long to sort out the issue and unfortunately I
disagree with your analysis. The issue here is not that we do not know
when last reference is being dropped (because we expect that KOBJ_REMOVE
uevent will be sent out when we call input_unregister_device, which is
quite deterministic) but the kobject cleanup logic added in commit
0f4dafc0563c6c49e17fe14b3f5f356e4c4b8806 ("Kobject: auto-cleanup on
final unref") coupled with the fault injected by the syzcaller.
The commit tries to send final uevent for objects for which "add" uevent
has been sent, but not "remove" event. However in uinput (and general
input case) we always take care of sending uevent at unregister, and do
not expect to have uevent sent out at the final "put" time.

I believe the real fix is to have kobj->state_remove_uevent_sent be set
to true as soon as we enter kobject_uevent(kobj, KOBJ_REMOVE) so that
it is being set even if memory allocation fails. Doing anything else may
violate expectations of subsystem owning the kobject.

Thanks.

-- 
Dmitry
