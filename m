From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: gpio_get_value in atomic context (was: make gpio-keys use
	IRQF_SHARED)
Date: Wed, 14 Oct 2009 04:40:32 -0700
Message-ID: <d6200be20910140440t2357cb4fx5f7aeba0d4b15943@mail.gmail.com>
References: <1253113398-22751-1-git-send-email-dbaryshkov@gmail.com>
	 <20090916162853.GA4970@core.coreip.homeip.net>
	 <87hbuvggfl.fsf@tac.ki.iif.hu>
	 <20090922164136.GA22639@core.coreip.homeip.net>
	 <87fxae3ile.fsf@tac.ki.iif.hu>
	 <20090928170301.GG21455@core.coreip.homeip.net>
	 <87fxa3xleg.fsf@tac.ki.iif.hu> <877hv0y1wh.fsf@tac.ki.iif.hu>
	 <20091014080437.GF5318@core.coreip.homeip.net>
	 <87eip6jkzr.fsf_-_@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:56574 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505AbZJNLlo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Oct 2009 07:41:44 -0400
Received: by pzk26 with SMTP id 26so9881296pzk.4
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2009 04:40:32 -0700 (PDT)
In-Reply-To: <87eip6jkzr.fsf_-_@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-input@vger.kernel.org, David Brownell <dbrownell@users.sourceforge.net>

2009/10/14 Ferenc Wagner <wferi@niif.hu>:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>
>> On Mon, Oct 12, 2009 at 07:09:50PM +0200, Ferenc Wagner wrote:
>>
>>> =A0 =A0 The gpio_get_value function may sleep, so it should not be
>>> =A0 =A0 called in a timer function.
>>>
>>> So is drivers/staging/dream/gpio_input.c in error, too?
>>
>> I guess so. Initially gpio method did not sleep but that has
>> changed.
>
> Let's make Arve aware of this then (even though it may not affect
> Android in practice).

If gpio_get_value may sleep, then what is gpio_get_value_cansleep for?
The gpio documentation claims gpio_get_value and gpio_set_value are
safe to use from interrupt context, but a call to gpio_cansleep is
probably needed in probe.

The matrix driver also need to change the direction of the gpio from
the timer, so it would be useful to have a standard way to check if
this is allowed as well.

--=20
Arve Hj=F8nnev=E5g
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
