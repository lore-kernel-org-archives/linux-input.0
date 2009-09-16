From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH] input/keyboard: add ADP5588 QWERTY I2C Keyboard Input device driver
Date: Wed, 16 Sep 2009 17:07:34 -0400
Message-ID: <200909161707.34804.rgetz@blackfin.uclinux.org>
References: <1252966719-27557-1-git-send-email-vapier@gentoo.org> <20090915062050.GB10232@core.coreip.homeip.net> <8bd0f97a0909150419p1048bfe9j243fa30a0581b198@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:44925 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760083AbZIPVEL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 17:04:11 -0400
In-Reply-To: <8bd0f97a0909150419p1048bfe9j243fa30a0581b198@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, "Hennerich, Michael" <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

On Tue 15 Sep 2009 07:19, Mike Frysinger pondered:
> On Tue, Sep 15, 2009 at 02:20, Dmitry Torokhov wrote:
> > On Mon, Sep 14, 2009 at 06:18:39PM -0400, Mike Frysinger wrote:
> >> +static int __devexit adp5588_remove(struct i2c_client *client)
> >> +{
> >> + =C2=A0 =C2=A0 struct adp5588_kpad *kpad =3D dev_get_drvdata(&cli=
ent->dev);
> >> +
> >> + =C2=A0 =C2=A0 adp5588_write(client, CFG, 0);
> >> + =C2=A0 =C2=A0 free_irq(client->irq, kpad);
> >
> > cancel_work_sync() is missing. Could you try the updated version be=
low?
>=20
> i dont think i have any adp5588 hardware.  Robin: do we have any in
> Norwood?  otherwise, it'll have to wait for Michael to get back to
> double check.

I think Michael has the only hardware at the moment.

He will be back on Monday.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
