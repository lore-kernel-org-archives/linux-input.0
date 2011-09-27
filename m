From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v3 2/2] input: samsung-keypad: Add device tree support
Date: Tue, 27 Sep 2011 13:39:58 +0530
Message-ID: <CAJuYYwTgn2KqNr28MNEPEC7eVkuUA-dzVzJHMTy-MV+GBCn=zA@mail.gmail.com>
References: <1316427553-5033-1-git-send-email-thomas.abraham@linaro.org>
	<1316427553-5033-3-git-send-email-thomas.abraham@linaro.org>
	<20110922174054.GO17168@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110922174054.GO17168@ponder.secretlab.ca>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

Hi Grant,

On 22 September 2011 23:10, Grant Likely <grant.likely@secretlab.ca> wr=
ote:
> On Mon, Sep 19, 2011 at 03:49:13PM +0530, Thomas Abraham wrote:
>> Add device tree based discovery support for Samsung's keypad control=
ler.
>>
>> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
>> Cc: Donghwa Lee <dh09.lee@samsung.com>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>
> A few things to fix below, but you can add my acked-by when you've
> addressed them.

Ok. Thanks for your review. I will fix as per your comments.

[...]

>
>> diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input=
/keyboard/samsung-keypad.c
>> index f689f49..2a477bc 100644
>> --- a/drivers/input/keyboard/samsung-keypad.c
>> +++ b/drivers/input/keyboard/samsung-keypad.c

[...]

>> +
>> + =A0 =A0 of_property_read_u32(np, "samsung,keypad-num-rows", &num_r=
ows);
>> + =A0 =A0 of_property_read_u32(np, "samsung,keypad-num-columns", &nu=
m_cols);
>
> property_read doesn't touch the values of num_rows or num_cols on
> failure. =A0The values need to be initialized if you're going to test
> the result value.

Ok. num_rows and num_cols variables will be set to zero before the
property read call.

>
>> + =A0 =A0 if (!num_rows || !num_cols) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "number of keypad rows/column=
s not specified\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 }

[...]

>>
>> + =A0 =A0 if (pdev->dev.of_node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 samsung_keypad_parse_dt_gpio(&pdev->dev, k=
eypad);
>> +#ifdef CONFIG_OF
>> + =A0 =A0 =A0 =A0 =A0 =A0 keypad->type =3D of_device_is_compatible(p=
dev->dev.of_node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "samsung,s5pv210-keypad");
>> +#endif
>
> This still looks odd. =A0If you move the #ifdef up one line, then you
> can remove the empty version of samsung_keypad_parse_dt_gpio(), and
> this block won't look so weird.
>

That would be a better approach. Thanks for the suggestion.

Regards,
Thomas.

[...]
