Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999AE2FD69A
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720788; cv=none; b=GFGUTJi27js7Xn0jzXBx5cHd9SuObqkqLRH6xo/R+VyO7v1TyHZlPtb6/LtWI3OHGh1uZEvU7HqTfL8SrahXJ+0zSXnShxfXYISHIj4Ab0mimQiFI4d6+bahiHO6vxOr7iHAIWbL7qx0DqN4kmLjj5L9CrwjizSDZfHoBuJ9sw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720788; c=relaxed/simple;
	bh=aoWVUnrNGXrpLeSGUtzeNV0fEI905n7NsOh0XmM0u+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=taLJ9ZAiAahkcHGnYHlJmn7i55Q/R70e5XPaTyyz1tvowRmMNwPSybCs6NINdAuN8Aag2tkq8ayu4X/zj1NfCM1665S1N4rTZMum4LlND4PaLI7ynm0TdUDnXNp+jV+u7/i/y5GA0vaxQmpAADhSJ8V8+m0BfV0ucn/mSFHoN6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tBONjtZF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBONjtZF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F7CC19425;
	Thu, 14 May 2026 01:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720788;
	bh=aoWVUnrNGXrpLeSGUtzeNV0fEI905n7NsOh0XmM0u+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=tBONjtZFXQ5ZBpAfriah3BriYmuybmV8r5/9HmfGbaEooBKQotX4e2QLs/Bj0TkA8
	 jDIbNNY92h1YLqC7nOFnEgb2TJeX218jtiOUsWbfa/0EItvPU8Bofnv4bpJgFCYocT
	 FS2gW/IIffh9eTlwhnpLXgsvp/6rbNkM0cx61kUyELPiSgZAtVQFukH64Sy1hYHc4N
	 6Ixl6yNz3gm9mOvQDEnNSJL7nNlECxq7IXTTmbF9HweK1HkSkbY1dQVaiVd6+9ojWO
	 bTxe2Bz06vvqRxoY9PaazGsPwRnfFaZrdoYL2jXNi8y4bMV9/DSg5Y8rKpo6uoM24a
	 XTblBlQEYPHXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] HID: nintendo: Add unified report format support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260512200051.2534081-4-vi@endrift.com>
References: <20260512200051.2534081-4-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 01:06:27 +0000
Message-Id: <20260514010628.28F7CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Insufficient bounds checking for NS2_REPORT_UNIFIED payload leads =
to out-of-bounds reads.
- [High] Divide-by-zero kernel panic in switch2_report_trigger() caused by =
attacker-controlled calibration data.
--

commit 6e45b564fde8014fc6ade8452a1b793097b3bee4
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add unified report format support

This commit adds support for the "unified" report format to the nintendo hid
driver. It introduces new mappings for overlapping button and axis fields
across different controller types.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 9801799a90758..9e7eda7b70bfb 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> @@ -3690,11 +3791,48 @@ static int switch2_event(struct hid_device *hdev,=
 struct hid_report *report, uin
> =20
>  	switch (report->id) {
>  	case NS2_REPORT_UNIFIED:
> -		/*
> -		 * TODO
> -		 * This won't be sent unless the report type gets changed via command
> -		 * 03-0A, but we should support it at some point regardless.
> -		 */
> +		switch (ns2->ctlr_type) {
> +		case NS2_CTLR_TYPE_JCL:
> +			switch2_report_stick(input, &ns2->stick_calib[0],
> +				ABS_X, false, ABS_Y, true, &raw_data[11]);
> +			switch2_report_buttons(input, &raw_data[5],
> +				ns2_left_joycon_button_unified_mappings);
> +			break;
> +		case NS2_CTLR_TYPE_JCR:
> +			switch2_report_stick(input, &ns2->stick_calib[0],
> +				ABS_X, false, ABS_Y, true, &raw_data[14]);

Is this safe if the report size is exactly 15 bytes?

Earlier in switch2_event(), there is a global size check:

    if (size < 15)
        return -EINVAL;

However, switch2_report_stick() reads up to 3 bytes from the provided data
pointer (indices 0, 1, and 2). Passing &raw_data[14] means it will read
raw_data[14], raw_data[15], and raw_data[16].

Could this cause an out-of-bounds read if an undersized report is sent?

> +			switch2_report_buttons(input, &raw_data[5],
> +				ns2_right_joycon_button_unified_mappings);
> +			break;
> +		case NS2_CTLR_TYPE_GC:
> +			input_report_abs(input, ABS_HAT0X,
> +				!!(raw_data[7] & NS2_BTN_U3_RIGHT) -
> +				!!(raw_data[7] & NS2_BTN_U3_LEFT));
> +			input_report_abs(input, ABS_HAT0Y,
> +				!!(raw_data[7] & NS2_BTN_U3_DOWN) -
> +				!!(raw_data[7] & NS2_BTN_U3_UP));
> +			switch2_report_buttons(input, &raw_data[5], ns2_gccon_unified_mapping=
s);
> +			switch2_report_stick(input, &ns2->stick_calib[0],
> +				ABS_X, false, ABS_Y, true, &raw_data[11]);
> +			switch2_report_stick(input, &ns2->stick_calib[1],
> +				ABS_RX, false, ABS_RY, true, &raw_data[14]);
> +			switch2_report_trigger(input, ns2->lt_zero, ABS_Z, raw_data[0x3d]);
> +			switch2_report_trigger(input, ns2->rt_zero, ABS_RZ, raw_data[0x3e]);

Similarly, does this code read past the end of the buffer?

Accessing raw_data[0x3d] (index 61) and raw_data[0x3e] (index 62) requires
the report size to be at least 63 bytes, but the global check only guarante=
es
15 bytes.

Additionally, could this new path trigger a divide-by-zero panic?

While this issue pre-dates this commit, switch2_report_trigger() contains t=
he
following calculation:

    int value =3D (NS2_TRIGGER_RANGE + 1) * (data - zero) / (232 - zero);

The zero parameter here comes from the device's factory calibration data
(ns2->lt_zero and ns2->rt_zero). If a device advertises 232 as its zero
calibration point, this division evaluates to 0.

Since this patch exposes a new way to call switch2_report_trigger(), might =
it
be worth adding validation to prevent a zero divisor?

> +			break;
> +		case NS2_CTLR_TYPE_PRO:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512200051.2534=
081-1-vi@endrift.com?part=3D3
