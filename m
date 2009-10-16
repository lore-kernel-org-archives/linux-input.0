From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] input/misc: new ADXL345/346
	driver
Date: Fri, 16 Oct 2009 02:57:15 -0400
Message-ID: <8bd0f97a0910152357i38a483c0h97ff516c7c43a717@mail.gmail.com>
References: <1255516029-30023-1-git-send-email-vapier@gentoo.org>
	<1255517680-30733-1-git-send-email-vapier@gentoo.org> <20091016043627.GC11582@core.coreip.homeip.net>
	<8bd0f97a0910152239v3c889a95rd9b100e3e7204e98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:33696 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbZJPG6L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2009 02:58:11 -0400
Received: by ywh40 with SMTP id 40so408904ywh.33
        for <linux-input@vger.kernel.org>; Thu, 15 Oct 2009 23:57:35 -0700 (PDT)
In-Reply-To: <8bd0f97a0910152239v3c889a95rd9b100e3e7204e98@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Luotao Fu <l.fu@pengutronix.de>, Barry Song <barry.song@analog.com>, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Chris Verges <chrisv@cyberswitching.com>

On Fri, Oct 16, 2009 at 01:39, Mike Frysinger wrote:
> On Fri, Oct 16, 2009 at 00:36, Dmitry Torokhov wrote:
>> On Wed, Oct 14, 2009 at 06:54:40AM -0400, Mike Frysinger wrote:
>>> +struct device;
>>> +struct adxl34x;
>>> +typedef int (adxl34x_read_t) (struct device *, unsigned char);
>>> +typedef int (adxl34x_read_block_t) (struct device *, unsigned char=
, int, unsigned char *);
>>> +typedef int (adxl34x_write_t) (struct device *, unsigned char, uns=
igned char);
>>> +
>>> +void adxl34x_disable(struct adxl34x *ac);
>>> +void adxl34x_enable(struct adxl34x *ac);
>>> +int adxl34x_probe(struct adxl34x **pac, struct device *dev, u16 bu=
s_type,
>>> + =C2=A0 =C2=A0 int irq, int fifo_delay_default, adxl34x_read_t rea=
d,
>>> + =C2=A0 =C2=A0 adxl34x_read_block_t read_block, adxl34x_write_t wr=
ite);
>>
>> Too many arguments... I think creating "struct adxl34x_ops" is calle=
d
>> for.
>
> guess i should do the same with the ad714x driver ?

although looking at it, it'd only combine 4 args into 1 (so there'd be
5 instead of 8).  i'd still have to pass the rest in as they're
instance-specific.  guess you still want the change though ?
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
