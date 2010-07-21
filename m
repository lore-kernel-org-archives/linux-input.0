From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v6 3/3] input: samsung-keypad - Add samsung keypad driver
Date: Wed, 21 Jul 2010 21:39:27 +0900
Message-ID: <009501cb28d1$c54c9f00$4fe5dd00$%kim@samsung.com>
References: <1277724824-13308-1-git-send-email-jy0922.shim@samsung.com>
 <1277724824-13308-3-git-send-email-jy0922.shim@samsung.com>
 <4C32E21A.8080100@samsung.com>
 <013401cb1d66$5fbf3fb0$1f3dbf10$%kim@samsung.com>
 <4C33D859.9050708@samsung.com>
 <026901cb1f35$64c63470$2e529d50$%kim@samsung.com>
 <4C36D235.3040702@samsung.com> <4C4688BE.1080409@samsung.com>
 <20100721080725.GA21373@core.coreip.homeip.net> <4C46B777.9010808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4C46B777.9010808@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Joonyoung Shim' <jy0922.shim@samsung.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, ch.naveen@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Joonyoung Shim wrote:
> 
> On 7/21/2010 5:07 PM, Dmitry Torokhov wrote:
> > Hi Joonyoung,
> >
> > On Wed, Jul 21, 2010 at 02:42:22PM +0900, Joonyoung Shim wrote:
> >> Hi, Dmitry.
> >>
> >> On 7/9/2010 4:39 PM, Joonyoung Shim wrote:
> >>> On 7/9/2010 4:07 PM, Kukjin Kim wrote:
> >>>> Joonyoung Shim wrote:
> >>>>> On 7/7/2010 8:52 AM, Kukjin Kim wrote:
> >>>>>> Joonyoung Shim wrote:
> >>>>>>> Hi, Naveen.
> >>>>>>>
> >>>>>>> On 6/28/2010 8:33 PM, Joonyoung Shim wrote:
> >>>>>>>> This patch adds support for keypad driver running on Samsung cpus.
> This
> >>>>>>>> driver is tested on GONI and Aquila board using S5PC110 cpu.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> >>>>>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >>>>>>>> ---
> >>>>>>>>  drivers/input/keyboard/Kconfig          |    9 +
> >>>>>>>>  drivers/input/keyboard/Makefile         |    1 +
> >>>>>>>>  drivers/input/keyboard/samsung-keypad.c |  491
> >>>>>>> +++++++++++++++++++++++++++++++
> >>>>>>>>  3 files changed, 501 insertions(+), 0 deletions(-)
> >>>>>>>>  create mode 100644 drivers/input/keyboard/samsung-keypad.c
> >>>>>>>>
> >>>>>>> Could you please test this v6 keypad driver on your various targets?
> >>>>>> Hi,
> >>>>>>
> >>>>>> I received the test result from Naveen.
> >>>>>> And now he is debugging about that.
> >>>>>>
> >>>>>> ..his e-mail client has some problem..so I replied...
> >>>>>>
> >>>>>> ---
> >>>>>> From: Naveen Ch
> >>>>>>
> >>>>>> I've tested with v6 patches and they are working fine on SMDK6410,
> SMDKC100
> >>>>> and SMDKV210, except for some header inclusion (linux/sched.h) in
> samsung-
> >>>>> keypad.c.
> >>>>>> The build breaking error is like following:
> >>>>>> (make s5pc100_defconfig and select input->keypad->samsung keypad)
> >>>>>>
> >>>>>> drivers/input/keyboard/samsung-keypad.c: In function
> 'samsung_keypad_irq':
> >>>>>> drivers/input/keyboard/samsung-keypad.c:170: error:
> 'TASK_UNINTERRUPTIBLE'
> >>>>> undeclared (first use in this function)
> >>>>>> drivers/input/keyboard/samsung-keypad.c:170: error: (Each undeclared
> identifier
> >>>>> is reported only once
> >>>>>> drivers/input/keyboard/samsung-keypad.c:170: error: for each function it
> appears
> >>>>> in.)
> >>>>>> drivers/input/keyboard/samsung-keypad.c:170: error: implicit declaration
> of
> >>>>> function 'schedule_timeout'
> >>>>>> drivers/input/keyboard/samsung-keypad.c: In function
> 'samsung_keypad_stop':
> >>>>>> drivers/input/keyboard/samsung-keypad.c:202: error: 'TASK_NORMAL'
> >>>>> undeclared (first use in this function)
> >>>>>> make[3]: *** [drivers/input/keyboard/samsung-keypad.o] Error 1
> >>>>>>
> >>>>> This error occurs on s5pc100_defconfig having disabled
> CONFIG_PREEMPT
> >>>>> option. I think sched.h should be included to remove like this
> >>>>> dependency in driver, are there other ways?
> >>>> I'm not sure root cause is that. But as you said, I think need inclusion it for
> prevent the problem.
> >>>> Actually didn't happen it before..so maybe the some core functions have
> moved between rc-3 and earlier versions...
> >>> The sched.h is included by below path.
> >>>
> >>> interrupt.h -> hardirq.h -> smp_lock.h -> sched.h
> >>>
> >>> The smp_lock.h in hardirq.h is included if CONFIG_PREEMPT is defined.
> >>> The samsung keypad driver haven't needed including sched.h before
> >>> Dmitry's patch is applied..
> >>>
> >>>> Anyway, if no any issues, could you please re-submit updated it soon?
> >>> I haven't get yet Dmitry's review of v6 patch set, so i am waiting it.
> >>>
> >> Ping.
> >>
> >> Do you have any feedback? If ok, i want to go to input tree or samsung
> >> tree these added sched.h including.
> >
> > I applied the patch adding samsung-keypad.c and the platform data
> > arch/arm/plat-samsung/include/plat/keypad.h and I expect that
> > patches to actually enable keypad will go through appropriate
> > platform tree(s).
> >
> 
> OK, the rest will go through samsung platform tree
> 
Ok..will apply.

> > The only caveat is that I removed declarations for copying platform data
> > around and for gpio config function - if it is there there is no point
> > of invoking it through the pointer in platform data.
> >
> 
> I agree, but currently samsung platform framework uses such this way. I
> believe these can change later at once.
> 
> > Overall I am confused why you set up keypad in platform code in the
> > way you do. I'd put the device definitions and all supporting functions
> > in the same module that registers platform device and be done with it.
> >
> 
> Thanks.


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
