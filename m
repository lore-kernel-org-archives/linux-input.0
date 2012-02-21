From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid-magicmouse: Add pointer and buttonpad properties
 for Magic Trackpad
Date: Tue, 21 Feb 2012 11:52:40 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202211152220.31150@pobox.suse.cz>
References: <1329192751-6041-1-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50589 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701Ab2BUKwm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 05:52:42 -0500
In-Reply-To: <1329192751-6041-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org

On Mon, 13 Feb 2012, Chase Douglas wrote:

> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
>  drivers/hid/hid-magicmouse.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 2ab7175..7cf3ffe 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -418,6 +418,8 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>  		__set_bit(BTN_TOOL_TRIPLETAP, input->keybit);
>  		__set_bit(BTN_TOOL_QUADTAP, input->keybit);
>  		__set_bit(BTN_TOUCH, input->keybit);
> +		__set_bit(INPUT_PROP_POINTER, input->propbit);
> +		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
>  	}
>  
>  	if (report_touches) {

Applied, although a bit more verbose commit message would be welcome next 
time :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
