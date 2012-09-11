From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: picolcd: Fix build error due to redefinition of
 'picolcd_debug_raw_event'
Date: Tue, 11 Sep 2012 16:08:01 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209111607060.22683@pobox.suse.cz>
References: <1347366593.7690.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52627 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790Ab2IKOIJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Sep 2012 10:08:09 -0400
In-Reply-To: <1347366593.7690.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

On Tue, 11 Sep 2012, Axel Lin wrote:

> Current code missed the definition for picolcd_debug_raw_event, but add

This should be picolcd_debug_out_report().

> definition for picolcd_debug_raw_event twice.
> 
> This patch fixes below build error:
>   CC [M]  drivers/hid/hid-picolcd_core.o
> In file included from drivers/hid/hid-picolcd_core.c:34:0:
> drivers/hid/hid-picolcd.h:176:20: error: redefinition of 'picolcd_debug_raw_event'
> drivers/hid/hid-picolcd.h:162:20: note: previous definition of 'picolcd_debug_raw_event' was here
> make[2]: *** [drivers/hid/hid-picolcd_core.o] Error 1
> make[1]: *** [drivers/hid] Error 2
> make: *** [drivers] Error 2

I have fixed the changelog, added the information that this affects 
!CONFIG_DEBUG_FS case, and applied, thanks Alex.

> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/hid/hid-picolcd.h |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hid/hid-picolcd.h b/drivers/hid/hid-picolcd.h
> index 240eb1c..020cef6 100644
> --- a/drivers/hid/hid-picolcd.h
> +++ b/drivers/hid/hid-picolcd.h
> @@ -159,6 +159,10 @@ void picolcd_init_devfs(struct picolcd_data *data,
>  
>  void picolcd_exit_devfs(struct picolcd_data *data);
>  #else
> +static inline void picolcd_debug_out_report(struct picolcd_data *data,
> +		struct hid_device *hdev, struct hid_report *report)
> +{
> +}
>  static inline void picolcd_debug_raw_event(struct picolcd_data *data,
>  		struct hid_device *hdev, struct hid_report *report,
>  		u8 *raw_data, int size)
> @@ -173,11 +177,6 @@ static inline void picolcd_init_devfs(struct picolcd_data *data,
>  static inline void picolcd_exit_devfs(struct picolcd_data *data)
>  {
>  }
> -static inline void picolcd_debug_raw_event(struct picolcd_data *data,
> -		struct hid_device *hdev, struct hid_report *report,
> -		u8 *raw_data, int size)
> -{
> -}
>  #endif /* CONFIG_DEBUG_FS */
>  
>  
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Jiri Kosina
SUSE Labs
