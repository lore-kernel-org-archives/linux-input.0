Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818193AD539;
	Fri,  3 Apr 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775221381; cv=none; b=CK1n9GJfGmrHNC8GV+IKP+0GN8jbYDtzs0/GgLj7dNSPqs9qAvN5bHI0F9P4yDLFjVaav4VFDEd5S3QXdwaUcHAWg1DGm/K/V6p7hHL03PXP0EUJUiCaiyECTMSBYEaYVJIQVb0jPT1fs/5EMtArz6MFHNECCXr6i2FZvCB9ZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775221381; c=relaxed/simple;
	bh=fRMw6MYRmr4zNRJysuyGDapx4K4o7oPZbKSSFsB18/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNvrKLkBIWfMUzKaTeRjG8T2husg6+mjbu3/LerA2apeAgO3VjCZ7rHwTRhjy255B/fSECfX6cEQU9Lz0e2EAfl2b/qs8MJPp+yaeZvDVelPjebTlE9ExJaep32DmS6ploRgGO8bt6aUdgQpgDsQntSN0lF883H7YFvRU8CeKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYsJs/nb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYsJs/nb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC890C4CEF7;
	Fri,  3 Apr 2026 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775221380;
	bh=fRMw6MYRmr4zNRJysuyGDapx4K4o7oPZbKSSFsB18/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYsJs/nbGaBd9MBrcQBsoVlOPtpehCIRV9nRWqKkkZ6A6XSJRGrzbyYQFLWHKcjFF
	 e+mS5rHGaQYONVpaSo8yuOBSGrytObwiHjcDy9DHZEO/DSqLQUH0/YIYv5WqZcJLTE
	 G4dH03XGQBOtrnizjSHFyyCw5VOibXSnuJ/A+7q0TJNuex382V3hOUPuejPqBjBT0j
	 fWZ5VV8N76eXfAStsMeu4AaO9kiHqW2rpO7Ze45YUw5OQgxr6sxu2biYw8PyF0rrob
	 tlbkYk7W8z6n347oFOpevggTqTRr10UQ/n8m7SEtyVtoxFnfAnG635ZXrPvppvU5ja
	 WTpFYz8vOZEdw==
Date: Fri, 3 Apr 2026 15:02:55 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dave Carey <carvsdriver@gmail.com>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: multitouch: Fix Yoga Book 9 14IAH10 touchscreen
 misclassification
Message-ID: <ac-419v9pBcZhuKA@beelink>
References: <20260402182937.388847-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402182937.388847-1-carvsdriver@gmail.com>

Hi Dave,

On Apr 02 2026, Dave Carey wrote:
> The Lenovo Yoga Book 9 14IAH10 (83KJ) uses a composite USB HID device
> (17EF:6161) where three descriptor quirks combine to cause hid-multitouch
> to incorrectly set INPUT_PROP_BUTTONPAD on both touchscreen nodes, making
> libinput treat them as indirect clickpads rather than direct touchscreens.
> 
> Quirk 1: The HID_DG_TOUCHSCREEN application collection contains
> HID_UP_BUTTON usages (stylus barrel buttons). The generic heuristic in
> mt_touch_input_mapping() treats any touchscreen-with-buttons as a
> touchpad, setting INPUT_MT_POINTER.
> 
> Quirk 2: A HID_DG_TOUCHPAD collection ("Emulated Touchpad") sets
> INPUT_MT_POINTER unconditionally in mt_allocate_application().
> 
> Quirk 3: The HID_DG_BUTTONTYPE feature report (0x51) returns
> MT_BUTTONTYPE_CLICKPAD, directly setting td->is_buttonpad = true.
> 
> These combine to produce INPUT_PROP_BUTTONPAD on the touchscreen input
> nodes. libinput treats the devices as indirect clickpads and suppresses
> direct touch events, leaving the touchscreens non-functional under
> KDE/Wayland.

This looks like a completely borked report descriptor. Out of curiosity,
do you know if there is a specific Windows driver for it or if it's
using the plain generic driver there.

The reasoning is that if it's using the generic win driver, we are
probably doing something wrong, and we need to fix it in a more generic
way.

> 
> Additionally, the firmware resets if any USB control request is received
> during the CDC ACM initialization window. The existing GET_REPORT call
> in mt_check_input_mode() during probe triggers this reset.

Ouch, even better :(

> 
> Fix by extending MT_QUIRK_YOGABOOK9I (already defined for the earlier
> Yoga Book 9i) to guard all three BUTTONPAD heuristics and skip the
> HID_DG_BUTTONTYPE GET_REPORT during probe for this device.

Really not a big fan of the approach taken here: We are sprinkling the
code with special quirks for one particular device and that makes
everything worse.

I would much prefer a report descriptor fixup where:
- we drop the HID_UP_BUTTON
- we drop the HID_DG_TOUCHPAD collection entirely
- we drop the HID_DG_BUTTONTYPE feature entirely
- we drop the Win8 blob feature as well to prevent queries during
  initialization.

For ease of development I would recomend working with a separate HID-BPF
program instead of a in-kernel fix, but we already have a .report_fixup
here, so I wouldn't mind having the fix here as well.

Cheers,
Benjamin

> 
> Signed-off-by: Dave Carey <carvsdriver@gmail.com>
> Tested-by: Dave Carey <carvsdriver@gmail.com>
> ---
>  drivers/hid/hid-multitouch.c | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index e82a3c4e5..1bef32b1d 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -549,7 +549,14 @@ static void mt_feature_mapping(struct hid_device *hdev,
>  
>  	switch (usage->hid) {
>  	case HID_DG_CONTACTMAX:
> -		mt_get_feature(hdev, field->report);
> +		/*
> +		 * Yoga Book 9: skip GET_REPORT during probe; the firmware
> +		 * resets if it receives any control request before the init
> +		 * Output report is sent (within ~1.18s of USB enumeration).
> +		 * Logical maximum from the descriptor is used as the fallback.
> +		 */
> +		if (!(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I))
> +			mt_get_feature(hdev, field->report);
>  
>  		td->maxcontacts = field->value[0];
>  		if (!td->maxcontacts &&
> @@ -566,6 +573,10 @@ static void mt_feature_mapping(struct hid_device *hdev,
>  			break;
>  		}
>  
> +		/* Yoga Book 9 reports Clickpad but is a direct touchscreen */
> +		if (td->mtclass.quirks & MT_QUIRK_YOGABOOK9I)
> +			break;
> +
>  		mt_get_feature(hdev, field->report);
>  		switch (field->value[usage->usage_index]) {
>  		case MT_BUTTONTYPE_CLICKPAD:
> @@ -579,7 +590,9 @@ static void mt_feature_mapping(struct hid_device *hdev,
>  		break;
>  	case 0xff0000c5:
>  		/* Retrieve the Win8 blob once to enable some devices */
> -		if (usage->usage_index == 0)
> +		/* Yoga Book 9: skip; firmware resets before init if queried */
> +		if (usage->usage_index == 0 &&
> +		    !(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I))
>  			mt_get_feature(hdev, field->report);
>  		break;
>  	}
> @@ -644,8 +657,11 @@ static struct mt_application *mt_allocate_application(struct mt_device *td,
>  
>  	/*
>  	 * Model touchscreens providing buttons as touchpads.
> +	 * Yoga Book 9 has an emulated touchpad but its touch surfaces
> +	 * are direct screens, not indirect pointers.
>  	 */
> -	if (application == HID_DG_TOUCHPAD) {
> +	if (application == HID_DG_TOUCHPAD &&
> +	    !(td->mtclass.quirks & MT_QUIRK_YOGABOOK9I)) {
>  		mt_application->mt_flags |= INPUT_MT_POINTER;
>  		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
>  	}
> @@ -802,11 +818,15 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
>  
>  	/*
>  	 * Model touchscreens providing buttons as touchpads.
> +	 * Skip for Yoga Book 9 which has stylus buttons inside
> +	 * touchscreen collections, not physical touchpad buttons.
>  	 */
>  	if (field->application == HID_DG_TOUCHSCREEN &&
>  	    (usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
> -		app->mt_flags |= INPUT_MT_POINTER;
> -		td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
> +		if (!(app->quirks & MT_QUIRK_YOGABOOK9I)) {
> +			app->mt_flags |= INPUT_MT_POINTER;
> +			td->inputmode_value = MT_INPUTMODE_TOUCHPAD;
> +		}
>  	}
>  
>  	/* count the buttons on touchpads */
> @@ -1420,7 +1440,6 @@ static int mt_touch_input_configured(struct hid_device *hdev,
>  	 */
>  	if (cls->quirks & MT_QUIRK_APPLE_TOUCHBAR)
>  		app->mt_flags |= INPUT_MT_DIRECT;
> -
>  	if (cls->is_indirect)
>  		app->mt_flags |= INPUT_MT_POINTER;
>  
> @@ -1432,7 +1451,8 @@ static int mt_touch_input_configured(struct hid_device *hdev,
>  
>  	/* check for clickpads */
>  	if ((app->mt_flags & INPUT_MT_POINTER) &&
> -	    (app->buttons_count == 1))
> +	    (app->buttons_count == 1) &&
> +	    !(app->quirks & MT_QUIRK_YOGABOOK9I))
>  		td->is_buttonpad = true;
>  
>  	if (td->is_buttonpad)
> -- 
> 2.53.0
> 
> 
