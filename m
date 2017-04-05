From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: asus: support backlight on USB keyboards
Date: Wed, 5 Apr 2017 11:41:10 +0200
Message-ID: <20170405094110.GA4939@mail.corp.redhat.com>
References: <20170404175132.20498-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170404175132.20498-1-carlo@caione.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux@endlessm.com, Carlo Caione <carlo@endlessm.com>
List-Id: linux-input@vger.kernel.org

Hi Carlo,

On Apr 04 2017 or thereabouts, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> The latest USB keyboards shipped on several ASUS laptop models
> (including ROG laptop models such as GL702VMK) have the keyboards
> backlight controlled by the keyboard firmware.
> 
> The firmware implements at least 3 different commands:
> - Init command (to use when the system starts)
> - Configuration command (to get keyboard status/information)
> - Backlight level control (to change the level of the keyboard light)
> 
> With this patch we create the usual 'asus::kbd_backlight' sysfs entry

Please change 'sysfs' with 'led class' or this will mislead people into
understanding that you are adding a custom sysfs entry.

> to control the keyboard backlight.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  drivers/hid/hid-asus.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 191 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index bacba97..e40ff72 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -40,8 +40,12 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  
>  #define FEATURE_REPORT_ID 0x0d
>  #define INPUT_REPORT_ID 0x5d
> +#define FEATURE_KBD_REPORT_ID 0x5a
>  
>  #define INPUT_REPORT_SIZE 28
> +#define FEATURE_KBD_REPORT_SIZE 16
> +
> +#define SUPPORT_BKD_BACKLIGHT BIT(0)
>  
>  #define MAX_CONTACTS 5
>  
> @@ -64,6 +68,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  #define QUIRK_SKIP_INPUT_MAPPING	BIT(2)
>  #define QUIRK_IS_MULTITOUCH		BIT(3)
>  #define QUIRK_NO_CONSUMER_USAGES	BIT(4)
> +#define QUIRK_USE_KBD_BACKLIGHT		BIT(5)
>  
>  #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
>  						 QUIRK_NO_INIT_REPORTS | \
> @@ -74,9 +79,18 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
>  
>  #define TRKID_SGN       ((TRKID_MAX + 1) >> 1)
>  
> +struct asus_kbd_leds {
> +	struct led_classdev cdev;
> +	struct hid_device *hdev;
> +	struct work_struct work;
> +	unsigned int brightness;
> +};
> +
>  struct asus_drvdata {
>  	unsigned long quirks;
>  	struct input_dev *input;
> +	struct asus_kbd_leds *kbd_backlight;
> +	bool enable_backlight;
>  };
>  
>  static void asus_report_contact_down(struct input_dev *input,
> @@ -171,14 +185,166 @@ static int asus_raw_event(struct hid_device *hdev,
>  	return 0;
>  }
>  
> +static int asus_init_kbd(struct hid_device *hdev)
> +{
> +	int ret;
> +	const unsigned char buf[] = { FEATURE_KBD_REPORT_ID, 0x41, 0x53, 0x55,
> +				      0x53, 0x20, 0x54, 0x65, 0x63, 0x68, 0x2e,
> +				      0x49, 0x6e, 0x63, 0x2e, 0x00 };

Do you have any hints in what this magical blob is?

> +	unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
> +
> +	if (!dmabuf) {
> +		ret = -ENOMEM;
> +		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);

No need to have an error if kzalloc fails. There will already one to be
shout by kzalloc. Please remove all of those errors after
kzalloc/kmemdup.

> +		return ret;

just return -ENOMEM.

> +	}
> +
> +	ret = hid_hw_raw_request(hdev, FEATURE_KBD_REPORT_ID, dmabuf,
> +				 sizeof(buf), HID_FEATURE_REPORT,
> +				 HID_REQ_SET_REPORT);
> +
> +	kfree(dmabuf);
> +
> +	if (ret != sizeof(buf)) {
> +		hid_err(hdev, "Asus failed to send init command: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int asus_get_kbd_functions(struct hid_device *hdev,
> +				  unsigned char *kbd_func)
> +{
> +	int ret;
> +	const unsigned char buf[] = { FEATURE_KBD_REPORT_ID, 0x05, 0x20, 0x31,
> +				      0x00, 0x08 };
> +	unsigned char *dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
> +	unsigned char *readbuf;
> +
> +	if (!dmabuf) {
> +		ret = -ENOMEM;
> +		hid_err(hdev, "Asus failed to alloc dma buf: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = hid_hw_raw_request(hdev, FEATURE_KBD_REPORT_ID, dmabuf,
> +				 sizeof(buf), HID_FEATURE_REPORT,
> +				 HID_REQ_SET_REPORT);
> +
> +	kfree(dmabuf);
> +
> +	if (ret != sizeof(buf)) {
> +		hid_err(hdev, "Asus failed to send configuration command: %d\n", ret);
> +		return ret;
> +	}
> +
> +	readbuf = kzalloc(FEATURE_KBD_REPORT_SIZE, GFP_KERNEL);

That's a lot of kzalloc/kmemdup/kfree. I wonder if you couldn't just
prepare some buffers in asus_register_kbd_leds() and just reuse them.

> +	if (!readbuf) {
> +		ret = -ENOMEM;
> +		hid_err(hdev, "Asus failed to alloc readbuf: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = hid_hw_raw_request(hdev, FEATURE_KBD_REPORT_ID, readbuf,
> +				 FEATURE_KBD_REPORT_SIZE, HID_FEATURE_REPORT,
> +				 HID_REQ_GET_REPORT);
> +	if (ret != FEATURE_KBD_REPORT_SIZE) {
> +		hid_err(hdev, "Asus failed to request functions: %d\n", ret);
> +		kfree(readbuf);
> +		return ret;
> +	}
> +
> +	*kbd_func = readbuf[6];
> +
> +	kfree(readbuf);
> +	return 0;
> +}
> +
> +static void asus_kbd_backlight_set(struct led_classdev *led_cdev,
> +				   enum led_brightness brightness)
> +{
> +	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
> +						 cdev);
> +	led->brightness = brightness;
> +	schedule_work(&led->work);

If a worker is already happening, aren't we losing the last brightness
setting?

When unplugging the device, you should also make sure nobody queued an
event and that you are not allowing anybody to schedule a new work (by
unregistering the led class interface first or adding a guard.

> +}
> +
> +static enum led_brightness asus_kbd_backlight_get(struct led_classdev *led_cdev)
> +{
> +	struct asus_kbd_leds *led = container_of(led_cdev, struct asus_kbd_leds,
> +						 cdev);
> +
> +	return led->brightness;
> +}
> +
> +static void asus_kbd_backlight_work(struct work_struct *work)
> +{
> +	unsigned char buf[] = { FEATURE_KBD_REPORT_ID, 0xba, 0xc5, 0xc4, 0x00 };
> +	unsigned char *dmabuf;
> +	struct asus_kbd_leds *led = container_of(work, struct asus_kbd_leds,
> +						 work);
> +	int ret;
> +
> +	buf[4] = led->brightness;
> +
> +	dmabuf = kmemdup(buf, sizeof(buf), GFP_KERNEL);
> +	if (!dmabuf) {
> +		ret = -ENOMEM;
> +		hid_err(led->hdev, "Asus failed to alloc dma buf: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = hid_hw_raw_request(led->hdev, FEATURE_KBD_REPORT_ID, dmabuf,
> +				 sizeof(buf), HID_FEATURE_REPORT,
> +				 HID_REQ_SET_REPORT);
> +
> +	kfree(dmabuf);
> +
> +	if (ret != sizeof(buf)) {
> +		hid_err(led->hdev, "Asus failed to set keyboard backlight: %d\n", ret);
> +		return;
> +	}
> +}
> +
> +static int asus_register_kbd_leds(struct hid_device *hdev)
> +{
> +	int ret;
> +	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +
> +	drvdata->kbd_backlight = kzalloc(sizeof(struct asus_kbd_leds),
> +					 GFP_KERNEL);

Unless I am mistaken, I do not see the matching kfree.
Also note that the rest of the driver uses devres (devm_* functions) so
for data that's allocated and which needs to stay during the entire life
of the device, please use the devm API.

> +	if (!drvdata->kbd_backlight) {
> +		ret = -ENOMEM;
> +		hid_err(hdev, "Asus failed to allocate memory: %d\n", ret);

Again, like everywhere else, no error message here.

> +		return ret;
> +	}
> +
> +	drvdata->kbd_backlight->brightness = 0;
> +	drvdata->kbd_backlight->hdev = hdev;
> +	drvdata->kbd_backlight->cdev.name = "asus::kbd_backlight";
> +	drvdata->kbd_backlight->cdev.max_brightness = 3;
> +	drvdata->kbd_backlight->cdev.brightness_set = asus_kbd_backlight_set;
> +	drvdata->kbd_backlight->cdev.brightness_get = asus_kbd_backlight_get;
> +	INIT_WORK(&drvdata->kbd_backlight->work, asus_kbd_backlight_work);
> +
> +	ret = led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);

I do not see the matching led_classdev_unregister() call too. Note that
there is also a devm_led_classdev_register() which might help you.

> +	if (ret != 0) {
> +		kfree(drvdata->kbd_backlight);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  {
>  	struct input_dev *input = hi->input;
>  	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
> +	unsigned char kbd_func = 0;
> +	int ret;
>  
>  	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
> -		int ret;
> -
>  		input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X, 0, 0);
>  		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, MAX_Y, 0, 0);
>  		input_set_abs_params(input, ABS_TOOL_WIDTH, 0, MAX_TOUCH_MAJOR, 0, 0);
> @@ -198,6 +364,18 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
>  
>  	drvdata->input = input;
>  
> +	if (drvdata->enable_backlight) {
> +		if (asus_init_kbd(hdev))
> +			return 0;

Returning success here (and in the other statements below) seems wrong.

> +
> +		ret = asus_get_kbd_functions(hdev, &kbd_func);
> +		if (ret)
> +			return 0;

I do not fully understand why you need to poll the keyboard for the
functionality if you have a quirk for it. If it's mandatory to have
functional backlight that's OK, but otherwise it does seem like waiting
time.

> +
> +		if (kbd_func & SUPPORT_BKD_BACKLIGHT)
> +			asus_register_kbd_leds(hdev);

Don't you need to check for the return value here?

> +	}
> +
>  	return 0;
>  }
>  
> @@ -248,6 +426,16 @@ static int asus_input_mapping(struct hid_device *hdev,
>  			 * as some make the keyboard appear as a pointer device. */
>  			return -1;
>  		}
> +
> +		/*
> +		 * Check and enable backlight only on devices with UsagePage ==
> +		 * 0xff31 to avoid initializing the keyboard firmware multiple
> +		 * times on devices with multiple HID descriptors but same
> +		 * PID/VID.
> +		 */
> +		if (drvdata->quirks & QUIRK_USE_KBD_BACKLIGHT)
> +			drvdata->enable_backlight = true;
> +
>  		return 1;
>  	}
>  
> @@ -379,7 +567,7 @@ static const struct hid_device_id asus_devices[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> -		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
> +		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, asus_devices);
> -- 
> 2.9.3
> 

Cheers,
Benjamin
