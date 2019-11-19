Return-Path: <SRS0=+AoC=ZL=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71063C432C0
	for <linux-input@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497D120679
	for <linux-input@archiver.kernel.org>; Tue, 19 Nov 2019 11:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfKSLi2 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:38:28 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38383 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfKSLi2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 19 Nov 2019 06:38:28 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1iX1px-0000Yw-8u; Tue, 19 Nov 2019 12:38:25 +0100
Message-ID: <3f4c87125e5021622fe80cc85411c5b1d25bc427.camel@pengutronix.de>
Subject: Re: [PATCH 4/5] input/rmi4/rmi_driver: check if irq_find_mapping
 returns 0
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Cc:     linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nick Dyer <nick@shmanahar.org>,
        Christopher Heiny <cheiny@synaptics.com>,
        Vandana BN <bnvandana@gmail.com>
Date:   Tue, 19 Nov 2019 12:38:24 +0100
In-Reply-To: <20191119105118.54285-5-hverkuil-cisco@xs4all.nl>
References: <20191119105118.54285-1-hverkuil-cisco@xs4all.nl>
         <20191119105118.54285-5-hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-input@vger.kernel.org
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi Hans,

On Di, 2019-11-19 at 11:51 +0100, Hans Verkuil wrote:
> The irq_find_mapping() function can return 0 when called in the
> rmi_process_interrupt_requests() function.
> 
> This causes a kernel crash. Check for a 0 value and skip calling
> handle_nested_irq() in that case.
> 
> This was tested with the F54 function enabled on a Lenovo X1 Carbon.
> 
> Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")

This is already fixed upstream by 549766ac2ac1
"Input: synaptics-rmi4 - clear IRQ enables for F54"

Regards,
Lucas

> ---
>  drivers/input/rmi4/rmi_driver.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 772493b1f665..6085ec424a84 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -154,8 +154,12 @@ static int rmi_process_interrupt_requests(struct rmi_device *rmi_dev)
>  	 */
>  	mutex_unlock(&data->irq_mutex);
>  
> -	for_each_set_bit(i, data->irq_status, data->irq_count)
> -		handle_nested_irq(irq_find_mapping(data->irqdomain, i));
> +	for_each_set_bit(i, data->irq_status, data->irq_count) {
> +		unsigned int irq = irq_find_mapping(data->irqdomain, i);
> +
> +		if (irq)
> +			handle_nested_irq(irq);
> +	}
>  
>  	if (data->input)
>  		input_sync(data->input);

