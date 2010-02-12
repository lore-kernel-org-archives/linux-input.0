From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] HID: hid-ntrig add multi input quirk and clean up
Date: Thu, 11 Feb 2010 16:36:04 -0800
Message-ID: <20100212003604.GA6394@core.coreip.homeip.net>
References: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:51871 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab0BLAnr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Feb 2010 19:43:47 -0500
Received: by ywh27 with SMTP id 27so1699210ywh.1
        for <linux-input@vger.kernel.org>; Thu, 11 Feb 2010 16:43:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1265933946-8318-1-git-send-email-rafi@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chatty@enac.fr

Hi Rafi,

On Thu, Feb 11, 2010 at 07:19:03PM -0500, Rafi Rubin wrote:
> Added a quirk to enable distinct input devices.  The digitizer utilizes
> three inputs to represent pen, multitouch and a normal touch screen.
> 
> With the Pen partitioned, it behaves well and does not need special
> handling.
> 
> Also, I set names to the input devices to clarify the functions of the
> various inputs.
> 

Overall looks much nicer (goes for all 4 patches) and reader should be
able to see what is going on much easier now.

Couple of formatting nits still (I am pretty sure scripts/checkpatch.pl
warns about these as well):

> Signed-off-by: Rafi Rubin <rafi@seas.upenn.edu>
> ---
>  drivers/hid/hid-ntrig.c |   46 ++++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
> index 49ce69d..4bb5ed0 100644
> --- a/drivers/hid/hid-ntrig.c
> +++ b/drivers/hid/hid-ntrig.c
> @@ -42,6 +42,10 @@ static int ntrig_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  		struct hid_field *field, struct hid_usage *usage,
>  		unsigned long **bit, int *max)
>  {
> +	/* No special mappings needed for the pen */
> +	if(field->application == HID_DG_PEN)
> +		return 0;

Please add space after keyword and before opening paren ("if (...)",
"While (...)", etc) here and elsewhere.

> +
>  	switch (usage->hid & HID_USAGE_PAGE) {
>  
>  	case HID_UP_GENDESK:
> @@ -104,6 +108,9 @@ static int ntrig_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>  		struct hid_field *field, struct hid_usage *usage,
>  		unsigned long **bit, int *max)
>  {
> +	/* No special mappings needed for the pen */
> +	if(field->application == HID_DG_PEN)
> +		return 0;
>  	if (usage->type == EV_KEY || usage->type == EV_REL
>  			|| usage->type == EV_ABS)
>  		clear_bit(usage->code, *bit);
> @@ -123,6 +130,10 @@ static int ntrig_event (struct hid_device *hid, struct hid_field *field,
>  	struct input_dev *input = field->hidinput->input;
>  	struct ntrig_data *nd = hid_get_drvdata(hid);
>  
> +	/* No special handling needed for the pen */
> +	if(field->application == HID_DG_PEN)
> +		return 0;
> +
>          if (hid->claimed & HID_CLAIMED_INPUT) {
>  		switch (usage->hid) {
>  
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
> @@ -255,14 +271,36 @@ static int ntrig_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (!ret)
>  		ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
>  
> -	if (ret)
> +	if (ret) {
>  		kfree (nd);

What about hid_hw_stop()? Overall I'd rather see the standard error
unwinding path with gotos.

> +		return ret;
> +	}
> +
> +	list_for_each_entry(hidinput, &hdev->inputs, list) {
> +		input = hidinput->input;
> +		switch (hidinput->report->field[0]->application) {
> +		case HID_DG_PEN:
> +			input->name = "N-Trig Pen";
> +			break;
> +		case HID_DG_TOUCHSCREEN:
> +			/* 
> +			 * The physical touchscreen (single touch) input
> +			 * has a value for physical, whereas the multitouch
> +			 * only has logical input fields.
> +			 */
> +			if(hidinput->report->field[0]->physical) {
> +				input->name = "N-Trig Touchscreen";
> +			} else {
> +				input->name = "N-Trig MultiTouch";
> +			}

No need for curly braces for single-line statements. Maybe compress to
?: statement?

-- 
Dmitry
