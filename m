From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] MODULE_DEVICE_TABLE: fix gscps2
Date: Wed, 4 Feb 2015 11:00:18 -0800
Message-ID: <20150204190018.GA7818@dtor-ws>
References: <1423062935-2025-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423062935-2025-1-git-send-email-geert@linux-m68k.org>
Sender: linux-parisc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <a.ryabinin@samsung.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Feb 04, 2015 at 04:15:35PM +0100, Geert Uytterhoeven wrote:
> The patch "module: fix types of device tables aliases" newly requires
> that invocations of
> 
> MODULE_DEVICE_TABLE(type, name);
> 
> come *after* the definition of `name'.  That is reasonable, but gscps2
> wasn't doing this.  Fix it.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thank you.

> ---
> One more fix for your collection...
> 
> parisc/allmodconfig
> http://kisskb.ellerman.id.au/kisskb/buildresult/12358386/
> ---
>  drivers/input/serio/gscps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 8d9ba0c3827c5b2a..94ab494a6ade8d49 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
> @@ -40,7 +40,6 @@
>  MODULE_AUTHOR("Laurent Canet <canetl@esiee.fr>, Thibaut Varene <varenet@parisc-linux.org>, Helge Deller <deller@gmx.de>");
>  MODULE_DESCRIPTION("HP GSC PS2 port driver");
>  MODULE_LICENSE("GPL");
> -MODULE_DEVICE_TABLE(parisc, gscps2_device_tbl);
>  
>  #define PFX "gscps2.c: "
>  
> @@ -439,6 +438,7 @@ static struct parisc_device_id gscps2_device_tbl[] = {
>  #endif
>  	{ 0, }	/* 0 terminated list */
>  };
> +MODULE_DEVICE_TABLE(parisc, gscps2_device_tbl);
>  
>  static struct parisc_driver parisc_ps2_driver = {
>  	.name		= "gsc_ps2",
> -- 
> 1.9.1
> 

-- 
Dmitry
