From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] Input: xpad - send rumble on Xbox One init to fix
 PowerA pads
Date: Mon, 6 Feb 2017 14:13:53 -0800
Message-ID: <20170206221353.GF17441@dtor-ws>
References: <20170205003002.28160-1-aicommander@gmail.com>
 <20170205003002.28160-4-aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170205003002.28160-4-aicommander@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, Feb 04, 2017 at 04:30:00PM -0800, Cameron Gutman wrote:
> Some PowerA pads require a rumble packet to start sending
> input reports.
> 
> Signed-off-by: Cameron Gutman <aicommander@gmail.com>
> ---
>  drivers/input/joystick/xpad.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 3f19f32b..13f298d 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -358,6 +358,13 @@ static const struct xpad_output_packet xone_init_pkt[] = {
>  	 * or later firmware installed (or present from the factory).
>  	 */
>  	{{0x05, 0x20, 0x00, 0x01, 0x00}, 5, true},
> +
> +	/*
> +	 * A rumble packet is required for some PowerA pads to start
> +	 * sending input reports. One of those pads is (0x24c6:0x543a).
> +	 */
> +	{{0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
> +	  0x00, 0x00, 0x00, 0x00, 0x00}, 13, true},

I am uncomfortable with us just blasting random commands to random
controllers. Can we make it device-dependent. I.e:

struct xboxone_init_packet = {
	u16 idVendor;
	u16 idProduct;
	const u8 *data;
	size_t len;
};

static const u8 xboxone_powera_init[] = {
	0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00
};

#define XBOXONE_INIT_PKT(_vid, _pid, _data)		\
	{						\
		.idVendor	= (_vid),		\
		.idProduct	= (_pid),		\
		.data		= (_data),		\
		.len		= ARRAY_SIZE(data),	\
	}
...

static const struct xboxone_init_packet xboxone_init_packets[] = {
	...
	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_powera_init),
	...

With 0/0 VID/PID being "catch all" entry.

BTW, why do we set "pending" on these ones? I do not think it is needed.

Thanks.

-- 
Dmitry
