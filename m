From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: psmouse - cleanup Focaltech code
Date: Mon, 24 Oct 2016 16:35:50 -0700
Message-ID: <20161024233550.GA9026@dtor-ws>
References: <1475923136-6046-1-git-send-email-hanipouspilot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475923136-6046-1-git-send-email-hanipouspilot@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Tunin <hanipouspilot@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>
List-Id: linux-input@vger.kernel.org

On Sat, Oct 08, 2016 at 01:38:56PM +0300, Dmitry Tunin wrote:
> psmouse->name "Focaltech Touchpad" is an overkill. In xinput it is too long as
> "FocaltechPS/2 Focaltech Focaltech Touchpad"
> 
> In focaltech_report_state() pointer to psmouse->dev is already stored as *dev
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/focaltech.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> index c8c6a8c..49a56f655 100644
> --- a/drivers/input/mouse/focaltech.c
> +++ b/drivers/input/mouse/focaltech.c
> @@ -43,7 +43,7 @@ int focaltech_detect(struct psmouse *psmouse, bool set_properties)
>  
>  	if (set_properties) {
>  		psmouse->vendor = "FocalTech";
> -		psmouse->name = "FocalTech Touchpad";
> +		psmouse->name = "Touchpad";
>  	}
>  
>  	return 0;
> @@ -146,8 +146,8 @@ static void focaltech_report_state(struct psmouse *psmouse)
>  	}
>  	input_mt_report_pointer_emulation(dev, true);
>  
> -	input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
> -	input_sync(psmouse->dev);
> +	input_report_key(dev, BTN_LEFT, state->pressed);
> +	input_sync(dev);
>  }
>  
>  static void focaltech_process_touch_packet(struct psmouse *psmouse,
> -- 
> 2.7.4
> 

-- 
Dmitry
