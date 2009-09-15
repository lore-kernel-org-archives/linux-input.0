From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH] input/keyboard: add ADP5588 QWERTY I2C Keyboard Input
	device driver
Date: Tue, 15 Sep 2009 12:46:14 -0400
Message-ID: <8bd0f97a0909150946t65c445ddo6741c2a472c1738c@mail.gmail.com>
References: <1252966719-27557-1-git-send-email-vapier@gentoo.org>
	<20090915062050.GB10232@core.coreip.homeip.net> <8bd0f97a0909150419p1048bfe9j243fa30a0581b198@mail.gmail.com>
	<20090915162655.GB29241@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.211.174]:46769 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbZIOQqb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 12:46:31 -0400
In-Reply-To: <20090915162655.GB29241@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Robin Getz <rgetz@blackfin.uclinux.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>, Bryan Wu <cooloney@kernel.org>

On Tue, Sep 15, 2009 at 12:26, Dmitry Torokhov wrote:
> On Tue, Sep 15, 2009 at 07:19:14AM -0400, Mike Frysinger wrote:
>> On Tue, Sep 15, 2009 at 02:20, Dmitry Torokhov wrote:
>> > On Mon, Sep 14, 2009 at 06:18:39PM -0400, Mike Frysinger wrote:
>> >> +static int __devexit adp5588_remove(struct i2c_client *client)
>> >> +{
>> >> + =C2=A0 =C2=A0 struct adp5588_kpad *kpad =3D dev_get_drvdata(&cl=
ient->dev);
>> >> +
>> >> + =C2=A0 =C2=A0 adp5588_write(client, CFG, 0);
>> >> + =C2=A0 =C2=A0 free_irq(client->irq, kpad);
>> >
>> > cancel_work_sync() is missing. Could you try the updated version b=
elow?
>>
>> i dont think i have any adp5588 hardware. =C2=A0Robin: do we have an=
y in
>> Norwood ? =C2=A0otherwise, it'll have to wait for Michael to get bac=
k to
>> double check.
>>
>> > BTW, maybe you shoudl convert to threaded IRQs here?
>>
>> yes, after your suggestion for the previous driver, we've been looki=
ng
>> at all our input drivers to convert to threaded IRQs. =C2=A0do we ne=
ed to
>> convert all of them before acceptance, or can we merge now and post =
an
>> updated patch after ?
>
> It really depends on the driver. If there is a race between IRQ and t=
he
> WQ in the driver I will request you to fix it one way or another befo=
re
> accepting the driver (and quite often using threaded IRQ gets rid of =
the
> race). In the cases like this particular driver though I am not even
> convinced that we need threaded IRQ. The driver is not expected to
> generate lots of events rapidly so using keventd as it does now is
> probably the best solution.

i dont think there is a race here as we only use the IRQ to schedule
the WQ; we dont read/pass info between the two.

at any rate, i noticed that this driver isnt the final one.  i spent
some time cleaning it up a bit more (style, messages, dev_pm_ops), so
i'll merge your changes and mine and post another one.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
