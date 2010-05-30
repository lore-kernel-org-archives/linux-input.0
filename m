From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [spi-devel-general] [PATCH] Input: Add tsc2046 touchscreen driver
Date: Sun, 30 May 2010 14:15:12 -0700
Message-ID: <AANLkTik0Kz0wZDcAMh8VBeIJ-nKX_oL1k023T9jjtrRj@mail.gmail.com>
References: <AANLkTike4Hu6xJ52fcC9TcKaeD4hLeWxHwUvA90tc3_Q@mail.gmail.com>
	<885802.70948.qm@web180316.mail.gq1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:64590 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754882Ab0E3VPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 17:15:32 -0400
Received: by pxi18 with SMTP id 18so1218337pxi.19
        for <linux-input@vger.kernel.org>; Sun, 30 May 2010 14:15:32 -0700 (PDT)
In-Reply-To: <885802.70948.qm@web180316.mail.gq1.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org

On Sun, May 30, 2010 at 2:08 PM, David Brownell <david-b@pacbell.net> w=
rote:
> --- On Sun, 5/30/10, Cory Maccarrone <darkstar6262@gmail.com> wrote:
>
> I don't see the point in having a separate driver
> for this chip ... it's just an updated ADS7846,
> and the ads7846 driver has handled it for quite
> a few years now, as I recall. =C2=A0There's no need for
> =C2=A0second driver.
>
>> >> This driver differs from the ADS7846 in that it
>> >> uses 16-bit commands instead of 8-bit,
>
> The reason the ads7846 code uses 8-bit messaging
> is portability ... it works with SPI controllers
> which don't support 16-bit words. =C2=A0The commands are
> of necessity 16-bits. =C2=A0Using 16-bit words means this
> driver won't run on as many systems; folk will still
> need to use the ads7846 driver with tsc2046 chips..
>
>
>
> =C2=A0and does not include
>> temerature
>> >> or voltage sensing capabilities.
>
> Another reason not to have a separate driver: this
> one is less capable (as well as less portable)
>
>
>> >> additions that allow
>> >> the injection of pointercal parameters from tslib through /sys.
>
> Something the ads7846 driver could benefit from
> too ... again, two drivers is counterproductive.
>
> - Dave
>
>

I totally agree, thus my previous message.  This submitted patch is no
longer relevant.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
