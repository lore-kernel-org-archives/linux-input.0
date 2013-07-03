From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [patch 2/3] Input: cyttsp4 - silence NULL dereference warning
Date: Wed, 3 Jul 2013 15:33:19 +0300
Message-ID: <51D41A0F.80008@cypress.com>
References: <20130702214107.GB1598@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay-s04-hub004.domainlocalhost.com ([74.115.207.103]:22563
	"EHLO relay-S04-HUB004.domainlocalhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755924Ab3GCMd1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jul 2013 08:33:27 -0400
In-Reply-To: <20130702214107.GB1598@elgon.mountain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

On 07/03/2013 12:41 AM, Dan Carpenter wrote:
> If "cd" were NULL then we would dereference it when we print the error
> message.  Fortunately enough, it can't ever be NULL so we can remove
> those lines.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
> index 7aa4a34..851e3ff 100644
> --- a/drivers/input/touchscreen/cyttsp4_core.c
> +++ b/drivers/input/touchscreen/cyttsp4_core.c
> @@ -1450,11 +1450,6 @@ static void cyttsp4_watchdog_work(struct work_struct *work)
>       u8 *mode;
>       int retval;
>
> -     if (cd == NULL) {
> -             dev_err(cd->dev, "%s: NULL context pointer\n", __func__);
> -             return;
> -     }
> -
>       mutex_lock(&cd->system_lock);
>       retval = cyttsp4_load_status_regs(cd);
>       if (retval < 0) {
You are right, cd dereference is wrong in error message.
And agree on removing block, cd will not be NULL in this context.

--

Thanks,
ferruh

This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
