Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793629383;
	b=RcEsPBel36OupLUoSvwK0J/nEzD4S8at9imDspMiGKjxA85Ciflnl4ytLUJdOpW09Bhp
	 k8omgPOAyTQ1Shrh+/iQi3hrykNvwBqKQzC2Lxcd6IBCAVeE+GeHhhMjgBCKdufuggRkb
	 HycwEGSQ1z3Q3bXawDAIcU7gl6spEgbjTTnb5igvXfJOAEwxsfP7KbjpsjUHrtbNOd9U6
	 +mQW2fzrJl05piIpJt5pAduK832d0FgKoITUnVhD2GjrvOdmo8b864oTXvzf2lyOV9/gJ
	 MWlVUsMTacE7jwcfItqVAEn/YTQ/voPo+ZL2v2cedbNGXFEBfYK/atT7H5CyeBAVSyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
	b=RbMiQ0eoi/6PXWENaHEayONR2QQYSQ5pKTKe2Ry85Ohi1vhEiUIA+NlAy5hmwtcftO4I
	 zh0aAv1LUrN8wI/qEa4K8cpnjE0uivL+WA8LZBBkA7LAZ1Q3pxMGHIiVVK+2TsJHR+OZh
	 jgdLlBEZUoKctt5qG5GzV1arvvW19SsCOz5/yaWVDUKFzpE58vyHvwalncxBR/MWt2rXw
	 LCKtuGWOEVQVb6iefQ42m3ArO2sDca5RZ7D1eGwITyz9uXNHToPp5/F2NLMa0FLIVTuEf
	 cC/3Zw+duqm3oVpibP1RBS4SfFjlUjhLAly+WRoKCaKIRy72+9Q10kTB9KSUo/AA26w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I5x7qIGW;
	arc=fail smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDACA60A2613
	for <linux-input@vger.kernel.org>; Mon,  2 Nov 2026 14:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDACA60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I5x7qIGW
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c79a9a739so49724806d6.1
        for <linux-input@vger.kernel.org>; Mon, 02 Nov 2026 06:23:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793629382; cv=none;
        d=google.com; s=arc-20260327;
        b=XUXHdcLkH/TE4RK/fpN3izRRfTeYYoik7TFA+YXQqP5zIa+u/ZV9LIgVe8T8EB5q0W
         4HIOHdrGkCq7DaKbp9C90aEu6R29e5fxRMjkscRQWNk7URdlBDF0Lmw5UityOjZ13yiB
         mdfCo3eA2xy7wzrCdgPXp2D5PfAqOZwXhG8w/0LrQEQQT28uH6gHEQaMuZAI2XVE/zNY
         E3Wr6ATDO9/2Mru0DK8aWkzPpUBpcuu4Ep2VcHVCgynUVwsFTGUthch/CEETxp1HW0z3
         4RR/ijV2pgazbsZvn/dpF6OJERdOyKq7P2XEf+KPh1aSvSMwA17fvxZLKIRcipgKkTRN
         bw1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
        fh=Zg5xBUu3IzU4WrZEmJ47kt/w+c6GGGI5UPKSApixvUw=;
        b=mKfKsQi0bZsBk4LVtXqMxu+gOKQfeMPUsu+8DSzpa0i8kcJRHcrSw0ZxDubIv1R1XF
         wNLab3IeliMuUXCmMN/KOs4l0ziZuhvDXrVb1f2F9vwjVfDKUW0ZUZnnrZwsOzXUmauQ
         iPTZBi4I9IB2027ftOL799UX7dI13cG5Fk5DbAUwKq7AC7QuMIzgpFpHpNRfRW7ZTuQY
         +UCyhfp2eMXw8tii793MnWPyE6wTVbD5FLdo+B5wUgR2A9lAqF7YhUbH68cQMEPD9g+M
         2YW9kq9HI72lCdtFDbJzIV7AqQRxDA3lGpy9s1um40GBgO5aOHFjWXvm2GGQ3iro0IU0
         Sg2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793629382; x=1794234182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
        b=I5x7qIGWTsAsfBWf71taDZbRlUUaYCG2iAGsyK7dWndyX8PF0VEktAOe3+XdQMCNnn
         TBZ3rZmTyRKlBo8mXiaPVVz2takyoI4yGmsQNCJDi0waYa6MRwyO0xsSXwTVHPpcLHrQ
         EuF+Z5O316PvlCsze993jBk6PNZ752f4/PHaiYLawgqLEUCIcOxRmSmWKtO1gycmyzBn
         oWjstQPbA8hAo9iAh8ZoQFDFflZp+sobMnmGafMi45kKM8djdRbnhuTD1rltWlU7wajg
         pBBV5sSGs1bGdhsHE0xQn6zYU3qRBgkrKAiAruouuTLmMJZud4rfXYd8JP4Af18wYrhP
         Kh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629382; x=1794234182;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2eoSP0yEoTlChnuRvtczHJcCT/7hM/Jtun8ZUxsvjQg=;
        b=lyqeM2k07YRYdCvv0uoFHm7soEydMBtKqdO2SaoOpud4C7J9kPHBq/j8XpCYnoeMGP
         zJSZWfpfwfOGmLHK79AVXjZ8+BIQy45j86qv0fxVeGjMHidum0veNDDSFZIx3gEMX9Tc
         FCFy2J2v6117EpUUrTVxy8G3BOZqnU5st7rIE9wd7WH0zBCbkoCIxFDU8/S6KnIkaRvc
         qEx1KIEj3KYNVg1pnK2kw0l7qwEllHZxbUcOSXR/7cwAEopgXhiBGyOs9RjNVjSAOmj6
         mNQaUv0ffF/aLRhxzUrh6YVpIwHOxx82u06cYUkT6BwLp2LGVbVac0fi7w1Wuxo2f/mR
         1tmg==
X-Forwarded-Encrypted: i=1; AKwUvBzn4Ci6JpKxiMj6PvnYL2IIw3x4HIXxyMhjd4JTkSE5t7sfc6CVz/shCr16ah1l/HQHdIFVVXgA/qmZ5g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9MhbXiHQ5wl+OxqBKy4cBNovBDjE4DXc9FK1yn7HZwJlXMUZWO
	oMAYN9lcLzTgp5TQ7X4nrHnTFhmT3z1OHGBguhFUa5Bc0ftKSry9oNs+1c/zxAVQ8P7WuIG059+
	tfIXomYB5VJf3Kk3OzaNkQRdIOtgpR6s=
X-Gm-Gg: AYBFou1si2KEeZoNrizJjmI/Xe0t5qkxxOJVE4amEVRIiEt7y2pSmtMlauO7vWnEzRT
	WrAKEDXO/3bDFgogD288oNciTLUR7jRkSANHZdIjH/cWmEyeXHpoZQfsuHlf+QqNSgXf1CpZ7UY
	j9zQa80w71GzUAWkcI7hzcY+RjdBv0cSHFPr+CGN0kovxqoLKXPYFMzZnFjSXI+U+0OypdKfu/0
	5/Tj26VQSbZqevQVN/k2/TtmdIEj3mQfyzdd2lOJ60wPnjAWZLfjVTza2Ul5OGMhkrzRiopgPNW
	F+/K0sek+rOS9KVwZHXzQDAAE/Lw+RNpFTTdDabdG0TALSFA+fToLbhQtGZWq+bEYoJqFG8dJE1
	c5uj6RxYAwLz3MgaROtDr62hB5CmyGl/iosSqrQ==
X-Received: by 2002:a05:6214:1252:b0:917:7d92:6486 with SMTP id
 6a1803df08f44-91ca4a0c511mr173181156d6.6.1793629381607; Mon, 02 Nov 2026
 06:23:01 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260824184019.432703-1-max@enpas.org>
In-Reply-To: <20260824184019.432703-1-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Mon, 2 Nov 2026 06:22:50 -0800
X-Gm-Features: AclHuK-al9_fk_gWf3tmNtTa80C7h_iFVOnR-naeSMTklj7rwoY_cjC4_EB5wQY
Message-ID: <CAEc3jaD8W0CZ+V06c=S2V8oR+UwFVKd8KGbtNhzBm7Gv5XnM8w@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND] Input: joydev: Don't expose DualSense motion
 sensors as jsX
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max,

This looks good to me. It was an oversight from when hid-playstation
was added to not add the filter to joydev.

Signed-off-by: roderick.colenbrander@sony.com

Thanks,
Roderick Colenbrander

On Mon, Aug 24, 2026 at 11:43=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> Without this, DualSense (PS5) gamepads are allocated a second jsX
> device for their gyroscope/accelerometer, confusing programs such as
> /lib/udev/js-set-enum-leds which look at jsX device numbers to
> determine the player number. Ideally, we should have only one jsX
> device per gamepad.
>
> This follows the schema started by:
>   commit 20ac95d52a28 ("Input: joydev - blacklist ds3/ds4/udraw motion se=
nsors")
>
> Fixes: 402987c5d98a ("HID: playstation: add DualSense accelerometer and g=
yroscope support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/input/joydev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
> index 32459fd8a7c1..f49dd10782f0 100644
> --- a/drivers/input/joydev.c
> +++ b/drivers/input/joydev.c
> @@ -753,6 +753,8 @@ static void joydev_cleanup(struct joydev *joydev)
>  #define USB_DEVICE_ID_SONY_PS4_CONTROLLER              0x05c4
>  #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_2            0x09cc
>  #define USB_DEVICE_ID_SONY_PS4_CONTROLLER_DONGLE       0x0ba0
> +#define USB_DEVICE_ID_SONY_PS5_CONTROLLER              0x0ce6
> +#define USB_DEVICE_ID_SONY_PS5_CONTROLLER_2            0x0df2
>
>  #define USB_VENDOR_ID_THQ                      0x20d6
>  #define USB_DEVICE_ID_THQ_PS3_UDRAW                    0xcb17
> @@ -793,6 +795,8 @@ static const struct input_device_id joydev_blacklist[=
] =3D {
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER),
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_2=
),
>         ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS4_CONTROLLER_D=
ONGLE),
> +       ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER),
> +       ACCEL_DEV(USB_VENDOR_ID_SONY, USB_DEVICE_ID_SONY_PS5_CONTROLLER_2=
),
>         ACCEL_DEV(USB_VENDOR_ID_THQ, USB_DEVICE_ID_THQ_PS3_UDRAW),
>         ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_PROCON),
>         ACCEL_DEV(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_CHRGGRIP=
),
> --
> 2.47.3
>
>
