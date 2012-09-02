From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 16/20] HID: Only dump input if someone is listening
Date: Sun, 2 Sep 2012 09:28:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209020927130.20709@pobox.suse.cz>
References: <1346528835-363-1-git-send-email-rydberg@euromail.se> <1346528835-363-17-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755154Ab2IBH2j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 2 Sep 2012 03:28:39 -0400
In-Reply-To: <1346528835-363-17-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 1 Sep 2012, Henrik Rydberg wrote:

> Going through the motions of printing the debug message information
> takes a long time; using the keyboard can lead to a 160 us irqsoff
> latency. This patch skips hid_dump_input() when there are no open
> handles, which brings latency down to 100 us.
> 
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/hid/hid-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 60ea284..5b74e78 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -996,7 +996,8 @@ static void hid_process_event(struct hid_device *hid, struct hid_field *field,
>  	struct hid_driver *hdrv = hid->driver;
>  	int ret;
>  
> -	hid_dump_input(hid, usage, value);
> +	if (!list_empty(&hid->debug_list))
> +		hid_dump_input(hid, usage, value);
>  
>  	if (hdrv && hdrv->event && hid_match_usage(hid, usage)) {
>  		ret = hdrv->event(hid, field, usage, value);

Henrik,

I have applied this one right away, so you can drop it from your series. 
The remaining ones I am still about to review (currently travelling).

There is no inter-dependency between the Input and HID ones, and so we can 
handle them with Dmitry as two independent Input and HID series, right?

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
