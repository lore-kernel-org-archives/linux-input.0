From: Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH v2] HID: i2c-hid: Add vddl regulator control
Date: Thu, 21 Jun 2018 16:58:31 -0700
Message-ID: <CAE_wzQ8YKUF1U4MKBfi9GQpFz=971j57w-1n-ggZHidMA4HEzQ@mail.gmail.com>
References: <20180621234138.30537-1-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621234138.30537-1-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: swboyd@chromium.org
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, andriy.shevchenko@linux.intel.com, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 21, 2018 at 4:41 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Some wacom w9013 devices have a vddl supply for "low valtage"
> requirements. Add support in this driver to turn on this low voltage
> supply. We can also drop a handful of error messages because the
> regulator core is already printing an error when bulk regulators fail to
> enable or disable.
>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Dmitry Torokhov <dtor@chromium.org>
> Cc: Doug Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes from v1:
>  * Use the bulk regulator APIs instead of open coding it (Dmitry)
>
>  .../bindings/input/hid-over-i2c.txt           |  3 +-
>  drivers/hid/i2c-hid/i2c-hid.c                 | 62 +++++++++----------
>  include/linux/platform_data/i2c-hid.h         |  7 +--
>  3 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> index 4d3da9d91de4..89e6ab89ba38 100644
> --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> @@ -26,7 +26,8 @@ device-specific compatible properties, which should be used in addition to the
>
>  - compatible:
>    * "wacom,w9013" (Wacom W9013 digitizer). Supports:
> -    - vdd-supply
> +    - vdd-supply (3.3V)
> +    - vddl-supply (1.8V)
>      - post-power-on-delay-ms
>
>  - vdd-supply: phandle of the regulator that provides the supply voltage.
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index c1652bb7bd15..1d83531454c5 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1002,18 +1002,21 @@ static int i2c_hid_probe(struct i2c_client *client,
>                 return client->irq;
>         }
>
> -       ihid = kzalloc(sizeof(struct i2c_hid), GFP_KERNEL);
> +       ihid = devm_kzalloc(&client->dev, sizeof(*ihid), GFP_KERNEL);

The patch looks good, but I think this chunk needs to be split out.

Thanks,
Dmitry
