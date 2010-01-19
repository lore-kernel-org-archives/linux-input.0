From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] Input: ad7879: split bus logic
	out
Date: Tue, 19 Jan 2010 03:46:20 -0500
Message-ID: <8bd0f97a1001190046jcb51d1bs6275ef317b43739@mail.gmail.com>
References: <1263742686-22305-1-git-send-email-vapier@gentoo.org>
	<1263876764-6464-1-git-send-email-vapier@gentoo.org> <20100119082652.GA19338@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:58495 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755571Ab0ASIql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 03:46:41 -0500
Received: by ywh12 with SMTP id 12so2256224ywh.21
        for <linux-input@vger.kernel.org>; Tue, 19 Jan 2010 00:46:40 -0800 (PST)
In-Reply-To: <20100119082652.GA19338@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Tue, Jan 19, 2010 at 03:26, Dmitry Torokhov wrote:
> On Mon, Jan 18, 2010 at 11:52:44PM -0500, Mike Frysinger wrote:
>> =C2=A0struct ad7879 {
>> - =C2=A0 =C2=A0 bus_device =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*bus;
>> + =C2=A0 =C2=A0 struct ad7879_bus_ops =C2=A0 bops;
>
> Could you change it to 'const struct ad7879_bus_ops *bops;' and add a
> separate pointer to private transport data so that bus ops are truly
> shared between instances (if any).

i can make the struct containing only the funcs const, but not the
struct that contains the irq/client since i dynamically assign the
contents in the probe func

> Also I dont see the reason for having the following typedefs:

it made sense in the other drivers i copied this format from, and in
an earlier version of the code, but they arent needed anymore, so i'll
drop em

>> +typedef int (ad7879_read_t) (void *bus_data, u8 reg);
>> +typedef int (ad7879_multi_read_t) (void *bus_data, u8 first_reg, u8=
 count, u16 *buf);
>> +typedef int (ad7879_write_t) (void *bus_data, u8 reg, u16 val);
>> +
>> +struct ad7879_bus_ops {
>> + =C2=A0 =C2=A0 void *bus_data;
>> + =C2=A0 =C2=A0 int irq;
>> + =C2=A0 =C2=A0 ad7879_read_t *read;
>> + =C2=A0 =C2=A0 ad7879_multi_read_t *multi_read;
>> + =C2=A0 =C2=A0 ad7879_write_t *write;
>> +};
>> +
>> +int ad7879_disable(struct device *dev);
>> +int ad7879_enable(struct device *dev);
>> +int ad7879_probe(struct device *dev, struct ad7879_bus_ops *bops, u=
8 devid, u16 bustype);
>> +int ad7879_remove(struct device *dev);
>
> Hmm, I liked when these accepted "struct ad7879" better.

i toyed with that a bit, but the generated code was worse because the
drvdata helpers are externals
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
