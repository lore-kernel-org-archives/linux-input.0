From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 1/1] Input: mms114: Use devm_* APIs
Date: Tue, 8 Jan 2013 16:38:19 +0530
Message-ID: <50EBFE23.7070401@nvidia.com>
References: <1357639508-15645-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:10910 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754918Ab3AHLIl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 06:08:41 -0500
In-Reply-To: <1357639508-15645-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "patche@linaro.org" <patche@linaro.org>, Joonyoung Shim <jy0922.shim@samsung.com>

On Tuesday 08 January 2013 03:35 PM, Sachin Kamat wrote:
> devm_* APIs are device managed and make the exit and clean up code
> simpler.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> ---
> Compile tested against linux-next tree (20130108).
> ---
>   drivers/input/touchscreen/mms114.c |   41 +++++++++++------------------------
>   1 files changed, 13 insertions(+), 28 deletions(-)

>   static int mms114_remove(struct i2c_client *client)
>   {
>   	struct mms114_data *data = i2c_get_clientdata(client);
>   
> -	free_irq(client->irq, data);
> -	regulator_put(data->io_reg);
> -	regulator_put(data->core_reg);
>   	input_unregister_device(data->input_dev);

Because you are using devm_input_allocate_device() for allocating input 
device, you need not to have the input_unregister_device() and so you 
can get rid of remove() callback at all.
This is what I learnt from Dmitry on similar patch for Tegra KBC.

Thanks,
Laxman

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
