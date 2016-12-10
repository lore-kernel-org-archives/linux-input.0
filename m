From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: asus: Fix keyboard support
Date: Sat, 10 Dec 2016 22:17:56 +0100
Message-ID: <20161210211756.GE1919@mail.corp.redhat.com>
References: <20161129091344.GD24670@mail.corp.redhat.com>
 <1481365242-13528-1-git-send-email-redmcg@redmandi.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481365242-13528-1-git-send-email-redmcg@redmandi.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brendan McGrath <redmcg@redmandi.dyndns.org>
Cc: Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Vlasenko <victor.vlasenko@sysgears.com>
List-Id: linux-input@vger.kernel.org

Hi Brendan,

Sorry for breaking the existing device.

I have a few minor issues with your patch, but I'll let Jiri says
whether or not you need a v2.

On Dec 10 2016 or thereabouts, Brendan McGrath wrote:
> The previous submission which added Touchpad support broke the
> Keyboard support of this driver. This patch:
> 1. fixes the Keyboard support (by assigning drvdata->input);

This is actually what was breaking your keyboard (plus item 4 which is
cosmetic). Ideally, this should be in a separate patch.

> 2. renames NOTEBOOK_QUIRKS to KEYBOARD_QUIRKS;
> 3. adds the NO_INIT_REPORT quirk to the KEYBOARD_QUIRKS; and

Points 2 and 3 are actually improvements because I can't seem to find
that previously the keyboard had this quirk. I understand it is
valuable, but it should be in a different patch IMO.

> 4. sets the input->name to 'Asus Keyboard' for the keyboard 

Cosmetic, but so important :)

Anyway, the patch in its current form is:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

But it might be good to split it in 2 (it will depend on Jiri I guess).

Let's hope we won't break the touchpad this time :)

Cheers,
Benjamin

> 
> Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
> ---
>  drivers/hid/hid-asus.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 96179b2..34a703c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -64,7 +64,8 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
>  #define QUIRK_IS_MULTITOUCH		BIT(3)
>  
> -#define NOTEBOOK_QUIRKS			QUIRK_FIX_NOTEBOOK_REPORT
> +#define KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
> +						 QUIRK_NO_INIT_REPORTS)
>  #define TOUCHPAD_QUIRKS			(QUIRK_NO_INIT_REPORTS | \
>  						 QUIRK_SKIP_INPUT_MAPPING | \
>  						 QUIRK_IS_MULTITOUCH)
> @@ -170,11 +171,11 @@ static int asus_raw_event(struct hid_device *hdev,
>  
>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  {
> +	struct input_dev *input = hi->input;
>  	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
>  
>  	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
>  		int ret;
> -		struct input_dev *input = hi->input;
>  
>  		input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X, 0, 0);
>  		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, MAX_Y, 0, 0);
> @@ -191,10 +192,10 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  			hid_err(hdev, "Asus input mt init slots failed: %d\n", ret);
>  			return ret;
>  		}
> -
> -		drvdata->input = input;
>  	}
>  
> +	drvdata->input = input;
> +
>  	return 0;
>  }
>  
> @@ -286,7 +287,11 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		goto err_stop_hw;
>  	}
>  
> -	drvdata->input->name = "Asus TouchPad";
> +	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
> +		drvdata->input->name = "Asus TouchPad";
> +	} else {
> +		drvdata->input->name = "Asus Keyboard";
> +	}
>  
>  	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
>  		ret = asus_start_multitouch(hdev);
> @@ -315,7 +320,7 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
>  
>  static const struct hid_device_id asus_devices[] = {
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
> -		 USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD), NOTEBOOK_QUIRKS},
> +		 USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD), KEYBOARD_QUIRKS},
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  			 USB_DEVICE_ID_ASUSTEK_TOUCHPAD), TOUCHPAD_QUIRKS },
>  	{ }
> -- 
> 2.7.4
> 
