From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH v2 1/2] xen,input: add xen-kbdfront module parameter for
 setting resolution
Date: Tue, 11 Apr 2017 12:26:37 +0300
Message-ID: <c7608f78-912b-c777-0aa9-1db64fb003f4@gmail.com>
References: <20170411085028.6750-1-jgross@suse.com>
 <20170411085028.6750-2-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170411085028.6750-2-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, linux-input@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On 04/11/2017 11:50 AM, Juergen Gross wrote:
> Add a parameter for setting the resolution of xen-kbdfront in order to
> be able to cope with a (virtual) frame buffer of arbitrary resolution.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   drivers/input/misc/xen-kbdfront.c | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 3900875dec10..90e7981a7768 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -41,6 +41,12 @@ struct xenkbd_info {
>   	char phys[32];
>   };
>   
> +enum { KPARAM_WIDTH, KPARAM_HEIGHT, KPARAM_CNT };
> +static int size[KPARAM_CNT] = { XENFB_WIDTH, XENFB_HEIGHT };
if you are about to release yet another version of the series,
could you please also rename "size" to "ptr_size/pointer_size/XXX",
so later when I add multi-touch support I can have
"mtouch_size" module parameter and they are consistent all together?
> +module_param_array(size, int, NULL, 0444);
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
> @@ -344,12 +350,16 @@ static void xenkbd_backend_changed(struct xenbus_device *dev,
>   
>   		/* Set input abs params to match backend screen res */
>   		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
> -				 "width", "%d", &val) > 0)
> +				 "width", "%d", &val) > 0) {
>   			input_set_abs_params(info->ptr, ABS_X, 0, val, 0, 0);
> +			size[KPARAM_WIDTH] = val;
> +		}
>   
>   		if (xenbus_scanf(XBT_NIL, info->xbdev->otherend,
> -				 "height", "%d", &val) > 0)
> +				 "height", "%d", &val) > 0) {
>   			input_set_abs_params(info->ptr, ABS_Y, 0, val, 0, 0);
> +			size[KPARAM_HEIGHT] = val;
> +		}
>   
>   		break;
>   
Thank you,
Oleksandr
