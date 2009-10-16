From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] input/misc: new ADXL345/346
	driver
Date: Fri, 16 Oct 2009 00:22:16 -0700
Message-ID: <20091016072216.GH11582@core.coreip.homeip.net>
References: <1255516029-30023-1-git-send-email-vapier@gentoo.org> <1255517680-30733-1-git-send-email-vapier@gentoo.org> <20091016043627.GC11582@core.coreip.homeip.net> <8bd0f97a0910152239v3c889a95rd9b100e3e7204e98@mail.gmail.com> <8bd0f97a0910152357i38a483c0h97ff516c7c43a717@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:39165 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125AbZJPHWz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Oct 2009 03:22:55 -0400
Received: by pxi9 with SMTP id 9so217890pxi.4
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2009 00:22:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8bd0f97a0910152357i38a483c0h97ff516c7c43a717@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Luotao Fu <l.fu@pengutronix.de>, Barry Song <barry.song@analog.com>, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Chris Verges <chrisv@cyberswitching.com>

On Fri, Oct 16, 2009 at 02:57:15AM -0400, Mike Frysinger wrote:
> On Fri, Oct 16, 2009 at 01:39, Mike Frysinger wrote:
> > On Fri, Oct 16, 2009 at 00:36, Dmitry Torokhov wrote:
> >> On Wed, Oct 14, 2009 at 06:54:40AM -0400, Mike Frysinger wrote:
> >>> +struct device;
> >>> +struct adxl34x;
> >>> +typedef int (adxl34x_read_t) (struct device *, unsigned char);
> >>> +typedef int (adxl34x_read_block_t) (struct device *, unsigned ch=
ar, int, unsigned char *);
> >>> +typedef int (adxl34x_write_t) (struct device *, unsigned char, u=
nsigned char);
> >>> +
> >>> +void adxl34x_disable(struct adxl34x *ac);
> >>> +void adxl34x_enable(struct adxl34x *ac);
> >>> +int adxl34x_probe(struct adxl34x **pac, struct device *dev, u16 =
bus_type,
> >>> + =A0 =A0 int irq, int fifo_delay_default, adxl34x_read_t read,
> >>> + =A0 =A0 adxl34x_read_block_t read_block, adxl34x_write_t write)=
;
> >>
> >> Too many arguments... I think creating "struct adxl34x_ops" is cal=
led
> >> for.
> >
> > guess i should do the same with the ad714x driver ?
>=20
> although looking at it, it'd only combine 4 args into 1 (so there'd b=
e
> 5 instead of 8).  i'd still have to pass the rest in as they're
> instance-specific.  guess you still want the change though ?

Yes, please. I still think it would be cleaner this way.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
