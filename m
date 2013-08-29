From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] Input: add SYN_MAX and SYN_CNT constants
Date: Thu, 29 Aug 2013 11:06:27 +1000
Message-ID: <20130829010627.GA1354@yabbi.redhat.com>
References: <1377602632-23259-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:37725 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab3H2Bhq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Aug 2013 21:37:46 -0400
Content-Disposition: inline
In-Reply-To: <1377602632-23259-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Aug 27, 2013 at 01:23:52PM +0200, David Herrmann wrote:
> SYN_* events are special and not enabled via set_bit() for devices. Hence,
> they haven't been really needed, yet. However, user-space can still make
> great use of that for int->string debugging helpers or alike.
> 
> Also, I haven't seen any reason not to define these, so here they are.
> 
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> ---
>  include/uapi/linux/input.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
> index 4649ee3..2fb6fae 100644
> --- a/include/uapi/linux/input.h
> +++ b/include/uapi/linux/input.h
> @@ -194,6 +194,8 @@ struct input_keymap_entry {
>  #define SYN_CONFIG		1
>  #define SYN_MT_REPORT		2
>  #define SYN_DROPPED		3
> +#define SYN_MAX			0xf
> +#define SYN_CNT			(SYN_MAX+1)
>  
>  /*
>   * Keys and buttons
> -- 
> 1.8.4

yes please!

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

