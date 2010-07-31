From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [PATCH 13/13] IR: Port ene driver to new IR subsystem and enable  it.
Date: 31 Jul 2010 19:47:00 +0200
Message-ID: <BTtOJbzJjFB@christoph>
References: <AANLkTimaut1mMUXwbJAgjNjmQkxgsf-GOCTXmKYNm1Lz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55676 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab0GaRt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 13:49:59 -0400
In-Reply-To: <AANLkTimaut1mMUXwbJAgjNjmQkxgsf-GOCTXmKYNm1Lz@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jonsmirl@gmail.com
Cc: awalls@md.metrocast.net, jarod@wilsonet.com, linux-input@vger.kernel.org, linux-media@vger.kernel.org, lirc-list@lists.sourceforge.net, maximlevitsky@gmail.com, mchehab@redhat.com

Hi Jon,

on 31 Jul 10 at 12:25, Jon Smirl wrote:
> On Sat, Jul 31, 2010 at 11:12 AM, Andy Walls <awalls@md.metrocast.net=
>
> wrote:
>> I think you won't be able to fix the problem conclusively either way=
=2E =A0A
>> lot of how the chip's clocks should be programmed depends on how the
>> GPIOs are used and what crystal is used.
>>
>> I suspect many designers will use some reference design layout from =
ENE,
>> but it won't be good in every case. =A0The wire-up of the ENE of var=
ious
>> motherboards is likely something you'll have to live with as unknown=
s.
>>
>> This is a case where looser tolerances in the in kernel decoders cou=
ld
>> reduce this driver's complexity and/or get rid of arbitrary fudge
>> factors in the driver.

> The tolerances are as loose as they can be. The NEC protocol uses
> pulses that are 4% longer than JVC. The decoders allow errors up to 2=
%
> (50% of 4%).  The crystals used in electronics are accurate to
> 0.0001%+.

But the standard IR receivers are far from being accurate enough to all=
ow
tolerance windows of only 2%.
I'm surprised that this works for you. LIRC uses a standard tolerance o=
f
30% / 100 us and even this is not enough sometimes.

=46or the NEC protocol one signal consists of 22 individual pulses at 3=
8kHz.
If the receiver just misses one pulse, you already have an error of 1/2=
2
> 4%.

Christoph
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
