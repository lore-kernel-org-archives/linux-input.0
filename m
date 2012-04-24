From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: [PATCH 1/2] input: adp5588-keys - get value from data out when dir out
Date: Tue, 24 Apr 2012 09:33:11 -0400
Message-ID: <6E61B4B4-D654-41E0-ACF3-FA9F2D4B8C0F@gmail.com>
References: <1334935921-13016-1-git-send-email-jeff.dagenais@gmail.com> <20120421064710.GC2360@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:49437 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab2DXNdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 09:33:15 -0400
In-Reply-To: <20120421064710.GC2360@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: grant.likely@secretlab.ca, linus.walleij@stericsson.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, michael.hennerich@analog.com


On Apr 21, 2012, at 2:47, Dmitry Torokhov wrote:

> Hi Jean-Fran=E7ois,
>=20
> On Fri, Apr 20, 2012 at 11:32:00AM -0400, Jean-Fran=E7ois Dagenais wr=
ote:
>> As discussed here: http://ez.analog.com/message/35852,
>> the 5587 revC and 5588 revB spec sheets contain a mistake
>> in the GPIO_DAT_STATx register description.
>>=20
>> According to R.Shnell at ADI, as well as my own
>> observations, it should read:
>> "GPIO data status (shows GPIO state when read for inputs)".
>>=20
>> This commit changes the get value function accordingly.
>>=20
>> A similar patch for gpio-adp5588 follows.
>>=20
>> Signed-off-by: Jean-Fran=E7ois Dagenais <jeff.dagenais@gmail.com>
>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>> drivers/input/keyboard/adp5588-keys.c |    7 +++++++
>> 1 files changed, 7 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/k=
eyboard/adp5588-keys.c
>> index 6412ced..b7a0f1a 100644
>> --- a/drivers/input/keyboard/adp5588-keys.c
>> +++ b/drivers/input/keyboard/adp5588-keys.c
>> @@ -78,6 +78,13 @@ static int adp5588_gpio_get_value(struct gpio_chi=
p *chip, unsigned off)
>> 	unsigned int bank =3D ADP5588_BANK(kpad->gpiomap[off]);
>> 	unsigned int bit =3D ADP5588_BIT(kpad->gpiomap[off]);
>>=20
>> +	mutex_lock(&kpad->gpio_lock);
>> +	if (kpad->dir[bank] & bit) {
>> +		int result =3D !!(kpad->dat_out[bank] & bit);
>> +		mutex_unlock(&kpad->gpio_lock);
>> +		return result;
>> +	}
>> +	mutex_unlock(&kpad->gpio_lock);
>> 	return !!(adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank) & bit);
>=20
> This locking looks wrong as it is possible for adp5588_gpio_get_value=
()
> to get scheduled out after checking kpad->dir[bank] and releasing
> kpad->gpio_lock while another thread executes
> adp5588_gpio_direction_output() and modifies kpad->dir[bank].
>=20
> You should keep mutex for the entire duration; something like this:
>=20
> 	mutex_lock(&kpad->gpio_lock);
> 	if (kpad->dir[bank] & bit)
> 		val =3D kpad->dat_out[bank];
> 	else
> 		val =3D adp5588_read(kpad->client, GPIO_DAT_STAT1 + bank);
> 	mutex_unlock(&kpad->gpio_lock);
>=20
> 	return !!(val & bit);
>=20
Agreed, I think I wanted to minimize refactoring a bit too much and got=
 distracted. I will send V2 shortly for both drivers.
> Thanks.
Thank you!
>=20
> --=20
> Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
