Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0804A4848A2
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792391788; cv=pass; b=WBxu+NmAv81zH/IszlnwAV3ftAuhP9I2IeahopC2h37KQt1QcM0MVSXYgjS5pVG2hv90a5poiimXrsgMSCY9K8qMUbTb0FzpblIsWm9HLUA8THCyl0XTEV9HqNf887HvHXDCapkq6TAVxFQ5w4N9aLFxRXCJJ5+NmRxwPmoUA+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792391788; c=relaxed/simple;
	bh=6oVEr/4KliyQPSxat8l4eE3P0YthzSqxsxoIP3vxxmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeRoKLcFzxr43SF6rKfvTKujNdROZuoH7QAgc94csFKPGNDp/hnhjUgtLb9tlas7uFIfYRgZW7gzMqi4lfbUWD8XVDvx7RH/7H4o6noTGHx1i6hHBXCMKsB9f35EFcvtWb4vHwC2YH+4O68sIAP1XnT9DWBBFeeHQ5WYfCdSb7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pm6bDEbU; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm6bDEbU"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bc18f54abbso1371407e87.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 23:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792391785; cv=none;
        d=google.com; s=arc-20260327;
        b=CSSYflN6KwSHIdYSz+J3Lufe77CrwhJi6OoAzaJXUdOJeYwMLmLIBGWXwEVhuoQF9B
         ZMzfcPl3bUJaEa67cunq4WxaEfO4jIggi2QaoGyy4wA2Lcv0Ca8FQZRxUB7eafPMz/2g
         6P/gQVX9JvZAlBRAXb8qAZDlV25/+OsPZ2HVBdFHCzKHZBxIy4V6/56HIbG6511dHWVM
         nBxogryqbYe9OYsovzXvY6KladefQ2xN1+njmmzCaegGkzpVgxGqdmZUIRTljSK2VMlN
         ywj0ah7I9w0LQPR9R8eSJgEQ8pMwfXXS06JsZ5/Hdark/umb/4PJl0S9AwDyQskfDrpi
         NaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U94c+785ttg3YXYwXun84olJnh2cjej2HRkwN79dUF4=;
        fh=WgZR5/YcWAiDxXKJFesbKCLpKkZgrB+1Fix4GpX62ks=;
        b=VwLV6zWXgIe40WDHAwnU3EmUFCpxd/9E17neoP/21cn4ArnEQr4hHhnKo8Sl30j2C/
         kXvqAUfaVeog3EI/A9ArUaUgV/6w02Oco6mPvK9VqecqQjDG+Qs7oTbCxVlD6cg6N7Sa
         QlCOw/0VoOOS4NJdYMXVeEFgJj78qPdJhMcAyy0NQnAAyztBCtgquAfbZEne6BrtaDfT
         a319ps8NO8S83+12Qi2kr0TnnCmUr46lGnH4ND6HUX1cI2cFHnH453hpaWv2i6cXpWPU
         wMumj0WHacP27oIdKvVNClHhETM8TfgCcbkgbWaMCN3hjVbl+0yoUHWpCpnk68hJjBr+
         28yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792391785; x=1792996585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U94c+785ttg3YXYwXun84olJnh2cjej2HRkwN79dUF4=;
        b=pm6bDEbUV6rthblB3gbxRDCIMQUatyQJSY56jtzPjl5gBqWFKjOLpe2UwOzxzrxsGa
         n53DtueNsYFZKhkFGQkRbW8keNd9hODPGM+WtU93muiA+a0eGdCatGlgRo8XU2rb6uim
         qPncImxRYF3DqiP7eyWkXJYOQgtunVS7NNBkP7ovUaRXOPaZ3f3a8Pc7+2s+D5PEHe+V
         456I+Py/M4JHBQCf8QNeKig3TonSl7uy2cJr6DxBYnEFsAFy9WuvXJ0+UBwXI6+wi5Hz
         Q4s/Ky/ojH7B3/y9hL8Lw9dqd5SxIjy8kggd383uUaFWzFLT0ykPrQotiu6UEAgSaqGP
         wnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792391785; x=1792996585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U94c+785ttg3YXYwXun84olJnh2cjej2HRkwN79dUF4=;
        b=lrEughfH9lrIw6agn7+A8JhQM1ebP0JyayXvky8DEn6ahYWc7EolnMmMoleMYRsb23
         I1ESIj6IS1izAc5el4dwixFe7hZAnNwfOFXjX+W/crBHRwVnBTeCCxFiwhLz7zucfbpa
         so1mKY+JeWZJXfz+rL8vA9//jKyJeWgpb4ywcoNYE+mhQjFuYVmbB7N8+FEjiAzrGXPA
         L39hJIf90GFFOGmVfJSsXb1ABwEXjdVpig4MyaDG06he4R99I7DAAK5fQel/ijeFakEh
         oEUcVssUuK32QQVbxIjVRv350RGLdaAJwt5t2YZF6BsSAD3M/498UhrmKXutYrsimURU
         tjvQ==
X-Gm-Message-State: AFq9FYInnbhUwLZDo2NeQKqBEPymL6MihB1Ow6yz9hqQhKVRQQk0ru1R
	10S9y7Xyk+AFibFaZNyFb80s/f+tgjhkLTDTM5AGEJOtxeN6NKF7LXOtHUdXkyGwoQGiROWrg1/
	SV7i5wGe4oiO5A++9f4Z2Dx7bnhXBLXM=
X-Gm-Gg: AYBFou1JASckmm4EUZGvTMSdbkaUwrjN7BejOoYAEgk3/injqhLaOxziuibbsuXvX9Z
	zrOw2uM98c7+1ixcWRklXSCealzpN9ZZvpT4kKSegUK37G7W6agOzrmiXaLH3IaC6aJmma0Nbbl
	ZmEUf86VYWBOepw3enL3b7yJB/tlkkYsEwRfgBysAFMnAav7Ttwq8vTWTair9yaTZmKwg8ZVJnU
	eVZFtvMXWO5QAR8IRINvdTrEsHR0tOLcTKdZr1Qyzwfo7zU0PsmA221dmNqnGFEvdslKfDWVYGJ
	pNYnccH5caT/qbQz0OCVKw5qY+gKOMkYElqEPlEi+GUeRbhfFuLxIJAuyKLcm6BVfVAza2t/VNv
	JGR4BvkAS
X-Received: by 2002:a05:6512:2309:b0:5b8:f0d9:98c2 with SMTP id
 2adb3069b0e04-5be50a65472mr2055004e87.30.1792391784655; Sun, 18 Oct 2026
 23:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930002133.10794-1-vishnuocv@gmail.com>
In-Reply-To: <20260930002133.10794-1-vishnuocv@gmail.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Mon, 19 Oct 2026 15:35:45 +0900
X-Gm-Features: AclHuK9fJIHNAGQ_7zL3gxv35C95pstuMV3JgF3k-f1Yjf7DKEdx_hICUUW_pCI
Message-ID: <CABxCQKsV49CKbvZ2m2556+P=+q-9DSMdanzXk_v-syzZ=uJ9WA@mail.gmail.com>
Subject: Re: [PATCH] HID: lenovo: add fn+F7 display switch support for X12 and
 X13 Folio
To: "Derek J . Clark" <derekjohn.clark@gmail.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Pearson <mpearson@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi All,

A gentle ping on this =E2=80=94 any feedback would be appreciated. Thanks!

Vishnu


On Wed, Sep 30, 2026 at 9:22=E2=80=AFAM Vishnu Sankar <vishnuocv@gmail.com>=
 wrote:
>
> On ThinkPad X12 and X13 detachable keyboards FN+F7 reports the Super+P
> key chord, which behaves differently from FN+F7 on other Thinkpads.
> In particular giving a shorter on screen display time making it harder
> for users to select their preferred display mode.
>
> Newer keyboard FW is now available, allowing the keyboard to be
> configured by the OS to provide the standard FN+F7 KEY_SWITCHVIDEOMODE
> code as used on other Thinkpads.
>
> Detect if the capability is present and enables the mode if available
> on initial probe and resume.
>
> Suggested-by: Mark Pearson <mpearson@squebb.ca>
> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> ---
>  drivers/hid/hid-lenovo.c | 71 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 66 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 3976d7b53b14..6b4b689c8834 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -44,6 +44,7 @@
>  #define TP_X12_RAW_HOTKEY_FN_F10       0x00000803
>  #define TP_X12_RAW_HOTKEY_FN_F12       0x00000403
>  #define TP_X12_RAW_HOTKEY_FN_SPACE     0x18001003
> +#define TP_X12_RAW_HOTKEY_FN_F7                0x00000815
>
>  struct lenovo_drvdata {
>         u8 led_report[3]; /* Must be first for proper alignment */
> @@ -557,6 +558,34 @@ static int lenovo_send_cmd_cptkbd(struct hid_device =
*hdev,
>         return ret < 0 ? ret : 0; /* BT returns 0, USB returns sizeof(buf=
) */
>  }
>
> +/* X12/X13 folio Fn+F7 reporting mode: feature report 0xa4, [id, mode]. =
*/
> +#define TP_X12_FEATURE_HOTKEY_MODE     0xa4
> +#define TP_X12_MODE_DEDICATED_HOTKEY   0x01
> +
> +/*
> + * Select how the X12/X13 detachable folio reports Fn+F7 (display switch=
):
> + * a dedicated vendor hotkey (report ID 0x15) instead of the default
> + * Super+P key chords.
> + */
> +static int lenovo_send_hotkey_mode_tp10ubkbd(struct hid_device *hdev, u8=
 mode)
> +{
> +       unsigned char *buf;
> +       int ret;
> +
> +       buf =3D kzalloc(2, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       buf[0] =3D TP_X12_FEATURE_HOTKEY_MODE;
> +       buf[1] =3D mode;
> +
> +       ret =3D hid_hw_raw_request(hdev, TP_X12_FEATURE_HOTKEY_MODE, buf,=
 2,
> +                                HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +
> +       kfree(buf);
> +       return ret < 0 ? ret : 0;
> +}
> +
>  static void lenovo_features_set_cptkbd(struct hid_device *hdev)
>  {
>         int ret;
> @@ -739,6 +768,10 @@ static int lenovo_raw_event_TP_X12_tab(struct hid_de=
vice *hdev, u32 raw_data)
>                 case TP_X12_RAW_HOTKEY_FN_F4:
>                         report_key_event(input, LENOVO_KEY_MICMUTE);
>                         return 1;
> +               case TP_X12_RAW_HOTKEY_FN_F7:
> +                       /* Fn-F7: switch/extend external display */
> +                       report_key_event(input, KEY_SWITCHVIDEOMODE);
> +                       return 1;
>                 /* Power-mode or Airplane mode will be called based on th=
e device*/
>                 case TP_X12_RAW_HOTKEY_FN_F8:
>                         /*
> @@ -794,11 +827,22 @@ static int lenovo_raw_event(struct hid_device *hdev=
,
>          * Lenovo TP X12 Tab KBD's Fn+XX is HID raw data defined. Report =
ID is 0x03
>          * e.g.: Raw data received for MIC mute is 0x00020003.
>          */
> -       if (unlikely((hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB |=
|
> -                     hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB2 =
||
> -                     hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB) =
&&
> -                     size >=3D 4 && report->id =3D=3D 0x03))
> -               return lenovo_raw_event_TP_X12_tab(hdev, get_unaligned_le=
32(data));
> +       if (unlikely(hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB ||
> +                    hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB2 |=
|
> +                    hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB)) =
{
> +               /* Existing 0x03 vendor hotkeys (8-byte). */
> +               if (size >=3D 4 && report->id =3D=3D 0x03)
> +                       return lenovo_raw_event_TP_X12_tab(hdev,
> +                               get_unaligned_le32(data));
> +
> +               /* Dedicated-mode display-switch (F7): 3-byte 0x15 report=
. */
> +               if (report->id =3D=3D 0x15 && size >=3D 3) {
> +                       u8 pad[4] =3D { data[0], data[1], data[2], 0 };
> +
> +                       return lenovo_raw_event_TP_X12_tab(hdev,
> +                                       get_unaligned_le32(pad));
> +               }
> +       }
>
>         return 0;
>  }
> @@ -1366,6 +1410,12 @@ static int lenovo_probe_tp10ubkbd(struct hid_devic=
e *hdev)
>
>         lenovo_led_set_tp10ubkbd(hdev, TP10UBKBD_FN_LOCK_LED, data->fn_lo=
ck);
>
> +       if (hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB ||
> +           hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X12_TAB2 ||
> +           hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB)
> +               lenovo_send_hotkey_mode_tp10ubkbd(hdev,
> +                                                 TP_X12_MODE_DEDICATED_H=
OTKEY);
> +
>         ret =3D sysfs_create_group(&hdev->dev.kobj, &lenovo_attr_group_tp=
10ubkbd);
>         if (ret)
>                 return ret;
> @@ -1439,6 +1489,13 @@ static int lenovo_reset_resume(struct hid_device *=
hdev)
>                         lenovo_features_set_cptkbd(hdev);
>
>                 break;
> +       case USB_DEVICE_ID_LENOVO_X12_TAB:
> +       case USB_DEVICE_ID_LENOVO_X12_TAB2:
> +       case USB_DEVICE_ID_LENOVO_X13_TAB:
> +               lenovo_send_hotkey_mode_tp10ubkbd(hdev,
> +                                                 TP_X12_MODE_DEDICATED_H=
OTKEY);
> +               break;
> +
>         default:
>                 break;
>         }
> @@ -1526,9 +1583,13 @@ static int lenovo_input_configured(struct hid_devi=
ce *hdev,
>                                                 hi->input->propbit);
>                         }
>                         break;
> +               case USB_DEVICE_ID_LENOVO_X12_TAB:
> +                       input_set_capability(hi->input, EV_KEY, KEY_SWITC=
HVIDEOMODE);
> +                       break;
>                 case USB_DEVICE_ID_LENOVO_X12_TAB2:
>                 case USB_DEVICE_ID_LENOVO_X13_TAB:
>                         input_set_capability(hi->input, EV_KEY, KEY_PERFO=
RMANCE);
> +                       input_set_capability(hi->input, EV_KEY, KEY_SWITC=
HVIDEOMODE);
>                         break;
>         }
>
> --
> 2.55.0
>


--

Regards,

      Vishnu Sankar
