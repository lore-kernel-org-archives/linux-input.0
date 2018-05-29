From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Date: Tue, 29 May 2018 11:05:06 -0700
Message-ID: <20180529180506.GB167092@dtor-ws>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: KT Liao <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

Hi KT,

On Mon, May 28, 2018 at 07:33:02PM +0800, KT Liao wrote:
> Some touchpad has middle key and it will be indicated in bit 2 of packet[0].
> We need to fix V4 formation's byte mask to prevent error decoding.

Could you please let me know what devices this patch fixes? Are they
released or new hardware?

> 
> Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index fb4d902..f39dc66 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -799,7 +799,7 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
>  	else if (ic_version == 7 && etd->info.samples[1] == 0x2A)
>  		sanity_check = ((packet[3] & 0x1c) == 0x10);
>  	else
> -		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> +		sanity_check = ((packet[0] & 0x08) == 0x00 &&
>  				(packet[3] & 0x1c) == 0x10);
>  
>  	if (!sanity_check)
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
