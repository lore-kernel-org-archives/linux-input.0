From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 5/5] input: MT - add ABS_TOOL_WIDTH to the legacy
 pointer emulation
Date: Thu, 11 Jun 2015 17:38:27 -0700
Message-ID: <20150612003827.GB20581@dtor-pixel>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
 <1427035436-2168-6-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427035436-2168-6-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de
List-Id: linux-input@vger.kernel.org

Hi Gabriele,

On Sun, Mar 22, 2015 at 03:43:56PM +0100, Gabriele Mazzotta wrote:
> Userspace might still rely on ABS_TOOL_WIDTH to determine the width of
> contacts, so add it to the legacy pointer emulation.

I do not think we can do that, at least not in such straightforward
manner, because while ABS_TOOL_WIDTH uses abstract units, normally in
the range of 0 - 15 (16 for bcm5974 driver) ABS_MT_TOUCH_MAJOR reports in
surface units. We would need to come up with a way to scale one into
another and make sure we are not stomping on whatever driver choses to
implement on its own.

In addition, the conversion only makes sense for touchpads, not tablets
or touchscreens.

> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> ---
>  drivers/input/input-mt.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
> index cb150a1..bb4ca6d 100644
> --- a/drivers/input/input-mt.c
> +++ b/drivers/input/input-mt.c
> @@ -65,6 +65,7 @@ int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots,
>  		copy_abs(dev, ABS_X, ABS_MT_POSITION_X);
>  		copy_abs(dev, ABS_Y, ABS_MT_POSITION_Y);
>  		copy_abs(dev, ABS_PRESSURE, ABS_MT_PRESSURE);
> +		copy_abs(dev, ABS_TOOL_WIDTH, ABS_MT_TOUCH_MAJOR);
>  	}
>  	if (flags & INPUT_MT_POINTER) {
>  		__set_bit(BTN_TOOL_FINGER, dev->keybit);
> @@ -182,8 +183,9 @@ EXPORT_SYMBOL(input_mt_report_finger_count);
>   * @dev: input device with allocated MT slots
>   * @use_count: report number of active contacts as finger count
>   *
> - * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y and
> - * ABS_PRESSURE. Touchpad finger count is emulated if use_count is true.
> + * Performs legacy pointer emulation via BTN_TOUCH, ABS_X, ABS_Y,
> + * ABS_PRESSURE and ABS_TOOL_WIDTH. Touchpad finger count is emulated
> + * if use_count is true.
>   *
>   * The input core ensures only the KEY and ABS axes already setup for
>   * this device will produce output.
> @@ -229,9 +231,15 @@ void input_mt_report_pointer_emulation(struct input_dev *dev, bool use_count)
>  			int p = input_mt_get_value(oldest, ABS_MT_PRESSURE);
>  			input_event(dev, EV_ABS, ABS_PRESSURE, p);
>  		}
> +		if (test_bit(ABS_MT_TOUCH_MAJOR, dev->absbit)) {
> +			int w = input_mt_get_value(oldest, ABS_MT_TOUCH_MAJOR);
> +			input_event(dev, EV_ABS, ABS_TOOL_WIDTH, w);
> +		}
>  	} else {
>  		if (test_bit(ABS_MT_PRESSURE, dev->absbit))
>  			input_event(dev, EV_ABS, ABS_PRESSURE, 0);
> +		if (test_bit(ABS_MT_TOUCH_MAJOR, dev->absbit))
> +			input_event(dev, EV_ABS, ABS_TOOL_WIDTH, 0);
>  	}
>  }
>  EXPORT_SYMBOL(input_mt_report_pointer_emulation);
> -- 
> 2.1.4
> 

Thanks.

-- 
Dmitry
