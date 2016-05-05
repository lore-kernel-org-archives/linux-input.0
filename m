From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: CM109: Fix handling of volume and mute buttons
Date: Wed, 4 May 2016 17:18:20 -0700
Message-ID: <20160505001820.GA15115@dtor-ws>
References: <1462393511-20979-1-git-send-email-florian.euchner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462393511-20979-1-git-send-email-florian.euchner@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Euchner <florian.euchner@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, May 04, 2016 at 10:25:11PM +0200, Florian Euchner wrote:
> The CM109 driver reported key press events of volume up / down and
> record / playback mute buttons, but no release events. Report those events
> properly by handling volume and mute keys seperately. For the record and
> playback mute buttons, only presses are registered by the CM109, therefore
> simulate press-n-release. This fixes the volume control buttons of various
> USB headsets.
> 
> Signed-off-by: Florian Euchner <florian.euchner@gmail.com>

Applied, thank you.

> ---
> Thank you very much for your response to my first patch, Dmitry.
> I didn't realize input_report_key already does all of the logic to
> make sure keypresses are not reported twice, which made my code more
> complicated than it had to be. I have applied your code with some
> adjustments:
> * The for loop should only count to 4, not to 8. There are only four keys,
> otherwise this would cause reading outside the bounds of the keymap[] array
> and bits 4-7 of HID_IR0 are not used for keys according to the datasheet.
> * The RECORD_MUTE key should mute the microphone, not the speaker.
> * There only need to be 15 slots in the keymap for special keys since
> "no special key pressed" is not a valid combination anymore.
> 
> I hope those adjustments make sense.
> 
>  drivers/input/misc/cm109.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
> index 9365535..ee1bedd 100644
> --- a/drivers/input/misc/cm109.c
> +++ b/drivers/input/misc/cm109.c
> @@ -76,8 +76,8 @@ enum {
>  
>  	BUZZER_ON = 1 << 5,
>  
> -	/* up to 256 normal keys, up to 16 special keys */
> -	KEYMAP_SIZE = 256 + 16,
> +	/* up to 256 normal keys, up to 15 special key combinations */
> +	KEYMAP_SIZE = 256 + 15,
>  };
>  
>  /* CM109 protocol packet */
> @@ -139,7 +139,7 @@ static unsigned short special_keymap(int code)
>  {
>  	if (code > 0xff) {
>  		switch (code - 0xff) {
> -		case RECORD_MUTE:	return KEY_MUTE;
> +		case RECORD_MUTE:	return KEY_MICMUTE;
>  		case PLAYBACK_MUTE:	return KEY_MUTE;
>  		case VOLUME_DOWN:	return KEY_VOLUMEDOWN;
>  		case VOLUME_UP:		return KEY_VOLUMEUP;
> @@ -312,6 +312,32 @@ static void report_key(struct cm109_dev *dev, int key)
>  	input_sync(idev);
>  }
>  
> +/*
> + * Converts data of special key presses (volume, mute) into events
> + * for the input subsystem, sends press-n-release for mute keys.
> + */
> +static void cm109_report_special(struct cm109_dev *dev)
> +{
> +	static const u8 autorelease = RECORD_MUTE | PLAYBACK_MUTE;
> +	struct input_dev *idev = dev->idev;
> +	u8 data = dev->irq_data->byte[HID_IR0];
> +	unsigned short keycode;
> +	int i;
> +
> +	for (i = 0; i < 4; i++) {
> +		keycode = dev->keymap[0xff + BIT(i)];
> +		if (keycode == KEY_RESERVED)
> +			continue;
> +
> +		input_report_key(idev, keycode, data & BIT(i));
> +		if (data & autorelease & BIT(i)) {
> +			input_sync(idev);
> +			input_report_key(idev, keycode, 0);
> +		}
> +	}
> +	input_sync(idev);
> +}
> +
>  /******************************************************************************
>   * CM109 usb communication interface
>   *****************************************************************************/
> @@ -357,10 +383,7 @@ static void cm109_urb_irq_callback(struct urb *urb)
>  	}
>  
>  	/* Special keys */
> -	if (dev->irq_data->byte[HID_IR0] & 0x0f) {
> -		const int code = (dev->irq_data->byte[HID_IR0] & 0x0f);
> -		report_key(dev, dev->keymap[0xff + code]);
> -	}
> +	cm109_report_special(dev);
>  
>  	/* Scan key column */
>  	if (dev->keybit == 0xf) {
> -- 
> 2.8.2
> 

-- 
Dmitry
