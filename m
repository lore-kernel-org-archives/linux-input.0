From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] ad7877: fix spi word size to 16 bit
Date: Sun, 16 May 2010 15:25:34 -0400
Message-ID: <AANLkTinn6VgvujPP3gGsteBGckIFgljn7B35DV6n8kwL@mail.gmail.com>
References: <1273142265-11929-1-git-send-email-os@emlix.com>
	<n2j8bd0f97a1005061126h7fecc32btad9986c0e38246f2@mail.gmail.com>
	<4BE3E02E.1090500@emlix.com> <h2l8bd0f97a1005071123u782bab2doee5c122dbd4c8642@mail.gmail.com>
	<20100513075335.GD30110@core.coreip.homeip.net> <20100515181523.GA3081@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f191.google.com ([209.85.210.191]:56142 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab0EPTZy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 May 2010 15:25:54 -0400
In-Reply-To: <20100515181523.GA3081@emlix.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oskar Schirmer <os@emlix.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Daniel_Gl=C3=B6ckner?= <dg@emlix.com>, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver Schneidewind <osw@emlix.com>, Michael Hennerich <michael.hennerich@analog.com>

On Sat, May 15, 2010 at 14:15, Oskar Schirmer wrote:
> On Thu, May 13, 2010 at 00:53:35 -0700, Dmitry Torokhov wrote:
>> On Fri, May 07, 2010 at 02:23:07PM -0400, Mike Frysinger wrote:
>> > On Fri, May 7, 2010 at 05:41, Daniel Gl=C3=B6ckner wrote:
>> > > On 05/06/2010 08:26 PM, Mike Frysinger wrote:
>> > >> i think it'd be a better idea to do something like:
>> > >> =C2=A0 if (spi->bits_per_word !=3D 16) {
>> > >> =C2=A0 =C2=A0 if (spi->bits_per_word) {
>> > >> =C2=A0 =C2=A0 =C2=A0 dev_err(&spi->dev, "Invalid SPI settings; =
bits_per_word must be 16\n");
>> > >> =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
>> > >> =C2=A0 =C2=A0 }
>> > >> =C2=A0 =C2=A0 spi->bits_per_word =3D 16;
>> > >> =C2=A0 =C2=A0 spi_setup(spi);
>> > >> =C2=A0 }
>> > >
>> > > There is no way to set bits_per_word using struct spi_board_info=
=2E The
>> > > description of that structure in spi.h explicitly lists the word=
size as
>> > > one of the parameters drivers should set themself in probe().
>> > >
>> > > Only struct bfin5xx_spi_chip allows to set this value in the boa=
rd code.
>> >
>> > an obvious shortcoming in the SPI framework that should be fixed, =
but
>> > that doesnt make any difference to the above code now does it ? =C2=
=A0it'll
>> > operate correctly regardless of the SPI bus master.
>>
>> So is the updated patch coming?
>
> The basic question I see is, whether it is in the
> responsibility of ad7877 to check a wrong setting
> possibly caused in board specific code. If so,
> then the proposal by Mike should be used, but if not
> so, it would introduce unneeded code.
>
> Remember: both versions end up in correctly setting
> bits_per_word, with the difference merely in feedback
> level.

imo, unsupported board settings should always be detected & rejected.
all SPI master drivers do this (detect & reject unsupported SPI slave
settings).
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
