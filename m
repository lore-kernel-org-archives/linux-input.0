Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE72033A02D
	for <linux-input@vger.kernel.org>; Sun,  8 Mar 2026 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772957339; cv=pass; b=rqhOx4enfADI3hSvhCRJTvefgm3mYnXySXOm9ERMUSLL3J0xvuUIJi/7kWQSfamif31pCDXapers4LMprqZdDuU9AYafwaJ+ElK06ecjkeBc9N7vT5Y6R8F183gEaR8nMOFYi+fDHYZDCGKpniajiqZDNPQyC4Ox37pm3150IEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772957339; c=relaxed/simple;
	bh=UZenzo+3cCcyzWji0iBC5yLMpPeEoM1bQuwX5lEOfJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ecCkcEwvZtKso4vnapWUobxCOi8hAKeRyTRwQtQt8syTSTk2QtQJmjsMsMCdX1KeXQRMyYFHYL8qst52vo1/EZOR9FTRyaD901UVT3y+eCoB4Or1wNMVSyofKg5e91gHslQI6dKXUo7Fj7MrUZS/GutN6BOOBBv2pD78KxdvryU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLDTOknF; arc=pass smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLDTOknF"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d743ba241aso222991a34.1
        for <linux-input@vger.kernel.org>; Sun, 08 Mar 2026 00:08:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772957337; cv=none;
        d=google.com; s=arc-20240605;
        b=dhPnk6WpyLNibaxM7yB9cdPHOsY10xoRS2qg7ljetRDfWRx8zswP3MNoOb+zYRkgEV
         KrplDdZY8cZos5ha46CC68nrOe3NNmBpyi+TTwshKZFgw3Batm45CSyMgiTeXDZv6ax2
         X10cMOPBf6zfFIFGVm06xG+h8WY5PJSU35H7yC7FOVECi9z/L/j81J+E87/UrpcVf3rx
         h/bI4Q90GdNk20Ycn4s6kqHq1vF3k+bOd35AiAkCRyBiVEp+UQnBGG+3TM+6pZwjajee
         83rAW08aXeYUxYxYD0btAE0DMI9/6hE7oJugICeKvOMI6Df0+WXN+5O7GO/uGClPZt91
         7/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TyCTf8nQ2cY2kgY8QGVH6rSCTr0FIFLhe2KRl1SmTvk=;
        fh=ErGJs+zdv3AseMKb3l8WQsSle20+1EkJvTUGjeczRok=;
        b=YxceuPAfgP+CIBET7KQO+McfNwtfZHs/LJK3AWeY5p1DJcu97+lgB49+L2PA1ZU6vb
         eBMtxLLg0i65A4wlYVjOeF0WCB51MjMNeudVhVEWi28qsfouORubWlrqxic6mzeQSio9
         RxunRQZobGZPwkdoAaKXqQp/oV5RHkBSIqMxdNjbvEKUg/muRlLr2lvZs1GMOBia8yVE
         UpHHHipjlzCHHmad+n6r8SAVxNvGM7HOLbv3XBZt6IiedNU+dI7huKPz+qr0ByfU8AKx
         RWpvAWZhRGvByOQOIAX6+mDJpCVS+NKLliLMoDTjyJ2OldZRZga+FUpJHhtCOlWYbdP6
         +zpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772957337; x=1773562137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyCTf8nQ2cY2kgY8QGVH6rSCTr0FIFLhe2KRl1SmTvk=;
        b=fLDTOknFR4sw9SgOlIi9Ezoye+d3IuiytYAqVyOMZN3P8TogMbDjwgLa0aiDCkWLcZ
         RgHC5ZaPQQnNC1Gl13Fg8Qgcbwn4cxh6fFjGd98O3hV6Hsu/fMoG/+XHKWm99F5dqRbW
         Pjzh5IUy6rW1B3CW0/RZiclxY7JdTboUCFqggOiy1ZgBxekBPMS1BL5qCeOuO+Z0Ak9k
         wfx5JTlFZfLtr1fpHSWerGU9Put9xXSBLk9EivSQuEUfns05vxY0Zkl8TGIxL9/efG1j
         vWv9E99oXrLSbEcL+P2mdT3t/kFW8Rm6Fqp2XTEvvr2VYqX/BlGnfrRwMxoNMQoe+ga0
         c1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772957337; x=1773562137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TyCTf8nQ2cY2kgY8QGVH6rSCTr0FIFLhe2KRl1SmTvk=;
        b=DHRCVOUzUHmBR+/nDQemPKCKQCynDpjnJS8+cR1jYT1iIvr0+nUQk0CxYsg9pBsX4U
         io82wCy4kXz6IRyR7qknr5F2oXQJpkd57C3JRDD3px/eaUXkyJQrGT/ULtLlW6EVh83Q
         Ni/0/KXNJmu5dGotHcBOuK4ncaLQ8np/rAElgH2WUa2DDPqUE1q6sOJoxr7W9x6EqKRK
         wvzvydzu1Mj1ZnF3AqE4dKkQwmZJfvjBH78BtmSmRSyr+M9WXsZxQ+uLtjmqt3Yng0HK
         D+HYW2l0urOyC+FrGclbsLNTHkbyHeiMmJ7XK1PhyosO9Y5p/ipKrvqUYfkCl6fwlIuN
         fHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUClZmyq+pAsW2SyEXJV3Mw2cC/w9aXP8qNLcb0jPn0orRjUuP8qLjC5hViz0zflljVCEkUpD7TNPSSSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqUBD/t/L3CxO0E6jisSiQIGsWovvAfAyuOaTxIbghYowSP9l+
	Fdc9TGEoGRuhxfeIUjWeCRnHb20x+6SHViEb2HB94aHXK3GXIltqHmgz4EBNNgFwYew92tS1p8I
	7Lps4nh+n/yo1XQTlWgIbQnoY/hQP5aatPMBjm2s=
X-Gm-Gg: ATEYQzwlCIheAoEhk3oDUHvjznU4JihFhMUmcxaHS6YqQU55xmOycWaPgMs5ghcKOuW
	NISgrkXLzf5ghEWoQ47eynaPY7xJK01siVYJIeorGCwz5Y3F1th0mKq0vGyxPmGr5pCeAvolj8F
	Au0umfkNd0UI08OKvuB2kaY+AdRAsc8OVp67Pa/h1+CJ1UdD70YSNIXdvjw7sPqYzH4DhBy5wyy
	9tEGtfKs86Vh72aUlX6wWqPZjbB3Gg1u7ayIESnc58dtqO+dARzT4u8XtJm2aQjWIZvKIXh/gk4
	pO6bUmw=
X-Received: by 2002:a05:6870:2252:b0:417:21a9:81bf with SMTP id
 586e51a60fabf-41721a99de1mr712598fac.14.1772957336666; Sun, 08 Mar 2026
 00:08:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215125319.33261-1-exalt.dev.team@gmail.com> <CAJaUH_8A70=_Cb8yCWqJxbjpW-BnK958fExnC1kSgyhVaydbUw@mail.gmail.com>
In-Reply-To: <CAJaUH_8A70=_Cb8yCWqJxbjpW-BnK958fExnC1kSgyhVaydbUw@mail.gmail.com>
From: dev exalt <exalt.dev.team@gmail.com>
Date: Sun, 8 Mar 2026 10:08:44 +0200
X-Gm-Features: AaiRm521sfSrzMPe8k_WXONgMaqDS34jDgZNKnEGcCpyI_aweTW6lUimN-EYGKc
Message-ID: <CAJaUH__GSYNB2ZgX_9Us1PCHeFVLnoLuQ+hQYX-YtHS4UhY1zw@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for HID++ Multi-Platform
 feature (0x4531)
To: jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, hadess@hadess.net, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sari.kreitem@exalt.corp-partner.google.com, 
	hbarnor@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear maintainers,


We would like to kindly follow up on this patch sent on Dec 15, 2025,
as we haven't received feedback yet.

Patch link:
https://lore.kernel.org/linux-input/20251215125319.33261-1-exalt.dev.team@g=
mail.com/T/#u

We understand maintainers are busy, so just sending a gentle reminder
in case this slipped.

Thank you for your time and review.


Best regards,

Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>


On Sun, Mar 8, 2026 at 10:01=E2=80=AFAM dev exalt <exalt.dev.team@gmail.com=
> wrote:
>
> Dear maintainers,
>
>
> We would like to kindly follow up on this patch sent on Dec 15, 2025, as =
we haven't received feedback yet.
>
> Patch link:
> https://lore.kernel.org/linux-input/20251215125319.33261-1-exalt.dev.team=
@gmail.com/T/#u
>
> We understand maintainers are busy, so just sending a gentle reminder in =
case this slipped.
>
> Thank you for your time and review.
>
>
> Best regards,
>
> Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>
>
>
> On Mon, Dec 15, 2025 at 2:53=E2=80=AFPM DevExalt <exalt.dev.team@gmail.co=
m> wrote:
>>
>> From: "Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>
>>
>> Add support in the Logitech HID++ driver for the HID++ Multi-Platform
>> feature (0x4531), which enables HID++ devices to adjust their behavior
>> based on the host operating system (Linux, ChromeOS, Android).
>>
>> This patch:
>>  * Adds device IDs for MX Keys S (046d:b378) and Casa Keys (046d:b371).
>>  * Introduces the module parameter "hidpp_platform" to allow selecting a
>>    target platform.
>>  * Detects whether a device implements feature 0x4531.
>>  * Validates that the requested platform is supported by the device.
>>  * Applies the platform index when valid, otherwise leaves the device
>>    unchanged.
>>  * Keeps default behavior when "hidpp_platform" is unset or invalid.
>>
>> Supported values for hidpp_platform:
>>    Android, Linux, Chrome
>>
>> TEST=3DPair MX Keys S and Casa Keys over Bluetooth and verify:
>>      * Feature 0x4531 is detected.
>>      * Valid platform values are accepted and applied.
>>      * Invalid platform values result in no update.
>>      * Devices without 0x4531 retain default behavior.
>>      * Platform-specific key behavior is observed once applied.
>>
>> Signed-off-by: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>
>> ---
>>  drivers/hid/hid-ids.h            |   2 +
>>  drivers/hid/hid-logitech-hidpp.c | 280 +++++++++++++++++++++++++++++++
>>  drivers/hid/hid-quirks.c         |   2 +
>>  3 files changed, 284 insertions(+)
>>
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index d31711f1aaec..12de1194d7fa 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -866,6 +866,8 @@
>>  #define USB_DEVICE_ID_LOGITECH_T651    0xb00c
>>  #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD 0xb309
>>  #define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD   0xbb00
>> +#define USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD      0xb371
>> +#define USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD      0xb378
>>  #define USB_DEVICE_ID_LOGITECH_C007    0xc007
>>  #define USB_DEVICE_ID_LOGITECH_C077    0xc077
>>  #define USB_DEVICE_ID_LOGITECH_RECEIVER        0xc101
>> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech=
-hidpp.c
>> index d5011a5d0890..e94daed31981 100644
>> --- a/drivers/hid/hid-logitech-hidpp.c
>> +++ b/drivers/hid/hid-logitech-hidpp.c
>> @@ -4373,6 +4373,280 @@ static bool hidpp_application_equals(struct hid_=
device *hdev,
>>         return report && report->application =3D=3D application;
>>  }
>>
>> +/* --------------------------------------------------------------------=
------ */
>> +/* 0x4531: Multi-Platform Support                                      =
       */
>> +/* --------------------------------------------------------------------=
------ */
>> +
>> +/*
>> + * Some Logitech devices expose the HID++ feature 0x4531 (Multi-Platfor=
m) allowing
>> + * the host to specify which operating system platform to use on the de=
vice. Changing device's
>> + * platform may alter the behavior of the device to match the specified=
 platform.
>> + */
>> +
>> +static char *hidpp_platform;
>> +module_param(hidpp_platform, charp, 0644);
>> +MODULE_PARM_DESC(hidpp_platform, "Select host platform type for Logitec=
h HID++ Multi-Platform feature "
>> +                "0x4531, valid values: (linux|chrome|android).  If unse=
t, no "
>> +                "change is applied.");
>> +
>> +#define HIDPP_MULTIPLATFORM_FEAT_ID                    0x4531
>> +#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO           0x0F
>> +#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR    0x1F
>> +#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM       0x3F
>> +
>> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX                BIT(10)
>> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME       BIT(11)
>> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID      BIT(12)
>> +
>> +struct hidpp_platform_desc {
>> +       u8 plat_idx;
>> +       u8 desc_idx;
>> +       u16 plat_mask;
>> +};
>> +
>> +/**
>> + * hidpp_multiplatform_mask_from_str() - Convert platform name to an HI=
D++ platform mask
>> + * @pname: Platform name string
>> + *
>> + * Converts a platform name string to its corresponding HID++ platform =
mask based on
>> + * the Multi-Platform feature specification.
>> + *
>> + * Return: Platform mask corresponding to @pname on success,
>> + * or 0 if @pname is NULL or unsupported.
>> + */
>> +static u16 hidpp_multiplatform_mask_from_str(const char *pname)
>> +{
>> +       if (!pname)
>> +               return 0;
>> +
>> +       if (!strcasecmp(pname, "linux"))
>> +               return HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX;
>> +       if (!strcasecmp(pname, "chrome"))
>> +               return HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME;
>> +       if (!strcasecmp(pname, "android"))
>> +               return HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * hidpp_multiplatform_get_num_pdesc() - Retrieve number of platform de=
scriptors
>> + * @hidpp: Pointer to the hidpp_device instance
>> + * @feat_index: Feature index of the Multi-Platform feature
>> + * @num_desc: Pointer to store the number of platform descriptors
>> + *
>> + * Retrieves the number of platform descriptors supported by the device=
 through
>> + * the Multi-Platform feature and stores it in @num_desc.
>> + *
>> + * Return: 0 on success, or non-zero on failure.
>> + */
>> +static int hidpp_multiplatform_get_num_pdesc(struct hidpp_device *hidpp=
,
>> +                                            u8 feat_index, u8 *num_desc=
)
>> +{
>> +       int ret;
>> +       struct hidpp_report response;
>> +       struct hid_device *hdev =3D hidpp->hid_dev;
>> +
>> +       ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
>> +                                         HIDPP_MULTIPLATFORM_GET_FEATUR=
E_INFO,
>> +                                         NULL, 0, &response);
>> +       if (ret) {
>> +               hid_warn(hdev, "Multiplatform: GET_FEATURE_INFO failed (=
err=3D%d)", ret);
>> +               return ret;
>> +       }
>> +
>> +       *num_desc =3D response.fap.params[3];
>> +       hid_dbg(hdev, "Multiplatform: Device supports %d platform descri=
ptors", *num_desc);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * hidpp_multiplatform_get_platform_desc() - Retrieve a platform descri=
ptor entry
>> + * @hidpp: Pointer to the hidpp_device instance
>> + * @feat_index: Feature index of the Multi-Platform feature
>> + * @platform_idx: Index of the platform descriptor to retrieve
>> + * @pdesc: Pointer to store the retrieved platform descriptor
>> + *
>> + * Retrieves a single platform descriptor identified by @platform_idx f=
rom the
>> + * device and stores the parsed descriptor fields in @pdesc.
>> + *
>> + * Return: 0 on success, or non-zero on failure.
>> + */
>> +static int hidpp_multiplatform_get_platform_desc(struct hidpp_device *h=
idpp, u8 feat_index,
>> +                                                u8 platform_idx, struct=
 hidpp_platform_desc *pdesc)
>> +{
>> +       int ret;
>> +       struct hidpp_report response;
>> +       u8 params[1] =3D { platform_idx };
>> +       struct hid_device *hdev =3D hidpp->hid_dev;
>> +
>> +       ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
>> +                                         HIDPP_MULTIPLATFORM_GET_PLATFO=
RM_DESCRIPTOR,
>> +                                         params, sizeof(params), &respo=
nse);
>> +
>> +       if (ret) {
>> +               hid_warn(hdev,
>> +                        "Multiplatform: GET_PLATFORM_DESCRIPTOR failed =
for index %d (err=3D%d)",
>> +                        platform_idx, ret);
>> +               return ret;
>> +       }
>> +
>> +       pdesc->plat_idx =3D response.fap.params[0];
>> +       pdesc->desc_idx =3D response.fap.params[1];
>> +       pdesc->plat_mask =3D get_unaligned_be16(&response.fap.params[2])=
;
>> +
>> +       hid_dbg(hdev,
>> +               "Multiplatform: descriptor %d: plat_idx=3D%d, desc_idx=
=3D%d, plat_mask=3D0x%04x",
>> +               platform_idx, pdesc->plat_idx, pdesc->desc_idx, pdesc->p=
lat_mask);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * hidpp_multiplatform_get_platform_index() - Find platform index for a=
 mask
>> + * @hidpp: Pointer to the hidpp_device instance
>> + * @feat_index: Feature index of the Multi-Platform feature
>> + * @plat_mask: Platform mask to search for
>> + * @plat_index: Pointer to store the matched platform index
>> + *
>> + * Iterates through all platform descriptors exposed by the device via =
the
>> + * Multi-Platform feature, retrieving each descriptor and comparing its
>> + * platform mask to @plat_mask. A descriptor matches if its mask overla=
ps with
>> + * the requested @plat_mask (i.e. (pdesc.plat_mask & plat_mask) is non-=
zero).
>> + *
>> + * When a matching descriptor is found, its platform index (plat_idx) i=
s
>> + * written to @plat_index and the function returns success.
>> + *
>> + * If no descriptor matches, -ENOENT is returned.
>> + *
>> + * Return: 0 on success; -ENOENT if no matching descriptor exists;
>> + *         or non-zero on failure.
>> + */
>> +static int hidpp_multiplatform_get_platform_index(struct hidpp_device *=
hidpp,
>> +                                                 u8 feat_index, u16 pla=
t_mask,
>> +                                                 u8 *plat_index)
>> +{
>> +       int i;
>> +       int ret;
>> +       u8 num_desc;
>> +       struct hidpp_platform_desc pdesc;
>> +       struct hid_device *hdev =3D hidpp->hid_dev;
>> +
>> +       ret =3D hidpp_multiplatform_get_num_pdesc(hidpp, feat_index, &nu=
m_desc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       for (i =3D 0; i < num_desc; i++) {
>> +               ret =3D hidpp_multiplatform_get_platform_desc(hidpp, fea=
t_index, i, &pdesc);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               if (pdesc.plat_mask & plat_mask) {
>> +                       *plat_index =3D pdesc.plat_idx;
>> +                       hid_dbg(hdev,
>> +                               "Multiplatform: Selected platform index =
%d for platform '%s'",
>> +                               *plat_index, hidpp_platform);
>> +                       return 0;
>> +               }
>> +       }
>> +
>> +       hid_dbg(hdev,
>> +               "Multiplatform: No matching platform descriptor found fo=
r platform '%s'",
>> +               hidpp_platform);
>> +       return -ENOENT;
>> +}
>> +
>> +/**
>> + * hidpp_multiplatform_update_device_platform() - Update the device pla=
tform
>> + * @hidpp: Pointer to the hidpp_device instance
>> + * @feat_index: Feature index of the Multi-Platform feature
>> + * @plat_index: Platform index to set on the device
>> + *
>> + * Sends the HID++ Multi-Platform 'SET_CURRENT_PLATFORM' command to the=
 device to
>> + * update its platform index to @plat_index.
>> + *
>> + * Return: 0 on success, or non-zero on failure.
>> + */
>> +static int hidpp_multiplatform_update_device_platform(struct hidpp_devi=
ce *hidpp,
>> +                                                     u8 feat_index, u8 =
plat_index)
>> +{
>> +       int ret;
>> +       struct hidpp_report response;
>> +       /* Byte 0 (hostIndex): 0xFF selects the current host. */
>> +       u8 params[2] =3D { 0xFF, plat_index };
>> +
>> +       ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
>> +                                         HIDPP_MULTIPLATFORM_SET_CURREN=
T_PLATFORM,
>> +                                         params, sizeof(params), &respo=
nse);
>> +
>> +       if (ret)
>> +               hid_warn(hidpp->hid_dev,
>> +                        "Multiplatform: SET_CURRENT_PLATFORM failed for=
 index %d (err=3D%d)",
>> +                        plat_index, ret);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * hidpp_multiplatform_init() - Apply the HID++ Multi-Platform (0x4531)=
 feature
>> + * @hidpp: Pointer to the hidpp_device instance
>> + *
>> + * Initializes the Multi-Platform feature by selecting the device platf=
orm
>> + * corresponding to the module parameter @hidpp_platform, if provided.
>> + *
>> + * The function performs the following steps:
>> + *   1. Convert the @hidpp_platform string into a platform mask.
>> + *   2. Check whether the device supports the Multi-Platform feature (0=
x4531).
>> + *   3. Look up the device's platform index whose mask matches the host
>> + *      platform mask.
>> + *   4. Apply that platform index to the device via 'SET_CURRENT_PLATFO=
RM'.
>> + *
>> + * If the module parameter is unset or invalid, or the device does not =
support
>> + * the feature, or no matching platform descriptor is found, the functi=
on exits
>> + * silently without modifying the device state.
>> + *
>> + * On success, the device's platform configuration is updated.
>> + */
>> +static void hidpp_multiplatform_init(struct hidpp_device *hidpp)
>> +{
>> +       int ret;
>> +       u8 feat_index;
>> +       u8 plat_index;
>> +       u16 host_plat_mask;
>> +       struct hid_device *hdev =3D hidpp->hid_dev;
>> +
>> +       if (!hidpp_platform)
>> +               return;
>> +
>> +       host_plat_mask =3D hidpp_multiplatform_mask_from_str(hidpp_platf=
orm);
>> +       if (!host_plat_mask) {
>> +               hid_warn(hdev,
>> +                        "Multiplatform: Invalid or unsupported platform=
 name '%s'",
>> +                        hidpp_platform);
>> +               return;
>> +       }
>> +
>> +       ret =3D hidpp_root_get_feature(hidpp, HIDPP_MULTIPLATFORM_FEAT_I=
D, &feat_index);
>> +       if (ret) {
>> +               hid_warn(hdev,
>> +                        "Multiplatform: Failed to get the HID++ multipl=
atform feature 0x4531");
>> +               return;
>> +       }
>> +
>> +       ret =3D hidpp_multiplatform_get_platform_index(hidpp, feat_index=
, host_plat_mask,
>> +                                                    &plat_index);
>> +       if (ret)
>> +               return;
>> +
>> +       ret =3D hidpp_multiplatform_update_device_platform(hidpp, feat_i=
ndex, plat_index);
>> +       if (ret)
>> +               return;
>> +
>> +       hid_info(hdev,
>> +                "Multiplatform: Device platform successfully set to '%s=
'", hidpp_platform);
>> +}
>> +
>>  static int hidpp_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
>>  {
>>         struct hidpp_device *hidpp;
>> @@ -4467,6 +4741,8 @@ static int hidpp_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>>         if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
>>                 connect_mask &=3D ~HID_CONNECT_HIDINPUT;
>>
>> +       hidpp_multiplatform_init(hidpp);
>> +
>>         /* Now export the actual inputs and hidraw nodes to the world */
>>         hid_device_io_stop(hdev);
>>         ret =3D hid_connect(hdev, connect_mask);
>> @@ -4664,6 +4940,10 @@ static const struct hid_device_id hidpp_devices[]=
 =3D {
>>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
>>         { /* MX Anywhere 3SB mouse over Bluetooth */
>>           HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
>> +       { /* Casa Keys keyboard over Bluetooth */
>> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOG=
ITECH_CASA_KEYS_KEYBOARD) },
>> +       { /* MX Keys S keyboard over Bluetooth */
>> +         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOG=
ITECH_MX_KEYS_S_KEYBOARD) },
>>         {}
>>  };
>>
>> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
>> index c89a015686c0..99ca04b61bda 100644
>> --- a/drivers/hid/hid-quirks.c
>> +++ b/drivers/hid/hid-quirks.c
>> @@ -520,6 +520,8 @@ static const struct hid_device_id hid_have_special_d=
river[] =3D {
>>  #endif
>>  #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
>>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_=
G920_WHEEL) },
>> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOG=
ITECH_CASA_KEYS_KEYBOARD) },
>> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOG=
ITECH_MX_KEYS_S_KEYBOARD) },
>>  #endif
>>  #if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
>>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_=
MAGICMOUSE) },
>> --
>> 2.34.1
>>
