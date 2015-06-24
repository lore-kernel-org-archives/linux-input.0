From: Carlo Caione <carlo@caione.org>
Subject: Re: [linux-sunxi] Re: [PATCH] input: axp20x-pek: Fix reporting button
 state as inverted
Date: Wed, 24 Jun 2015 11:19:39 +0200
Message-ID: <CAOQ7t2a+3TvmgfW3dJBc=FJk1sXNAT+SE6qP0r5ovG7yx9fYHA@mail.gmail.com>
References: <1434278541-21355-1-git-send-email-hdegoede@redhat.com>
	<20150622213051.GD2350@dtor-ws>
	<CAGb2v64AF3bnd-QBRCszjD7MSfCnGSvfu3wUT2W+7fNTE76d5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34966 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbbFXJTl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 05:19:41 -0400
In-Reply-To: <CAGb2v64AF3bnd-QBRCszjD7MSfCnGSvfu3wUT2W+7fNTE76d5g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Carlo Caione <carlo@caione.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>

On Wed, Jun 24, 2015 at 3:42 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Jun 23, 2015 at 5:30 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Sun, Jun 14, 2015 at 12:42:21PM +0200, Hans de Goede wrote:
>>> Currently we are reporting the button state as inverted on all boards with
>>> an axp209 pmic, tested on a ba10-tvbox, bananapi, bananapro, cubietruck and
>>> utoo-p66 tablet.
>>>
>>> The axp209 datasheet clearly states that the power button must be connected
>>> between the PWRON key and ground. Which means that on a press we will get
>>> a falling edge (dbf) irq not a rising one, and likewise on release we will
>>> get a rising edge (dbr) irq, not a falling one.
>>>
>>> This commit swaps the check for the 2 irqs fixing the inverted reporting of
>>> the power button state.
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Carlo, Chen-Yu, could you please give this patch a spin and let us know
>> if it works on your boards?
>
> I've not actually tested this patch on my boards, but I can confirm that
> the original code had the state inverted, by checking /proc/interrupts
> counters, before and after releasing the power button.
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Same here (I don't have the board anymore)

Acked-by: Carlo Caione <carlo@caione.org>

-- 
Carlo Caione
