From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-holtekff: don't push static constants on stack for
 %*ph
Date: Mon, 5 Aug 2013 11:30:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308051130120.17512@pobox.suse.cz>
References: <1375441680-13593-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45595 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab3HEJaW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 5 Aug 2013 05:30:22 -0400
In-Reply-To: <1375441680-13593-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Fri, 2 Aug 2013, Andy Shevchenko wrote:

> There is no need to pass constants via stack. The width may be explicitly
> specified in the format.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/hid-holtekff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
> index 9a8f051..9325545 100644
> --- a/drivers/hid/hid-holtekff.c
> +++ b/drivers/hid/hid-holtekff.c
> @@ -98,7 +98,7 @@ static void holtekff_send(struct holtekff_device *holtekff,
>  		holtekff->field->value[i] = data[i];
>  	}
>  
> -	dbg_hid("sending %*ph\n", 7, data);
> +	dbg_hid("sending %7ph\n", data);
>  
>  	hid_hw_request(hid, holtekff->field->report, HID_REQ_SET_REPORT);

Applied, thanks Andy.

-- 
Jiri Kosina
SUSE Labs
