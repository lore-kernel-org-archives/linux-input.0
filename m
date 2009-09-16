From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH] input/keyboard: add ADP5588 QWERTYI2C Keyboard Input device driver
Date: Wed, 16 Sep 2009 12:18:38 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04BEE48B@chinexm1.ad.analog.com>
References: <1252966719-27557-1-git-send-email-vapier@gentoo.org> <20090915062050.GB10232@core.coreip.homeip.net><8bd0f97a0909150419p1048bfe9j243fa30a0581b198@mail.gmail.com> <20090915162655.GB29241@core.coreip.homeip.net><3c17e3570909152049nd801aeds3915e5889d6181f0@mail.gmail.com> <8bd0f97a0909152103m4848fe9ayb5835a6844ea4ca1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:44267 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbZIPES6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 00:18:58 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909152103m4848fe9ayb5835a6844ea4ca1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: "Hennerich, Michael" <Michael.Hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

=20

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org=20
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On=20
>Behalf Of Mike Frysinger
>Sent: Wednesday, September 16, 2009 12:04 PM
>To: Barry Song
>Cc: Hennerich, Michael; Dmitry Torokhov;=20
>linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;=20
>uclinux-dist-devel@blackfin.uclinux.org
>Subject: Re: [Uclinux-dist-devel] [PATCH] input/keyboard: add=20
>ADP5588 QWERTYI2C Keyboard Input device driver
>
>On Tue, Sep 15, 2009 at 23:49, Barry Song wrote:
>> On Wed, Sep 16, 2009 at 12:26 AM, Dmitry Torokhov wrote:
>>> On Tue, Sep 15, 2009 at 07:19:14AM -0400, Mike Frysinger wrote:
>>>> On Tue, Sep 15, 2009 at 02:20, Dmitry Torokhov wrote:
>>>> > BTW, maybe you shoudl convert to threaded IRQs here?
>>>>
>>>> yes, after your suggestion for the previous driver, we've=20
>been looking
>>>> at all our input drivers to convert to threaded IRQs. =A0do=20
>we need to
>>>> convert all of them before acceptance, or can we merge now=20
>and post an
>>>> updated patch after ?
>>>
>>> It really depends on the driver. If there is a race between=20
>IRQ and the
>>> WQ in the driver I will request you to fix it one way or=20
>another before
>>> accepting the driver (and quite often using threaded IRQ=20
>gets rid of the
>>> race). In the cases like this particular driver though I am not eve=
n
>>> convinced that we need threaded IRQ. The driver is not expected to
>>> generate lots of events rapidly so using keventd as it does now is
>>> probably the best solution.
>>
>> Even though CONFIG_GENERIC_HARDIRQS is almost always "y", in case
>> CONFIG_GENERIC_HARDIRQS is "n" not "y", threaded_irq will become
>> original irq, drivers will not work. So is it necessary to check the
>> dependence of GENERIC_HARDIRQS while using threaded_irq?
>
>when is GENERIC_HARDIRQS not "y" ?  a quick check shows only s390/m68k
>dont set it to "y" in their arch Kconfig ?  s390 isnt going to use any
>of these drivers, and m68k will eventually update (m68knommu already
>has !?).
SPARC32 is "n" too. I am not caring about only these several drivers. I=
 just want to find whether that can be a generic problem while using th=
readed_irq in any driver.
>-mike
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
