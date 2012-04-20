From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: Re: [PATCH 1/2] input: adp5588 - add support for gpio names
Date: Fri, 20 Apr 2012 10:49:38 -0400
Message-ID: <BF755A95-C914-432C-BF16-959C14E1F330@gmail.com>
References: <1326136527-31447-1-git-send-email-jeff.dagenais@gmail.com> <20120109192226.GA15158@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:60009 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab2DTOty convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 10:49:54 -0400
Received: by qafi31 with SMTP id i31so737898qaf.1
        for <linux-input@vger.kernel.org>; Fri, 20 Apr 2012 07:49:53 -0700 (PDT)
In-Reply-To: <20120109192226.GA15158@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>


On Jan 9, 2012, at 14:22, Dmitry Torokhov wrote:

> On Mon, Jan 09, 2012 at 02:15:26PM -0500, Jean-Fran=E7ois Dagenais wr=
ote:
>>=20
>> Signed-off-by: Jean-Fran=E7ois Dagenais <jeff.dagenais@gmail.com>
>> Acked-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>> drivers/input/keyboard/adp5588-keys.c |    1 +
>> include/linux/i2c/adp5588.h           |    1 +
>> 2 files changed, 2 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/k=
eyboard/adp5588-keys.c
>> index e34eeb8..6412ced 100644
>> --- a/drivers/input/keyboard/adp5588-keys.c
>> +++ b/drivers/input/keyboard/adp5588-keys.c
>> @@ -197,6 +197,7 @@ static int __devinit adp5588_gpio_add(struct adp=
5588_kpad *kpad)
>> 	kpad->gc.base =3D gpio_data->gpio_start;
>> 	kpad->gc.label =3D kpad->client->name;
>> 	kpad->gc.owner =3D THIS_MODULE;
>> +	kpad->gc.names =3D gpio_data->names;
>>=20
>> 	mutex_init(&kpad->gpio_lock);
>>=20
>> diff --git a/include/linux/i2c/adp5588.h b/include/linux/i2c/adp5588=
=2Eh
>> index cec17cf..d8341cb 100644
>> --- a/include/linux/i2c/adp5588.h
>> +++ b/include/linux/i2c/adp5588.h
>> @@ -157,6 +157,7 @@ struct i2c_client; /* forward declaration */
>>=20
>> struct adp5588_gpio_platform_data {
>> 	int gpio_start;		/* GPIO Chip base # */
>> +	const char *const *names;
>=20
> I think it is 1 const too much - you won't be able to use non-statioc
> initialization...
The following code (compiles without warning using gcc version 4.6.1) w=
orks as expected
#include <stdio.h>
#include <malloc.h>
struct adp5588_gpio_platform_data {
   const char const*const* names;
};

int main(void)
{
   struct adp5588_gpio_platform_data s;
   char const* str_tbl[2];
   const char str0[10] =3D "string 0";
   const char str1[10] =3D "string 1";
   str_tbl[0] =3D str0;
   str_tbl[1] =3D str1;
   s.names =3D str_tbl;
   printf("tbl index 0: \"%s\"\n", s.names[0]);
   printf("tbl index 1: \"%s\"\n", s.names[1]);
   return 0;
}

terminal output:
tbl index 0:string 0
tbl index 1:string 1

Do I need to resend the patches? Do I need to forward to "linux-kernel"=
?
>=20
> --=20
> Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
