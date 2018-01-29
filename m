From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/8] Input: mms114 - remove unused variable
Date: Mon, 29 Jan 2018 10:43:09 -0800
Message-ID: <20180129184309.ljnw63owyuhofqko@dtor-ws>
References: <20180129113323.18961-1-andi.shyti@samsung.com>
 <CGME20180129113331epcas2p3bb7bc89558e7219ef257b36fa47dc076@epcas2p3.samsung.com>
 <20180129113323.18961-5-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180129113323.18961-5-andi.shyti@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>
Cc: Simon Shields <simon@lineageos.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Shyti <andi@etezian.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 29, 2018 at 08:33:19PM +0900, Andi Shyti wrote:
> '__packed' is not used anywhere, remove it.

Umm, this is not a variable, this is type annotation meaning that the
structure is packed. Still not needed, as we are not using anything but
u8 data elements, but justification is completely wrong.

> 
> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
> ---
>  drivers/input/touchscreen/mms114.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index fb4435ae506b..11dba8bb48e3 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -78,7 +78,7 @@ struct mms114_touch {
>  	u8 width;
>  	u8 strength;
>  	u8 reserved[2];
> -} __packed;
> +};
>  
>  static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *touch)
>  {
> -- 
> 2.15.1
> 

-- 
Dmitry
