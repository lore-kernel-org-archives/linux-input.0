From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 1/4] HID: hid-ntrig add multi input quirk and clean up
Date: Thu, 11 Feb 2010 22:15:38 -0500
Message-ID: <4B74C7DA.4060509@seas.upenn.edu>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu> <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:52545 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757889Ab0BLDPs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 22:15:48 -0500
In-Reply-To: <1265944448-23436-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, chatty@enac.fr

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This set is a resubmission of the previous with Dmitry's requests integrated.

Rafi

On 02/11/10 22:14, Rafi Rubin wrote:
> Added a quirk to enable distinct input devices.  The digitizer utilizes
> three inputs to represent pen, multitouch and a normal touch screen.
> 
> With the Pen partitioned, it behaves well and does not need special
> handling.
> 
> Also, I set names to the input devices to clarify the functions of the
> various inputs.
> 
> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
>  drivers/hid/hid-ntrig.c |   69 +++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 49ce69d..38b2364 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -26,10 +26,10 @@
>  
>  struct ntrig_data {
>  	__s32 x, y, id, w, h;
> -	char reading_a_point, found_contact_id;
> -	char pen_active;
> -	char finger_active;
> -	char inverted;
> +	bool reading_a_point, found_contact_id;
> +	bool pen_active;
> +	bool finger_active;
> +	bool inverted;
>  };
>  
>  /*
> @@ -42,6 +42,10 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		struct hid_field *field, struct hid_usage *usage,
>  		unsigned long **bit, int *max)
>  {
> +	/* No special mappings needed for the pen */
> +	if (field->application == HID_DG_PEN)
> +		return 0;
> +
>  	switch (usage->hid & HID_USAGE_PAGE) {
>  
>  	case HID_UP_GENDESK:
> @@ -104,6 +108,9 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>  		struct hid_field *field, struct hid_usage *usage,
>  		unsigned long **bit, int *max)
>  {
> +	/* No special mappings needed for the pen */
> +	if (field->application == HID_DG_PEN)
> +		return 0;
>  	if (usage->type == EV_KEY || usage->type == EV_REL
>  			|| usage->type == EV_ABS)
>  		clear_bit(usage->code, *bit);
> @@ -123,6 +130,10 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  	struct input_dev *input = field->hidinput->input;
>  	struct ntrig_data *nd = hid_get_drvdata(hid);
>  
> +	/* No special handling needed for the pen */
> +	if (field->application == HID_DG_PEN)
> +		return 0;
> +
>          if (hid->claimed & HID_CLAIMED_INPUT) {
>  		switch (usage->hid) {
>  
> @@ -231,8 +242,8 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  	}
>  
>  	/* we have handled the hidinput part, now remains hiddev */
> -        if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)
> -                hid->hiddev_hid_event(hid, field, usage, value);
> +	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_hid_event)
> +		hid->hiddev_hid_event(hid, field, usage, value);
>  
>  	return 1;
>  }
> @@ -241,6 +252,11 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  {
>  	int ret;
>  	struct ntrig_data *nd;
> +	struct hid_input *hidinput;
> +	struct input_dev *input;
> +
> +	if (id->driver_data)
> +		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
>  
>  	nd = kmalloc(sizeof(struct ntrig_data), GFP_KERNEL);
>  	if (!nd) {
> @@ -252,12 +268,43 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	hid_set_drvdata(hdev, nd);
>  
>  	ret = hid_parse(hdev);
> -	if (!ret)
> -		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		dev_err(&hdev->dev, "parse failed\n");
> +		goto err_free;
> +	}
> +
> +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
> +	if (ret) {
> +		dev_err(&hdev->dev, "hw start failed\n");
> +		goto err_free;
> +	}
>  
> -	if (ret)
> -		kfree (nd);
>  
> +	list_for_each_entry(hidinput, &hdev->inputs, list) {
> +		input = hidinput->input;
> +		switch (hidinput->report->field[0]->application) {
> +		case HID_DG_PEN:
> +			input->name = "N-Trig Pen";
> +			break;
> +		case HID_DG_TOUCHSCREEN:
> +			/*
> +			 * The physical touchscreen (single touch)
> +			 * input has a value for physical, whereas
> +			 * the multitouch only has logical input
> +			 * fields.
> +			 */
> +			input->name =
> +				(hidinput->report->field[0]
> +				 ->physical) ?
> +				"N-Trig Touchscreen" :
> +				"N-Trig MultiTouch";
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +err_free:
> +	kfree(nd);
>  	return ret;
>  }
>  
> @@ -276,7 +323,7 @@ MODULE_DEVICE_TABLE(hid, ntrig_devices);
>  
>  static const struct hid_usage_id ntrig_grabbed_usages[] = {
>  	{ HID_ANY_ID, HID_ANY_ID, HID_ANY_ID },
> -	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1}
> +	{ HID_ANY_ID - 1, HID_ANY_ID - 1, HID_ANY_ID - 1 }
>  };
>  
>  static struct hid_driver ntrig_driver = {
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkt0x9oACgkQwuRiAT9o60+eTwCdG+bbQ1MWV8QG5fQol7/eZyx4
omoAmwU3W1Prsx/JDIpc9IRrcBDUDjGB
=0On1
-----END PGP SIGNATURE-----
