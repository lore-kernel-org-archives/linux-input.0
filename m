From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] Input: adp5520-keys: Delete an error message for a failed
 memory allocation in adp5520_keys_probe()
Date: Thu, 1 Feb 2018 17:27:25 +0100
Message-ID: <4e9d8aa4-3e01-4fb3-d0b5-42b02522a15e@analog.com>
References: <9d0729d2-59ab-f116-aa12-0457ebde0041@users.sourceforge.net>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9d0729d2-59ab-f116-aa12-0457ebde0041@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 27.01.2018 15:20, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 27 Jan 2018 15:15:52 +0100
> 
> Omit an extra message for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/input/keyboard/adp5520-keys.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/adp5520-keys.c b/drivers/input/keyboard/adp5520-keys.c
> index f0b9b37bde58..72e01cb77881 100644
> --- a/drivers/input/keyboard/adp5520-keys.c
> +++ b/drivers/input/keyboard/adp5520-keys.c
> @@ -91,10 +91,8 @@ static int adp5520_keys_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   
>   	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> -	if (!dev) {
> -		dev_err(&pdev->dev, "failed to alloc memory\n");
> +	if (!dev)
>   		return -ENOMEM;
> -	}
>   
>   	input = devm_input_allocate_device(&pdev->dev);
>   	if (!input)
> 
