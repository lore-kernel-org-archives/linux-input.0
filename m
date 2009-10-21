From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v3] input/misc: new ADXL345/346
	driver
Date: Tue, 20 Oct 2009 22:32:29 -0400
Message-ID: <8bd0f97a0910201932l1fc83412g8c3385920eae6aa0@mail.gmail.com>
References: <1255517680-30733-1-git-send-email-vapier@gentoo.org>
	<1256028039-15044-1-git-send-email-vapier@gentoo.org> <68FBE0F3CE97264395875AC1C468F22C1CA0D8@mail03.cyberswitching.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:46529 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbZJUCj2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Oct 2009 22:39:28 -0400
Received: by ywh40 with SMTP id 40so4140828ywh.33
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2009 19:39:33 -0700 (PDT)
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C1CA0D8@mail03.cyberswitching.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Verges <chrisv@cyberswitching.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Luotao Fu <l.fu@pengutronix.de>, Michael Hennerich <michael.hennerich@analog.com>, Barry Song <barry.song@analog.com>

On Tue, Oct 20, 2009 at 14:46, Chris Verges wrote:
> Hi Mike and Michael,
>
>>+config INPUT_ADXL34X
>>+config INPUT_ADXL34X_I2C
>>+config INPUT_ADXL34X_SPI
>
> Should the INPUT_ADXL34X option be auto-selected when the _I2C or _SP=
I
> counterparts are selected? =C2=A0Something like:
>
> config HAVE_INPUT_ADXL34X
>
> config INPUT_ADXL34X
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on HAVE_INPUT_ADXL34X
>
> config INPUT_ADXL34X_I2C
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "..."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on I2C
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select HAVE_INPUT_ADXL34X
>
> config INPUT_ADXL34X_SPI
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "..."
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on SPI_MASTER
> =C2=A0 =C2=A0 =C2=A0 =C2=A0select HAVE_INPUT_ADXL34X
>
> The end user would only see the INPUT_ADXL34X_SPI and INPUT_ADXL34X_I=
2C
> options, with the common INPUT_ADXL34X option being automagically
> selected due to the reverse dependencies.

while it should work nicely if we only dealt with bools, dealing with
tristates (and thus allowing the driver to be a module) doesnt work
cleanly.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
