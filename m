From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Input: colibri-vf50-ts: fix implicit declaration
Date: Wed, 10 Feb 2016 10:54:45 +0100
Message-ID: <CAMuHMdVViFX+0Wi_LBFsjFStEZnX1XNG-n8tj6qug3mSioySag@mail.gmail.com>
References: <1455097547-31053-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455097547-31053-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sanchayan Maity <maitysanchayan@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-testers@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 10, 2016 at 10:45 AM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
> The build of m32r allmodconfig fails with the error:
> drivers/input/touchscreen/colibri-vf50-ts.c:302:10: error: implicit
>         declaration of function 'of_property_read_u32'
>
> of_property_read_u32() is defined in linux/of.h which was not included.
>
> Fixes: 1261d013daea ("Input: Allow compile test of Goodix and Colibri VF50 if !GPIOLIB")

Actually I had sent the exact same patch to add this missing include,
to apply before 1261d013daea, but it seems Dmitry only applied the
second one.

http://permalink.gmane.org/gmane.linux.kernel.gpio/14086

> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
>  drivers/input/touchscreen/colibri-vf50-ts.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/input/touchscreen/colibri-vf50-ts.c b/drivers/input/touchscreen/colibri-vf50-ts.c
> index 5d4903a..594c096 100644
> --- a/drivers/input/touchscreen/colibri-vf50-ts.c
> +++ b/drivers/input/touchscreen/colibri-vf50-ts.c
> @@ -25,6 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/of.h>

Gr{oetje,eeting}s,

                        Geert
