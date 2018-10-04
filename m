From: Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in mousedev_write()
Date: Thu, 4 Oct 2018 12:45:29 -0700
Message-ID: <CANn89i+Xoyjrjg_XcwAj9G7KP7CXt+CvpJ38Bj4O53j3sac4Xw@mail.gmail.com>
References: <20181004154749.111595-1-edumazet@google.com> <20181004185949.GA233675@dtor-ws>
 <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com> <30074728-D1C4-46D4-8BF5-6AB8ECAE3EBD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <30074728-D1C4-46D4-8BF5-6AB8ECAE3EBD@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, linux-input@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 4, 2018 at 12:38 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On October 4, 2018 12:28:56 PM PDT, Eric Dumazet <edumazet@google.com> wrote:
> >On Thu, Oct 4, 2018 at 11:59 AM Dmitry Torokhov
> ><dmitry.torokhov@gmail.com> wrote:
> >>
> >> Hi Eric,
> >>
> >> On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
> >> > syzbot was able to trigger rcu stalls by calling write()
> >> > with large number of bytes.
> >> >
> >> > Add a cond_resched() in the loop to avoid this.
> >>
> >> I think this simply masks a deeper issue. The code fetches characters
> >> from userspace in a loop, takes a lock, quickly places response in an
> >> output buffer, and releases interrupt. I do not see why this should
> >> cause stalls as we do not hold spinlock/interrupts off for extended
> >> period of time.
> >>
> >> Adding Paul so he can straighten me out...
> >>
> >
> >Well...
> >
> >write(fd, buffer, 0x7FFF0000);
> >
> >Takes between 20 seconds and 2 minutes depending on CONFIG options ....
>
> That's fine even if it takes a couple of years. We are not holding spinlock for the entirety of this time, so we should get bumped off CPU at some point.

Well, you are saying that we could get rid of all cond_resched() calls
in the kernel.

You should send patches asap ;)

>
> >
> >So either apply my patch, or add a limit on the max count, and
> >possibly break legitimate user space ?
>
> Legitimate users write a single character at a time and read response, so exciting after, let's say, 32 bytes would be fine. But I still want to understand why we have to do that.
>
> >
> >I dunno...
> >
> >> >
> >> > Link: https://lkml.org/lkml/2018/8/23/1106
> >> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >> > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller.appspotmail.com
> >> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> > Cc: linux-input@vger.kernel.org
> >> > ---
> >> >  drivers/input/mousedev.c | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
> >> > index
> >e08228061bcdd2f97aaadece31d6c83eb7539ae5..412fa71245afe26a7a8ad75705566f83633ba347
> >100644
> >> > --- a/drivers/input/mousedev.c
> >> > +++ b/drivers/input/mousedev.c
> >> > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file
> >*file, const char __user *buffer,
> >> >               mousedev_generate_response(client, c);
> >> >
> >> >               spin_unlock_irq(&client->packet_lock);
> >> > +             cond_resched();
> >> >       }
> >> >
> >> >       kill_fasync(&client->fasync, SIGIO, POLL_IN);
> >> > --
> >> > 2.19.0.605.g01d371f741-goog
> >> >
> >>
> >> Thanks.
> >>
> >> --
> >> Dmitry
>
>
> Thanks.
>
> --
> Dmitry
