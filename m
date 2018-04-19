From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] Input: xen-kbdfront - allow better run-time configuration
Date: Thu, 19 Apr 2018 13:25:25 +0200
Message-ID: <ccb7a33b-7862-9803-fb24-67861d5ecab9@suse.com>
References: <20180418150445.9805-1-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418150445.9805-1-andr2000@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On 18/04/18 17:04, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> It is now only possible to control if multi-touch virtual device
> is created or not (via the corresponding XenStore entries),
> but keyboard and pointer devices are always created.

Why don't you want to go that route for keyboard and mouse, too?
Or does this really make no sense?

> In some cases this is not desirable. For example, if virtual
> keyboard device is exposed to Android then the latter won't
> automatically show on-screen keyboard as it expects that a
> physical keyboard device can be used for typing.
> 
> Make it possible to configure which virtual devices are created
> with module parameters:
>   - no_ptr_dev=1 if no pointer device needs to be created
>   - no_kbd_dev=1 if no keyboard device needs to be created
> Keep old behavior by default.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Suggested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
> Tested-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>
> ---
>  drivers/input/misc/xen-kbdfront.c | 159 +++++++++++++++++-------------
>  1 file changed, 92 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index d91f3b1c5375..a3306aad40b0 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -51,6 +51,16 @@ module_param_array(ptr_size, int, NULL, 0444);
>  MODULE_PARM_DESC(ptr_size,
>  	"Pointing device width, height in pixels (default 800,600)");
>  
> +static unsigned int no_ptr_dev;
> +module_param(no_ptr_dev, uint, 0);

Use type invbool instead?

> +MODULE_PARM_DESC(no_ptr_dev,
> +	"If set then no virtual pointing device exposed to the guest");
> +
> +static unsigned int no_kbd_dev;
> +module_param(no_kbd_dev, uint, 0);

invbool?


Juergen
