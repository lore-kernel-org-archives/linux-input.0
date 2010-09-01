From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH] identify firmware version
Date: Wed, 01 Sep 2010 06:04:06 -0400
Message-ID: <4C7E2516.1020400@seas.upenn.edu>
References: <20100901020634.GD23585@core.coreip.homeip.net> <1283334517-15121-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283334517-15121-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: dmitry.torokhov@gmail.com, jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, micki@n-trig.com, rydberg@euromail.se, chatty@enac.fr
List-Id: linux-input@vger.kernel.org

Just to be clear, this is basically the same as the previous patch 3/4.  I just 
pulled the storage of the value.  Even if later someone wants a sysfs node, we 
can just poll the device on read.

Thanks Henrik for pointing out that it would be nice to dump the version during 
init.

Rafi

On 09/01/10 05:48, Rafi Rubin wrote:
> This adds firmware version polling to the end of probe and reports the
> version both in the raw form and proccessed to match the formatting used
> by ntrig in windows.
>
> Signed-off-by: Rafi Rubin<rafi@seas.upenn.edu>
> ---
>   drivers/hid/hid-ntrig.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 files changed, 52 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 43e95de..c91ad4a 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -90,6 +90,26 @@ struct ntrig_data {
>   };
>
>
> +/*
> + * This function converts the 4 byte raw firmware code into
> + * a string containing 5 comma separated numbers.
> + */
> +static int ntrig_version_string(unsigned char *raw, char *buf)
> +{
> +	__u8 a =  (raw[1]&  0b00001110)>>  1;
> +	__u8 b =  (raw[0]&  0b00111100)>>  2;
> +	__u8 c = ((raw[0]&  0b00000011)<<  3) | ((raw[3]&  0b11100000)>>  5);
> +	__u8 d = ((raw[3]&  0b00000111)<<  3) | ((raw[2]&  0b11100000)>>  5);
> +	__u8 e =   raw[2]&  0b00000111;
> +
> +	/*
> +	 * As yet unmapped bits:
> +	 * 0b11000000 0b11110001 0b00011000 0b00011000
> +	 */
> +
> +	return sprintf(buf, "%u.%u.%u.%u.%u", a, b, c, d, e);
> +}
> +
>   static ssize_t show_phys_width(struct device *dev,
>   			       struct device_attribute *attr,
>   			       char *buf)
> @@ -776,6 +796,9 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	struct hid_input *hidinput;
>   	struct input_dev *input;
>   	struct hid_report *report;
> +	unsigned char *data;
> +	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
> +	char *buf;
>
>   	if (id->driver_data)
>   		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
> @@ -848,10 +871,39 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	if (report)
>   		usbhid_submit_report(hdev, report, USB_DIR_OUT);
>
> +	data = kmalloc(8, GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	ret = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
> +			      USB_REQ_CLEAR_FEATURE,
> +			      USB_TYPE_CLASS | USB_RECIP_INTERFACE |
> +			      USB_DIR_IN,
> +			      0x30c, 1, data, 8,
> +			      USB_CTRL_SET_TIMEOUT);
> +
> +	if (ret == 8) {
> +		buf = kmalloc(20, GFP_KERNEL);
> +		if (!buf) {
> +			ret = -ENOMEM;
> +			goto err_free_data;
> +		}
> +
> +		ret = ntrig_version_string(&data[2], buf);
> +
> +		dev_info(&hdev->dev,
> +			 "Firmware version: %s (%02x%02x %02x%02x)\n",
> +			 buf, data[2], data[3], data[4], data[5]);
> +	}
> +
>   	ret = sysfs_create_group(&hdev->dev.kobj,
>   			&ntrig_attribute_group);
>
>   	return 0;
> +err_free_data:
> +	kfree(data);
>   err_free:
>   	kfree(nd);
>   	return ret;
