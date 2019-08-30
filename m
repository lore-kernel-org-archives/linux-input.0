From: Peter Cai <peter@typeblog.net>
Subject: Re: [PATCH 2/2] touchscreen: goodix: define GPIO mapping for GPD P2 Max
Date: Fri, 30 Aug 2019 23:32:53 +0800
Message-ID: <D5227099-6120-446B-A39D-6AE437F5E11E@typeblog.net>
References: <20190830000024.20384-1-peter@typeblog.net> <20190830000024.20384-2-peter@typeblog.net> <20190830115505.GX2680@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190830115505.GX2680@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On August 30, 2019 7:55:05 PM GMT+08:00, Andy Shevchenko <andriy=2Eshevchen=
ko@linux=2Eintel=2Ecom> wrote:
>On Fri, Aug 30, 2019 at 08:00:24AM +0800, Peter Cai wrote:
>> The firmware of GPD P2 Max could not handle panel resets although
>code
>> is present in DSDT=2E The kernel needs to take on this job instead, but
>> the DSDT does not provide _DSD, rendering kernel helpless when trying
>to
>> find the respective GPIO pins=2E
>>=20
>> Fortunately, this time GPD has proper DMI vendor / product strings
>that
>> we could match against=2E We simply apply an acpi_gpio_mapping table
>when
>> GPD P2 Max is matched=2E
>>=20
>> Additionally, the DSDT definition of the irq pin specifies a wrong
>> polarity=2E The new quirk introduced in the previous patch
>> (ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this=2E
>
>> +#ifdef CONFIG_ACPI
>
>I guess most of these #ifdef:s makes code less readable for exchange of
>saving
>few bytes in the module footprint=2E
>
>> +	{ "irq-gpios", &irq_gpios_default, 1,
>> +		ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },
>
>One line?
>
>> +		=2Ematches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
>> +			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")
>
>Comma at the end?
>
>> +		},
>> +		=2Edriver_data =3D &gpio_mapping_force_irq_active_high
>
>Ditto=2E

> I guess most of these #ifdef:s makes code less readable for exchange of =
saving
few bytes in the module footprint=2E

Since they can only be used when ACPI is supported (devm_acpi_dev_add_driv=
er_gpios does not exist without ACPI defined, thus the last guard must exis=
t), if they were not guarded then we would be left with a bunch of unused v=
ariables warnings when building without ACPI which doesn't seem good=2E

Should we use __maybe_unused here instead of #ifdef guards?

> Comma at the end?

I was trying to follow the style of this driver but it doesn't seem to be =
really consistent within itself=2E Another dmi_system_id definition in the =
same file mixed both styles so I was kind of confused=2E

--=20
Regards,
Xiyu Cai
