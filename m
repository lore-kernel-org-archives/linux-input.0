Return-Path: <SRS0=CZzJ=DW=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA7DC433DF
	for <linux-input@archiver.kernel.org>; Thu, 15 Oct 2020 10:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25CF22249
	for <linux-input@archiver.kernel.org>; Thu, 15 Oct 2020 10:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="YI2wAXus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbgJOKeA (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:34:00 -0400
Received: from mail-03.mail-europe.com ([91.134.188.129]:48904 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731165AbgJOKeA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 15 Oct 2020 06:34:00 -0400
Date:   Thu, 15 Oct 2020 10:33:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1602758036;
        bh=LmKMfbM7Hkdq+2pNRnuptrCxbTHKyZc4+lIHOhhd0oc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=YI2wAXusKjmgO/3QlwNAbO5kcl95jZbDDF9Mx7+1C06FP2QBrSwUIP3ZQFV7b6HEE
         C4aA04BWM+070lhYyjxe5ZD4YFmThIq5IvgAxfniUIndgXsxtk3hyp6J+tnL7DZYKO
         JF+fjW04QWCV/jinBEYE6zIfT4weD2ql71BPDbIY=
To:     Coiby Xu <coiby.xu@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] HID: i2c-hid: add polling mode based on connected GPIO chip's pin status
Message-ID: <t_cZwIcdajFYTSx2_B2UCOxOZLfPVBz3goQ7mtcy1g1lyok_u0sGB5nKWhZ2AX0p4-_EhwMwjGzp50wv3SYfNa3PJQWrhkk3AN5MisD9TJg=@protonmail.com>
In-Reply-To: <20201009081100.3154-1-coiby.xu@gmail.com>
References: <20201009081100.3154-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi,

I believe this patch causes I2C HID devices not to work with IRQs after res=
uming
from suspend.


> [...]
>  #ifdef CONFIG_PM_SLEEP
> @@ -1183,7 +1292,8 @@ static int i2c_hid_suspend(struct device *dev)
>  =09/* Save some power */
>  =09i2c_hid_set_power(client, I2C_HID_PWR_SLEEP);
>
> -=09disable_irq(client->irq);
> +=09if (polling_mode =3D=3D I2C_POLLING_DISABLED)
> +=09=09disable_irq(client->irq);
>

The IRQ is disabled when suspending if polling is *off*.


>  =09if (device_may_wakeup(&client->dev)) {
>  =09=09wake_status =3D enable_irq_wake(client->irq);
> @@ -1216,7 +1326,7 @@ static int i2c_hid_resume(struct device *dev)
>
>  =09=09if (ihid->pdata.post_power_delay_ms)
>  =09=09=09msleep(ihid->pdata.post_power_delay_ms);
> -=09} else if (ihid->irq_wake_enabled) {
> +=09} else if (ihid->irq_wake_enabled && polling_mode !=3D I2C_POLLING_DI=
SABLED) {

As a side note, I'm not sure if the 'polling_mode !=3D I2C_POLLING_DISABLED=
' part
is necessary (or that it's necessary *here*). It causes 'i2c_hid_resume' an=
d
'i2c_hid_suspend' to be "asymmetric" which - I believe - may cause problems=
.


>  =09=09wake_status =3D disable_irq_wake(client->irq);
>  =09=09if (!wake_status)
>  =09=09=09ihid->irq_wake_enabled =3D false;
> @@ -1225,7 +1335,8 @@ static int i2c_hid_resume(struct device *dev)
>  =09=09=09=09wake_status);
>  =09}
>
> -=09enable_irq(client->irq);
> +=09if (polling_mode !=3D I2C_POLLING_DISABLED)
> +=09=09enable_irq(client->irq);
>

The IRQ is enabled when resuming if polling is *on*. It should be enabled i=
f polling is *off*
in my opinion.


> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
