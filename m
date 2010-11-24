From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v4 2/5] da850-evm: add UI Expander pushbuttons
Date: Wed, 24 Nov 2010 12:16:46 -0500
Message-ID: <AANLkTinunPwAxOvm03dUHz-nCQY+xXVsoGZZihRWzsvf@mail.gmail.com>
References: <cover.1290201713.git.bengardiner@nanometrics.ca>
	<cover.1290540916.git.bengardiner@nanometrics.ca>
	<9e73184bfb5c0a0d47377dd9b0627405dd87ce8a.1290540916.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB593024793194E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:38238 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753487Ab0KXRQr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Nov 2010 12:16:47 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024793194E@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Cordahi <christophercordahi@nanometrics.ca>, Paul Mundt <lethal@linux-sh.org>, "Govindarajan, Sriramakrishnan" <srk@ti.com>

Hi Sekhar,

On Wed, Nov 24, 2010 at 8:16 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Ben,
>
> I have some minor comments on this patch. You could
> wait for other pending items to get resolved before
> posting a re-spin.

Thank you for your continued interest and input.

> On Wed, Nov 24, 2010 at 01:10:57, Ben Gardiner wrote:
>
>> =A0arch/arm/mach-davinci/board-da850-evm.c | =A0 98 ++++++++++++++++=
++++++++++++++-
>> =A01 files changed, 97 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach=
-davinci/board-da850-evm.c
>
>> +static struct gpio_keys_button da850_evm_ui_keys[] =3D {
>> + =A0 =A0 [0 ... DA850_N_UI_PB - 1] =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D EV_KEY,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .active_low =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .wakeup =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .debounce_interval =A0 =A0 =A0=3D DA850_KE=
YS_DEBOUNCE_MS,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .code =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D -1, /* assigned at runtime */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .gpio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D -1, /* assigned at runtime */
>> + =A0 =A0 =A0 =A0 =A0 =A0 .desc =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D NULL, /* assigned at runtime */
>> + =A0 =A0 },
>> +};
>> +
>> +static struct gpio_keys_platform_data da850_evm_ui_keys_pdata =3D {
>> + =A0 =A0 .buttons =3D da850_evm_ui_keys,
>> + =A0 =A0 .nbuttons =3D ARRAY_SIZE(da850_evm_ui_keys),
>> + =A0 =A0 .rep =3D 0, /* disable auto-repeat */
>> + =A0 =A0 .poll_interval =3D DA850_GPIO_KEYS_POLL_MS,
>> +};
>> +
>> +static struct platform_device da850_evm_ui_keys_device =3D {
>> + =A0 =A0 .name =3D "gpio-keys",
>> + =A0 =A0 .id =3D 0,
>> + =A0 =A0 .dev =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &da850_evm_ui_keys_pdat=
a
>> + =A0 =A0 },
>> +};
>
> No need of zero/NULL initialization in structures above
> since they are static.

It my opinion -- please tell me if it is wrong :) -- that explicit
initialization of platform data members is better than implicit
initialization; future developers and browsers of the code can see
that wakeup events are disabled as are auto-repeats.

I also included the .desc =3D NULL explicitly to indicate that it would
be populated at runtime so that future developers who grep the code
would know to look for a runtime initialization.

The .id =3D 0 is there since the bb keys get .id =3D 1.

As I said please tell me if you would still like me to remove this
expliciti initializations -- I would prefer to leave them as-is.

>> @@ -304,15 +388,24 @@ static int da850_evm_ui_expander_setup(struct =
i2c_client *client, unsigned gpio,
>> =A0 =A0 =A0 gpio_direction_output(sel_b, 1);
>> =A0 =A0 =A0 gpio_direction_output(sel_c, 1);
>>
>> + =A0 =A0 da850_evm_ui_keys_init(gpio);
>> + =A0 =A0 ret =3D platform_device_register(&da850_evm_ui_keys_device=
);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("Could not register UI GPIO exp=
ander push-buttons"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " device\n=
");
>
> Line-breaking an error message is not preferred since it becomes
> difficult to grep in code. Looking at this message, you could drop
> " device" altogether.

Interesting point. Thank you, I really apreciate all the knowledge you
are imparting to me throughout this process. I will remove the "
device" string from the error message entirely.

>> + =A0 =A0 =A0 =A0 =A0 =A0 goto exp_setup_keys_fail;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 ui_card_detected =3D 1;
>> =A0 =A0 =A0 pr_info("DA850/OMAP-L138 EVM UI card detected\n");
>>
>> =A0 =A0 =A0 da850_evm_setup_nor_nand();
>> -
>
> Random white space change?

Oops, yes -- I am relying to heavily on checkpatch.pl to tell me about
my mistakes. I should be reviewing my patches more closely. Thank you
again.

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
