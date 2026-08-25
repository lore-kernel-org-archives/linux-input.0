Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F9D335066
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690423; cv=pass; b=TSmwsgdQeWS5vZ0v9G8xgALRkxTK42LabzXzTZ/9w9/WwtuCyiE8y+98GYM3n/rXBVhbDqzLeSazIuqEWSumYe9St2B6H3kiYHr51kN6S2ZGObKQ+3FPEUMsnFEK5CTNH5gEGxdMnpZm9sTKKBkz5LWCBnCZn5uFJ8sbJ3x5X3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690423; c=relaxed/simple;
	bh=AArwIUhkBE8lVKRLU59Y3qY/f2Dvr+7whqUkIFyrn0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsK//XGoWSpuSGioNf8MNNRUNP8RNfDkSfXcBdzyYJCEfCj0Bkao5Tw973PMLcslV8pLz33so1L6+c1CB3ofTfEOYb8vG3cP8UbcdKW4K5vyN/rEULIRwVivZRDM/XLscTJk/nr3cPKyRdjBjsd0xopP3HoypBtnMBkd+StTPGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kgc2uOX9; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kgc2uOX9"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-902e4af2d9dso9238766d6.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 13:40:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787690421; cv=none;
        d=google.com; s=arc-20260327;
        b=htcPwyp2FNi14vFy/X+uQ2rQPKW8KDk0xAlMW4VViwbWFgBC75f2uneHDWtagxz6bc
         Pyfh9sgSOLmKh6IfzbvHPCDIcVcouc8J7aYAZ/HpU63Inw7m9AOh/gW5ijQZ8vLHk99O
         FLbwa3GumqI1WNarqvvPyEgsm7HEtMdwRxsU7aDwNI5Chhjrw2dfoA2mUOkDzPXpB44y
         AxBG5W6MZaCn3btF1DPUq0+g4ME54rKwz+m5WPIAH13V/k4JV21HhIGhSdntTjAwaO4+
         UR1Iv1xcNpfCSyaRzzJOODtvRnPL646ij5/ZzrEh/67HPHDALwqHLcAlKUFoZ5GulnVN
         Q3Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dj05ythan2rJXjfpopyXX21G+CzGRzMKX3bDMY1+YfM=;
        fh=yH7yGZIqHnKxievRBAOR4hQmCx0gDrMqcRziFjY9Q/s=;
        b=TXPbIPhWFbEkzTQ66vHV1YPzNugipE8MBhpeZzVScMZbkVbucPepWsXycvNXyc0TGP
         5XibgWy4iRDrMoM02IOzAIhPpvH41k7gN/mhSlD7XXLyX9IXpn2daETPV8zcc44RNdm1
         fadDr9swlwh7n0iIeO6RwV9m4EnLA8jU1g3KaFRvhu3ZHyuMfCfq/+T4hxBQdNyho0Jw
         4SDpuOPOwIRG3lw1qzbAFVbkhMr43fsnBXvMnPpl6BMpzWp6AYpdm1rGD6ZgUF+embmP
         ZJdwyGEt4sVtuEloRUlFM6/PVIXoMwT0fuKXUI0vFYHiofgE38dctmEjhalGXqgK7a1W
         w+XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787690421; x=1788295221; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dj05ythan2rJXjfpopyXX21G+CzGRzMKX3bDMY1+YfM=;
        b=Kgc2uOX90u/2Ah2BkkFEbgSX5b2qgb8ng7e2VYolf7Lw0Bk4PIgk0TS7ArWX6A8QAi
         9cnjYRYkflj4pM74zyBxJRFgIs1NEjs5viPutQ/Ip0qJDzjqrHfWMQS4e/8E9NOFlOzR
         dhJEprP5EkQzE0mEe2fb49ZfdrQ8GZLL6Pxb9LROuuZgGA+UGXj1l7XSrBo3KcZPmowh
         QXD07juQM+uXaOi06KQwx89LJiCCvrKv0/yJQvwIns8oJObbnOamYdtuJbRsUHC4ZPD3
         OgsUGCHZo7BPyJt/hh6cqJpY54urdNT4M/bPBla4+ygS0On/uA3sZOw607UWHnC+6l98
         bYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787690421; x=1788295221;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dj05ythan2rJXjfpopyXX21G+CzGRzMKX3bDMY1+YfM=;
        b=fx0T7l7B3UQYzC+kBQy9NCvLV7x8TrxOxLwFd44ouAMUCGRuBs6pObXLLxIR+slKGv
         +sSOT3ebLKwfMNiurJ41xGBwevXIjlMkpyIRDTKSYMjRz47Ut0q4lIJFKRw24iNW+yHc
         7SKRLDSXiSdZsj9f4ZaHQ/l6BPFkCShelFIF8PZFj3YcK43h4GVsfmGA/GohSGausoEk
         MMDXCRZcv0MY6dxiT++KwxAZzBxF3uL82ZawKXjn+jWTTV47TB0ZykgMd+tMhzztkcvo
         6z9nZxRksCv1YKqCWGYt5dbE3vuzgg3kAYORZ1njamENCVmAj50C/hCkuLghKqQGRpzz
         c9zw==
X-Forwarded-Encrypted: i=1; AHgh+RobEiFPxvWUWeAQB3kmN/iKqXM0HoHTnfOzGm8qh92oRBKrTNh14eKb1GP901+sgcUvbjjpx1wmxBkMkA==@vger.kernel.org
X-Gm-Message-State: AFuF++kqNPZ8E4mHOkI4B1FFrOlwsb9nlzV0pPOXFnVYtM34emOqcfHh
	KLoZnam040NZHH63QXZ/eq3XoWFuBjevZss5ZAiVYbTT10Gz0AuVYbTTHgtJjyHsQ7/BDd/dxEU
	Ub3N0vq+0SMjJfLJEqrH/C+R2ijfh71U=
X-Gm-Gg: AR+sD12okDts1zDsaYZTRCEFqYdca11y2/Xn1E+7TpS+b57jP9XI3WZvIj6owAFPSgk
	CUBEnbJPmoSPSt53T5oASjpTlG78E4yl6F2H+axjNgCsC32ParHy15pRK0eZgLGf1lu03BIMvXw
	r+ixLpAoQIOOIp1dN+FxI7iVU/3sc58BCl2tZWcm37NYsj6ItB2TaXuNnBPyRUcgM2vVijCKhxa
	LWuEYkthiEKXs2PI/OVjgK2hISJXi180Vy2e5OCQrMNbERMdtj66pSskKPCcIubie9l/6m3OyTE
	ls9NYIWVLmbj2In7hnYdMELUyZrfvBsapshQwMUPPJHgiA==
X-Received: by 2002:a05:6214:21e6:b0:8e5:8d7b:5188 with SMTP id
 6a1803df08f44-90cb60dc3d5mr97981666d6.9.1787690420804; Tue, 25 Aug 2026
 13:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821214810.87826-1-mradityadash@gmail.com> <20260821214810.87826-5-mradityadash@gmail.com>
In-Reply-To: <20260821214810.87826-5-mradityadash@gmail.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 25 Aug 2026 13:40:09 -0700
X-Gm-Features: AcwNN1WDXT2XyzS5sr19VD2tOTeqCcFG1NBFYeNLYvdSUoWBodw2n0X9Kezp--8
Message-ID: <CAFqHKT=SYHBrp3pu563A0AwM7ONAsWeXBkfVde2Y+G5w5k-aMQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] HID: hid-lenovo-go: use the right controller selectors
To: Aditya Dash <mradityadash@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 2:48=E2=80=AFPM Aditya Dash <mradityadash@gmail.com=
> wrote:
>
> The right imu_enabled attribute selects FEATURE_IMU_BYPASS, and the right
> reset attribute targets the left controller.
>
> Select FEATURE_IMU_ENABLE for the right imu_enabled attribute. Target the
> right controller for a right reset.
>
> Fixes: 82cd9bc866e1 ("HID: hid-lenovo-go: Add Feature Status Attributes")
> Assisted-by: Pi:gpt-5.6-sol
> Signed-off-by: Aditya Dash <mradityadash@gmail.com>
> ---
> The corrected right reset and right IMU writes were not tested on
> hardware.
>
>  drivers/hid/hid-lenovo-go.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
> index d2d134873dd1..1e6915c969d8 100644
> --- a/drivers/hid/hid-lenovo-go.c
> +++ b/drivers/hid/hid-lenovo-go.c
> @@ -2006,13 +2006,13 @@ LEGO_DEVICE_ATTR_RW(imu_bypass_right, "imu_bypass=
_enabled", RIGHT_CONTROLLER,
>                     index, feature_status);
>  static DEVICE_ATTR_RO_NAMED(imu_bypass_right_index, "imu_bypass_enabled_=
index");
>
> -static struct go_cfg_attr imu_enabled_right =3D { FEATURE_IMU_BYPASS };
> +static struct go_cfg_attr imu_enabled_right =3D { FEATURE_IMU_ENABLE };
>  LEGO_DEVICE_ATTR_RW(imu_enabled_right, "imu_enabled", RIGHT_CONTROLLER, =
index,
>                     feature_status);
>  static DEVICE_ATTR_RO_NAMED(imu_enabled_right_index, "imu_enabled_index"=
);
>
>  static struct go_cfg_attr reset_right =3D { FEATURE_RESET_GAMEPAD };
> -LEGO_DEVICE_ATTR_WO(reset_right, "reset", LEFT_CONTROLLER, feature_statu=
s);
> +LEGO_DEVICE_ATTR_WO(reset_right, "reset", RIGHT_CONTROLLER, feature_stat=
us);
>
>  static struct go_cfg_attr rumble_mode_right =3D { RUMBLE_MODE };
>  LEGO_DEVICE_ATTR_RW(rumble_mode_right, "rumble_mode", RIGHT_CONTROLLER, =
index,
> --
> 2.55.0
>

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
