From: Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] Input: adp5588-keys: cancel workqueue in failure path
Date: Tue, 7 Oct 2014 14:42:40 +0200
Message-ID: <5433DFC0.705@analog.com>
References: <1412667049-6128-1-git-send-email-pramod.gurav@smartplayin.com>
Reply-To: <michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1on0077.outbound.protection.outlook.com ([157.56.110.77]:62818
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752368AbaJGOaa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Oct 2014 10:30:30 -0400
In-Reply-To: <1412667049-6128-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On 10/07/2014 09:30 AM, Pramod Gurav wrote:
> This change introduces a label to call cancel_delayed_work_sync in
> failure path.
>
> Cc: Michael Hennerich <michael.hennerich@analog.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

The interrupt triggers the work queue. adp5588_setup() enable the HW 
interrupt.
Only if the device was configured before, without being resetb -
The earliest point in time where a problem could happen - is after the 
request_irq().

Anyways patch below doesn't harm and fixes a potential problem.

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>   drivers/input/keyboard/adp5588-keys.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
> index 5ef7fcf..b494062 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -559,7 +559,7 @@ static int adp5588_probe(struct i2c_client *client,
>   	error = input_register_device(input);
>   	if (error) {
>   		dev_err(&client->dev, "unable to register input device\n");
> -		goto err_free_mem;
> +		goto err_delayed_work;
>   	}
>   
>   	error = request_irq(client->irq, adp5588_irq,
> @@ -592,6 +592,8 @@ static int adp5588_probe(struct i2c_client *client,
>    err_unreg_dev:
>   	input_unregister_device(input);
>   	input = NULL;
> + err_delayed_work:
> +	cancel_delayed_work_sync(&kpad->work);
>    err_free_mem:
>   	input_free_device(input);
>   	kfree(kpad);


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif

