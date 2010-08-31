From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH 2/6] HID: magicmouse: move features reports to static
 array
Date: Mon, 30 Aug 2010 23:52:38 -0400
Message-ID: <1283226758.14419.50.camel@graviton>
References: <1283188858-4839-1-git-send-email-chase.douglas@canonical.com>
	 <1283188858-4839-2-git-send-email-chase.douglas@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:49367 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753771Ab0HaEhf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Aug 2010 00:37:35 -0400
Received: by mail-qy0-f179.google.com with SMTP id 9so6111377qyk.3
        for <linux-input@vger.kernel.org>; Mon, 30 Aug 2010 21:37:35 -0700 (PDT)
In-Reply-To: <1283188858-4839-2-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On Mon, 2010-08-30 at 13:20 -0400, Chase Douglas wrote:
> From: Chase Douglas <chase.douglas@ubuntu.com>
> 
> By moving the feature reports to an array, we can easily support
> more products with different initialization reports. This will be
> useful for enabling the Apple Magic Trackpad.
> 
> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> ---
>  drivers/hid/hid-magicmouse.c |   35 ++++++++++++++++++++---------------
>  1 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
> index 2d8532d..d758061 100644
> --- a/drivers/hid/hid-magicmouse.c
> +++ b/drivers/hid/hid-magicmouse.c
> @@ -377,14 +377,23 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
>  	}
>  }
>  
> +struct feature {
> +	__u8 data[3];
> +	__u8 length;
> +};
> +
> +static struct feature mouse_features[] = {
> +	{ { 0xd7, 0x01 }, 2 },
> +	{ { 0xf8, 0x01, 0x32 }, 3 }
> +};
> +

While fiddling with my Magic Trackpad, I noticed that only the first
message is required to make it send multitouch reports.  The same turns
out to be true for the Magic Mouse.  I don't know what effect the second
message has.

>  static int magicmouse_probe(struct hid_device *hdev,
>  	const struct hid_device_id *id)
>  {
> -	__u8 feature_1[] = { 0xd7, 0x01 };
> -	__u8 feature_2[] = { 0xf8, 0x01, 0x32 };
>  	struct input_dev *input;
>  	struct magicmouse_sc *msc;
>  	struct hid_report *report;
> +	int i;
>  	int ret;
>  
>  	msc = kzalloc(sizeof(*msc), GFP_KERNEL);
> @@ -419,19 +428,15 @@ static int magicmouse_probe(struct hid_device *hdev,
>  	}
>  	report->size = 6;
>  
> -	ret = hdev->hid_output_raw_report(hdev, feature_1, sizeof(feature_1),
> -			HID_FEATURE_REPORT);
> -	if (ret != sizeof(feature_1)) {
> -		dev_err(&hdev->dev, "unable to request touch data (1:%d)\n",
> -				ret);
> -		goto err_stop_hw;
> -	}
> -	ret = hdev->hid_output_raw_report(hdev, feature_2,
> -			sizeof(feature_2), HID_FEATURE_REPORT);
> -	if (ret != sizeof(feature_2)) {
> -		dev_err(&hdev->dev, "unable to request touch data (2:%d)\n",
> -				ret);
> -		goto err_stop_hw;
> +	for (i = 0; i < ARRAY_SIZE(mouse_features); i++) {
> +		ret = hdev->hid_output_raw_report(hdev, mouse_features[i].data,
> +				mouse_features[i].length, HID_FEATURE_REPORT);
> +		if (ret != mouse_features[i].length) {
> +			dev_err(&hdev->dev,
> +				"unable to request touch data (%d:%d)\n",
> +				i, ret);
> +			goto err_stop_hw;
> +		}
>  	}
>  
>  	input = input_allocate_device();

Acked-by: Michael Poole <mdpoole@troilus.org>


