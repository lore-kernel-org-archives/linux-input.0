From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID: Allow changing not-yet-mapped usages
Date: Wed, 15 Sep 2010 16:48:42 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1009151645360.26813@pobox.suse.cz>
References: <20100915045822.GA21672@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:54849 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015Ab0IOOso (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Sep 2010 10:48:44 -0400
In-Reply-To: <20100915045822.GA21672@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, jonno.conder+bugs@gmail.com

On Tue, 14 Sep 2010, Dmitry Torokhov wrote:

> Jiri,
> 
> Currently HID only allows re-mapping of usages that have already been
> mapped by hid-input or one of the sub-drivers as keys. This,
> unfortunately, leads to sub-drivers multiplying by the hour and many
> of them only do initial setup of usages and waste memory once that is
> done.
> 
> How about we also allow EVIOCSKEYCODE to establish mapping for
> not-yet-unmapped usages (usage->type == 0)? Then we could offload the
> task of setting up keymaps to udev.
> 
> This depends on the large keycode handling patches that are in my tree
> in 'next' branch. Not tested past booting...

Hi Dmitry,

fully agreed. I would love to shovel all the special drivers which only 
establish mappings down to userspace.

> 
> -- 
> Dmitry
> 
> Input: hid-input - allow mapping unknown usages
> 
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> Currently HID layer only allows to remap keycodes for known usages,
> and responds with -EINVAL when user tries to map new usage code.
> This precludes us form relying on udev/keymap for establishing correct
> mappings and forces us to write dummy HID drivers responsible only for
> setting up keymaps.
> 
> Let's allow remapping not only usages that have been set up as keys
> (usage->type == EV_KEY) but also yet-unmapped usages (usage->type == 0).
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> 
>  drivers/hid/hid-input.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index b12c07e..8dd17ce 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -77,7 +77,10 @@ static bool match_scancode(struct hid_usage *usage,
>  static bool match_keycode(struct hid_usage *usage,
>  			  unsigned int cur_idx, unsigned int keycode)
>  {
> -	return usage->code == keycode;
> +	/*
> +	 * We should exclude unmapped usages when doing lookup by keycode.
> +	 */
> +	return usage->type == EV_KEY && usage->code == keycode;

This is for some reason hurting my eyes. It'd seem much more readable to 
me if the condition would be enclosed in brackets, purely for sake for 
readability. What do you think?

>  }
>  
>  static bool match_index(struct hid_usage *usage,
> @@ -103,7 +106,7 @@ static struct hid_usage *hidinput_find_key(struct hid_device *hid,
>  			for (i = 0; i < report->maxfield; i++) {
>  				for (j = 0; j < report->field[i]->maxusage; j++) {
>  					usage = report->field[i]->usage + j;
> -					if (usage->type == EV_KEY) {
> +					if (usage->type == EV_KEY || usage->type == 0) {
>  						if (match(usage, cur_idx, value)) {
>  							if (usage_idx)
>  								*usage_idx = cur_idx;
> @@ -144,7 +147,8 @@ static int hidinput_getkeycode(struct input_dev *dev,
>  
>  	usage = hidinput_locate_usage(hid, ke, &index);
>  	if (usage) {
> -		ke->keycode = usage->code;
> +		ke->keycode = usage->type == EV_KEY ?
> +				usage->code : KEY_RESERVED;
>  		ke->index = index;
>  		scancode = usage->hid & (HID_USAGE_PAGE | HID_USAGE);
>  		ke->len = sizeof(scancode);
> @@ -164,7 +168,8 @@ static int hidinput_setkeycode(struct input_dev *dev,
>  
>  	usage = hidinput_locate_usage(hid, ke, NULL);
>  	if (usage) {
> -		*old_keycode = usage->code;
> +		*old_keycode = usage->type == EV_KEY ?
> +				usage->code : KEY_RESERVED;
>  		usage->code = ke->keycode;
>  
>  		clear_bit(*old_keycode, dev->keybit);

I guess you will be taking it through your tree together with all your 
keycode handling patches, right?

Thanks!

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
