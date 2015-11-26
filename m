From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 02/26] Input: synaptics-rmi4 - add a common input device
 in rmi_driver
Date: Wed, 25 Nov 2015 16:13:06 -0800
Message-ID: <56564E92.8040604@synaptics.com>
References: <1446766616-30258-1-git-send-email-aduggan@synaptics.com>
 <20151109231351.GD9155@dtor-ws>
 <CAN+gG=Guce5kQ+vkipmRRR9VWx_eZR=NmZPigWRs9xoehBjAGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:55738 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752204AbbKZANH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 19:13:07 -0500
In-Reply-To: <CAN+gG=Guce5kQ+vkipmRRR9VWx_eZR=NmZPigWRs9xoehBjAGg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>

On 11/10/2015 01:23 AM, Benjamin Tissoires wrote:
> On Tue, Nov 10, 2015 at 12:13 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
> index ee5f4a1..2d72dc8 100644
> --- a/drivers/input/rmi4/rmi_f01.c
> +++ b/drivers/input/rmi4/rmi_f01.c
> @@ -176,6 +176,13 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
>        return 0;
>   }
>
> +char *rmi_f01_get_product_ID(struct rmi_function *fn)
> +{
> +     struct f01_data *f01 = dev_get_drvdata(&fn->dev);
> +
> +     return f01->properties.product_id;
> +}
>> Should we have something like rmi_to_input_id() that is similar to
>> usb_to_input_id()?
> Works for me.
>

In the patch set I just submitted I did not implement a 
rmi_to_input_id() function mostly because the product id in RMI is a 
string with a few possible formats. There isn't really a good way to 
convert it into a u16 which is what struct input_id is expecting. We 
would still need a function to return the string so I just left it the 
way it is.

Andrew
