From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: xpad - add Thrustmaster as Xbox 360
 controller vendor
Date: Thu, 16 Oct 2014 14:02:57 -0700
Message-ID: <20141016210257.GE38361@dtor-ws>
References: <1413371076-12390-1-git-send-email-tt.rantala@gmail.com>
 <1413371076-12390-2-git-send-email-tt.rantala@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1413371076-12390-2-git-send-email-tt.rantala@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tommi Rantala <tt.rantala@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 15, 2014 at 02:04:36PM +0300, Tommi Rantala wrote:
> Add Thrustmaster as Xbox 360 controller vendor. This is required for
> example to make the GP XID (044f:b326) gamepad work.
> 
> Signed-off-by: Tommi Rantala <tt.rantala@gmail.com>

Applied both, thank you.

> ---
>  drivers/input/joystick/xpad.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index cee4fe3..2ed7905 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -293,6 +293,7 @@ static const signed short xpad_abs_triggers[] = {
>  
>  static struct usb_device_id xpad_table[] = {
>  	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
> +	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
>  	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
>  	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
>  	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
> -- 
> 1.9.3
> 

-- 
Dmitry
