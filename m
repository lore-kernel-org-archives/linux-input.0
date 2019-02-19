From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH (resend)] Input: uinput - Set name/phys to NULL before
 kfree().
Date: Tue, 19 Feb 2019 10:58:55 -0800
Message-ID: <20190219185855.GB210481@dtor-ws>
References: <0000000000009ce64e0574fe896e@google.com>
 <47d5fdbe-120e-cf42-106f-b0cc0f2feb49@I-love.SAKURA.ne.jp>
 <b937b59c-22b8-9113-229f-056738819467@I-love.SAKURA.ne.jp>
 <20190217210713.GA145509@dtor-ws>
 <722c14a1-78cd-14b6-59ef-ba0d6fc82cb1@i-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <722c14a1-78cd-14b6-59ef-ba0d6fc82cb1@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: rydberg@bitmath.org, syzbot <syzbot+f648cfb7e0b52bf7ae32@syzkaller.appspotmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Mon, Feb 18, 2019 at 07:10:23PM +0900, Tetsuo Handa wrote:
> Thank you for responding.
> 
> On 2019/02/18 6:07, Dmitry Torokhov wrote:
> > The commit tries to send final uevent for objects for which "add" uevent
> > has been sent, but not "remove" event. However in uinput (and general
> > input case) we always take care of sending uevent at unregister, and do
> > not expect to have uevent sent out at the final "put" time.
> 
> Then, we want to keep dev->name and dev->phys when calling "unregister" time.
> 
> > 
> > I believe the real fix is to have kobj->state_remove_uevent_sent be set
> > to true as soon as we enter kobject_uevent(kobj, KOBJ_REMOVE) so that
> > it is being set even if memory allocation fails. Doing anything else may
> > violate expectations of subsystem owning the kobject.
> 
> If we want to keep dev->name and dev->phys when calling "unregister" time,
> we could do something like below. Does calling kobject_uevent(KOBJ_REMOVE)
> without dev->name and dev->phys (to some degree) help (compared to not
> triggering kobject_uevent(KOBJ_REMOVE) at all) ?

We are talking about handling pretty bad failure (I am not sure if these
allocations can fail in real life) so not getting KOBJ_REMOVE uevent is
not a big deal.

Thanks.

-- 
Dmitry
