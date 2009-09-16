From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] input/keyboard: add ADP5588 QWERTY I2C Keyboard Input
	device driver
Date: Wed, 16 Sep 2009 00:03:46 -0400
Message-ID: <8bd0f97a0909152103m4848fe9ayb5835a6844ea4ca1@mail.gmail.com>
References: <1252966719-27557-1-git-send-email-vapier@gentoo.org>
	<20090915062050.GB10232@core.coreip.homeip.net> <8bd0f97a0909150419p1048bfe9j243fa30a0581b198@mail.gmail.com>
	<20090915162655.GB29241@core.coreip.homeip.net> <3c17e3570909152049nd801aeds3915e5889d6181f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750984AbZIPEEF@vger.kernel.org>
In-Reply-To: <3c17e3570909152049nd801aeds3915e5889d6181f0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Robin Getz <rgetz@blackfin.uclinux.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Sep 15, 2009 at 23:49, Barry Song wrote:
> On Wed, Sep 16, 2009 at 12:26 AM, Dmitry Torokhov wrote:
>> On Tue, Sep 15, 2009 at 07:19:14AM -0400, Mike Frysinger wrote:
>>> On Tue, Sep 15, 2009 at 02:20, Dmitry Torokhov wrote:
>>> > BTW, maybe you shoudl convert to threaded IRQs here?
>>>
>>> yes, after your suggestion for the previous driver, we've been look=
ing
>>> at all our input drivers to convert to threaded IRQs. =C2=A0do we n=
eed to
>>> convert all of them before acceptance, or can we merge now and post=
 an
>>> updated patch after ?
>>
>> It really depends on the driver. If there is a race between IRQ and =
the
>> WQ in the driver I will request you to fix it one way or another bef=
ore
>> accepting the driver (and quite often using threaded IRQ gets rid of=
 the
>> race). In the cases like this particular driver though I am not even
>> convinced that we need threaded IRQ. The driver is not expected to
>> generate lots of events rapidly so using keventd as it does now is
>> probably the best solution.
>
> Even though CONFIG_GENERIC_HARDIRQS is almost always "y", in case
> CONFIG_GENERIC_HARDIRQS is "n" not "y", threaded_irq will become
> original irq, drivers will not work. So is it necessary to check the
> dependence of GENERIC_HARDIRQS while using threaded_irq?

when is GENERIC_HARDIRQS not "y" ?  a quick check shows only s390/m68k
dont set it to "y" in their arch Kconfig ?  s390 isnt going to use any
of these drivers, and m68k will eventually update (m68knommu already
has !?).
-mike
