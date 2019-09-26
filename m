From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: i2c-hid: allow delay after SET_POWER
Date: Thu, 26 Sep 2019 12:29:27 +0200
Message-ID: <CAO-hwJJsJPQxBLTPpHnvERiCtkWUfbwB-5ZcJFTcXu-c07GuNg@mail.gmail.com>
References: <20190925094326.41693-1-vicamo.yang@canonical.com> <20190925094326.41693-2-vicamo.yang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925094326.41693-2-vicamo.yang@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: You-Sheng Yang <vicamo.yang@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Kosina <jikos@kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Hui Wang <hui.wang@canonical.com>, Julian Sax <jsbc@gmx.de>, HungNien Chen <hn.chen@weidahitech.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,


On Wed, Sep 25, 2019 at 11:43 AM You-Sheng Yang
<vicamo.yang@canonical.com> wrote:
>
> According to HID over I2C specification v1.0 section 7.2.8, a device is
> allowed to take at most 1 second to make the transition to the specified
> power state. On some touchpad devices implements Microsoft Precision
> Touchpad, it may fail to execute following set PTP mode command without
> the delay and leaves the device in an unsupported Mouse mode.
>
> This change adds a post-setpower-delay-ms device property that allows
> specifying the delay after a SET_POWER command is issued.

I must confess I have at least 2 problems with your series:
- this patch is quite hard to review. There are unrelated changes and
it should be split in at least 2 (I'll detail this in the code review
below)
- you are basically adding a new quirk when Windows doesn't need it.

So before we merge this, I'd like to actually know if Windows is doing
the same and if we could not mimic what Windows is doing to prevent
further similar quirks in the future.


>
> References: https://bugzilla.kernel.org/show_bug.cgi?id=3D204991
> Signed-off-by: You-Sheng Yang <vicamo.yang@canonical.com>
> ---
>  .../bindings/input/hid-over-i2c.txt           |  2 +
>  drivers/hid/i2c-hid/i2c-hid-core.c            | 46 +++++++++++--------
>  include/linux/platform_data/i2c-hid.h         |  3 ++
>  3 files changed, 32 insertions(+), 19 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/D=
ocumentation/devicetree/bindings/input/hid-over-i2c.txt
> index c76bafaf98d2f..d82faae335da0 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> @@ -32,6 +32,8 @@ device-specific compatible properties, which should be =
used in addition to the
>  - vdd-supply: phandle of the regulator that provides the supply voltage.
>  - post-power-on-delay-ms: time required by the device after enabling its=
 regulators

Why are you removing those 2 properties?

>    or powering it on, before it is ready for communication.
> +- post-setpower-delay-ms: time required by the device after a SET_POWER =
command
> +  before it finished the state transition.

couple of issues:
- the name might not be the best. It is similar to the
post-power-on-delay while having a complete different impact. (note: I
don't have a better name at hand)
- checkpatch complains that device tree changes should be in a
separate patch, and I tend to agree.

>
>  Example:
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c=
-hid-core.c
> index 2a7c6e33bb1c4..a5bc2786dc440 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -168,6 +168,7 @@ static const struct i2c_hid_quirks {
>         __u16 idVendor;
>         __u16 idProduct;
>         __u32 quirks;
> +       __u32 post_setpower_delay_ms;
>  } i2c_hid_quirks[] =3D {
>         { USB_VENDOR_ID_WEIDA, HID_ANY_ID,
>                 I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
> @@ -189,21 +190,20 @@ static const struct i2c_hid_quirks {
>   * i2c_hid_lookup_quirk: return any quirks associated with a I2C HID dev=
ice
>   * @idVendor: the 16-bit vendor ID
>   * @idProduct: the 16-bit product ID
> - *
> - * Returns: a u32 quirks value.
>   */
> -static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
> +static void i2c_hid_set_quirk(struct i2c_hid *ihid,
> +               const u16 idVendor, const u16 idProduct)
>  {
> -       u32 quirks =3D 0;
>         int n;
>
>         for (n =3D 0; i2c_hid_quirks[n].idVendor; n++)
>                 if (i2c_hid_quirks[n].idVendor =3D=3D idVendor &&
>                     (i2c_hid_quirks[n].idProduct =3D=3D (__u16)HID_ANY_ID=
 ||
> -                    i2c_hid_quirks[n].idProduct =3D=3D idProduct))
> -                       quirks =3D i2c_hid_quirks[n].quirks;
> -
> -       return quirks;
> +                    i2c_hid_quirks[n].idProduct =3D=3D idProduct)) {
> +                       ihid->quirks =3D i2c_hid_quirks[n].quirks;
> +                       ihid->pdata.post_setpower_delay_ms =3D
> +                               i2c_hid_quirks[n].post_setpower_delay_ms;
> +               }

Why are you changing the signature of i2c_hid_set_quirk? If this is
really a good thing to do, it should go in a separate patch.

>  }
>
>  static int __i2c_hid_command(struct i2c_client *client,
> @@ -431,8 +431,22 @@ static int i2c_hid_set_power(struct i2c_client *clie=
nt, int power_state)
>             power_state =3D=3D I2C_HID_PWR_SLEEP)
>                 ihid->sleep_delay =3D jiffies + msecs_to_jiffies(20);
>
> -       if (ret)
> +       if (ret) {
>                 dev_err(&client->dev, "failed to change power setting.\n"=
);
> +               goto set_pwr_exit;
> +       }
> +
> +       /*
> +        * The HID over I2C specification states that if a DEVICE needs t=
ime
> +        * after the PWR_ON request, it should utilise CLOCK stretching.
> +        * However, it has been observered that the Windows driver provid=
es a
> +        * 1ms sleep between the PWR_ON and RESET requests and that some =
devices
> +        * rely on this.
> +        */
> +       if (ihid->pdata.post_setpower_delay_ms)
> +               msleep(ihid->pdata.post_setpower_delay_ms);
> +       else
> +               usleep_range(1000, 5000);

Moving up this part needs definitively to be in a separate patch as
well, with a good explanation on why.

Cheers,
Benjamin

>
>  set_pwr_exit:
>         return ret;
> @@ -456,15 +470,6 @@ static int i2c_hid_hwreset(struct i2c_client *client=
)
>         if (ret)
>                 goto out_unlock;
>
> -       /*
> -        * The HID over I2C specification states that if a DEVICE needs t=
ime
> -        * after the PWR_ON request, it should utilise CLOCK stretching.
> -        * However, it has been observered that the Windows driver provid=
es a
> -        * 1ms sleep between the PWR_ON and RESET requests and that some =
devices
> -        * rely on this.
> -        */
> -       usleep_range(1000, 5000);
> -
>         i2c_hid_dbg(ihid, "resetting...\n");
>
>         ret =3D i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
> @@ -1023,6 +1028,9 @@ static void i2c_hid_fwnode_probe(struct i2c_client =
*client,
>         if (!device_property_read_u32(&client->dev, "post-power-on-delay-=
ms",
>                                       &val))
>                 pdata->post_power_delay_ms =3D val;
> +       if (!device_property_read_u32(&client->dev, "post-setpower-delay-=
ms",
> +                                     &val))
> +               pdata->post_setpower_delay_ms =3D val;
>  }
>
>  static int i2c_hid_probe(struct i2c_client *client,
> @@ -1145,7 +1153,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>                  client->name, hid->vendor, hid->product);
>         strlcpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
>
> -       ihid->quirks =3D i2c_hid_lookup_quirk(hid->vendor, hid->product);
> +       i2c_hid_set_quirk(ihid, hid->vendor, hid->product);
>
>         ret =3D hid_add_device(hid);
>         if (ret) {
> diff --git a/include/linux/platform_data/i2c-hid.h b/include/linux/platfo=
rm_data/i2c-hid.h
> index c628bb5e10610..71682f2ad8a53 100644
> --- a/include/linux/platform_data/i2c-hid.h
> +++ b/include/linux/platform_data/i2c-hid.h
> @@ -20,6 +20,8 @@
>   * @hid_descriptor_address: i2c register where the HID descriptor is sto=
red.
>   * @supplies: regulators for powering on the device.
>   * @post_power_delay_ms: delay after powering on before device is usable=
.
> + * @post_setpower_delay_ms: delay after SET_POWER command before device
> + *                          completes state transition.
>   *
>   * Note that it is the responsibility of the platform driver (or the acp=
i 5.0
>   * driver, or the flattened device tree) to setup the irq related to the=
 gpio in
> @@ -36,6 +38,7 @@ struct i2c_hid_platform_data {
>         u16 hid_descriptor_address;
>         struct regulator_bulk_data supplies[2];
>         int post_power_delay_ms;
> +       int post_setpower_delay_ms;
>  };
>
>  #endif /* __LINUX_I2C_HID_H */
> --
> 2.23.0
>
