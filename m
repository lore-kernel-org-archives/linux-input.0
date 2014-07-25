From: pramod gurav <pramod.gurav.etc@gmail.com>
Subject: Re: [PATCH v2] Input: soc_button_array: Remove kfree on data
 allocated with devm_zalloc
Date: Fri, 25 Jul 2014 16:14:27 +0530
Message-ID: <CAMf-jSk_q89AJsWywXPKFMMEv9j3Fv1sUxvyyB779Miks_yBRQ@mail.gmail.com>
References: <1406279557-26754-1-git-send-email-pramod.gurav@smartplayin.com>
	<CAK5sBcH6hunJZxnhLGdbAzbRCdgWr9+L=JcrhXc2zSLFAbRRdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK5sBcH6hunJZxnhLGdbAzbRCdgWr9+L=JcrhXc2zSLFAbRRdQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sachin Kamat <spk.linux@gmail.com>
Cc: linux-input@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Pramod Gurav <pramod.gurav@smartplayin.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lejun Zhu <lejun.zhu@linux.intel.com>, Sachin Kamat <sachin.kamat@linaro.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jul 25, 2014 at 3:59 PM, Sachin Kamat <spk.linux@gmail.com> wrote:
> Hi Pramod,
>
>
> On Fri, Jul 25, 2014 at 2:42 PM,  <pramod.gurav.etc@gmail.com> wrote:
>> From: Pramod Gurav <pramod.gurav@smartplayin.com>
>>
>> This patch does below:
>> - Removes kfree done on data allocated with devm_zalloc in probe
>>   path of the driver.
>> - Adds a check on return value from devm_kzalloc which was missing
>> - Removes the error lables and instead releases resources and returns
>>   after failures
>>
>> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> CC: Lejun Zhu <lejun.zhu@linux.intel.com>
>> CC: Sachin Kamat <sachin.kamat@linaro.org>
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
>> ---
>>
>> Changes since v1:
>> - Removes de_err logs on OOM cases which is not needed.
>>
>>  drivers/input/misc/soc_button_array.c |   27 +++++++++++++++------------
>>  1 file changed, 15 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
>> index 5a6334b..f421cf4 100644
>> --- a/drivers/input/misc/soc_button_array.c
>> +++ b/drivers/input/misc/soc_button_array.c
>> @@ -83,6 +83,11 @@ soc_button_device_create(struct pnp_dev *pdev,
>>                                        sizeof(*gpio_keys_pdata) +
>>                                         sizeof(*gpio_keys) * MAX_NBUTTONS,
>>                                        GFP_KERNEL);
>> +       if (!gpio_keys_pdata) {
>> +               error = -ENOMEM;
>> +               return ERR_PTR(error);
>
> You don't need a variable here. You could directly do:
I tried to retain the original code as it is. I was not sure if am
supposed to do that. Wil do it now.

>                    return ERR_PTR(-ENOMEM);
>
>> +       }
>> +
>>         gpio_keys = (void *)(gpio_keys_pdata + 1);
>>
>>         for (info = button_info; info->name; info++) {
>> @@ -104,7 +109,7 @@ soc_button_device_create(struct pnp_dev *pdev,
>>
>>         if (n_buttons == 0) {
>>                 error = -ENODEV;
>> -               goto err_free_mem;
>> +               return ERR_PTR(error);
>
> ditto
>
>>         }
>>
>>         gpio_keys_pdata->buttons = gpio_keys;
>> @@ -114,25 +119,23 @@ soc_button_device_create(struct pnp_dev *pdev,
>>         pd = platform_device_alloc("gpio-keys", PLATFORM_DEVID_AUTO);
>>         if (!pd) {
>>                 error = -ENOMEM;
>> -               goto err_free_mem;
>> +               return ERR_PTR(error);
>
> ditto
>
>>         }
>>
>>         error = platform_device_add_data(pd, gpio_keys_pdata,
>>                                          sizeof(*gpio_keys_pdata));
>> -       if (error)
>> -               goto err_free_pdev;
>
> This goto could be retained to avoid code duplication.
If I keep this here, I have to handle the following returns in this
lable, which is what my previous patch was doing. So lable would look
something like this:

+err_free_pdev:
+      platform_device_put(pd);
+      return ERR_PTR(error);

>
>> +       if (error) {
>> +               platform_device_put(pd);
>> +               return ERR_PTR(error);
>> +       }
>>
>>         error = platform_device_add(pd);
>> -       if (error)
>> -               goto err_free_pdev;
>
> ditto
>
>> +       if (error) {
>> +               platform_device_put(pd);
>> +               return ERR_PTR(error);
>> +       }
>>
>>         return pd;
>> -
>> -err_free_pdev:
>> -       platform_device_put(pd);
>> -err_free_mem:
>> -       devm_kfree(&pdev->dev, gpio_keys_pdata);
>> -       return ERR_PTR(error);
>>  }
>>
>>  static void soc_button_remove(struct pnp_dev *pdev)
>> --
>> 1.7.9.5
>>
>
>
>
> --
> Regards,
> Sachin.



-- 
Thanks and Regards
Pramod
