From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v2 4/4] da850-evm: add baseboard UI expander buttons,
 switches and LEDs
Date: Fri, 19 Nov 2010 10:40:50 -0500
Message-ID: <AANLkTike4sRvptEe9PXLT2u+SrFMOpNC6pvLPSzBfVOX@mail.gmail.com>
References: <cover.1289835508.git.bengardiner@nanometrics.ca>
	<cover.1289935504.git.bengardiner@nanometrics.ca>
	<d6d59b4a3c34149008f3681e0d6106efa15f354d.1289935504.git.bengardiner@nanometrics.ca>
	<B85A65D85D7EB246BE421B3FB0FBB59302477EAA89@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:39917 "HELO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754998Ab0KSPkw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Nov 2010 10:40:52 -0500
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302477EAA89@dbde02.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Govindarajan, Sriramakrishnan" <srk@ti.com>, Paul Mundt <lethal@linux-sh.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Clouter <alex@digriz.org.uk>, Chris Cordahi <christophercordahi@nanometrics.ca>

Hi Sehkar,

On Fri, Nov 19, 2010 at 7:14 AM, Nori, Sekhar <nsekhar@ti.com> wrote:
> The board patches look good to me overall. Some minor comments below:

Thanks -- and I appreciate your input.

> On Wed, Nov 17, 2010 at 01:09:37, Ben Gardiner wrote:
>> [...]
>> +static const char const *baseboard_expander_names[] =3D {
>> + =A0 =A0 "deep_sleep_en", "sw_rst", "tp_23", "tp_22", "tp_21", "use=
r_pb1",
>> + =A0 =A0 "user_led2", "user_led1", "user_sw_1", "user_sw_2", "user_=
sw_3",
>> + =A0 =A0 "user_sw_4", "user_sw_5", "user_sw_6", "user_sw_7", "user_=
sw_8"
>> +};
>> +
>> +#define DA850_DEEP_SLEEP_EN_OFFSET =A0 =A0 =A0 =A0 =A0 0
>> +#define DA850_SW_RST_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +#define DA850_PB1_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 5
>> +#define DA850_USER_LED2_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 6
>> +#define DA850_USER_SW_1_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 8
>
> Again, I think index initialized array will work much
> better here. Currently it is error prone to keep the defines
> and the array of names in sync.

Agreed. Now that I've seen what you did with the previous patch I am
eager to apply that pattern also to the definitions in this patch.

>> [...]
>> +static struct gpio_keys_platform_data user_pb_gpio_key_platform_dat=
a =3D {
>
> Similarly "da850evm_bb_pb_pdata" instead of the long name?

Will do.

>> [...]
>> +static struct gpio_keys_button user_sw_gpio_keys[DA850_N_USER_SW];
>
> You could initialize most static fields here itself using:
>
> static struct gpio_keys_button user_sw_gpio_keys[] =3D {
> =A0 =A0 =A0 =A0[0 ... DA850_N_USER_SW] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0},
> };
>
> This way your runtime initialization will come down.

Indeed; I am eager to extend the pattern you introduced to this
initialization also.

>> +
>> +static struct gpio_keys_platform_data user_sw_gpio_key_platform_dat=
a =3D {
>> + =A0 =A0 .buttons =3D user_sw_gpio_keys,
>> + =A0 =A0 .nbuttons =3D ARRAY_SIZE(user_sw_gpio_keys),
>> + =A0 =A0 .rep =3D 0, /* disable auto-repeat */
>> + =A0 =A0 .poll_interval =3D DA850_SW_POLL_MS,
>> +};
>
> I wonder if we really have create to separate platform data
> for switches and push buttons. If it is only the debounce period
> that is different, it can be handled by initializing that field
> differently.

I see. Good idea; we can declare an array of gpio_keys_platform_data.

Note; it is the polling interval which differs, not the debounce interv=
al.

>> +
>> +static struct platform_device user_sw_gpio_key_device =3D {
>> + =A0 =A0 .name =3D "gpio-keys",
>> + =A0 =A0 .id =3D 2,
>> + =A0 =A0 .dev =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &user_sw_gpio_key_platf=
orm_data
>
> End with a ',' here.

Will do.

>> [...]
>> +static void da850_user_switches_init(unsigned gpio)
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 struct gpio_keys_button *button;
>> +
>> + =A0 =A0 for (i =3D 0; i < DA850_N_USER_SW; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 button =3D &user_sw_gpio_keys[i];
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 button->code =3D SW_LID + i;
>> + =A0 =A0 =A0 =A0 =A0 =A0 button->type =3D EV_SW;
>> + =A0 =A0 =A0 =A0 =A0 =A0 button->active_low =3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 button->wakeup =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 button->debounce_interval =3D DA850_PB_DEB=
OUNCE_MS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 button->desc =3D (char *)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 baseboard_expander_names[D=
A850_USER_SW_1_OFFSET + i];
>
> You could use some shorter names here. In the context of EVM file, 'b=
b'
> will fit for "base board", "exp" works for expander. Also, here it is
> clear the macro is used as an array offset, so _OFFSET can be dropped
> altogether. Similarly with _names. Also, the global and static symbol=
s
> should be pre-fixed with da850evm_ so it is easy to look up the symbo=
l
> file or object dump.

I see your points; 1) exp and bb for expander and baseboard variable
names, respectively 2) drop _OFFSET and _names 3) prefix statics and
globals with da850evm.

>> [...]
>
> How does gpio_request prevent sysfs control?

To obtain access to a gpio through the sysfs interface the user must
first write the gpio number to 'export'. When the gpio has been
gpio_request()'d the result of writing to 'export' is nothing; whereas
writing to export would normally result in the appearance of a named
gpio line alongside 'export'.

 I hope the following commands and their output illustrate my point:

$ cd /sys/class/gpio/
$ ls
export       gpiochip128  gpiochip160  gpiochip64   unexport
gpiochip0    gpiochip144  gpiochip32   gpiochip96
$ echo 160 > export
$ ls
export       gpiochip128  gpiochip160  gpiochip64   unexport
gpiochip0    gpiochip144  gpiochip32   gpiochip96
$ echo 163 > export
$ ls
export       gpiochip128  gpiochip160  gpiochip64   tp_22
gpiochip0    gpiochip144  gpiochip32   gpiochip96   unexport

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
