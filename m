Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8123ED5AC
	for <linux-input@vger.kernel.org>; Tue,  9 Jun 2026 23:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046364; cv=pass; b=j4TrtYdCw+36RYUiRtHGyljCiZp4tP//SE4y+qHPYwWc/jTneDPOJi3A5Eiya0kTilBfirMrBFhdEY5h8oq+NFOIdCcHjuejHN7moY5Zuspx6ND5p2CFbkVfcRfxD2gAlAIYQLt0ezOKPHFIOJftkGByvObiAdsDwYR9ZpYF/uY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046364; c=relaxed/simple;
	bh=eP8aHE2i79nL41i6V2Jy0Kv0JsteCe392JNrRMHs+x0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nk0q3Z5ObmUWZ2b9hfmnVlDVbWArkOIDmtgAxYphBb+KMT7U3tqwtvn4znblB00c+bkfS/wJp30DFBTKU2EZeRDaF1HlZ9khkrunfgH+4aiNcA5U4d+xX4nnzKDf3ZjR7gLKVy8JUTrHJkVEiQFpjV4CTEAi6B//0gDjobTkWb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAH1lcdg; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAH1lcdg"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39697a4e16cso58010801fa.3
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2026 16:06:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781046361; cv=none;
        d=google.com; s=arc-20240605;
        b=BAkf0Iue0N6i8bXnbXGnMPR9+tKhYOZTIjrQK8O1BixRn/I5AyT8Po9goYKa4Lu8Ir
         K9IIl6OgStRqhVs33sImgaO17Zwswll4RgGjeEGWNtEarN/g88RDgthbriHSuDXAvG9i
         dkNksnwmFgq97Wd8Ms7ufDwKVrIsQgtVy2Wmk9YHx+NcqqjQiQgjqnRIX1nkzjoic0Tg
         Iv17/+ZuCCt91fkZoSX631cpWXQYKAE4qrNFErUvUXeXOdLXa1iYXxHR+vdi+wc9yjjG
         8paCSViY79+mS+VLsaxoyOzLNVcjaSiX3yI/FfG/mYccVrKCKzAN0w44nh8iNAqbcV5b
         MdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Agtfhe+WClJsFdENh+WmY0xqAJXLc4EKjDj+0hTX6jk=;
        fh=30aFSaQRn4WTFjJBhbPzbjDgj+qdePolAgWMnkmu7QQ=;
        b=dFvlYhNTcvn+MrAY28a8v9aLdY4RlXBwqqrz4LXzG9lcZ0TfDU2wQkDzGXp4FNO/45
         O6SV21/072vRfOJfZnKSg6479rz7fGyjImeMxfWB3icFNgIyVFUaptER7vm95bs1YGq1
         YAEBWl87qjRql62ndoUTqV4+4/ZxcwyyADhrN67ZYJ1x7nacpmgmiWVRHE0UZwQhD5Ru
         ySk9DepCS7h3rZ/Dpt4y2ryCCMsCJYut3IxU+/f3PIEN1h1l+cqoq7auhK8TFzt5DA6r
         g/Jo4iX0oRw/sNAdCMizEQa4GGfiuSdsothrWZYus7c7UcCDAAy83l74pJNjHtSQVLc/
         0U1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781046361; x=1781651161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Agtfhe+WClJsFdENh+WmY0xqAJXLc4EKjDj+0hTX6jk=;
        b=BAH1lcdgCt6IO+ZO14Ki76kLmOhRlLC2ePoGskAFk0szoVeCW23bhbI7UhyeGr6E7u
         PcnRdcFzt6N2Zr7KzUO/6r9Vz38mKmpZPF8KH+vwZSZWNOtjKwmVVaUijyduGv5apPOf
         +o5ZR5ufSGEOYRgTkWEBwgDcIBMVbN2L6tRZR5oi6qSS21v7hYE9qr/11WNgSm9Iuot7
         pI99jZyFB7kb1Rwt9/oLYieIBNfwEfYrik+o10wqKuLkvM/55zK/mKfIRwPicjOad2uS
         jvrzCmT98g+TKStPPpUyHn5/rtqLfQG+nAnRsctcqhYMo3IsP4gdnvNBTFqHb0zkyM11
         pbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046361; x=1781651161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Agtfhe+WClJsFdENh+WmY0xqAJXLc4EKjDj+0hTX6jk=;
        b=mKKzw8SLVK71RC3GZkMBStqvpynwWeK32+zrFmP5xUokWhE9TayVkd078qfqiigQHc
         YeS+GLkhybfVntPu1qjzS2+GxDVxCFsWCRH+eZfJdf6wpy6ktI8lb7o4fB2o2TS7kIMa
         vYKhmDrLYqivqqtCeeQ9ReAqLn/pdvbYHP3efluykVY6/Oh42PRIEufx462o40UYPMS2
         uMNz/J+4Pl6/v8Zv1RJVWtmErUfsYnCm08U5o5ute++SuOBtDvXQ1UxPHeRONI2s+xi/
         oE8nNhXdstrKnDfsPPDaP6BujD2JwGoZ00Lnr1dVDgL8HQX1idY+xZDPXhyzo2OUH5T5
         dRZw==
X-Forwarded-Encrypted: i=1; AFNElJ93nLb+qIQ6MMRoZNL2/SHIAk7xEpjATfiWVF47SnTUMCtm9N5rTepyJiS/4YlIMKFyp6CW+FRTdoYTZg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3Ce7lWyhIFRM4bfVCvUv2UvLwNWZNd+8go6vzZIhwgCXQoV5
	4pYz74ZjrTZNYRw6BFp4DvLoRrmdCx5J47saYD85OYPCFN+R+iKRQt7CHrGtpF8n/yOYW3jgWXp
	ffDN67mc6Lp2c/MDiIwMzQtHUL0KEo6o=
X-Gm-Gg: Acq92OF7X6389iU2n2IBYl0O6z1whhSDGM3+wiCo32QtT5Uv7BennX4Qq6pbyvUFkrv
	4fY4xKp50U42IxlVLGpKLzTIpCAC83UUB7NP5P34Im3nIDeEoltjHLvHaLSxxH6ZBE1RDANDjqP
	bVcEyr9K2iP8ekNhtFAREYRSjyswx8Ivy78FeiBrFUpv/BG2KCwrJdNYkQz1YYYWXOaR3f/rUWk
	hpWm7hef9lhCz9559mffep+jrtiMcqFhQjMcp4+/3I2YNSaiQQMalSHqtGpG9UDHAfD8LNvI8Ut
	cT2kWFYDwRLihms1KhbJq8p+JLXEWVFfp4XVo1riyyrzjthuHP8=
X-Received: by 2002:a2e:a581:0:b0:395:6085:a15f with SMTP id
 38308e7fff4ca-397f76fc64dmr14161411fa.9.1781046360275; Tue, 09 Jun 2026
 16:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522050632.8079-1-vishnuocv@gmail.com>
In-Reply-To: <20260522050632.8079-1-vishnuocv@gmail.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Wed, 10 Jun 2026 08:05:22 +0900
X-Gm-Features: AVVi8CcmJVVWP2MwgD-3UUeJwHl0PUCARPZL712jLev4nxuGRWvclmqUvtUep8o
Message-ID: <CABxCQKtr1g8xEg_EYEQhjsgAR7QtSQ0dDQhOAByuxvHBeHK5iA@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: lenovo: Add support for ThinkPad X13 Folio keyboard
To: jikos@kernel.org, bentiss@kernel.org, derekjohn.clark@gmail.com, 
	mpearson-lenovo@squebb.ca
Cc: vsankar@lenovo.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri / Benjamin,

Gently pinging on this series.
Is there anything blocking acceptance or any changes needed from my side?
The series has been tested on physical hardware.

Thank you!

Vishnu

On Fri, May 22, 2026 at 2:07=E2=80=AFPM Vishnu Sankar <vishnuocv@gmail.com>=
 wrote:
>
> From: Vishnu Sankar <vishnuocv@gmail.com>
>
> Add USB ID support for the ThinkPad X13 detachable keyboard.
> The Keyboard uses the same HID raw event protocol as the ThinkPad
> X12 Gen 2. The functionality stays the same with X12 Gen 2 Keyboards.
>
> Also declare KEY_PERFORMANCE capability in lenovo_input_configured()
> for X13 detachable, allowing userspace to discover the key via evdev
> capability bits.
>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> ---
>  drivers/hid/hid-ids.h    |  1 +
>  drivers/hid/hid-lenovo.c | 21 +++++++++++++++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 4657d96fb083..064be2333a00 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -874,6 +874,7 @@
>  #define USB_DEVICE_ID_LENOVO_X1_TAB3   0x60b5
>  #define USB_DEVICE_ID_LENOVO_X12_TAB   0x60fe
>  #define USB_DEVICE_ID_LENOVO_X12_TAB2  0x61ae
> +#define USB_DEVICE_ID_LENOVO_X13_TAB   0x62af
>  #define USB_DEVICE_ID_LENOVO_YOGABOOK9I        0x6161
>  #define USB_DEVICE_ID_LENOVO_OPTICAL_USB_MOUSE_600E    0x600e
>  #define USB_DEVICE_ID_LENOVO_PIXART_USB_MOUSE_608D     0x608d
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index a6b73e03c16b..35b00619f045 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -504,6 +504,7 @@ static int lenovo_input_mapping(struct hid_device *hd=
ev,
>                                                                usage, bit=
, max);
>         case USB_DEVICE_ID_LENOVO_X12_TAB:
>         case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
>         case USB_DEVICE_ID_LENOVO_X1_TAB:
>         case USB_DEVICE_ID_LENOVO_X1_TAB2:
>         case USB_DEVICE_ID_LENOVO_X1_TAB3:
> @@ -620,6 +621,7 @@ static ssize_t attr_fn_lock_store(struct device *dev,
>                 break;
>         case USB_DEVICE_ID_LENOVO_X12_TAB:
>         case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
>         case USB_DEVICE_ID_LENOVO_X1_TAB:
>         case USB_DEVICE_ID_LENOVO_X1_TAB2:
> @@ -791,9 +793,10 @@ static int lenovo_raw_event(struct hid_device *hdev,
>          * Lenovo TP X12 Tab KBD's Fn+XX is HID raw data defined. Report =
ID is 0x03
>          * e.g.: Raw data received for MIC mute is 0x00020003.
>          */
> -       if (unlikely((hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB
> -                       || hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_=
TAB2)
> -                       && size >=3D 3 && report->id =3D=3D 0x03))
> +       if (unlikely((hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB |=
|
> +                     hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB2 =
||
> +                     hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB) =
&&
> +                     size >=3D 3 && report->id =3D=3D 0x03))
>                 return lenovo_raw_event_TP_X12_tab(hdev, le32_to_cpu(*(__=
le32 *)data));
>
>         return 0;
> @@ -877,6 +880,7 @@ static int lenovo_event(struct hid_device *hdev, stru=
ct hid_field *field,
>                 return lenovo_event_cptkbd(hdev, field, usage, value);
>         case USB_DEVICE_ID_LENOVO_X12_TAB:
>         case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
>         case USB_DEVICE_ID_LENOVO_X1_TAB:
>         case USB_DEVICE_ID_LENOVO_X1_TAB2:
> @@ -1161,6 +1165,7 @@ static int lenovo_led_brightness_set(struct led_cla=
ssdev *led_cdev,
>                 break;
>         case USB_DEVICE_ID_LENOVO_X12_TAB:
>         case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
>         case USB_DEVICE_ID_LENOVO_X1_TAB:
>         case USB_DEVICE_ID_LENOVO_X1_TAB2:
> @@ -1355,7 +1360,8 @@ static int lenovo_probe_tp10ubkbd(struct hid_device=
 *hdev)
>          */
>
>         data->fn_lock =3D !(hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12=
_TAB ||
> -                       hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB=
2);
> +                       hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB=
2 ||
> +                       hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB=
);
>
>         lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED, data->fn_lo=
ck);
>
> @@ -1402,6 +1408,7 @@ static int lenovo_probe(struct hid_device *hdev,
>                 break;
>         case USB_DEVICE_ID_LENOVO_X12_TAB:
>         case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
>         case USB_DEVICE_ID_LENOVO_X1_TAB:
>         case USB_DEVICE_ID_LENOVO_X1_TAB2:
> @@ -1490,6 +1497,7 @@ static void lenovo_remove(struct hid_device *hdev)
>                 break;
>         case USB_DEVICE_ID_LENOVO_X12_TAB:
>         case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
>         case USB_DEVICE_ID_LENOVO_TP10UBKBD:
>         case USB_DEVICE_ID_LENOVO_X1_TAB:
>         case USB_DEVICE_ID_LENOVO_X1_TAB2:
> @@ -1517,6 +1525,9 @@ static int lenovo_input_configured(struct hid_devic=
e *hdev,
>                                                 hi->input->propbit);
>                         }
>                         break;
> +               case USB_DEVICE_ID_LENOVO_X13_TAB:
> +                       input_set_capability(hi->input, EV_KEY, KEY_PERFO=
RMANCE);
> +                       break;
>         }
>
>         return 0;
> @@ -1551,6 +1562,8 @@ static const struct hid_device_id lenovo_devices[] =
=3D {
>                      USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X12_TAB) =
},
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X12_TAB2)=
 },
> +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +                    USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X13_TAB) =
},
>         { HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLI=
M_7X_KEYBOARD) },
>         { }
> --
> 2.54.0
>


--=20

Regards,

      Vishnu Sankar
