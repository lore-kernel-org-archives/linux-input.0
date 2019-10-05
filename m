From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 5.4 regression fix] Input: soc_button_array - partial
 revert of support for newer surface devices
Date: Sat, 5 Oct 2019 15:20:51 +0200
Message-ID: <96cea5be-d285-8323-1ab2-9c8e87993165@redhat.com>
References: <20191005105551.353273-1-hdegoede@redhat.com>
 <222c364a-bc2b-5960-3fe4-7d1ce222e3e2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <222c364a-bc2b-5960-3fe4-7d1ce222e3e2@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andy@infradead.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 05-10-2019 14:17, Maximilian Luz wrote:
> Hi,
>=20
> sorry for the inconvenience this change has caused.
>=20
> On 10/5/19 12:55 PM, Hans de Goede wrote:
>> Note ideally this seamingly unrelated change would have been made in a
>> separate commit, with a message explaining the what and why of this
>> change.
>=20
> Would I have known the impact, then yes. This change was added due to
> some reported instances where it seems that soc_button_array would
> occasionally load on MSHW0040 before the GPIO controller was ready,
> causing power and volume buttons to not work.
>=20
>> I guess this change may have been added to deal with -EPROBE_DEFER error=
s,
>=20
> Correct. After a comment mentioned that gpiod_get() returning
> -EPROBE_DEFER would be the proper way to detect this, I decided on this
> change.

Ok, on x86 the GPIO drivers really should all be builtin because
various ACPI methods including device D0 / D3 (power-on/off) methods
may depend on them. So normally this should never happen.

If this (-EPROBE_DEFER on surface devices) somehow still is happening
please let me know and we will figure something out.

> Might I suggest the following addition:
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

S-o-b is only for patches which pass through your hands, e.g. if
you make changes to my patch and submit a v2 of it.

I guess you mean / want one of:

Acked-by: ...

or

Reviewed-by: ...


?

Regards,

Hans



> ---
>  =C2=A0drivers/input/misc/soc_button_array.c | 25 ++++++++++++++++++++---=
--
>  =C2=A01 file changed, 20 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/s=
oc_button_array.c
> index 97e3639e99d0..a0f0c977b790 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -92,11 +92,18 @@ soc_button_device_create(struct platform_device *pdev=
,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 continue;
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio =3D soc_button_loo=
kup_gpio(&pdev->dev, info->acpi_index);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (gpio < 0 && gpio !=3D -EN=
OENT) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error=
 =3D gpio;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
err_free_mem;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!gpio_is_valid(gpi=
o)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Sk=
ip GPIO if not present */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!gpio_is_valid(gpio)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * Skip GPIO if not present. Note we deliberately
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * ignore -EPROBE_DEFER errors here. On some devices
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * Intel is using so called virtual GPIOs which are not
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * GPIOs at all but some way for AML code to check some
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * random status bits without need a custom opregion.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * In some cases the resources table we parse points to
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * such a virtual GPIO, since these are not real GPIOs
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * we do not have a driver for these so they will never
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * show up, therefor we ignore -EPROBE_DEFER.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 */
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 continue;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> @@ -429,6 +436,14 @@ static int soc_device_check_MSHW0040(struct device *=
dev)
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "OEM Platform Revision %llu\n", oe=
m_platform_rev);
>=20
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Explicitly check if GPIO controller is ready.=
 This check is done here
> +=C2=A0=C2=A0=C2=A0=C2=A0 * to avoid issues with virtual GPIOs on other c=
hips, as elaborated above.
> +=C2=A0=C2=A0=C2=A0=C2=A0 * We are at least expecting one GPIO pin for th=
e power button (index 0).
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 if (soc_button_lookup_gpio(dev, 0) =3D=3D -EPROBE_DEF=
ER)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EPROBE_DEFER;
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>  =C2=A0}
>=20
