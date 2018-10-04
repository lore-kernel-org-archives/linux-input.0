From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in mousedev_write()
Date: Thu, 04 Oct 2018 12:38:02 -0700
Message-ID: <30074728-D1C4-46D4-8BF5-6AB8ECAE3EBD@gmail.com>
References: <20181004154749.111595-1-edumazet@google.com> <20181004185949.GA233675@dtor-ws> <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANn89iJMhGEkw13KrGbqrvGbznb45QZwdr7eLy_rUV6zitvs=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Dumazet <edumazet@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, linux-input@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-input@vger.kernel.org

On October 4, 2018 12:28:56 PM PDT, Eric Dumazet <edumazet@google=2Ecom> wr=
ote:
>On Thu, Oct 4, 2018 at 11:59 AM Dmitry Torokhov
><dmitry=2Etorokhov@gmail=2Ecom> wrote:
>>
>> Hi Eric,
>>
>> On Thu, Oct 04, 2018 at 08:47:49AM -0700, Eric Dumazet wrote:
>> > syzbot was able to trigger rcu stalls by calling write()
>> > with large number of bytes=2E
>> >
>> > Add a cond_resched() in the loop to avoid this=2E
>>
>> I think this simply masks a deeper issue=2E The code fetches characters
>> from userspace in a loop, takes a lock, quickly places response in an
>> output buffer, and releases interrupt=2E I do not see why this should
>> cause stalls as we do not hold spinlock/interrupts off for extended
>> period of time=2E
>>
>> Adding Paul so he can straighten me out=2E=2E=2E
>>
>
>Well=2E=2E=2E
>
>write(fd, buffer, 0x7FFF0000);
>
>Takes between 20 seconds and 2 minutes depending on CONFIG options =2E=2E=
=2E=2E

That's fine even if it takes a couple of years=2E We are not holding spinl=
ock for the entirety of this time, so we should get bumped off CPU at some =
point=2E

>
>So either apply my patch, or add a limit on the max count, and
>possibly break legitimate user space ?

Legitimate users write a single character at a time and read response, so =
exciting after, let's say, 32 bytes would be fine=2E But I still want to un=
derstand why we have to do that=2E

>
>I dunno=2E=2E=2E
>
>> >
>> > Link: https://lkml=2Eorg/lkml/2018/8/23/1106
>> > Signed-off-by: Eric Dumazet <edumazet@google=2Ecom>
>> > Reported-by: syzbot+9436b02171ac0894d33e@syzkaller=2Eappspotmail=2Eco=
m
>> > Cc: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>> > Cc: linux-input@vger=2Ekernel=2Eorg
>> > ---
>> >  drivers/input/mousedev=2Ec | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/drivers/input/mousedev=2Ec b/drivers/input/mousedev=2Ec
>> > index
>e08228061bcdd2f97aaadece31d6c83eb7539ae5=2E=2E412fa71245afe26a7a8ad757055=
66f83633ba347
>100644
>> > --- a/drivers/input/mousedev=2Ec
>> > +++ b/drivers/input/mousedev=2Ec
>> > @@ -707,6 +707,7 @@ static ssize_t mousedev_write(struct file
>*file, const char __user *buffer,
>> >               mousedev_generate_response(client, c);
>> >
>> >               spin_unlock_irq(&client->packet_lock);
>> > +             cond_resched();
>> >       }
>> >
>> >       kill_fasync(&client->fasync, SIGIO, POLL_IN);
>> > --
>> > 2=2E19=2E0=2E605=2Eg01d371f741-goog
>> >
>>
>> Thanks=2E
>>
>> --
>> Dmitry


Thanks=2E

--=20
Dmitry
