From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] Input: ad7879: split bus logic
	out
Date: Tue, 19 Jan 2010 03:57:53 -0500
Message-ID: <8bd0f97a1001190057k71cf411fh547c8d0bc2bb4149@mail.gmail.com>
References: <1263742686-22305-1-git-send-email-vapier@gentoo.org>
	<1263876764-6464-1-git-send-email-vapier@gentoo.org> <20100119082652.GA19338@core.coreip.homeip.net>
	<8bd0f97a1001190046jcb51d1bs6275ef317b43739@mail.gmail.com>
	<20100119085156.GE19338@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:34484 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751271Ab0ASI6N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 03:58:13 -0500
Received: by ywh12 with SMTP id 12so2261326ywh.21
        for <linux-input@vger.kernel.org>; Tue, 19 Jan 2010 00:58:13 -0800 (PST)
In-Reply-To: <20100119085156.GE19338@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Tue, Jan 19, 2010 at 03:51, Dmitry Torokhov wrote:
> On Tue, Jan 19, 2010 at 03:46:20AM -0500, Mike Frysinger wrote:
>> On Tue, Jan 19, 2010 at 03:26, Dmitry Torokhov wrote:
>> > On Mon, Jan 18, 2010 at 11:52:44PM -0500, Mike Frysinger wrote:
>> >> +typedef int (ad7879_read_t) (void *bus_data, u8 reg);
>> >> +typedef int (ad7879_multi_read_t) (void *bus_data, u8 first_reg,=
 u8 count, u16 *buf);
>> >> +typedef int (ad7879_write_t) (void *bus_data, u8 reg, u16 val);
>> >> +
>> >> +struct ad7879_bus_ops {
>> >> + =C2=A0 =C2=A0 void *bus_data;
>> >> + =C2=A0 =C2=A0 int irq;
>> >> + =C2=A0 =C2=A0 ad7879_read_t *read;
>> >> + =C2=A0 =C2=A0 ad7879_multi_read_t *multi_read;
>> >> + =C2=A0 =C2=A0 ad7879_write_t *write;
>> >> +};
>> >> +
>> >> +int ad7879_disable(struct device *dev);
>> >> +int ad7879_enable(struct device *dev);
>> >> +int ad7879_probe(struct device *dev, struct ad7879_bus_ops *bops=
, u8 devid, u16 bustype);
>> >> +int ad7879_remove(struct device *dev);
>> >
>> > Hmm, I liked when these accepted "struct ad7879" better.
>>
>> i toyed with that a bit, but the generated code was worse because th=
e
>> drvdata helpers are externals
>
> Hm, it would only make overall difference when you have both transpor=
ts
> loaded, right? Oh well, I don't really have strong preference either
> way.

some of these funcs are used internally too, so there'd still be an
issue with only one bus driver
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
