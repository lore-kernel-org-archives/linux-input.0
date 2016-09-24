From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/4] Input-gameport: Add the macro "pr_fmt" for module
 "joydump"
Date: Sat, 24 Sep 2016 09:41:08 -0700
Message-ID: <20160924164108.GB40187@dtor-ws>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <3345f7c1-b823-a819-aabf-5b4990068075@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3345f7c1-b823-a819-aabf-5b4990068075@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 24, 2016 at 03:48:54PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 24 Sep 2016 14:30:44 +0200
> 
> Add a definition for the macro "pr_fmt" so that its information can be used
> for consistent message output.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/input/joystick/joydump.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
> index f9f6cbe..a38f10e 100644
> --- a/drivers/input/joystick/joydump.c
> +++ b/drivers/input/joystick/joydump.c
> @@ -27,6 +27,8 @@
>   * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +

Why did you split it off from the patch where you attempt to use it?
What good does this change do on its own?

>  #include <linux/module.h>
>  #include <linux/gameport.h>
>  #include <linux/kernel.h>
> -- 
> 2.10.0
> 

-- 
Dmitry
