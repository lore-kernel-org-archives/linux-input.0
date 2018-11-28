From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH] Input: xpad - add support for Hyperkin Duke Xbox One
 gamepad
Date: Tue, 27 Nov 2018 19:53:44 -0800
Message-ID: <e920f403-a9e0-5345-27a7-522488b89d27@gmail.com>
References: <20181128032857.26167-1-aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128032857.26167-1-aicommander@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: shelby@jueden.org
List-Id: linux-input@vger.kernel.org



On 11/27/2018 07:28 PM, Cameron Gutman wrote:
> Originally submitted by Shelby Jueden (GitHub: AkBKukU) to paroj/xpad:
> https://github.com/paroj/xpad/pull/97
> 
> Minor change to the location of the new entries done by me.
> 
> Cc: Shelby Jueden <shelby@jueden.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> ---

I'm going to actually NACK this one myself.

I didn't realize Shelby had already submitted it here and received
feedback - https://patchwork.kernel.org/patch/10421897/

I believe I have a patch to always read from Xbox One gamepads kicking around
here somewhere. I'll send that in a series with this patch (or Shelby's if he
wants to make a v2 with the ordering fixed).

>  drivers/input/joystick/xpad.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index cfc8b94527b9..8d6ea091a01a 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -330,6 +330,7 @@ static const struct xpad_device {
>  	{ 0x24c6, 0x5b03, "Thrustmaster Ferrari 458 Racing Wheel", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0x5d04, "Razer Sabertooth", 0, XTYPE_XBOX360 },
>  	{ 0x24c6, 0xfafe, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
> +	{ 0x2e24, 0x0652, "Hyperkin Duke X-Box One pad", 0, XTYPE_XBOXONE },
>  	{ 0x3767, 0x0101, "Fanatec Speedster 3 Forceshock Wheel", 0, XTYPE_XBOX },
>  	{ 0xffff, 0xffff, "Chinese-made Xbox Controller", 0, XTYPE_XBOX },
>  	{ 0x0000, 0x0000, "Generic X-Box pad", 0, XTYPE_UNKNOWN }
> @@ -440,6 +441,7 @@ static const struct usb_device_id xpad_table[] = {
>  	XPAD_XBOX360_VENDOR(0x1bad),		/* Harminix Rock Band Guitar and Drums */
>  	XPAD_XBOX360_VENDOR(0x24c6),		/* PowerA Controllers */
>  	XPAD_XBOXONE_VENDOR(0x24c6),		/* PowerA Controllers */
> +	XPAD_XBOXONE_VENDOR(0x2e24),		/* Hyperkin Duke X-Box One pad */
>  	{ }
>  };
>  
> 
