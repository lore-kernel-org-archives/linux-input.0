From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: Input: atmel_mxt_ts - status of the for-dtor branch and sscanf
 issue
Date: Wed, 4 Mar 2015 07:54:51 +0100
Message-ID: <54F6AC3B.5030606@de.bosch.com>
References: <54BD01D9.90608@de.bosch.com> <54C7CB6D.9050603@itdev.co.uk> <54D230CD.1070304@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:31759 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933353AbbCDGy4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 01:54:56 -0500
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id BC8C2840756
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2015 07:54:54 +0100 (CET)
In-Reply-To: <54D230CD.1070304@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org

Hi Nick,

On 04.02.2015 15:46, Dirk Behme wrote:
> On 27.01.2015 18:31, Nick Dyer wrote:
>> On 19/01/15 13:08, Dirk Behme wrote:
>>> we have two questions regarding the atmel_mxt_ts driver:
>>>
>>> First, what's the status of your github 'for-dtor' branch [1]? Is this
>>> subject to change? Or how stable is it? Will it go into mainline, soon?
>>>
>>> We've tested the patches in that branch on top of the mainline ~v3.18
>>> atmel_mxt_ts patches and they improve the driver a lot. So we'd like to
>>> pick that patches into our internal development tree.
>>
>> for-dtor is a set of patches that I have waiting to go upstream. I'm
>> trying
>> to feed them into mainline, but it's a slow process unfortunately. Any
>> feedback/review of these patches is greatly appreciated.
>>
>> It does get rebased frequently, for instance to re-order the patches
>> or to
>> take account of upstream review, so I would suggest not pulling it into
>> your tree. I do however keep some backported branches (maxtouch-v3.x) at
>> https://github.com/atmel-maxtouch/linux/ against various kernel versions
>> which aren't ever rebased, which you should be able to pull from.
>>
>>> Second, with that branch, doing a config file download, we sometimes
>>> randomly get
>>>
>>> atmel_mxt_ts 2-004a: Bad format: failed to parse object
>>> atmel_mxt_ts 2-004a: Error -22 updating config
>>>
>>> at the end of the parsing, depending on the byte following the
>>> firmware/config file in memory. Our config file does have CR/LF endings.
>>> The sscanf() returns "1" in that case.
>>>
>>> A quick hack solution to that is skipping the last two bytes [2].
>>> What do
>>> you think?
>>
>> I'm not convinced it's the right solution. I suspect the root cause is
>> that
>> the FW loader doesn't null-terminate the buffer we are handed from
>> user-space, so sscanf runs on past the end sometimes. So I think we
>> need to
>> do something like this (from the chromiumos fork of this driver):
>>
>> https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.14/drivers/input/touchscreen/atmel_mxt_ts.c#2251
>>
>
>
> What's about anything like [1], then? Inspired by above chromiumos fork.


Any opinions on the below?

Many thanks

Dirk


> [1]
>
> From: Dirk Behme <dirk.behme@de.bosch.com>
> Date: Wed, 4 Feb 2015 10:26:16 +0100
> Subject: [PATCH] Input: atmel_mxt_ts - terminate the config file with '\0'
>
> The config data is loaded by the firmware interface into the kernel's
> memory space. This is done without trailing '\0'. I.e. while parsing the
> data, the end of the configuration data is just detected by comparing
> the actual data position with the overall size of the config data.
>
> In case the configuration data ends with '\r' or with '\r\n', the config
> data parsing by sscanf() still reads data, even though the end of the
> file is already reached. This is done over the end of the config data,
> i.e. random kernel data might be read, until sscanf() detects a (random)
> end in that memory.
>
> Prevent this by adding a trailing '\0' to the configuration data. This
> stops sscanf() by reading over the end of the file in memory.
>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>   drivers/input/touchscreen/atmel_mxt_ts.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> b/drivers/input/touchscreen/atmel_mxt_ts.c
> index cd29e3b..843da8b 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -239,6 +239,11 @@ struct mxt_object {
>       u8 num_report_ids;
>   } __packed;
>
> +struct mxt_config {
> +    size_t size;
> +    u8 *data;
> +};
> +
>   /* Each client has this additional data */
>   struct mxt_data {
>       struct i2c_client *client;
> @@ -1571,7 +1576,7 @@ static int mxt_check_retrigen(struct mxt_data *data)
>   }
>
>   static int mxt_prepare_cfg_mem(struct mxt_data *data,
> -                   const struct firmware *cfg,
> +                   const struct mxt_config *cfg,
>                      unsigned int data_pos,
>                      unsigned int cfg_start_ofs,
>                      u8 *config_mem,
> @@ -1722,7 +1727,7 @@ static int mxt_init_t7_power_cfg(struct mxt_data
> *data);
>    *   <SIZE> - 2-byte object size as hex
>    *   <CONTENTS> - array of <SIZE> 1-byte hex values
>    */
> -static int mxt_update_cfg(struct mxt_data *data, const struct firmware
> *cfg)
> +static int mxt_update_cfg(struct mxt_data *data, const struct
> mxt_config *cfg)
>   {
>       struct device *dev = &data->client->dev;
>       struct mxt_info cfg_info;
> @@ -2709,6 +2714,7 @@ static int mxt_configure_objects(struct mxt_data
> *data,
>                    const struct firmware *cfg)
>   {
>       struct device *dev = &data->client->dev;
> +    struct mxt_config config;
>       int error;
>
>       error = mxt_init_t7_power_cfg(data);
> @@ -2718,11 +2724,26 @@ static int mxt_configure_objects(struct mxt_data
> *data,
>       }
>
>       if (cfg) {
> -        error = mxt_update_cfg(data, cfg);
> +        /* Make a mutable, '\0'-terminated copy of the config file */
> +        config.data = kmalloc(cfg->size + 1, GFP_KERNEL);
> +        if (!config.data) {
> +            error = -ENOMEM;
> +            dev_err(dev, "Error %d allocating config memory\n",
> +                error);
> +            goto err_alloc_cfg;
> +        }
> +        memcpy(config.data, cfg->data, cfg->size);
> +        config.data[cfg->size] = '\0';
> +        config.size = cfg->size;
> +
> +        error = mxt_update_cfg(data, &config);
>           if (error)
>               dev_warn(dev, "Error %d updating config\n", error);
> +
> +        kfree(config.data);
>       }
>
> +err_alloc_cfg:
>       if (data->T9_reportid_min) {
>           error = mxt_initialize_t9_input_device(data);
>           if (error)


