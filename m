Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518E37F33C
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787688315; cv=pass; b=WEpFSIVR4+qAoGEmfRlftRmbnbRS5Rrtpgkrfm90YGz1nbpFUF0uLgXEk1m4cAcXNLCwuwvy2pS9lFxZ3qPVR1svz8aTndVZ1rSbtofcMxvF1Y2kKkEOA7SAXdKH/mJCgFeRoxrrdxqolyZ1znLzRhkW478j5PkUvA8DD96xn0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787688315; c=relaxed/simple;
	bh=/mPKgqB/oSkNWZXrWMLRWBKQK9oeTXZOnIGLKDNEweI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3BZQxwL955+ftEE9HlkOn0AGghlCbJiUcMWMFJIFs5qKUv1hG2XMW3gd3Pzs6iYJjqvlAL0b6B7iaYol+pYQ4CrnySWM9L0ZWdZafrkTcd6V8NCPPhalge/ecouC7FrUHCwJmPRudbURycJdUy481babgkNoL7ES61LsPqnGIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipLOlH/B; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipLOlH/B"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51bfa429aa6so7537431cf.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 13:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787688313; cv=none;
        d=google.com; s=arc-20260327;
        b=lK0zw5NTZdi21lVHkfshS9fbVqIvo51sivIMaMx2uyyZRM5M2FRwJnJG0Adosr6abu
         NxU23/AQjoXU6jsOQy7M/mzIVGwg51Iu7SNWwo/2xRCw7MxXlu8C8Lo+88R/g/NRoS3z
         2GWGaWGSusdG+xibvB18KDGEOLzh5SNSQCYFEi8rLJxTYrNcnoIeyxdocdrqdFk/eiWa
         BTiASRuMlqnDdXEXXmuBNfgNamRgKB1pjLypmC1rjAsNndtVhC0amXDgX2hxWTXFdC0E
         KwNLEviXTbC/7nf4nEmv+4LHk6ap3MylvD7Ejd2plHOoYwDVdJQSNDona1tGpuGLOjw+
         595g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h+J+586COvgQPudoMvrhJcpUXrpsU047dA3KGtpBFOA=;
        fh=kJUmh3wjrpZ76E9SdHrKS6MzviSqnMu3cKPcEvGlLDY=;
        b=fCvL7Ke1GTRvPyuBeTSbzB4cZh4HtYjHVBWL50IA3YTeEsCoszKFCiFEXiWLwKgLAD
         Q3YkmzhMkyce6vRJmlI6lT/Tby/236643gXdObgv1t6/q0g+T39XLaOfJzjSRrh9DJzR
         AN2HlYr4Ej7BYzfmkvwgGZOt3i/+DQlp75K+kl75woo6LB7u9dz1ARri5i/pYyzA2NbE
         z8w0FBfcBMIdt3qpE9CZ8AvlsXC3uwbdslbNTsTEf4dCXBpK/rC34o3q4nbPV69U883V
         gEskjRJpV7f5RjZQjG2eMqsePUVupV7Egk8a/GmRuergxIOTGZPUXkPLTxFbLjfyc7Cy
         LuWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787688313; x=1788293113; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h+J+586COvgQPudoMvrhJcpUXrpsU047dA3KGtpBFOA=;
        b=ipLOlH/BZh7Nyfk/vBMmgm/AMj2kZPvS8FATxUL0Bl5beNEszx2C1pqbUgZEXVV3CL
         KbyNp7GqJyL1/T3d+SYsaLJFvoncL9Eec3eA1p3xva8XHNM9BpKuw7XHZj+y44w6mMJm
         uNnWm0QCMCFL39UwiAXnF6BkvlrZkVVzHZ4Kqd0I4hkkaTsP//zFKHngjA15UktNY0GT
         a3KVoT3gtpxCoFxxDoDvV9f+1sneHuE0tNVOJlLJkMlg0UXct1O3eGd3omfxv+VNi55C
         E9RapX9LDK2Agtib5A8KJwJ5Tp6GI3URxahSqnp1iYGVHUz4D8RkfhEw4wYtYwy+0nlG
         jkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787688313; x=1788293113;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h+J+586COvgQPudoMvrhJcpUXrpsU047dA3KGtpBFOA=;
        b=nmTxMoMZ5rGQKFzFrhKKfCIxpzAn2EFoBjJDKHMurAAoxGsePNY/2bNo7663B3P/Mu
         EXoCat1s/AXjheOqbs5/6NZQVxud/Ufuu8lQ0CEXhFMYFbfyST3nKhV5LLYk/Mwa6B+g
         k1DP4bci9uSHKGUOrze20TjoAmOxMOLE98bWdCQw9nnAVn0L1MxqTJsWDH/84nqEeY60
         r0E1euYWVud6P0RBF5tDHbQ/jMyzqxSQY8ZKet2tOrnP3qE3ipopXqFjbCQvjJ+PqlY/
         NbHUuJpEGimu27qFhcL79Xadfrwtw2R8il8hekvh7SPHQOv2jnY5anpojdcO3m/UlO/P
         ipsA==
X-Forwarded-Encrypted: i=1; AHgh+RpQDfogUhHHysaxL0KydpuCJUfSCWCmFSR/3AHsq5b6zUx3x7Pfi9ozOBpSlphVWogjGS++KOL0x9pIgA==@vger.kernel.org
X-Gm-Message-State: AFuF++kjABY/ntx4FkNOWX7Ekoi4HRtsddoGofoGic9ebGqUnURKUXOg
	eIn0nn4PB5A3KD6j5RHdNAdJpJVqxU/gAfJuwMrsUtWYptOZRoQeoHi6hAORuj7b609Y7kNjnWE
	V0ZBS5z1AouSdHmhe7REsaq8CoLgq3c4=
X-Gm-Gg: AR+sD121VWrMASsjBte83sXYw2qkRpbVj41PbM6XKx9OAqgyTe68rH2V8LGjFh/qQGf
	hzU0YOvrC6Cm6toXu8Hc0qLIgP2/Wrr8+E5HKYL7EUaP/+M3Z60Rv08Agmp3yrIOf4bZhsTyT7S
	t8Y9PmuOZfduls7gyEgNZagAaqURWq2SDdTw6fPwIM+RbEelngbiyhTcFTU0VrHhFa9GoZDUo3b
	Y6mEch1VkaQKYRNq5u6TdacM8pzp6U+QMK+JsH7b3GlxFsR0/GU4EfROyIAtdHCphZE3gXtrdK7
	yc3dFzbDIM88w91sl+M2aV+isq4VFpCD3BizESmJ6VKzxA==
X-Received: by 2002:a05:622a:490:b0:517:63df:91a5 with SMTP id
 d75a77b69052e-52e2ed34ebcmr100122051cf.19.1787688312869; Tue, 25 Aug 2026
 13:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821214810.87826-1-mradityadash@gmail.com> <20260821214810.87826-2-mradityadash@gmail.com>
In-Reply-To: <20260821214810.87826-2-mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 25 Aug 2026 13:05:01 -0700
X-Gm-Features: AcwNN1XP1W754hEVld-Hp8Kl37L7hABLz7J5OXzrCLQc3YiBnlHQLJ8bQ2RWfUE
Message-ID: <CAFqHKTmPXzoMLMcU2O1b_DQDmb3uuq2soz7Nk0bTECELsf9ZFA@mail.gmail.com>
Subject: Re: [PATCH 1/5] HID: hid-lenovo-go: use the correct calibration commands
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:48=E2=80=AFPM Aditya Dash <mradityadash@gmail.com=
> wrote:
>
> The calibration attributes pass the calibration operation as the command
> and the configuration command as the sub-command. This sends each request
> with the two fields reversed.
>
> Swap the command and sub-command values for all six calibration attribute=
s.
> For example, the malformed left joystick Start request is:
>
>   05 00 04 0c 03 01 ...
>
> The corrected request is:
>
>   05 00 0c 04 03 01 ...
>
> The bytes identify the output report, configuration group, command,
> sub-command, left controller, and Start action, in that order.
>
> Fixes: 995887a10da1 ("HID: hid-lenovo-go: Add Calibration Settings")
> Assisted-by: Pi:gpt-5.6-sol
> Signed-off-by: Aditya Dash <mradityadash@gmail.com>
> ---
>  drivers/hid/hid-lenovo-go.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index 318b1152ff8b..b8248bf8965c 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -1911,18 +1911,18 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_left, "ru=
mble_notification",
>  static DEVICE_ATTR_RO_NAMED(rumble_notification_left_index,
>                             "rumble_notification_index");
>
> -static struct go_cfg_attr cal_trigg_left =3D { TRIGGER_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", SET_TRIGGER_CF=
G,
> +static struct go_cfg_attr cal_trigg_left =3D { SET_TRIGGER_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_trigg_left, "calibrate_trigger", TRIGGER_CALIBR=
ATE,
>                      LEFT_CONTROLLER, index);
>  static DEVICE_ATTR_RO_NAMED(cal_trigg_left_index, "calibrate_trigger_ind=
ex");
>
> -static struct go_cfg_attr cal_joy_left =3D { JOYSTICK_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_joy_left, "calibrate_joystick", SET_JOYSTICK_CF=
G,
> +static struct go_cfg_attr cal_joy_left =3D { SET_JOYSTICK_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_joy_left, "calibrate_joystick", JOYSTICK_CALIBR=
ATE,
>                      LEFT_CONTROLLER, index);
>  static DEVICE_ATTR_RO_NAMED(cal_joy_left_index, "calibrate_joystick_inde=
x");
>
> -static struct go_cfg_attr cal_gyro_left =3D { GYRO_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_gyro_left, "calibrate_gyro", SET_GYRO_CFG,
> +static struct go_cfg_attr cal_gyro_left =3D { SET_GYRO_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_gyro_left, "calibrate_gyro", GYRO_CALIBRATE,
>                      LEFT_CONTROLLER, index);
>  static DEVICE_ATTR_RO_NAMED(cal_gyro_left_index, "calibrate_gyro_index")=
;
>
> @@ -2018,18 +2018,18 @@ LEGO_DEVICE_ATTR_RW(rumble_notification_right, "r=
umble_notification",
>  static DEVICE_ATTR_RO_NAMED(rumble_notification_right_index,
>                             "rumble_notification_index");
>
> -static struct go_cfg_attr cal_trigg_right =3D { TRIGGER_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_trigg_right, "calibrate_trigger", SET_TRIGGER_C=
FG,
> +static struct go_cfg_attr cal_trigg_right =3D { SET_TRIGGER_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_trigg_right, "calibrate_trigger", TRIGGER_CALIB=
RATE,
>                      RIGHT_CONTROLLER, index);
>  static DEVICE_ATTR_RO_NAMED(cal_trigg_right_index, "calibrate_trigger_in=
dex");
>
> -static struct go_cfg_attr cal_joy_right =3D { JOYSTICK_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_joy_right, "calibrate_joystick", SET_JOYSTICK_C=
FG,
> +static struct go_cfg_attr cal_joy_right =3D { SET_JOYSTICK_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_joy_right, "calibrate_joystick", JOYSTICK_CALIB=
RATE,
>                      RIGHT_CONTROLLER, index);
>  static DEVICE_ATTR_RO_NAMED(cal_joy_right_index, "calibrate_joystick_ind=
ex");
>
> -static struct go_cfg_attr cal_gyro_right =3D { GYRO_CALIBRATE };
> -LEGO_CAL_DEVICE_ATTR(cal_gyro_right, "calibrate_gyro", SET_GYRO_CFG,
> +static struct go_cfg_attr cal_gyro_right =3D { SET_GYRO_CFG };
> +LEGO_CAL_DEVICE_ATTR(cal_gyro_right, "calibrate_gyro", GYRO_CALIBRATE,
>                      RIGHT_CONTROLLER, index);
>  static DEVICE_ATTR_RO_NAMED(cal_gyro_right_index, "calibrate_gyro_index"=
);
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> --
> 2.55.0
>
