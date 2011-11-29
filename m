From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] HID: bump maximum global item tag report size to 96 bytes
Date: Tue, 29 Nov 2011 10:17:13 +0100
Message-ID: <20111129091713.GA2484@polaris.bitmath.org>
References: <1320692885-25733-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:53271 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab1K2JRR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 04:17:17 -0500
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 5AC12CE9F
	for <linux-input@vger.kernel.org>; Tue, 29 Nov 2011 10:17:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320692885-25733-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Mon, Nov 07, 2011 at 11:08:05AM -0800, Chase Douglas wrote:
> This allows the latest N-Trig devices to function properly.
> 
> BugLink: https://bugs.launchpad.net/bugs/724831
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
> I have no clue if this is according to spec or not. I only know that this
> change makes two users' N-Trig devices work properly in the above bug.
> 
>  drivers/hid/hid-core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 848a56c..6113996 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -362,7 +362,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
>  
>  	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
>  		parser->global.report_size = item_udata(item);
> -		if (parser->global.report_size > 32) {
> +		if (parser->global.report_size > 96) {
>  			dbg_hid("invalid report_size %d\n",
>  					parser->global.report_size);
>  			return -1;
> -- 
> 1.7.5.4

I remember writing this patch as a test, but I never checked the side
effects. Jiri, perhaps you can enlighten us all on this matter?

Thanks,
Henrik

