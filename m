From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2] input: goodix: Add device tree support
Date: Thu, 5 Mar 2015 11:36:36 -0500
Message-ID: <CAN+gG=GJ62rm1J9o65jh7xg0wr467f-JXs7SQUtohV-5txF1_w@mail.gmail.com>
References: <1425457930-4481-1-git-send-email-mamlinav@gmail.com>
	<1425572321-6564-1-git-send-email-mamlinav@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:55252 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbCEQgh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Mar 2015 11:36:37 -0500
In-Reply-To: <1425572321-6564-1-git-send-email-mamlinav@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Hans de Goede <hdegoede@redhat.com>

Hi Aleksei,

On Thu, Mar 5, 2015 at 11:18 AM, Aleksei Mamlin <mamlinav@gmail.com> wrote:
> This patch adds device tree support and binding information for Goodix
> GT9xx series touchscreen controller.
> It also adds support for 5-finger chips, like GT911 and GT912, which
> can be found on ARM tablets, like Wexler TAB7200 and MSI Primo73.
>
> Changes since v1:
> * Merge patches into single patch.

just a small comment on that. I am not sure if this was requested, but
this is IMO a really unfortunate choice.
If you accidentally break the currently working ACPI based tablet with
the touchmax retrieval, it will be a pain to decide if the problem
lies in the touchmax retrieval or a bug in the OF implementation.

I would expect this series to have at least 2 patches.

Thanks,
Benjamin

> * Use max touch number from config instead of hardcoding.
> * Update description in Kconfig.
>
> Datasheets can be found here:
> https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing
>
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  .../bindings/input/touchscreen/goodix.txt          | 29 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  drivers/input/touchscreen/Kconfig                  |  5 ++--
>  drivers/input/touchscreen/goodix.c                 | 34 ++++++++++++++++++----
>  4 files changed, 61 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/goodix.txt
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> new file mode 100644
> index 0000000..8ba98ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> @@ -0,0 +1,29 @@
> +Device tree bindings for Goodix GT9xx series touchscreen controller
> +
> +Required properties:
> +
> + - compatible          : Should be "goodix,gt911"
> +                                or "goodix,gt9110"
> +                                or "goodix,gt912"
> +                                or "goodix,gt927"
> +                                or "goodix,gt9271"
> +                                or "goodix,gt928"
> +                                or "goodix,gt967"
> + - reg                 : I2C address of the chip. Should be 0x5d or 0x14
> + - interrupt-parent    : Interrupt controller to which the chip is connected
> + - interrupts          : Interrupt to which the chip is connected
> +
> +Example:
> +
> +       i2c@00000000 {
> +               /* ... */
> +
> +               gt928@5d {
> +                       compatible = "goodix,gt928";
> +                       reg = <0x5d>;
> +                       interrupt-parent = <&gpio>;
> +                       interrupts = <0 0>;
> +               };
> +
> +               /* ... */
> +       };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 389ca13..ab6852d 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -76,6 +76,7 @@ geniatech     Geniatech, Inc.
>  giantplus      Giantplus Technology Co., Ltd.
>  globalscale    Globalscale Technologies, Inc.
>  gmt    Global Mixed-mode Technology, Inc.
> +goodix Shenzhen Huiding Technology Co., Ltd.
>  google Google, Inc.
>  gumstix        Gumstix, Inc.
>  gw     Gateworks Corporation
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 5891752..2adf724 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -297,11 +297,12 @@ config TOUCHSCREEN_FUJITSU
>
>  config TOUCHSCREEN_GOODIX
>         tristate "Goodix I2C touchscreen"
> -       depends on I2C && ACPI
> +       depends on I2C
>         help
>           Say Y here if you have the Goodix touchscreen (such as one
>           installed in Onda v975w tablets) connected to your
> -         system.
> +         system. It also supports 5-finger chip models, which can be
> +         found on ARM tablets, like Wexler TAB7200 and MSI Primo73.
>
>           If unsure, say N.
>
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index ca19668..efba6a3 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -23,6 +23,8 @@
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
> +#include <linux/acpi.h>
> +#include <linux/of.h>
>  #include <asm/unaligned.h>
>
>  struct goodix_ts_data {
> @@ -48,6 +50,7 @@ struct goodix_ts_data {
>  #define GOODIX_REG_VERSION             0x8140
>
>  #define RESOLUTION_LOC         1
> +#define MAX_CONTACTS_LOC       5
>  #define TRIGGER_LOC            6
>
>  static const unsigned long goodix_irq_flags[] = {
> @@ -99,7 +102,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
>         }
>
>         touch_num = data[0] & 0x0f;
> -       if (touch_num > GOODIX_MAX_CONTACTS)
> +       if (touch_num > ts->max_touch_num)
>                 return -EPROTO;
>
>         if (touch_num > 1) {
> @@ -141,7 +144,7 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
>   */
>  static void goodix_process_events(struct goodix_ts_data *ts)
>  {
> -       u8  point_data[1 + GOODIX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> +       u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
>         int touch_num;
>         int i;
>
> @@ -202,21 +205,23 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>                 ts->abs_x_max = GOODIX_MAX_WIDTH;
>                 ts->abs_y_max = GOODIX_MAX_HEIGHT;
>                 ts->int_trigger_type = GOODIX_INT_TRIGGER;
> +               ts->max_touch_num = GOODIX_MAX_CONTACTS;
>                 return;
>         }
>
>         ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
>         ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
>         ts->int_trigger_type = (config[TRIGGER_LOC]) & 0x03;
> -       if (!ts->abs_x_max || !ts->abs_y_max) {
> +       ts->max_touch_num = (config[MAX_CONTACTS_LOC]) & 0x0f;
> +       if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
>                 dev_err(&ts->client->dev,
>                         "Invalid config, using defaults\n");
>                 ts->abs_x_max = GOODIX_MAX_WIDTH;
>                 ts->abs_y_max = GOODIX_MAX_HEIGHT;
> +               ts->max_touch_num = GOODIX_MAX_CONTACTS;
>         }
>  }
>
> -
>  /**
>   * goodix_read_version - Read goodix touchscreen version
>   *
> @@ -295,7 +300,7 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
>         input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
>         input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>
> -       input_mt_init_slots(ts->input_dev, GOODIX_MAX_CONTACTS,
> +       input_mt_init_slots(ts->input_dev, ts->max_touch_num,
>                             INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>
>         ts->input_dev->name = "Goodix Capacitive TouchScreen";
> @@ -372,11 +377,27 @@ static const struct i2c_device_id goodix_ts_id[] = {
>         { }
>  };
>
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id goodix_acpi_match[] = {
>         { "GDIX1001", 0 },
>         { }
>  };
>  MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
> +#endif
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id goodix_of_match[] = {
> +       { .compatible = "goodix,gt911" },
> +       { .compatible = "goodix,gt9110" },
> +       { .compatible = "goodix,gt912" },
> +       { .compatible = "goodix,gt927" },
> +       { .compatible = "goodix,gt9271" },
> +       { .compatible = "goodix,gt928" },
> +       { .compatible = "goodix,gt967" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, goodix_of_match);
> +#endif
>
>  static struct i2c_driver goodix_ts_driver = {
>         .probe = goodix_ts_probe,
> @@ -384,7 +405,8 @@ static struct i2c_driver goodix_ts_driver = {
>         .driver = {
>                 .name = "Goodix-TS",
>                 .owner = THIS_MODULE,
> -               .acpi_match_table = goodix_acpi_match,
> +               .acpi_match_table = ACPI_PTR(goodix_acpi_match),
> +               .of_match_table = of_match_ptr(goodix_of_match),
>         },
>  };
>  module_i2c_driver(goodix_ts_driver);
> --
> 2.0.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
