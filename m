From: =?UTF-8?B?RXJpYyBCw6luYXJk?= <eric@eukrea.com>
Subject: Re: [PATCH v2] input/imx_keypad: add PM support
Date: Fri, 18 Jun 2010 16:37:23 +0200
Message-ID: <4C1B84A3.8080300@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com> <1276856186.3146.5.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 29.mail-out.ovh.net ([87.98.216.213]:36870 "HELO
	29.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933449Ab0FROh1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 10:37:27 -0400
In-Reply-To: <1276856186.3146.5.camel@realization>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Alberto,

Le 18/06/2010 12:16, Alberto Panizzo a =C3=A9crit :
> Ok, so with this patch the keypad cannot wake the system?
> It is scheduled another patch?
>
well, actually, the keypad wakes the system, at least on my board here.

I was quite surprised to get this working this way as I would have=20
expected disable_irq + clk_disable would prevent the keypad from being =
a=20
wake source.
Can you try on your board as this cleanup may be wrong on i.MX3 ?

Thanks,
Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
