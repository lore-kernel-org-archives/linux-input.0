From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Subject: Re: [PATCH RESEND] input: gpio_keys_polled: convert to dt
Date: Thu, 21 Jun 2012 08:37:18 -0300
Message-ID: <CAAAP30GsU1wy87QJjcctpu-=uYH6O0XEikMs5GeGDsz-gvwsZQ@mail.gmail.com>
References: <1340192062-10565-1-git-send-email-aletes.xgr@gmail.com>
	<20120621091833.GH2193@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35427 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759351Ab2FULhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jun 2012 07:37:19 -0400
In-Reply-To: <20120621091833.GH2193@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, JJ Ding <dgdunix@gmail.com>, Roland Stigge <stigge@antcom.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Thu, Jun 21, 2012 at 6:18 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>> @@ -38,7 +40,7 @@ struct gpio_keys_button_data {
>> =A0struct gpio_keys_polled_dev {
>> =A0 =A0 =A0 struct input_polled_dev *poll_dev;
>> =A0 =A0 =A0 struct device *dev;
>> - =A0 =A0 struct gpio_keys_platform_data *pdata;
>> + =A0 =A0 struct gpio_keys_platform_data pdata;
>
> I am not sure why this change is needed. Also it seems that the drive=
r
> leaks DT-created pdata on unload.

Pdata is now a member of gpio_keys_polled_dev now and that one is
kzalloc'ed at probe and kfree'd at the removal and errors. I see no
leaks there.

I could kzalloc and kfree gpio_keys_polled_dev independently instead,
to avoid all those pointer changes if you think it's better.

This is mostly a clone from the dt handling in gpio_keys, and
comparing both now,
I see that it will leak on pdata->buttons, so I will fix that.

>> +
>> +#define gpio_keys_polled_of_match NULL
>
> Please use of_match_ptr() instead.

Thanks for the suggestion, I will implement that.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
