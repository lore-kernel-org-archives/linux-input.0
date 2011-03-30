From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] Remove debug_hid module parameter and replace debug
 statements with pr_debug()
Date: Wed, 30 Mar 2011 16:56:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103301654560.26754@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:34886 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932599Ab1C3O4u (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2011 10:56:50 -0400
In-Reply-To: <1301445026-16442-2-git-send-email-root@yunbtp.(none
References: <1301445026-16442-1-git-send-email-root@yunbtp.(none <1301445026-16442-2-git-send-email-root@yunbtp.(none
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Becka <yuen@klacno.sk>
Cc: linux-input@vger.kernel.org

On Wed, 30 Mar 2011, root wrote:

> From: Marek Becka <yuen@klacno.sk>

Some explanation (changelog) would be good to have.

Also, your message has been sent with 'From: root <root@yunbtp.suse.de>', 
which looks rather strange.

> diff --git a/drivers/hid/hid-axff.c b/drivers/hid/hid-axff.c
> index b455428..c0a4bf6 100644
> --- a/drivers/hid/hid-axff.c
> +++ b/drivers/hid/hid-axff.c
> @@ -50,7 +50,7 @@ static int axff_play(struct input_dev *dev, void *data, struct ff_effect *effect
>  	left = effect->u.rumble.strong_magnitude;
>  	right = effect->u.rumble.weak_magnitude;
>  
> -	dbg_hid("called with 0x%04x 0x%04x", left, right);
> +	HID_DBG("called with 0x%04x 0x%04x", left, right);

[ ... snip ... ]

> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index bb29bb1..eaad657 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -686,8 +686,6 @@ struct hid_ll_driver {
>  
>  /* HID core API */
>  
> -extern int hid_debug;
> -
>  extern int hid_add_device(struct hid_device *);
>  extern void hid_destroy_device(struct hid_device *);
>  
> @@ -888,11 +886,8 @@ int hid_pidff_init(struct hid_device *hid);
>  #define hid_pidff_init NULL
>  #endif
>  
> -#define dbg_hid(format, arg...)						\
> -do {									\
> -	if (hid_debug)							\
> -		printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);	\
> -} while (0)
> +#define HID_DBG(fmt, arg...)				\
> +       pr_debug("%s: " fmt "\n" , __func__ , ##arg)
>  

1) why changing the name from dbg_hid to HID_DBG all over the place?
2) why removing the 'if (hid_debug)' condition?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
