From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: holtekff: use %*ph to dump small buffers
Date: Mon, 10 Sep 2012 23:01:36 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209102301310.22683@pobox.suse.cz>
References: <1346846443-27263-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43958 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2IJVBp (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Sep 2012 17:01:45 -0400
In-Reply-To: <1346846443-27263-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org

On Wed, 5 Sep 2012, Andy Shevchenko wrote:

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hid/hid-holtekff.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
> index 4e75421..ff295e6 100644
> --- a/drivers/hid/hid-holtekff.c
> +++ b/drivers/hid/hid-holtekff.c
> @@ -100,8 +100,7 @@ static void holtekff_send(struct holtekff_device *holtekff,
>  		holtekff->field->value[i] = data[i];
>  	}
>  
> -	dbg_hid("sending %02x %02x %02x %02x %02x %02x %02x\n", data[0],
> -		data[1], data[2], data[3], data[4], data[5], data[6]);
> +	dbg_hid("sending %*ph\n", 7, data);
>  
>  	usbhid_submit_report(hid, holtekff->field->report, USB_DIR_OUT);
>  }

Applied.

-- 
Jiri Kosina
SUSE Labs
