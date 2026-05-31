Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BDF37E303
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780250246; cv=none; b=VPKwoYDJLwbVu7C2JJH9lQMhUKbuDqhYXUbz5qk8MMrBn2uwkoRs+cuhyTe5PSIrQdXtVPu2PZCmK5rsIK1WYjADNimvyZl5HdZcikvfaonsOidYBN2l+T9Z1e54FV6pTAzOFTkgbQDHzxs2UuSEjr3A4EjPJK4t1Cu1UeibZNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780250246; c=relaxed/simple;
	bh=GzcRgZZ54Xp6fY2ubxRYOsQShY91E99cNCV07d1Fo5w=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=geKEkFa8XBS9aksr3NE2uj7dVlNTtjX8JVBBlJjmRFQKyEiPd9ugO2qOkRoClB7sx3hoP7ZGJAEjogotidTgjU10lGo44nHpHVMZSU+4IstvG/MquCuZjOYhg20oRhz7k4w7udPKWIIvRiTa1u5jazZpNfV6AjM/0jeHC9OA/4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWdbhhfc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWdbhhfc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a7629893so6880005e9.0
        for <linux-input@vger.kernel.org>; Sun, 31 May 2026 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780250243; x=1780855043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sZ4dMi2F8lMGxTUoiGUm4UUFWL3xQumUZSgizh7X264=;
        b=kWdbhhfcu4hbn80atsxD2dWbwHAcaY85p/GuHBDxrkJOszYQ0gy2KarDTTrEkBTZPZ
         R21nONOA5hYCwyquhVM9fm15g/tzJYtwXyYncJJCKWrn/d6Ichw2ehBX/iw8AY8UsVb+
         14jB/lw5FtROuwvL/4XUZEuRSAyYff+eAvCHLhH08OYr2on54x+XLwTzukD7uXMg4ttA
         dabNCkfh5DFvAeTEy8Fc9OOXHaghQ+P0ePDbGRAx6Xg4fQLjS3mOFWwfUMalZGqVSkW5
         lxPM3cYBUr6iExgnA8RSbpIpi8/fPgJrHGJ7jAHmtYG5BNa6vm6RJCI9pOgPOz+iZ3fr
         FZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780250243; x=1780855043;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sZ4dMi2F8lMGxTUoiGUm4UUFWL3xQumUZSgizh7X264=;
        b=AIgTXdhmeBLMpw3BIMSerDUo1xa9wFjN0lP0dsANBGGYpEoOWAa9UksVL/X97R0mg6
         +yVe8SxfZ4mcsuFrL8iZDlo5M0EMsGFPLPOiBRElT96TkH/OnQbFqSebUmIBFkzvoj8c
         otM29OFZZvuR92AOnJH33R5WYCfeXKZDQK3VEolWS2Az2iIWC573d0FhjVRJJ9Zl1nxB
         V4UYUEzkLZyo6YdzJLLngVlY2e9RO9D4gDvltHYhkdcyVE61xcK1e2sSEsdvh/3QoP2N
         dtOs7TmgtJjQrNj1LzSzf3WUMgteM0pm+cdKcp9NReUg9QZqXulr4nTV5XiDOL8Qtq6K
         YVPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+sUroEnXr57fJgRfBA6yHi9MT1EZWLDGvqPgOgWEwJm/BH30n+1B/Bn61bSLmXrpqlswIq2RMRiE9eCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1PXuWoKMQhliaoyFqXdS3X3SWbTrH5pEPiohtQEmOE3mLzgXz
	XobdO3ELa6VfhHHwtA0A0T7KGXPddrOv14m/ki0/4x5GxSBvgezrGyK2
X-Gm-Gg: Acq92OGFX9pVvpppBB4N8da3AAgho9cB+8QSX6R2AOp+XpzmftC80dWxdLSgpHtWIMA
	58B6QiI0GuXeanFesVSfh+FO09fbafbjq6nRmR6uK481FGmWYOKQBZxiRtdsQeMQYPKGjufCuTv
	MgRfMgLB93rHtG3IX/SES8O1LJ5ey2kVMvMN94u2OdaHd9uYEAwe03pgrXsDt7kNm93CqGYNBFd
	VGfrQgYx3Tm1C9lMDXWmHxxS/nxoSFUhX28flTDVWkYJf6GkgzFU+NiPDuWsvsgS9p5rTU0RVvs
	u8P+6L/GrmBY6g6ZKVwqzsNDZkVdvHKDJcCngXiroUKdBNxvSCVYpDulF+4rgraSOHmn410T2Xq
	AmEJVUdGqEWNcxjE7KIIGywCdHiZOEWWbkavma4NqHOATc8Az/wbNvm5UsoBxLmp+XFcmZKiLe9
	8rFtUFC/J6MgdrV17r6H5CDVAZhQ==
X-Received: by 2002:a05:600c:1d86:b0:48e:60a3:220a with SMTP id 5b1f17b1804b1-490a28aa789mr153499525e9.0.1780250242840;
        Sun, 31 May 2026 10:57:22 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6975e2sm312412855e9.6.2026.05.31.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:57:22 -0700 (PDT)
Date: Sun, 31 May 2026 19:57:22 +0200
To: sashiko-reviews@lists.linux.dev
Cc: Vicki Pfau <vi@endrift.com>, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com
Subject: Re: [PATCH v5 3/3] HID: nintendo: Add unified report format support
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260512200051.2534081-4-vi@endrift.com>
 <20260514010628.28F7CC19425@smtp.kernel.org>
In-Reply-To: <20260514010628.28F7CC19425@smtp.kernel.org>
Message-Id: <2WI1R6X45JVLO.2QWM1RBSXW7DU@homearch.localdomain>
User-Agent: mblaze/1.4-1-g5a69507 (2026-01-24)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] Insufficient bounds checking for NS2_REPORT_UNIFIED payload lead=
s to out-of-bounds reads.
> - [High] Divide-by-zero kernel panic in switch2_report_trigger() caused b=
y attacker-controlled calibration data.
> --
>=20
> commit 6e45b564fde8014fc6ade8452a1b793097b3bee4
> Author: Vicki Pfau <vi@endrift.com>
> Subject: HID: nintendo: Add unified report format support
>=20
> This commit adds support for the "unified" report format to the nintendo =
hid
> driver. It introduces new mappings for overlapping button and axis fields=

> across different controller types.
>=20
> > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> > index 9801799a90758..9e7eda7b70bfb 100644
> > --- a/drivers/hid/hid-nintendo.c
> > +++ b/drivers/hid/hid-nintendo.c
> [ ... ]
> > @@ -3690,11 +3791,48 @@ static int switch2_event(struct hid_device *hde=
v, struct hid_report *report, uin
> > =20
> >  	switch (report->id) {
> >  	case NS2_REPORT_UNIFIED:
> > -		/*
> > -		 * TODO
> > -		 * This won't be sent unless the report type gets changed via comman=
d
> > -		 * 03-0A, but we should support it at some point regardless.
> > -		 */
> > +		switch (ns2->ctlr_type) {
> > +		case NS2_CTLR_TYPE_JCL:
> > +			switch2_report_stick(input, &ns2->stick_calib[0],
> > +				ABS_X, false, ABS_Y, true, &raw_data[11]);
> > +			switch2_report_buttons(input, &raw_data[5],
> > +				ns2_left_joycon_button_unified_mappings);
> > +			break;
> > +		case NS2_CTLR_TYPE_JCR:
> > +			switch2_report_stick(input, &ns2->stick_calib[0],
> > +				ABS_X, false, ABS_Y, true, &raw_data[14]);
>=20
> Is this safe if the report size is exactly 15 bytes?
>=20
> Earlier in switch2_event(), there is a global size check:
>=20
>     if (size < 15)
>         return -EINVAL;
>=20
> However, switch2_report_stick() reads up to 3 bytes from the provided dat=
a
> pointer (indices 0, 1, and 2). Passing &raw_data[14] means it will read
> raw_data[14], raw_data[15], and raw_data[16].
>=20
> Could this cause an out-of-bounds read if an undersized report is sent?

Yes, I assume we would have to check for a bigger size here.

>=20
> > +			switch2_report_buttons(input, &raw_data[5],
> > +				ns2_right_joycon_button_unified_mappings);
> > +			break;
> > +		case NS2_CTLR_TYPE_GC:
> > +			input_report_abs(input, ABS_HAT0X,
> > +				!!(raw_data[7] & NS2_BTN_U3_RIGHT) -
> > +				!!(raw_data[7] & NS2_BTN_U3_LEFT));
> > +			input_report_abs(input, ABS_HAT0Y,
> > +				!!(raw_data[7] & NS2_BTN_U3_DOWN) -
> > +				!!(raw_data[7] & NS2_BTN_U3_UP));
> > +			switch2_report_buttons(input, &raw_data[5], ns2_gccon_unified_mappi=
ngs);
> > +			switch2_report_stick(input, &ns2->stick_calib[0],
> > +				ABS_X, false, ABS_Y, true, &raw_data[11]);
> > +			switch2_report_stick(input, &ns2->stick_calib[1],
> > +				ABS_RX, false, ABS_RY, true, &raw_data[14]);
> > +			switch2_report_trigger(input, ns2->lt_zero, ABS_Z, raw_data[0x3d]);=

> > +			switch2_report_trigger(input, ns2->rt_zero, ABS_RZ, raw_data[0x3e])=
;
>=20
> Similarly, does this code read past the end of the buffer?
>=20
> Accessing raw_data[0x3d] (index 61) and raw_data[0x3e] (index 62) require=
s
> the report size to be at least 63 bytes, but the global check only guaran=
tees
> 15 bytes.

Same here.


>
> Additionally, could this new path trigger a divide-by-zero panic?
>=20
> While this issue pre-dates this commit, switch2_report_trigger() contains=
 the
> following calculation:
>=20
>     int value =3D (NS2_TRIGGER_RANGE + 1) * (data - zero) / (232 - zero);=

>=20
> The zero parameter here comes from the device's factory calibration data
> (ns2->lt_zero and ns2->rt_zero). If a device advertises 232 as its zero
> calibration point, this division evaluates to 0.
>=20
> Since this patch exposes a new way to call switch2_report_trigger(), migh=
t it
> be worth adding validation to prevent a zero divisor?

This one has been reported already in one of the earlier emails.

Cheers,
Silvan

>=20
> > +			break;
> > +		case NS2_CTLR_TYPE_PRO:
> [ ... ]


