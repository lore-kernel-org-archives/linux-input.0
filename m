From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/4] input/vmmouse: Update the backdoor call with support
 for new instructions
Date: Tue, 20 Aug 2019 22:09:25 -0700
Message-ID: <20190821050925.GA566@penguin>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-5-thomas_os@shipmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190818143316.4906-5-thomas_os@shipmail.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= <thomas_os@shipmail.org>
Cc: linux-kernel@vger.kernel.org, pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org, Doug Covelli <dcovelli@vmware.com>
List-Id: linux-input@vger.kernel.org

On Sun, Aug 18, 2019 at 04:33:16PM +0200, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> Use the definition provided by include/asm/vmware.h
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: <linux-input@vger.kernel.org>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Doug Covelli <dcovelli@vmware.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge with the rest of the patches introducing
VMWARE_HYPERCALL.

> ---
>  drivers/input/mouse/vmmouse.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
> index 871e5b5ab129..0c7707c7bede 100644
> --- a/drivers/input/mouse/vmmouse.c
> +++ b/drivers/input/mouse/vmmouse.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <asm/hypervisor.h>
> +#include <asm/vmware.h>
>  
>  #include "psmouse.h"
>  #include "vmmouse.h"
> @@ -84,7 +85,7 @@ struct vmmouse_data {
>  #define VMMOUSE_CMD(cmd, in1, out1, out2, out3, out4)	\
>  ({							\
>  	unsigned long __dummy1, __dummy2;		\
> -	__asm__ __volatile__ ("inl %%dx" :		\
> +	__asm__ __volatile__ (VMWARE_HYPERCALL :	\
>  		"=a"(out1),				\
>  		"=b"(out2),				\
>  		"=c"(out3),				\
> -- 
> 2.20.1
> 

Thanks.

-- 
Dmitry
