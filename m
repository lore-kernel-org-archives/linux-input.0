From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 4/5] input: synaptics - make image sensors and cr48
 sensors report widths
Date: Thu, 11 Jun 2015 17:40:14 -0700
Message-ID: <20150612004014.GC20581@dtor-pixel>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
 <1427035436-2168-5-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427035436-2168-5-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de
List-Id: linux-input@vger.kernel.org

HI Gabriele,

On Sun, Mar 22, 2015 at 03:43:55PM +0100, Gabriele Mazzotta wrote:
> The driver was not reporting widths for image sensors and cr48 sensors
> despite it was calculating them.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=77161
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/input/mouse/synaptics.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index ff47084..4e86ba6 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -927,6 +927,7 @@ static void synaptics_report_mt_data(struct psmouse *psmouse,
>  		input_report_abs(dev, ABS_MT_POSITION_X, pos[i].x);
>  		input_report_abs(dev, ABS_MT_POSITION_Y, pos[i].y);
>  		input_report_abs(dev, ABS_MT_PRESSURE, hw[i]->z);
> +		input_report_abs(dev, ABS_MT_TOUCH_MAJOR, hw[i]->w);

As I mentioned in the other email ABS_MT_TOUCH_MAJOR should use surface
units for reporting.

>  	}
>  
>  	input_mt_drop_unused(dev);
> @@ -1192,8 +1193,9 @@ static void set_input_params(struct psmouse *psmouse,
>  	if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
>  		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
>  					ABS_MT_POSITION_Y);
> -		/* Image sensors can report per-contact pressure */
> +		/* Image sensors can report per-contact pressure and width */
>  		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_TOUCH_MAJOR, 4, 15, 0, 0);
>  		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
>  		/* Image sensors can signal 4 and 5 finger clicks */
>  		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
> @@ -1202,6 +1204,7 @@ static void set_input_params(struct psmouse *psmouse,
>  		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
>  					ABS_MT_POSITION_Y);
>  		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +		input_set_abs_params(dev, ABS_MT_TOUCH_MAJOR, 4, 15, 0, 0);
>  		/*
>  		 * Profile sensor in CR-48 tracks contacts reasonably well,
>  		 * other non-image sensors with AGM use semi-mt.
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
