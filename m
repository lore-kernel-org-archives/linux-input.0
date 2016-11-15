From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Subject: Re: [PATCH v9 1/5] mfd: mxs-lradc: Add support for mxs-lradc MFD
Date: Tue, 15 Nov 2016 20:55:36 +0100
Message-ID: <CAL7P5j+zfu7aF8gbz2_FLe7Jwa8VxZwvPFfwayndUPsv95XrOA@mail.gmail.com>
References: <cover.1478071676.git.ksenija.stanojevic@gmail.com>
 <c18883dfacaaf40ab98cbb4938d5164a95a817d7.1478071676.git.ksenija.stanojevic@gmail.com>
 <657653985.202232.6f7a3a9a-5120-4cc2-a76b-92a516ab6500.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34300 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbcKOTzi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 14:55:38 -0500
In-Reply-To: <657653985.202232.6f7a3a9a-5120-4cc2-a76b-92a516ab6500.open-xchange@email.1und1.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Harald Geyer <harald@ccbib.org>, Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org, Marek Vasut <marex@denx.de>

On Tue, Nov 15, 2016 at 8:33 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Hi Ksenija,
>
>> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 2. November 2016 um
>> 08:38 geschrieben:
>>
>>
>> Add core files for low resolution analog-to-digital converter (mxs-lradc)
>> MFD driver.
>>
>> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>> ---
>> Changes in v9:
>>  - improve commit message.
>>
>> Changes in v8:
>>  - rebase onto 4.9-rc1
>>
>> Changes in v7:
>>  - define macros ADC_CELL and TSC_CELL
>>  - remove one cell and dynamically set them in the switch()
>>  - fail in the touchscreen driver instead of mfd driver if
>>    hardware doesn't contain a touchscreen
>>
>> Changes in v6:
>>  - update copyright
>>  - add kernel-doc header for struct mxs-lradc
>>  - add error message
>>  - change EINVAL to ENODEV
>>  - use PLATFORM_DEVID_NONE instead -1
>>  - cosmetic fixes
>>
>> Changes in v5:
>>  - use DEFINE_RES_MEM
>>  - don't pass ioreammaped adress to platform cells
>>  - move comment outside of struct mxs_lradc
>>  - change type of argument in mxs_lradc_reg_set, mxs_lradc_reg_clear,
>>    mxs_lradc_reg_wrt (struct mxs_lradc * -> void __iomem *)
>>
>> Changes in v4:
>>  - update copyright
>>  - use DEFINE_RES_IRQ_NAMED
>>  - remove mxs_lradc_add_device function
>>  - use struct mfd_cell in static form
>>  - improve spacing
>>  - remove unnecessary comment
>>  - remove platform_get_irq
>>  - remove touch_ret and use ret instead
>>  - rename use_touchscreen to touchscreen_wire
>>  - use goto statements
>>  - remove irq[13], irq_count and irq_name from struct mxs_lradc
>>  - remove all defines from inside the struct definition
>>
>> Changes in v3:
>>  - add note to commit message
>>  - move switch statement into if(touch_ret == 0) branch
>>  - add MODULE_AUTHOR
>>
>> Changes in v2:
>>  - do not change spacing in Kconfig
>>  - make struct mfd_cell part of struct mxs_lradc
>>  - use switch instead of if in mxs_lradc_irq_mask
>>  - use only necessary header files in mxs_lradc.h
>>  - use devm_mfd_add_device
>>  - use separate function to register mfd device
>>  - change licence to GPL
>>  - add copyright
>>
>>  drivers/mfd/Kconfig           |  17 +++
>>  drivers/mfd/Makefile          |   1 +
>>  drivers/mfd/mxs-lradc.c       | 249
>> ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mfd/mxs-lradc.h | 203 ++++++++++++++++++++++++++++++++++
>>  4 files changed, 470 insertions(+)
>>  create mode 100644 drivers/mfd/mxs-lradc.c
>>  create mode 100644 include/linux/mfd/mxs-lradc.h
>>
>> ...
>> diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
>> new file mode 100644
>> index 0000000..ffc8f2e
>> --- /dev/null
>> +++ b/drivers/mfd/mxs-lradc.c
>> @@ -0,0 +1,249 @@
>> ...
>> +
>> +static const struct of_device_id mxs_lradc_dt_ids[] = {
>> +     { .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
>> +     { .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
>> +     { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
>> +
>> +static int mxs_lradc_probe(struct platform_device *pdev)
>> +{
>> +     const struct of_device_id *of_id;
>> +     struct device *dev = &pdev->dev;
>> +     struct device_node *node = dev->of_node;
>> +     struct mxs_lradc *lradc;
>> +     struct mfd_cell *cells = mxs_cells;
>> +     int ret = 0;
>> +     u32 ts_wires = 0;
>> +
>> +     lradc = devm_kzalloc(&pdev->dev, sizeof(*lradc), GFP_KERNEL);
>> +     if (!lradc)
>> +             return -ENOMEM;
>> +
>> +     of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
>
> since you already plan to make a V10, please add a NULL check here.
> So we can avoid a possible NULL pointer dereference in the following line.

Ok. I will.

Thanks,
Ksenija

>
>> +     lradc->soc = (enum mxs_lradc_id)of_id->data;
>> +
>> +     lradc->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(lradc->clk)) {
>> +             dev_err(dev, "Failed to get the delay unit clock\n");
>> +             return PTR_ERR(lradc->clk);
>> +     }
>> +
>> +     ret = clk_prepare_enable(lradc->clk);
>> +     if (ret) {
>> +             dev_err(dev, "Failed to enable the delay unit clock\n");
>> +             return ret;
>> +     }
>> +
