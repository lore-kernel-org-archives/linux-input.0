From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 00/15] atmel_mxt_ts - device tree, bootloader, etc
Date: Tue, 02 Sep 2014 09:45:22 -0600
Message-ID: <5405E612.9030402@wwwdotorg.org>
References: <1404399697-26484-1-git-send-email-nick.dyer@itdev.co.uk>	<53CECAEC.8080905@wwwdotorg.org>	<53CFD50C.4040509@itdev.co.uk>	<53CFEF6E.2060905@wwwdotorg.org>	<53D10E78.4010908@itdev.co.uk>	<53D17845.4020507@wwwdotorg.org>	<53D26572.3030404@itdev.co.uk>	<53D2B8D0.5090000@wwwdotorg.org>	<CAPDwgkNrBRJRR6WtoPSfs8Yq=ui-Ptjju4mJ=9h=95YVFuxw7g@mail.gmail.com>	<53D6BF50.3070306@wwwdotorg.org>	<53D6DFE7.3040901@wwwdotorg.org> <CAPDwgkPL1utj3DFoFbOCcJsASpf+12nvKg1KcseV_MhEz66eiw@mail.gmail.com> <53D7C8CC.1050201@wwwdotorg.org> <53D7D47E.5060906@itdev.co.uk> <53D7F561.1000603@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53D7F561.1000603@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Yufeng Shen <miletus@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Alan Bowens <Alan.Bowens@atmel.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Olof Johansson <olofj@chromium.org>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-input@vger.kernel.org

On 07/29/2014 01:26 PM, Stephen Warren wrote:
> On 07/29/2014 11:06 AM, Nick Dyer wrote:
>> On 29/07/14 17:16, Stephen Warren wrote:
...
>>> I also found that removing the module (even without attempting a FW
>>> update) yields:
>>>
>>> After attempted FW update via sysfs:
>>>
>>>> root@localhost:~# rmmod ./atmel_mxt_ts.ko
>>>> [   81.995672] Unable to handle kernel NULL pointer dereference at
>>>> virtual address 00000364
>>
>> Not good. It's trying to free an input device which isn't registered at
>> that point. In a later patch in my series I add a guard around that
>> (mxt_free_input_device):
>> https://github.com/ndyer/linux/commit/bb4800ff8c185
>
> It looks like 8d01a84b86b0 "Input: atmel_mxt_ts - implement T100 touch
> object support" from that branch is what solves the issue.
>
> Ah, in linux-next, it's simply a double-unregister; both mxt_remove()
> and mxt_free_object_table() call
> input_unregister_device(data->input_dev). I think it would make sense to
> send the following patch for 3.17. Do you agree?

Nick, I see the fix below isn't in linux-next as of next-20140829. IIRC, 
you'd sent the patch below but there had been some comments on it by 
Dmitry. Unfortunately, I don't recall the patch subject to search for 
it. Anyway, are you planning on re-spinning the patch so it can be applied?

> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c
> b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 03b85711cb70..da497dbf9735 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1353,8 +1353,10 @@ static int mxt_get_info(struct mxt_data *data)
>
>   static void mxt_free_object_table(struct mxt_data *data)
>   {
> -    input_unregister_device(data->input_dev);
> -    data->input_dev = NULL;
> +    if (data->input_dev) {
> +        input_unregister_device(data->input_dev);
> +        data->input_dev = NULL;
> +    }
>
>       kfree(data->object_table);
>       data->object_table = NULL;
> @@ -2194,7 +2196,6 @@ static int mxt_remove(struct i2c_client *client)
>
>       sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
>       free_irq(data->irq, data);
> -    input_unregister_device(data->input_dev);
>       mxt_free_object_table(data);
>       kfree(data);
