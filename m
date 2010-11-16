From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH 1/4] input: gpio_keys: polling mode support
Date: Tue, 16 Nov 2010 13:28:37 -0500
Message-ID: <AANLkTikNQgyZBLVCxKXhiYr0c0st5eLbYvoThgraqxWu@mail.gmail.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<8891d088e9a16122c780f737b1b1ec35f9517c36.1289835508.git.bengardiner@nanometrics.ca>
	<20101116093605.GD1330@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56003 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755869Ab0KPS2i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Nov 2010 13:28:38 -0500
Received: by mail-pz0-f41.google.com with SMTP id 26so27707pzk.0
        for <linux-input@vger.kernel.org>; Tue, 16 Nov 2010 10:28:37 -0800 (PST)
In-Reply-To: <20101116093605.GD1330@linux-sh.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, davinci-linux-open-source@linux.davincidsp.com, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Cordahi <christophercordahi@nanometrics.ca>, Alexander Clouter <alex@digriz.org.uk>

On Tue, Nov 16, 2010 at 4:36 AM, Paul Mundt <lethal@linux-sh.org> wrote=
:
> On Mon, Nov 15, 2010 at 02:07:50PM -0500, Ben Gardiner wrote:
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyb=
oard/gpio_keys.c
>> index 6069abe..477802a 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -44,6 +48,26 @@ struct gpio_keys_drvdata {
>> =A0 =A0 =A0 struct gpio_button_data data[0];
>> =A0};
>>
>> +#if !defined(CONFIG_INPUT_POLLDEV) && !defined(CONFIG_INPUT_POLLDEV=
_MODULE)
>> +inline struct input_polled_dev *input_allocate_polled_device(void)
>> +{
>> + =A0 =A0 return NULL;
>> +}
>> +
>> +inline void input_free_polled_device(struct input_polled_dev *poll_=
dev)
>> +{
>> +}
>> +
>> +inline int input_register_polled_device(struct input_polled_dev *de=
v)
>> +{
>> + =A0 =A0 return -ENXIO;
>> +}
>> +
>> +inline void input_unregister_polled_device(struct input_polled_dev =
*poll_dev)
>> +{
>> +}
>> +#endif
>> +
>
> Wouldn't these be better off in linux/input-polldev.h?

I'm not sure.

gpio-keys.c with these proposed changes appears to be the only user of
input-polldev.c that needs to compile and execute when
CONFIG_INPUT_POLLDEV is not defined. Moving these to input-polldev.h
wouldn't have any impact on other in-tree targets but could there be
effects on out-of-tree ones?

How would you feel about a shim layer that does a pass-thru when
CONFIG_INPUT_POLLDEV is defined and does some error checking
otherwise? I'll show you what I mean in the next version of the patch.

>> +#if !defined(CONFIG_INPUT_POLLDEV) && !defined(CONFIG_INPUT_POLLDEV=
_MODULE)
>> + =A0 =A0 if (pdata->poll_interval) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "device needs polling (enable=
 INPUT_POLLDEV)\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +#endif
>> +
> This you could probably just shove in to..
>
>> =A0 =A0 =A0 ddata =3D kzalloc(sizeof(struct gpio_keys_drvdata) +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->nbuttons * sizeof=
(struct gpio_button_data),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
>> - =A0 =A0 input =3D input_allocate_device();
>> + =A0 =A0 if (pdata->poll_interval) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 poll_dev =3D input_allocate_polled_device(=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 input =3D poll_dev ? poll_dev->input : 0;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 input =3D input_allocate_device();
>> =A0 =A0 =A0 if (!ddata || !input) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "failed to allocate state\n=
");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENOMEM;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;
>
> this. Then just get rid of the ifdefs, as the
> input_allocate_polled_device() case will have already NULL'ed out.

I like removing that #ifdef block -- as long as we keep the dev_err
about enabling INPUT_POLLDEV. It is possible for INPUT_POLLDEV to be
defined and an allocation error to occur; I think it is useful to the
clients of gpio_keys -- particularly the board setup developers -- to
differentiate between 'INPUT_POLLDEV needs to be defined' and 'failed
to allocate state', at least by printing an error message as in the
current state of this patch.

> The rest is obviously fine with me!

Alright! :) I will re-spin a version that tries to address your
comments. Thank you for your input so far.

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
