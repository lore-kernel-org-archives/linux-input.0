From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: trackpoint - force 3 buttons if 0 button is
 reported
Date: Fri, 12 Jan 2018 00:39:40 -0800
Message-ID: <20180112083940.p36qj6ltzzwtuhng@dtor-ws>
References: <20180112064658.25019-1-aaron.ma@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112064658.25019-1-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Jan 12, 2018 at 02:46:58PM +0800, Aaron Ma wrote:
> Lenovo introduced trackpoint compatible sticks with minimum PS/2 commands.
> Some of these sticks with 3 buttons always return 0 when reading
> extended button info, set it as 3 buttons to enable middle button.

Does it only happen with newer ELan/ALPS/NXP trackpoints, or also with
trackpoints advertising the original 0x010E version? What devices
respond with 0 as button info?

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/input/mouse/trackpoint.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 0871010f18d5..00c0d1706567 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -383,6 +383,10 @@ int trackpoint_detect(struct psmouse *psmouse, bool set_properties)
>  	if (trackpoint_read(ps2dev, TP_EXT_BTN, &button_info)) {
>  		psmouse_warn(psmouse, "failed to get extended button data, assuming 3 buttons\n");
>  		button_info = 0x33;
> +	} else if (!button_info) {
> +		psmouse_warn(psmouse,
> +			"got no extended button data, assuming 3 buttons\n");
> +		button_info = 0x33;
>  	}
>  
>  	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
> -- 
> 2.14.3
> 

-- 
Dmitry
