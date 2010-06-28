From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] wistron_btns: fix a memory leak in wb_module_init error
 path
Date: Mon, 28 Jun 2010 01:02:35 -0700
Message-ID: <20100628080235.GB25287@core.coreip.homeip.net>
References: <1277706620.4148.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1277706620.4148.2.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Miloslav Trmac <mitr@volny.cz>, Rakib Mullick <rakib.mullick@gmail.com>, TJ <ubuntu@tjworld.net>, Julia Lawall <julia@diku.dk>, Samu Onkalo <samu.p.onkalo@nokia.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Axel,

On Mon, Jun 28, 2010 at 02:30:20PM +0800, Axel Lin wrote:
> select_keymap calls copy_keymap to allocate a memory for keymap.
> This patch adds a missing kfree(keymap) in wb_module_init error path.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/input/misc/wistron_btns.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
> index 4dac8b7..55ce70e 100644
> --- a/drivers/input/misc/wistron_btns.c
> +++ b/drivers/input/misc/wistron_btns.c
> @@ -1371,6 +1371,7 @@ static int __init wb_module_init(void)
>  	platform_driver_unregister(&wistron_driver);
>   err_unmap_bios:
>  	unmap_bios();
> +	kfree(keymap);

Thank you for the patch, however this is not quite enough - we also need
to free keymap when map_bios() call fails instead of returning
immediately.

I fixed up locally and applied the patch.

-- 
Dmitry
