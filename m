From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: sony: Fix uninitialized spinlocks
Date: Mon, 23 Feb 2015 13:03:17 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502231302490.19920@pobox.suse.cz>
References: <1424655766-2102-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46664 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbbBWMDS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 07:03:18 -0500
In-Reply-To: <1424655766-2102-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, pavel@ucw.cz

On Sun, 22 Feb 2015, Frank Praznik wrote:

> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
> ---
>  drivers/hid/hid-sony.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 9e0987d..27f67e7 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -805,7 +805,7 @@ union sixaxis_output_report_01 {
>  #define SIXAXIS_REPORT_0xF2_SIZE 17
>  #define SIXAXIS_REPORT_0xF5_SIZE 8
>  
> -static spinlock_t sony_dev_list_lock;
> +static DEFINE_SPINLOCK(sony_dev_list_lock);
>  static LIST_HEAD(sony_device_list);
>  static DEFINE_IDA(sony_device_id_allocator);

This hunk was already in my tree from earlier today.

>  
> @@ -1965,6 +1965,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		return -ENOMEM;
>  	}
>  
> +	spin_lock_init(&sc->lock);
> +
>  	sc->quirks = quirks;
>  	hid_set_drvdata(hdev, sc);
>  	sc->hdev = hdev;

I have applied this one from your patch. I have also added a bit of 
changelog.

Thanks,

-- 
Jiri Kosina
SUSE Labs
