From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input/xen-kbdfront: Enable auto repeat for xen
 keyboard frontend driver
Date: Mon, 28 Aug 2017 09:42:26 -0700
Message-ID: <20170828164226.GC12195@dtor-ws>
References: <20170824135414.4870-1-lyan@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37317 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbdH1Qm3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Aug 2017 12:42:29 -0400
Content-Disposition: inline
In-Reply-To: <20170824135414.4870-1-lyan@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Liang Yan <lyan@suse.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 24, 2017 at 09:54:14AM -0400, Liang Yan wrote:
> Long pressed key could not show right in XEN vncviewer after tigervnc
> client changed the way how to send repeat keys, from "Down Up Down Up
> ..." to "Down Down ... Up". This will report autorepeat to input by
> checking if same key being pressed, and let handler process it finally.
> 
> Signed-off-by: Liang Yan <lyan@suse.com>
> ---
> v2:
> - Sending autorepeat event rather than enable EV_REP bit 

Applied, thank you.

> 
> drivers/input/misc/xen-kbdfront.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index fa130e7b734c..6bf56bb5f8d9 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -84,17 +84,20 @@ static void xenkbd_handle_key_event(struct xenkbd_info *info,
>  				    struct xenkbd_key *key)
>  {
>  	struct input_dev *dev;
> +	int value = key->pressed;
>  
>  	if (test_bit(key->keycode, info->ptr->keybit)) {
>  		dev = info->ptr;
>  	} else if (test_bit(key->keycode, info->kbd->keybit)) {
>  		dev = info->kbd;
> +		if (key->pressed && test_bit(key->keycode, info->kbd->key))
> +			value = 2; /* Mark as autorepeat */
>  	} else {
>  		pr_warn("unhandled keycode 0x%x\n", key->keycode);
>  		return;
>  	}
>  
> -	input_report_key(dev, key->keycode, key->pressed);
> +	input_event(dev, EV_KEY, key->keycode, value);
>  	input_sync(dev);
>  }
>  
> -- 
> 2.14.1
> 

-- 
Dmitry
