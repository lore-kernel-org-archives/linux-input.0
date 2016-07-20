From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] input: tablet: pegasus_notetaker: Cancel workqueue's
 work in suspend()
Date: Wed, 20 Jul 2016 14:30:13 -0700
Message-ID: <20160720213013.GB26006@dtor-ws>
References: <1468852149-2614-1-git-send-email-martink@posteo.de>
 <1468852149-2614-4-git-send-email-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34584 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbcGTVaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 17:30:17 -0400
Content-Disposition: inline
In-Reply-To: <1468852149-2614-4-git-send-email-martink@posteo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Mon, Jul 18, 2016 at 04:29:08PM +0200, Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martink@posteo.de>

Applied, thank you.

> ---
>  drivers/input/tablet/pegasus_notetaker.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index fdbc5e8..07436c6 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -377,6 +377,7 @@ static int pegasus_suspend(struct usb_interface *intf, pm_message_t message)
>  
>  	mutex_lock(&pegasus->dev->mutex);
>  	usb_kill_urb(pegasus->irq);
> +	cancel_work_sync(&pegasus->init);
>  	mutex_unlock(&pegasus->dev->mutex);

-- 
Dmitry
