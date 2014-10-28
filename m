From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] Input: spear-keyboard - Add CONFIG_PM_SLEEP to
 suspend/resume functions
Date: Tue, 28 Oct 2014 10:43:00 +0900
Message-ID: <000801cff250$81c87fe0$85597fa0$%han@samsung.com>
References: <000801cff1e2$2427ba40$6c772ec0$%han@samsung.com>
 <20141027233744.GC7594@dtor-ws>
 <000001cff242$80476680$80d63380$%han@samsung.com>
 <20141028001100.GF7594@dtor-ws>
 <000701cff249$a700dde0$f50299a0$%han@samsung.com>
 <71CA30BA-E2BE-45D3-9FA8-6E1E9B1284A9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52541 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbaJ1Bmm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Oct 2014 21:42:42 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NE400HOFSR5UF30@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Tue, 28 Oct 2014 10:42:41 +0900 (KST)
In-reply-to: <71CA30BA-E2BE-45D3-9FA8-6E1E9B1284A9@gmail.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Jingoo Han' <jg1.han@samsung.com>



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, October 28, 2014 10:09 AM
> To: Jingoo Han
> Cc: linux-input@vger.kernel.org; 'Viresh Kumar'; 'Jingoo Han'
> Subject: Re: [PATCH] Input: spear-keyboard - Add CONFIG_PM_SLEEP to suspend/resume functions
> 
> On October 27, 2014 5:53:56 PM PDT, Jingoo Han <jg1.han@samsung.com> wrote:
> >On Tuesday, October 28, 2014 9:11 AM, Dmitry Torokhov wrote:
> >> On Tue, Oct 28, 2014 at 09:02:44AM +0900, Jingoo Han wrote:
> >> > On Tuesday, October 28, 2014 8:38 AM, Dmitry Torokhov wrote:
> >> > > On Mon, Oct 27, 2014 at 09:32:58PM +0900, Jingoo Han wrote:
> >> > > > Add CONFIG_PM_SLEEP to suspend/resume functions
> >> > > >
> >> > > > Add CONFIG_PM_SLEEP to suspend/resume functions instead of
> >> > > > CONFIG_PM to fix the following build warning when
> >CONFIG_PM_SLEEP
> >> > > > is not selected and CONFIG_PM is selected. This is because
> >sleep
> >> > > > PM callbacks defined by SIMPLE_DEV_PM_OPS are only used when
> >the
> >> > > > CONFIG_PM_SLEEP is enabled.
> >> > >
> >> > > Recently I've become a fan of __maybe_unused markings as they
> >insulate
> >> > > us from various CONFIG changes in unrelated subsystems, I'll
> >transform
> >> > > this patch to use them instead.
> >> >
> >> > OK, I see. I have no objection.
> >> > Then, how about changing other usages of CONFIG_PM_SLEEP/CONFIG_PM
> >> > to __maybe_unused annotation? Personally, I prefer to increase
> >build
> >> > coverage than using #ifdef guards. Someone, however, argued that
> >#ifdef
> >> > guards should be used in this case because the size of binary can
> >be
> >> > reduced. How about your opinion?
> >>
> >> The optimizer is supposed to drop functions marked as
> >'__maybe_unused'
> >> if they are indeed unused so size of the binary should not change.
> >
> >Sorry for annoying you.
> >I built 'spear-keyboard' and got the binaries as below.
> >
> >spear-keyboard.o 89500 bytes, <-- CONFIG_PM_SLEEP=n
> >spear-keyboard.o 92352 bytes, <-- CONFIG_PM_SLEEP=y
> >spear-keyboard.o 92352 bytes, <-- Marked as __maybe_unused
> >
> >As presented above, when CONFIG_PM_SLEEP is used instead of
> >__maybe_unused, the size of binary is reduced. So, someone
> >complained me to use #ifdef guards. But, I agree with your
> >opinion. Personally, I DON'T want to use #ifdef guards,
> >because I prefer to increase build coverage.
> 
> What about the final kernel image size/kernel module size?

I used 'spear13xx_defconfig' with linux-next(20141027).
Then, I changed '#ifdef CONFIG_PM' into '#ifdef CONFIG_PM_SLEEP'
as below.

-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 static int spear_kbd_suspend(struct device *dev)
 {


Then, I got the following kernel images.

1. CONFIG_PM_SLEEP=y
    zImage 2891128 bytes
    spear-keyboard.o 88528 bytes

2. CONFIG_PM_SLEEP=n
    zImage 2842656 bytes
    spear-keyboard.o 85980 bytes

3. Marked as '__maybe_unused' for 'spear_kbd_suspend()/spear_kbd_resume()'
    instead of using '#ifdef CONFIG_PM_SLEEP',
    and CONFIG_PM_SLEEP=y
    zImage 2891160 bytes
    spear-keyboard.o 88528 bytes

4. Marked as '__maybe_unused' for 'spear_kbd_suspend()/spear_kbd_resume()'
    instead of using '#ifdef CONFIG_PM_SLEEP',
    and CONFIG_PM_SLEEP=n
    zImage 2842712 bytes
    spear-keyboard.o 85980 bytes

Oh, sorry! Your comment is right.
As you mentioned, the total sizes of the kernel and spear-keyboard.o
are reduced, when '__maybe_unused' annotation is used.
Thank you!

Best regards,
Jingoo Han

> 
> 
> Thanks.
> 
> --
> Dmitry

