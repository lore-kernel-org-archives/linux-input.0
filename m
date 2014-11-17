From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: print the correct data in dbg msg
Date: Mon, 17 Nov 2014 16:32:23 -0500
Message-ID: <20141117213223.GB30324@mail.corp.redhat.com>
References: <1416149143-25703-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45412 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752484AbaKQVce (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Nov 2014 16:32:34 -0500
Content-Disposition: inline
In-Reply-To: <1416149143-25703-1-git-send-email-borneo.antonio@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

On Nov 16 2014 or thereabouts, Antonio Borneo wrote:
> From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> 
> From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> 
> Report is received in "buffer"; fix the following i2c_hid_dbg()
> to dump data from the correct pointer.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> [Antonio Borneo: cleanup and rebase to v3.17]
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
> ---

Good catch.

This one is Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/i2c-hid/i2c-hid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 747d544..933bf10 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -437,7 +437,7 @@ static void i2c_hid_init_report(struct hid_report *report, u8 *buffer,
>  			report->id, buffer, size))
>  		return;
>  
> -	i2c_hid_dbg(ihid, "report (len=%d): %*ph\n", size, size, ihid->inbuf);
> +	i2c_hid_dbg(ihid, "report (len=%d): %*ph\n", size, size, buffer);
>  
>  	ret_size = buffer[0] | (buffer[1] << 8);
>  
> -- 
> 2.1.3
> 
