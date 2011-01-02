From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID, hid-picolcd: Fix memory leak in
 picolcd_debug_out_report()
Date: Mon, 3 Jan 2011 00:12:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101030012060.26685@pobox.suse.cz>
References: <alpine.LNX.2.00.1101022212030.11481@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1101022212030.11481@swampdragon.chaosbits.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, "Rick L. Vinyard, Jr." <rvinyard@cs.nmsu.edu>
List-Id: linux-input@vger.kernel.org

On Sun, 2 Jan 2011, Jesper Juhl wrote:

> We have a memory leak in 
> drivers/hid/hid-picolcd.c::picolcd_debug_out_report() in an error path..
> We are not always freeing the memory allocated to 'buff' - this patch 
> makes sure we always kfree() what we allocate with kmalloc() when it is 
> no longer needed.
> 
> 
> Signed-off-by: Jesper Juhl <jj@chaosbits.net>
> ---
>  hid-picolcd.c |    1 +
>  1 file changed, 1 insertion(+)
> 
>   compile tested only.
> 
> diff --git a/drivers/hid/hid-picolcd.c b/drivers/hid/hid-picolcd.c
> index bc2e077..ad6539a 100644
> --- a/drivers/hid/hid-picolcd.c
> +++ b/drivers/hid/hid-picolcd.c
> @@ -1867,6 +1867,7 @@ static void picolcd_debug_out_report(struct picolcd_data *data,
>  			report->id, raw_size);
>  	hid_debug_event(hdev, buff);
>  	if (raw_size + 5 > sizeof(raw_data)) {
> +		kfree(buff);
>  		hid_debug_event(hdev, " TOO BIG\n");
>  		return;
>  	} else {
> 

Good catch, applied, thanks Jesper.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
