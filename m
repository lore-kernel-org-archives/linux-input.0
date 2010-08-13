From: Kevin Wells <wellsk40@gmail.com>
Subject: Re: [PATCH] input/touch: Introduce the LPC32xx touchscreen controller driver
Date: Fri, 13 Aug 2010 12:00:33 -0700
Message-ID: <AANLkTik0voaTUHoJuaVGvmhqpUh_tfbk3VUNXyWMh1av@mail.gmail.com>
References: <1281568142-12892-1-git-send-email-wellsk40@gmail.com>
	<1281568142-12892-2-git-send-email-wellsk40@gmail.com>
	<20100813083311.GA7824@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34031 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754804Ab0HMTAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Aug 2010 15:00:36 -0400
Received: by wyb32 with SMTP id 32so2948772wyb.19
        for <linux-input@vger.kernel.org>; Fri, 13 Aug 2010 12:00:35 -0700 (PDT)
In-Reply-To: <20100813083311.GA7824@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Durgesh Pattamatta <durgesh.pattamatta@nxp.com>

>>
>> This patch set introduces support for the LPC32xx touchscreen
>> controller driver. The LPC32xx touchscreen controller supports
>> automated event detection and X/Y data conversion for resistive
>> touchscreens.
>>
>
> Overall looks very nice, a few comments below.
>

Thanks for helping review this driver. I'll update and repost once
the fixes and changes are finalized.

>> +
>> + =A0 =A0 if (input_register_device(tsc->dev)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed registering in=
put device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_stop_clk;
>
> retval is garbage here, you need to do:
>
> =A0 =A0 =A0 =A0error =3D input_register_device();
> =A0 =A0 =A0 =A0if (error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_stop_clk;
> =A0 =A0 =A0 =A0}
>
> I must say that I do not like mixing devm_* with the standard error p=
ath
> unwinding, if we can rely on devm_xxx() calls to take care of everyth=
ing
> we should revert to standard error unsinding practice for everythng.
>

Would it be preferable to just use standard resource functions and erro=
r
path unwinding (with fixes in _remove too) similar to the other drivers=
 in
=2E/drivers/input?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
