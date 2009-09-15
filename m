From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] input/keyboard: add ADP5588 QWERTY I2C Keyboard Input
	device driver
Date: Tue, 15 Sep 2009 07:19:14 -0400
Message-ID: <8bd0f97a0909150419p1048bfe9j243fa30a0581b198@mail.gmail.com>
References: <1252966719-27557-1-git-send-email-vapier@gentoo.org>
	<20090915062050.GB10232@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:50429 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbZIOLTb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 07:19:31 -0400
In-Reply-To: <20090915062050.GB10232@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Robin Getz <rgetz@blackfin.uclinux.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

On Tue, Sep 15, 2009 at 02:20, Dmitry Torokhov wrote:
> On Mon, Sep 14, 2009 at 06:18:39PM -0400, Mike Frysinger wrote:
>> +static int __devexit adp5588_remove(struct i2c_client *client)
>> +{
>> + =C2=A0 =C2=A0 struct adp5588_kpad *kpad =3D dev_get_drvdata(&clien=
t->dev);
>> +
>> + =C2=A0 =C2=A0 adp5588_write(client, CFG, 0);
>> + =C2=A0 =C2=A0 free_irq(client->irq, kpad);
>
> cancel_work_sync() is missing. Could you try the updated version belo=
w?

i dont think i have any adp5588 hardware.  Robin: do we have any in
Norwood ?  otherwise, it'll have to wait for Michael to get back to
double check.

> BTW, maybe you shoudl convert to threaded IRQs here?

yes, after your suggestion for the previous driver, we've been looking
at all our input drivers to convert to threaded IRQs.  do we need to
convert all of them before acceptance, or can we merge now and post an
updated patch after ?
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
