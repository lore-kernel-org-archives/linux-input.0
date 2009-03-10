From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] input: add suspend wakeup support to sh_keysc
Date: Tue, 10 Mar 2009 19:01:58 +0900
Message-ID: <aec7e5c30903100301n3ed24395i3d72fd956b4b7f@mail.gmail.com>
References: <20090310062421.22328.68726.sendpatchset@rx1.opensource.se>
	 <5d5443650903100124g2bbc4837gaa5d9a9f17cd56f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.30]:54285 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbZCJKCB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Mar 2009 06:02:01 -0400
In-Reply-To: <5d5443650903100124g2bbc4837gaa5d9a9f17cd56f0@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

Hi Trilok,

Thanks for your comments!

On Tue, Mar 10, 2009 at 5:24 PM, Trilok Soni <soni.trilok@gmail.com> wr=
ote:
> Hi Magnus,
>
>> +
>> + =A0 =A0 =A0 device_init_wakeup(&pdev->dev, 1);
>> =A0 =A0 =A0 =A0return 0;
>
>
> Please add device_init_wakeup(&pdev->dev, 0) in sh_keysc_remove.

Isn't this just flagging the device as wakeup capable? My first guess
would be that the the wakeup state of a removed device is irrelevant
since it won't be suspended anyway. Or am I misunderstanding? Please
explain in more detail.

>> =A0err5:
>> =A0 =A0 =A0 =A0free_irq(irq, pdev);
>> @@ -253,17 +255,36 @@ static int __devexit sh_keysc_remove(str
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> +static int sh_keysc_suspend(struct device *dev)
>> +{
>> + =A0 =A0 =A0 struct platform_device *pdev;
>> + =A0 =A0 =A0 struct sh_keysc_priv *priv;
>> + =A0 =A0 =A0 unsigned short value;
>> +
>> + =A0 =A0 =A0 pdev =3D container_of(dev, struct platform_device, dev=
);
>> + =A0 =A0 =A0 priv =3D platform_get_drvdata(pdev);
>
> to_platform_device(...) ?

Thanks, much better!

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
