From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: wacom: fix proximity tool release
Date: Tue, 21 Feb 2012 14:25:59 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202211423300.31150@pobox.suse.cz>
References: <1329682829-24347-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35465 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab2BUN0B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 08:26:01 -0500
In-Reply-To: <1329682829-24347-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: aris@redhat.com, pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 19 Feb 2012, Przemo Firszt wrote:

> Don't zero the current tool before reporting its release to the input
> subsystem.
> 
> Signed-off-by: Aristeu Rozanski <aris@redhat.com>
> Tested-by: Przemo Firszt <przemo@firszt.eu>
> ---
>  drivers/hid/hid-wacom.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 0621047..696b907 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -322,10 +322,10 @@ static void wacom_i4_parse_pen_report(struct wacom_data *wdata,
>  
>  	switch (data[1]) {
>  	case 0x80: /* Out of proximity report */
> -		wdata->tool = 0;
>  		input_report_key(input, BTN_TOUCH, 0);
>  		input_report_abs(input, ABS_PRESSURE, 0);
>  		input_report_key(input, wdata->tool, 0);
> +		wdata->tool = 0;
>  		input_sync(input);
>  		break;
>  	case 0xC2: /* Tool report */

I have put this into my upstream-fixes branch. I think this should go into 
3.3 still.

Thanks,

-- 
Jiri Kosina
SUSE Labs
