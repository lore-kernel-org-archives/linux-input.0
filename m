From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH 1/2] xen, input: add xen-kbdfront module
 parameter for setting resolution
Date: Mon, 10 Apr 2017 16:44:55 +0300
Message-ID: <cd255f47-a8fc-890d-1527-d56eaa6df311@gmail.com>
References: <20170321171905.31584-1-jgross@suse.com>
 <20170321171905.31584-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33633 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbdDJNpA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 09:45:00 -0400
In-Reply-To: <20170321171905.31584-2-jgross@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Hi, Juergen!

On 03/21/2017 07:19 PM, Juergen Gross wrote:
> Add a parameter for setting the resolution of xen-kbdfront in order to
> be able to cope with a (virtual) frame buffer of arbitrary resolution.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/input/misc/xen-kbdfront.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 3900875..2df5678 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -41,6 +41,12 @@ struct xenkbd_info {
>   	char phys[32];
>   };
>   
> +enum { KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
> +static int size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
> +module_param_array(size, int, NULL, 0444);
is this by intention that you use 0444 here?
It means read-only, thus one cannot change these,
so what is the point of the module parameters then?
> +MODULE_PARM_DESC(size,
> +	"Pointing device width, height in pixels (default 800,600)");
> +
>   static int xenkbd_remove(struct xenbus_device *);
>   static int xenkbd_connect_backend(struct xenbus_device *, struct xenkbd_info *);
>   static void xenkbd_disconnect_backend(struct xenkbd_info *);
> @@ -174,8 +180,8 @@ static int xenkbd_probe(struct xenbus_device *dev,
>   
>   	if (abs) {
>   		__set_bit(EV_ABS, ptr->evbit);
> -		input_set_abs_params(ptr, ABS_X, 0, XENFB_WIDTH, 0, 0);
> -		input_set_abs_params(ptr, ABS_Y, 0, XENFB_HEIGHT, 0, 0);
> +		input_set_abs_params(ptr, ABS_X, 0, size[KPARAM_WIDTH], 0, 0);
> +		input_set_abs_params(ptr, ABS_Y, 0, size[KPARAM_HEIGHT], 0, 0);
>   	} else {
>   		input_set_capability(ptr, EV_REL, REL_X);
>   		input_set_capability(ptr, EV_REL, REL_Y);
Thank you,
Oleksandr
