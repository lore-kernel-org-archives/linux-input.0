Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4E3B42CB
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690276; cv=pass; b=I3iuM2bfnS5erWsznmBPVJ8laS7n5Z6/6hdi5zUePf+4nIl78VGcxAS4cRPl3csu3mruREorVtv5P4Gl+zuDgZfzc6NS4W8g1rDcHRBtmP5/c7Mn4CSvUryOi/Gz82kAFpXniBnBIIL61LSPPcCWIE1EUwn0I0YBDIcsEWTaWuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690276; c=relaxed/simple;
	bh=MzfkPGPmLanHFGCiC+rg+Gk4ewwsW+0+KU+PhFeTQHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7fvwQzEWPx6BSP0t14gkgLlngK53Pd9SVs/SsrjcHJg1WsTc+Lsm7et5euYSiuDkDD0B5ZcxdwhCOKZUeCSgIqNLPZjBMt+oPr1Nu1y2pBxeliuiZ6RORPE5+EvqJ+v3HhvHyU76w4J4kwpxXzMwBlC+XB181KAcGuKgfcqme8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svKCn8HJ; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svKCn8HJ"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso1884106d6.3
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 13:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787690274; cv=none;
        d=google.com; s=arc-20260327;
        b=Vqk/E7rYISSYgbxH19eiJ4u1VxXD9/fB5WoB5xgVcEoYxZkuImL/tG8/4N+aRvGX2i
         RAOMvFfXfHfunb0biD6EiXSqVfL7GrB9uxW5QACMfLaRHo89s61dnJNQDgj+t9GVlwjF
         4hn1xEXdq9Y/Yv1XUKAzIcDp8VfBHU9+qf47E7UISm2Sv9YrhFqMMMYtx0ggzQYqBXfP
         k6JQ14Hl9QWojQwNuCYqsAP40GG7SAYrQ4v88tTnJ+GUjVaFieU9pFQ6nPOiZ2nJ0GjJ
         pY7q6QFMJ8GwlYi6kOBA/2Xarj09H9o99bEbmyPjyirodi/e1ZULCCjrMqyQVReT7Ow5
         12lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UHMK74l4t8p8IMzbWQcybwUkBONy9umXqHKZJ/RvtKE=;
        fh=OCDYNIqWmhWqSSfkQ7zWwLxEbi5RZOfxfAe9S0bAFO0=;
        b=Uhwr710jtTAS/pYvFvDAsYgdnInMibbkPPPNh5nUd9BrnTALMtc5E3B2bPflmKLZSf
         c3VsWCRY3MQSDDrzD8Roe6rzD8PEH4PwIe6YQozvtIq3Cc0Gwxnv7l5FH0sHiAMi8m4h
         dvbd0Z9xmuEXabpvlPqlB8rC0uHBqBHBGLHo8hy0K2pyObNrxuH/ybodN5zFSNOcRfCO
         F5+CRsYrnkfwJ+I42tGfiOWn+m2RwOQ/u8r4nPm42H7BkCjR/aT3S4bCIMI/uvBYhlDe
         UHb1sczDrjm6UpS5bu0U+Y+9H3tET+QRUyX7iSbUUA/xA2GwCDshL0ks+QFXeriYbZCf
         FKTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787690274; x=1788295074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UHMK74l4t8p8IMzbWQcybwUkBONy9umXqHKZJ/RvtKE=;
        b=svKCn8HJNqt+M4rOBEx3PIL8RbOEDXSBJ0khnWOuDxFCjQoxcAkTo46uL3Yg4xJeqF
         nfCnse1w3nrN3S5IKVZ5XzmP8xL1EaDw35I+BhXmsQsRvJlZ1pprNNua0dyIEtFsb178
         ZO58tLt+j8TgWbg+RmVYuOMK1uK4O+GJqwMuXgc9Zi1opewX3oEwRHfJf1YkoUWfZCYW
         OvgIA5NjLC6iF6p4b2keuyciOFoTNs+NmJ9Pi3EB6m2JT1T1UI4VP2ThDiBSkA8yMsbS
         g52m9X0kmEm7/dSzIfdnF9EoafsLYYAkYglQCrqM8la2wDvs3L6peVg0CVwt99XRTIGs
         X//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787690274; x=1788295074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UHMK74l4t8p8IMzbWQcybwUkBONy9umXqHKZJ/RvtKE=;
        b=Jrs048GH18VXojFTGQlsNczL/7TClfZjaTgA+mmB5TlqKOz+Hhah0SE68MRTZQl6Sg
         y4kvQxWfn2eoA/MKCtNQDJuFoHM0UpRokRZGEvTmkmLRguoXh0KU/F/eDnIpsmmGiM7n
         t0x8vQh/9g/WIICY9APimY2jjkL6xbsxz2kGKyoB+ZaqGlWzWIADLq8pc+W274kgi8fO
         pBA1XXKyS5+7tVrWF6bscJtdmumYO64gmtdyz0itEpuzoqiR5NpJGjjLPXe0x12EZf7Q
         hODyAaqiB80NoW5gxnJl4IPnl1LJrc1J58GST2g7kyHAQL7rUFE2Pebfw1uXYnGlAsva
         gnKA==
X-Forwarded-Encrypted: i=1; AHgh+RppeD8zUtt/LGYp7QqQYZbHxugwZb2KqX1DcxeFmDvKVVWJjk0DJvSxF2gJPTb1g0voMDpyoE73wvQ6Xg==@vger.kernel.org
X-Gm-Message-State: AFuF++nQPeXuMWgBieDxg2yaojk8261n6QfDrqQso4wJWtWejxFJIIu4
	+QqifCiLloz0LBD6IpGU1NyIFYAIYT/QZeAcNN/PjXDDkKrPB+OaLZ1AarH0PurIGGMdrIrAVaQ
	SpNlkalpr+GJK2hzgm2ltUdCNgRRxSAg=
X-Gm-Gg: AR+sD10DVbC3jHcDuRhGB1dUipxTq/T8uA+NfXI1gmhzBBu4vBnS+CC5ZCLgYLnhXs4
	VQLnVMfJKuU+xmPKu+ZicZxRRAGrOJOZP7uEEOuZ8rGS/Ws4GOzkF3LUGkXA6G5vbxIWY5zFNXn
	da30NQSp5v3peZXliVwLKde5rVVkmmtz8Q7Ik+XEQGJCiDWxn6eOYx1mR3caxdoU4e7EUaMcIG5
	YtqonrwqhkO9vfhAdGiohL0zt28Sl1rNGpiHXef4cC1Y3PFqSqaSQOYHCYQnyyko1O8RSFyBKRC
	nwq5vkXp2/dQmF/51OdAq5nPann5VcOi2DxcUsX+HFhf5NIMgyV3F1GX
X-Received: by 2002:a05:6214:5502:b0:8ef:4ed2:316 with SMTP id
 6a1803df08f44-90cc792b9d4mr16734046d6.1.1787690274242; Tue, 25 Aug 2026
 13:37:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821214810.87826-1-mradityadash@gmail.com> <20260821214810.87826-4-mradityadash@gmail.com>
In-Reply-To: <20260821214810.87826-4-mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 25 Aug 2026 13:37:43 -0700
X-Gm-Features: AcwNN1W6nAlqhzrz3lkKYNzHUwWsRz-9iG3n0h2dvctF3q6eXzZL5fNac5WHZGU
Message-ID: <CAFqHKT=XgpUysvD117WD7gdTvMn9wG5VuH7=KFBo96Kd+Z3Pjw@mail.gmail.com>
Subject: Re: [PATCH 3/5] HID: hid-lenovo-go: record calibration completion state
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:48=E2=80=AFPM Aditya Dash <mradityadash@gmail.com=
> wrote:
>
> The firmware uses result value 0 for failure and 1 for success. The drive=
r
> stores this value directly as a state index. Index 0 means unknown, so th=
e
> driver reports a firmware failure as unknown.
This is false. Firmware reports 0x01 as success, 0x02 as failure. With
this change all calibration actions result in a success.

From the documentation:

1. Start Joystick calibration.
2. The user needs to rotate the joystick along the edge for two full
circles and then return it to
the center position.
3. Upon successful calibration, the firmware will automatically exit
the calibration mode after 2
seconds and report a successful calibration status. If the joystick
calibration is not completed
within 10 seconds, the firmware will automatically exit the
calibration mode and report a
failed calibration status.

Thanks,
Derek
> Map the result value to the matching failure or success state.
>
> Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
> Assisted-by: Pi:gpt-5.6-sol
> Signed-off-by: Aditya Dash <mradityadash@gmail.com>
> ---
> A successful calibration completion was tested on hardware. No final
> failure completion was captured.
>
>  drivers/hid/hid-lenovo-go.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index a6e9a130ad41..d2d134873dd1 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -577,17 +577,19 @@ static int hid_go_light_event(struct command_report=
 *cmd_rep)
>
>  static int hid_go_device_status_event(struct command_report *cmd_rep)
>  {
> +       u8 status =3D cmd_rep->data[1] ? CAL_STAT_SUCCESS : CAL_STAT_FAIL=
URE;
> +
>         switch (cmd_rep->device_type) {
>         case LEFT_CONTROLLER:
>                 switch (cmd_rep->data[0]) {
>                 case CALDEV_GYROSCOPE:
> -                       drvdata.gp_left_gyro_cal_status =3D cmd_rep->data=
[1];
> +                       drvdata.gp_left_gyro_cal_status =3D status;
>                         return 0;
>                 case CALDEV_JOYSTICK:
> -                       drvdata.gp_left_joy_cal_status =3D cmd_rep->data[=
1];
> +                       drvdata.gp_left_joy_cal_status =3D status;
>                         return 0;
>                 case CALDEV_TRIGGER:
> -                       drvdata.gp_left_trigg_cal_status =3D cmd_rep->dat=
a[1];
> +                       drvdata.gp_left_trigg_cal_status =3D status;
>                         return 0;
>                 default:
>                         return -EINVAL;
> @@ -596,13 +598,13 @@ static int hid_go_device_status_event(struct comman=
d_report *cmd_rep)
>         case RIGHT_CONTROLLER:
>                 switch (cmd_rep->data[0]) {
>                 case CALDEV_GYROSCOPE:
> -                       drvdata.gp_right_gyro_cal_status =3D cmd_rep->dat=
a[1];
> +                       drvdata.gp_right_gyro_cal_status =3D status;
>                         return 0;
>                 case CALDEV_JOYSTICK:
> -                       drvdata.gp_right_joy_cal_status =3D cmd_rep->data=
[1];
> +                       drvdata.gp_right_joy_cal_status =3D status;
>                         return 0;
>                 case CALDEV_TRIGGER:
> -                       drvdata.gp_right_trigg_cal_status =3D cmd_rep->da=
ta[1];
> +                       drvdata.gp_right_trigg_cal_status =3D status;
>                         return 0;
>                 default:
>                         return -EINVAL;
> --
> 2.55.0
>
