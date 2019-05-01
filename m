From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v2] Input: uinput: Avoid Object-Already-Free with a global
 lock
Date: Wed, 1 May 2019 13:20:49 +0530
Message-ID: <f0a48477-8b25-6538-20e0-53b732afb4d1@codeaurora.org>
References: <a4d1a2f3-1db7-e300-9569-7b7a2fadd64e@codeaurora.org>
 <20190419071152.x5ghvbybjhv76uxt@penguin>
 <f3cd46fb-2bb1-0422-b2be-3f7625ec9c4e@codeaurora.org>
 <20190423032839.xvbldglrmjxkdntj@penguin>
 <17f4a0be-ab04-8537-9197-32fbca807f3f@codeaurora.org>
 <20190423084944.gj2boxfcg7lp4zad@penguin>
 <20190423110611.GL2217@ZenIV.linux.org.uk>
 <5614f04f-827d-1668-9ed0-60d93e110b8e@codeaurora.org>
 <20190424130711.GP2217@ZenIV.linux.org.uk>
 <5b02ac1e-df3e-d9cd-ecf3-fe60cda2cece@codeaurora.org>
 <20190424225641.GQ2217@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424225641.GQ2217@ZenIV.linux.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gaurav Kohli <gkohli@codeaurora.org>, Peter Hutterer <peter.hutterer@who-t.net>, Martin Kepplinger <martink@posteo.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>
List-Id: linux-input@vger.kernel.org

Sorry to come late on this

On 4/25/2019 4:26 AM, Al Viro wrote:
> On Wed, Apr 24, 2019 at 07:39:03PM +0530, Mukesh Ojha wrote:
>
>> This was my simple program no multithreading just to understand f_counting
>>
>> int main()
>> {
>>          int fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
>>          ioctl(fd, UI_SET_EVBIT, EV_KEY);
>>          close(fd);
>>          return 0;
>> }
>>
>>             uinput-532   [002] ....    45.312044: SYSC_ioctl: 2   <= f_count
> Er...  So how does it manage to hit ioctl(2) before open(2)?  Confused...

I was confused too about this earlier, but after printing fd got to know 
this is not for the same fd
opening for /dev/uinput, may it is for something while running the 
executable.

>
>>>      <After fdget()
>>            uinput-532   [002] ....    45.312055: SYSC_ioctl: 2
>> <After fdput()
>>            uinput-532   [004] ....    45.313766: uinput_open: uinput: 1   /*
>> This is from the uinput driver uinput_open()*/
>>
>>    =>>>>                         /* All the above calls happened for the
>> open() in userspace*/
>>
>>            uinput-532   [004] ....    45.313783: SYSC_ioctl: 1 /* This print
>> is for the trace, i put after fdget */
>>            uinput-532   [004] ....    45.313788: uinput_ioctl_handler:
>> uinput: uinput_ioctl_handler, 1 /* This print is from the uinput_ioctl
>> driver */
>>
>>            uinput-532   [004] ....    45.313835: SYSC_ioctl: 1 /* This print
>> is for the trace, i put after fdput*/
>>            uinput-532   [004] ....    45.313843: uinput_release: uinput:  0
>> /* And this is from the close()  */
>>
>>
>> Should fdget not suppose to increment the f_count here, as it is coming 1 ?
>> This f_count to one is done at the open, but i have no idea how this  below
>> f_count 2 came before open() for
>> this simple program.
> If descriptor table is not shared, fdget() will simply return you the reference
> from there, without bothering to bump the refcount.  _And_ having it marked
> "don't drop refcount" in struct fd.
>
> Rationale: since it's not shared, nobody other than our process can modify
> it.  So unless we remove (and drop) the reference from it ourselves (which
> we certainly have no business doing in ->ioctl() and do not do anywhere
> in drivers/input), it will remain there until we return from syscall.
>
> Nobody is allowed to modify descriptor table other than their own.
> And if it's not shared, no other owners can appear while the only
> existing one is in the middle of syscall other than clone() (with
> CLONE_FILES in flags, at that).
>
> For shared descriptor table fdget() bumps file refcount, since there
> the reference in descriptor table itself could be removed and dropped
> by another thread.
>
> And fdget() marks whether fput() is needed in fd.flags, so that
> fdput() does the right thing.


Thanks Al, it is quite clear that issue can't happen while a ioctl is in 
progress.
Actually the issue seems to be a race while glue_dir input is removed.

   114.339374] input: syz1 as /devices/virtual/input/input278
[  114.345619] input: syz1 as /devices/virtual/input/input279
[  114.353502] input: syz1 as /devices/virtual/input/input280
[  114.361907] input: syz1 as /devices/virtual/input/input281
[  114.367276] input: syz1 as /devices/virtual/input/input282
[  114.382292] input: syz1 as /devices/virtual/input/input283

in our case it is input which is getting removed while a inputxx is 
trying make node inside input.

Similar issue https://lkml.org/lkml/2019/5/1/3

Thanks,
Mukesh
