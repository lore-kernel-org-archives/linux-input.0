Received: from mail-oi2-f2.google.com (mail-oi2-f2.google.com [74.125.231.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BF63115AE
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124104; cv=pass; b=L4gsddi/mGlNzLKMLlsei3DVfLAhGG+aprT4GsRDZYtkL2zLLdxsRwSRErTii1hbiaHExsZ6Z/Vp0LDqYPMZB947R/fbZ2k7NJpjmKfyrRmywcyy4gIky0GVZc96zWbLSnbco5WRbsCEvKRkHmD+lyjcSClNWHMsPA0lQztCrYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124104; c=relaxed/simple;
	bh=qwJUfKFvD0dtBik9I9nXmaJ4Y3E7J2VtN2srs8NDMUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8AH3yfmcmzrdFIev8/6AoyVrFI5+3iS821VTrZhOUdPvIy14gLAVGMjaAlhAZ6hM9N5Muf9p3kb/woFHGVDoNUnt8xGsh5oVjT12LQy2BxVFwo9VlJxYCWZqtcLDLF66ShmXgePZdshTrV1ah6XzsPGxpWVjgyUL4p4xoxcl+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxysfi3j; arc=pass smtp.client-ip=74.125.231.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxysfi3j"
Received: by mail-oi2-f2.google.com with SMTP id 5614622812f47-495d5d27acfso1733780b6e.1
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 07:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784124101; cv=none;
        d=google.com; s=arc-20260327;
        b=MRH6OPEAUcbKK4BDOcKQAyQ88MKtrvYMXXT/vpglLn+1iDAkFTfTzxZbNVTCzmeKCb
         NDMkrrsi2GBgbgbRk7BoIEy35ENHwiE4xtfsii7Wskah9jLgF5F5RcpHagsXfRcPTWy7
         6nzIw9Ls4t9gn9kCvZKhv6y85BS2WPULVUGhq2NQu3I8tr5d6gdGlP6w7UhHGQU1ElYT
         XmkpxaHdUK2YvlPjTfvX6MccNKdnj6ErvxP8yHyVhJHFtdkAqXIAACW6vszhq0Gaszmg
         +/TjjVnytcdjpoHKj+sXq4ImPsgiVyBmFf07aZPHyvTeFhWAibLzB5pqozQnmwQ+b68G
         HMbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Nyn296PjL2bAlLjJ2EYsl8RqUVW0Z7ixuCbQT4vrgg=;
        fh=Qj9NsW/vDrJhj+eLysxAbt+TfGBT2cuRcNM9kLAe1WA=;
        b=IZbmt50S0RIRlB/kSe+13ECiOtuk+ayaOmeE/EaN+nehOwvvRxPb87wXD9XE1smJqx
         w6Pn9EcFQPvT7/scuK42YCFumIhCUMTw4E7V1Hnjs7n45+DxiPV5xK8zbmcNRrmOkK9H
         AQMZKKnki7scULEr/isaxPgkRjMx2QC0vy/IGA2GiD/svuErmq2DJaddFOdeVvWnZRpV
         HxaofRa1FIBhrgLfW85GSYdwTUvvSoz13inFgNZXPFOP8by1+NyCyRJdT3FM6gyt+de8
         qeHoGoADwilZ1gYS5CSzASqbmVq1MdHtCZsEmyu55OaPEtMAF21wrfMxexmnA128czoW
         rqow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784124101; x=1784728901; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Nyn296PjL2bAlLjJ2EYsl8RqUVW0Z7ixuCbQT4vrgg=;
        b=Wxysfi3ju/qmOvBulRpOByIh2M3O4T5bvLqublhqsTNSQL0G2IdyfS+DYR1q3mpNAe
         UOArO8cJRAe842g2fBTy/6l0BI/Rv/I0xTQwuis15wtue3uhU/EVmFNq5kzKQVEJezrz
         4ynOz1GEE5QoqhANbWJwXhu4Q3qV3In4S8E38xjREZgyXXySYS/ijg6v6t36oRanzvDg
         NNf4FXlZYi8AmzSvR08A6iVlTqGKqAL1z+gsg9NzmAqHnIGWTw4lgef1iTjG3mBOgvrr
         5Vbp/VdxDzc+Oximnny69tn56smpEPfC9SM0+VY38lJ2IJzB7WDcsXGektB9IVWikpOA
         HA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124101; x=1784728901;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Nyn296PjL2bAlLjJ2EYsl8RqUVW0Z7ixuCbQT4vrgg=;
        b=JSz7pYNvfPMdyEUgStJ6RgapsG7A2UmEAuMPlLExEQuW3Yo/q/rWQyR6krBcIwaleB
         +AYcTOY20bhb+7adOKdnSTiLEW1ByMyHU2RAd2fSgxf2n/8fWjiff75iMcn30ClCxqju
         Fb5eWtrgT5Lti+FlVxKiwDqw+n2r6Wo4TolQ1MOWDmYeOFiZXbk7hAMO5luQSQQLSVZl
         EFgB4VNfUZkc0cT53QHPcDzEQExGVW4BKGHkCu8AQEB9XAUW12hcbEtBcDP4htJsGv7o
         BElaK8OWR8iwEADRN8AJxNy3V/wyxQMiMtufUjk7pIrCu9AVCH4Vcwjw3wsKEcA6DZx5
         +91Q==
X-Forwarded-Encrypted: i=1; AHgh+RohsX0qVEYXRvOwv4LV7z47DzwPXHWdh1ti9BApWD+DOLP0SH/f5pXxOyP5OMxk+7SSqqIlre1y9KcQ8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBOSaIxkgibUFTFdVgVpOlIb3LCGRf5QaiJjqgGU077nUtme2
	wwFnmOuZ0YPPHIBTCRcZdOBsdE3tcv3EfSDdTz/STB6BAmUm7du6kQ+qAC1B3nI8hETggRENpdZ
	HnKUMQn9Cl74Oz+a+Xs64NDiEuDAu9tc=
X-Gm-Gg: AfdE7cn5n/YWpEHj40yxPSf/EK1XWfwWaZ5v2xISlHUwvGyKJ7tmCNgmmbqUNbtRZmy
	JtTaS2CMIqa2xNpxvYCxErSz1Cmxpd5qrTak1JhBGlX4Wt0h/iiI3sGAtZa8im8IZVbUKF2lbGS
	Oxckj9DLVStwD4VWjVQJf+ACC1f/lopbm3DFHnOXQqPnvuoRBXSja12+dlLpUsg/k1/909DqmxF
	rmcdb/BlQMi5CcbaHsTHNMxZ+5Qd1E+p+RqcfXBPGT0lfVWkSpaDjIK5amDb8+kl1caHfcLrA==
X-Received: by 2002:a05:6808:5191:b0:493:e2bb:2eaf with SMTP id
 5614622812f47-4a472b0a643mr4781156b6e.39.1784124100317; Wed, 15 Jul 2026
 07:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625080807.74157-1-exalt.dev.team@gmail.com> <20260701073727.53636-1-exalt.dev.team@gmail.com>
In-Reply-To: <20260701073727.53636-1-exalt.dev.team@gmail.com>
From: dev exalt <exalt.dev.team@gmail.com>
Date: Wed, 15 Jul 2026 17:01:29 +0300
X-Gm-Features: AUfX_myucKo0P0t2FpRyjIk2C_mLp18RprFxaojpu17zX6sjgsPipira0ZhE7cY
Message-ID: <CAJaUH_8b88VYq=cSZod56WvpHyaxCvj4EJxK4FgTq5Qo-GeRoA@mail.gmail.com>
Subject: Re: [PATCH v5] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
To: jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, hadess@hadess.net, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sari.kreitem@exalt.corp-partner.google.com, 
	hbarnor@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear maintainers,

We would like to kindly follow up on the latest revision of this
patch, as we have not yet received any feedback.
This patch is the latest revision of the work previously discussed here:
https://lore.kernel.org/linux-input/20251215125319.33261-1-exalt.dev.team@g=
mail.com/

This version incorporates the feedback and suggestions from the
previous discussion and updates the implementation accordingly.

We understand that maintainers are busy, so we are just sending a
gentle reminder in case this patch has not yet had a chance to be
reviewed.

Thank you very much for your time and review.

Best regards,
Baraa Atta

On Wed, Jul 1, 2026 at 10:37=E2=80=AFAM DevExalt <exalt.dev.team@gmail.com>=
 wrote:
>
> From: "Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>
>
> Add support in the Logitech HID++ driver for the HID++ Multi-Platform
> feature (0x4531), which enables HID++ devices to adjust their behavior
> based on the host operating system.
>
> This patch:
>  * Adds device IDs for MX Keys S (046d) and Casa Keys (046d).
>  * Introduces the per-device sysfs attribute "platform" to allow selectin=
g
>    a target platform.
>  * Detects whether a device implements feature 0x4531.
>  * Validates that the requested platform is supported by the device.
>  * Applies the selected platform when valid.
>  * Leaves the device unchanged when an unsupported platform is requested.
>
> Supported values for the platform sysfs attribute:
>
>  windows, winemb, linux, chrome, android,
>  macos, ios, webos, tizen
>
> TEST=3DPair MX Keys S and Casa Keys over Bluetooth and verify:
>  * Feature 0x4531 is detected.
>  * Valid platform values written through sysfs are accepted and applied.
>  * Invalid platform values result in no update.
>  * Devices without 0x4531 retain default behavior.
>  * Platform-specific key behavior is observed once applied.
>
> Signed-off-by: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>
> ---
> Changes in v2:
>   * Replace the global hidpp_platform module parameter with a per-device
>     sysfs attribute
>   * Expose all platforms  supported by the HID++ Multi-Platform feature
>   * Update documentation and testing description
>
> Changes in v3:
>   * Address Sashiko review comments.
>   * Switch to devm_mutex_init() to handle mutex lifecycle management
>     automatically.
>   * Move hidpp_multiplatform_init() to the end of hidpp_probe() after
>     hid_device_io_start() to guarantee that the hardware I/O loop is full=
y
>     active when the sysfs attribute becomes visible.
>
> Changes in v4:
>   * Address Sashiko review comments.
>   * Fix a potential use-after-destroy race condition during device unbind
>     by replacing devm_device_add_group() with manual sysfs_create_group()
>     management, ensuring the sysfs attribute is removed before the
>     associated device resources and send_mutex are destroyed.
>
> Changes in v5:
>   * Address Sashiko review comments.
>   * Fix a sub system design violation by removing the hardcoded 0xF clien=
t
>     ID from the lower nibble of the FAP command macros.
>
>  .../testing/sysfs-driver-hid-logitech-hidpp   |  29 ++
>  drivers/hid/hid-ids.h                         |   2 +
>  drivers/hid/hid-logitech-hidpp.c              | 399 ++++++++++++++++++
>  drivers/hid/hid-quirks.c                      |   2 +
>  4 files changed, 432 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp b/=
Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
> index d8f831f2d6b5..41f0fd8c2192 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
> @@ -17,3 +17,32 @@ Description:
>                 handling battery properties in the kernel. This way, upow=
er can
>                 add a udev rule to decide whether or not it should use th=
e
>                 internal unifying support or the generic kernel one.
> +
> +What:          /sys/bus/hid/drivers/logitech-hidpp-device/<dev>/platform
> +Date:          Jul, 2026
> +KernelVersion: 7.2
> +Contact:       linux-input@vger.kernel.org
> +Description:
> +               (WO) This attribute is present only on Logitech HID++ 2.0=
 devices
> +               that implement feature 0x4531 (Multi-Platform). It allows=
 the host
> +               to select which operating-system platform the device shou=
ld emulate,
> +               altering its key mapping and behaviour accordingly.
> +
> +               Writing one of the following platform names programs the =
device:
> +
> +                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +                 windows       Standard Windows key layout
> +                 winemb        Windows Embedded key layout
> +                 linux         Linux key layout
> +                 chrome        ChromeOS key layout
> +                 android       Android key layout
> +                 macos         macOS key layout
> +                 ios           iOS key layout
> +                 webos         webOS key layout
> +                 tizen         Tizen key layout
> +                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +               Only platforms advertised by the device's own descriptors=
 are
> +               accepted. The input is case-insensitive. Writing an unkno=
wn
> +               platform name returns -EINVAL; writing a valid name that =
the
> +               device does not expose in its descriptors returns -EOPNOT=
SUPP.
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1059922baaac..a6c2dea79397 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -913,6 +913,8 @@
>  #define USB_DEVICE_ID_LOGITECH_T651    0xb00c
>  #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD 0xb309
>  #define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD   0xbb00
> +#define USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD      0xb371
> +#define USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD      0xb378
>  #define USB_DEVICE_ID_LOGITECH_C007    0xc007
>  #define USB_DEVICE_ID_LOGITECH_C077    0xc077
>  #define USB_DEVICE_ID_LOGITECH_RECEIVER        0xc101
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 90b0184df777..39edb22b55e1 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -209,6 +209,9 @@ struct hidpp_device {
>         int hires_wheel_multiplier;
>         u8 hires_wheel_feature_index;
>
> +       u8 multiplatform_feature_index;
> +       struct mutex multiplatform_lock;
> +
>         bool connected_once;
>  };
>
> @@ -4423,6 +4426,398 @@ static bool hidpp_application_equals(struct hid_d=
evice *hdev,
>         return report && report->application =3D=3D application;
>  }
>
> +/* ---------------------------------------------------------------------=
----- */
> +/* 0x4531: Multi-Platform Support                                       =
      */
> +/* ---------------------------------------------------------------------=
----- */
> +
> +/*
> + * Some Logitech devices expose the HID++ feature 0x4531 (Multi-Platform=
) allowing
> + * the host to specify which operating system platform to use on the dev=
ice. Changing device's
> + * platform may alter the behavior of the device to match the specified =
platform.
> + *
> + * Devices that implement this feature expose a per-device sysfs attribu=
te
> + * "platform". Writing one of (windows|winemb|linux|chrome|android|
> + * macos|ios|webos|tizen) selects the matching platform descriptor on th=
e device.
> + */
> +
> +#define HIDPP_MULTIPLATFORM_FEAT_ID                    0x4531
> +#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO           0x00
> +#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR    0x10
> +#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM       0x30
> +
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_TIZEN                BIT(0)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS      BIT(8)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINEMB       BIT(9)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX                BIT(10)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME       BIT(11)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID      BIT(12)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_MACOS                BIT(13)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_IOS          BIT(14)
> +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_WEBOS                BIT(15)
> +
> +struct hidpp_platform_desc {
> +       u8 plat_idx;
> +       u8 desc_idx;
> +       u16 plat_mask;
> +};
> +
> +/*
> + * Platform names exposed through the "platform" sysfs attribute. The or=
der of
> + * this array must stay in sync with multiplatform_masks[] below, as the=
 index
> + * returned by sysfs_match_string() is used to look up the matching mask=
.
> + */
> +static const char * const multiplatform_names[] =3D {
> +       "windows", "winemb", "linux", "chrome",
> +       "android", "macos", "ios", "webos", "tizen", NULL
> +};
> +
> +static const u16 multiplatform_masks[] =3D {
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINDOWS,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_WINEMB,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_MACOS,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_IOS,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_WEBOS,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MASK_TIZEN,
> +};
> +
> +/**
> + * hidpp_multiplatform_errno() - Convert HID++ protocol error codes to L=
inux errno
> + * @err: HID++ protocol error code (positive) or Linux errno (negative o=
r zero)
> + *
> + * Converts a HID++ protocol error code to the corresponding Linux errno=
. If @err is
> + * already a negative or zero Linux errno, it is returned unchanged. Oth=
erwise, if @err
> + * is a positive HID++ error code, it is mapped to the appropriate negat=
ive Linux errno
> + * based on the HID++ specification error codes.
> + *
> + * This is used to ensure that functions interacting with the Multi-Plat=
form feature can
> + * return consistent Linux error codes even when they encounter errors d=
efined by the HID++
> + * protocol when the platform is set from the sysfs attribute.
> + *
> + * Return: Negative Linux errno corresponding to the HID++ error code, o=
r @err if it is
> + * already a Linux errno.
> + */
> +static int hidpp_multiplatform_errno(int err)
> +{
> +       if (err <=3D 0)
> +               return err;
> +
> +       switch (err) {
> +       case HIDPP20_ERROR_INVALID_ARGS:
> +       case HIDPP20_ERROR_OUT_OF_RANGE:
> +       case HIDPP20_ERROR_INVALID_FEATURE_INDEX:
> +       case HIDPP20_ERROR_INVALID_FUNCTION_ID:
> +               return -EINVAL;
> +       case HIDPP20_ERROR_NOT_ALLOWED:
> +               return -EPERM;
> +       case HIDPP20_ERROR_BUSY:
> +               return -EBUSY;
> +       case HIDPP20_ERROR_UNSUPPORTED:
> +               return -EOPNOTSUPP;
> +       case HIDPP20_ERROR_HW_ERROR:
> +       case HIDPP20_ERROR_UNKNOWN:
> +       default:
> +               return -EIO;
> +       }
> +}
> +
> +/**
> + * hidpp_multiplatform_get_num_pdesc() - Retrieve number of platform des=
criptors
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @num_desc: Pointer to store the number of platform descriptors
> + *
> + * Retrieves the number of platform descriptors supported by the device =
through
> + * the Multi-Platform feature and stores it in @num_desc.
> + *
> + * Return: 0 on success, or a negative Linux errno on failure.
> + */
> +static int hidpp_multiplatform_get_num_pdesc(struct hidpp_device *hidpp,
> +                                            u8 feat_index, u8 *num_desc)
> +{
> +       int ret;
> +       struct hidpp_report response;
> +       struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +       ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> +                                         HIDPP_MULTIPLATFORM_GET_FEATURE=
_INFO,
> +                                         NULL, 0, &response);
> +       if (ret) {
> +               hid_warn(hdev, "Multiplatform: GET_FEATURE_INFO failed (e=
rr=3D%d)", ret);
> +               return hidpp_multiplatform_errno(ret);
> +       }
> +
> +       *num_desc =3D response.fap.params[3];
> +       hid_dbg(hdev, "Multiplatform: Device supports %d platform descrip=
tors", *num_desc);
> +
> +       return 0;
> +}
> +
> +/**
> + * hidpp_multiplatform_get_platform_desc() - Retrieve a platform descrip=
tor entry
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @platform_idx: Index of the platform descriptor to retrieve
> + * @pdesc: Pointer to store the retrieved platform descriptor
> + *
> + * Retrieves a single platform descriptor identified by @platform_idx fr=
om the
> + * device and stores the parsed descriptor fields in @pdesc.
> + *
> + * Return: 0 on success, or a negative Linux errno on failure.
> + */
> +static int hidpp_multiplatform_get_platform_desc(struct hidpp_device *hi=
dpp, u8 feat_index,
> +                                                u8 platform_idx, struct =
hidpp_platform_desc *pdesc)
> +{
> +       int ret;
> +       struct hidpp_report response;
> +       u8 params[1] =3D { platform_idx };
> +       struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +       ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> +                                         HIDPP_MULTIPLATFORM_GET_PLATFOR=
M_DESCRIPTOR,
> +                                         params, sizeof(params), &respon=
se);
> +
> +       if (ret) {
> +               hid_warn(hdev,
> +                        "Multiplatform: GET_PLATFORM_DESCRIPTOR failed f=
or index %d (err=3D%d)",
> +                        platform_idx, ret);
> +               return hidpp_multiplatform_errno(ret);
> +       }
> +
> +       pdesc->plat_idx =3D response.fap.params[0];
> +       pdesc->desc_idx =3D response.fap.params[1];
> +       pdesc->plat_mask =3D get_unaligned_be16(&response.fap.params[2]);
> +
> +       hid_dbg(hdev,
> +               "Multiplatform: descriptor %d: plat_idx=3D%d, desc_idx=3D=
%d, plat_mask=3D0x%04x",
> +               platform_idx, pdesc->plat_idx, pdesc->desc_idx, pdesc->pl=
at_mask);
> +
> +       return 0;
> +}
> +
> +/**
> + * hidpp_multiplatform_get_platform_index() - Find platform index for a =
mask
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @plat_mask: Platform mask to search for
> + * @plat_index: Pointer to store the matched platform index
> + *
> + * Iterates through all platform descriptors exposed by the device via t=
he
> + * Multi-Platform feature, retrieving each descriptor and comparing its
> + * platform mask to @plat_mask. A descriptor matches if its mask overlap=
s with
> + * the requested @plat_mask (i.e. (pdesc.plat_mask & plat_mask) is non-z=
ero).
> + *
> + * When a matching descriptor is found, its platform index (plat_idx) is
> + * written to @plat_index and the function returns success.
> + *
> + * Return: 0 on success; -EOPNOTSUPP if the device exposes no descriptor
> + *         matching @plat_mask; or another negative Linux errno on trans=
port
> + *         failure.
> + */
> +static int hidpp_multiplatform_get_platform_index(struct hidpp_device *h=
idpp,
> +                                                 u8 feat_index, u16 plat=
_mask,
> +                                                 u8 *plat_index)
> +{
> +       int i;
> +       int ret;
> +       u8 num_desc;
> +       struct hidpp_platform_desc pdesc;
> +       struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +       ret =3D hidpp_multiplatform_get_num_pdesc(hidpp, feat_index, &num=
_desc);
> +       if (ret)
> +               return ret;
> +
> +       for (i =3D 0; i < num_desc; i++) {
> +               ret =3D hidpp_multiplatform_get_platform_desc(hidpp, feat=
_index, i, &pdesc);
> +               if (ret)
> +                       return ret;
> +
> +               if (pdesc.plat_mask & plat_mask) {
> +                       *plat_index =3D pdesc.plat_idx;
> +                       hid_dbg(hdev,
> +                               "Multiplatform: Selected platform index %=
d for mask 0x%04x",
> +                               *plat_index, plat_mask);
> +                       return 0;
> +               }
> +       }
> +
> +       hid_dbg(hdev,
> +               "Multiplatform: No matching platform descriptor for mask =
0x%04x",
> +               plat_mask);
> +       return -EOPNOTSUPP;
> +}
> +
> +/**
> + * hidpp_multiplatform_update_device_platform() - Update the device plat=
form
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @plat_index: Platform index to set on the device
> + *
> + * Sends the HID++ Multi-Platform 'SET_CURRENT_PLATFORM' command to the =
device to
> + * update its platform index to @plat_index.
> + *
> + * Return: 0 on success, or a negative Linux errno on failure.
> + */
> +static int hidpp_multiplatform_update_device_platform(struct hidpp_devic=
e *hidpp,
> +                                                     u8 feat_index, u8 p=
lat_index)
> +{
> +       int ret;
> +       struct hidpp_report response;
> +       /* Byte 0 (hostIndex): 0xFF selects the current host. */
> +       u8 params[2] =3D { 0xFF, plat_index };
> +
> +       ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> +                                         HIDPP_MULTIPLATFORM_SET_CURRENT=
_PLATFORM,
> +                                         params, sizeof(params), &respon=
se);
> +
> +       if (ret)
> +               hid_warn(hidpp->hid_dev,
> +                        "Multiplatform: SET_CURRENT_PLATFORM failed for =
index %d (err=3D%d)",
> +                        plat_index, ret);
> +
> +       return hidpp_multiplatform_errno(ret);
> +}
> +
> +/**
> + * hidpp_multiplatform_set_platform() - Apply a platform to the device
> + * @hidpp: Pointer to the hidpp_device instance
> + * @mask: A single HIDPP_MULTIPLATFORM_PLATFORM_MASK_* bit to apply
> + *
> + * Looks up the device's platform descriptor whose platform mask matches=
 @mask
> + * and instructs the device to switch to it via SET_CURRENT_PLATFORM.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device does not implement fe=
ature
> + *         0x4531 or exposes no descriptor matching @mask, or another ne=
gative
> + *         Linux errno from the underlying HID++ command.
> + */
> +static int hidpp_multiplatform_set_platform(struct hidpp_device *hidpp, =
u16 mask)
> +{
> +       u8 plat_index;
> +       int ret;
> +
> +       if (!hidpp->multiplatform_feature_index)
> +               return -EOPNOTSUPP;
> +
> +       ret =3D hidpp_multiplatform_get_platform_index(hidpp,
> +                       hidpp->multiplatform_feature_index, mask, &plat_i=
ndex);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D hidpp_multiplatform_update_device_platform(hidpp,
> +                       hidpp->multiplatform_feature_index, plat_index);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +/**
> + * platform_store() - Set the device platform based on user input
> + * @dev: Pointer to the device instance
> + * @attr: Pointer to the device attribute
> + * @buf: Buffer containing the platform name string
> + * @count: Size of the input buffer
> + *
> + * Parses the platform name from the input buffer, converts it to a plat=
form mask,
> + * and applies it to the device using the HID++ Multi-Platform feature. =
The function
> + * handles errors gracefully, returning appropriate Linux errno values i=
f the input
> + * is invalid or if the device does not support the requested platform.
> + *
> + * Return: Number of bytes consumed from the input buffer on success, or=
 a negative
> + * Linux errno on failure.
> + */
> +static ssize_t platform_store(struct device *dev,
> +                             struct device_attribute *attr,
> +                             const char *buf, size_t count)
> +{
> +       struct hid_device *hdev =3D to_hid_device(dev);
> +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> +       char platform[16];
> +       int idx;
> +       int ret;
> +
> +       strscpy(platform, buf, sizeof(platform));
> +       string_lower(platform, platform);
> +
> +       idx =3D sysfs_match_string(multiplatform_names, platform);
> +       if (idx < 0)
> +               return idx;
> +
> +       mutex_lock(&hidpp->multiplatform_lock);
> +       ret =3D hidpp_multiplatform_set_platform(hidpp, multiplatform_mas=
ks[idx]);
> +       mutex_unlock(&hidpp->multiplatform_lock);
> +       if (ret)
> +               return ret;
> +
> +       hid_dbg(hdev, "Multiplatform: Device platform set to '%s'\n",
> +               multiplatform_names[idx]);
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR_WO(platform);
> +
> +static struct attribute *multiplatform_attrs[] =3D {
> +       &dev_attr_platform.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group multiplatform_attribute_group =3D {
> +       .attrs =3D multiplatform_attrs,
> +};
> +
> +/**
> + * hidpp_multiplatform_init() - Initialize HID++ Multi-Platform support
> + * @hidpp: Pointer to the hidpp_device instance
> + *
> + * Checks if the device supports the HID++ Multi-Platform feature (0x453=
1) and, if so,
> + * initializes the hidpp_device structure to track the feature index and=
 creates the
> + * corresponding sysfs attribute group for platform selection.
> + */
> +static void hidpp_multiplatform_init(struct hidpp_device *hidpp)
> +{
> +       struct hid_device *hdev =3D hidpp->hid_dev;
> +       u8 feat_index;
> +       int ret;
> +
> +       ret =3D hidpp_root_get_feature(hidpp, HIDPP_MULTIPLATFORM_FEAT_ID=
, &feat_index);
> +       if (ret)
> +               return;
> +
> +       hidpp->multiplatform_feature_index =3D feat_index;
> +
> +       mutex_init(&hidpp->multiplatform_lock);
> +
> +       ret =3D sysfs_create_group(&hdev->dev.kobj, &multiplatform_attrib=
ute_group);
> +       if (ret) {
> +               hid_warn(hdev,
> +                        "Multiplatform: Failed to create sysfs group (er=
r=3D%d)\n", ret);
> +               mutex_destroy(&hidpp->multiplatform_lock);
> +               hidpp->multiplatform_feature_index =3D 0;
> +       }
> +}
> +
> +/**
> + * hidpp_multiplatform_cleanup() - Cleanup HID++ Multi-Platform support
> + * @hidpp: Pointer to the hidpp_device instance
> + *
> + * Removes the sysfs attribute group for platform selection and destroys=
 the mutex
> + * used for synchronizing access to the Multi-Platform feature.
> + * This function should be called during device removal or driver cleanu=
p to ensure
> + * proper resource management.
> + */
> +static void hidpp_multiplatform_cleanup(struct hidpp_device *hidpp)
> +{
> +       if (!hidpp->multiplatform_feature_index)
> +               return;
> +
> +       sysfs_remove_group(&hidpp->hid_dev->dev.kobj, &multiplatform_attr=
ibute_group);
> +       mutex_destroy(&hidpp->multiplatform_lock);
> +}
> +
>  static int hidpp_probe(struct hid_device *hdev, const struct hid_device_=
id *id)
>  {
>         struct hidpp_device *hidpp;
> @@ -4545,6 +4940,8 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>                 }
>         }
>
> +       hidpp_multiplatform_init(hidpp);
> +
>         /*
>          * This relies on logi_dj_ll_close() being a no-op so that DJ con=
nection
>          * events will still be received.
> @@ -4557,6 +4954,7 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  hid_hw_open_fail:
>         hid_hw_stop(hdev);
>  hid_hw_start_fail:
> +       hidpp_multiplatform_cleanup(hidpp);
>         sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>         cancel_work_sync(&hidpp->work);
>         mutex_destroy(&hidpp->send_mutex);
> @@ -4570,6 +4968,7 @@ static void hidpp_remove(struct hid_device *hdev)
>         if (!hidpp)
>                 return hid_hw_stop(hdev);
>
> +       hidpp_multiplatform_cleanup(hidpp);
>         sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>
>         hid_hw_stop(hdev);
> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> index 57d8efdd9b89..577af0075e27 100644
> --- a/drivers/hid/hid-quirks.c
> +++ b/drivers/hid/hid-quirks.c
> @@ -537,6 +537,8 @@ static const struct hid_device_id hid_have_special_dr=
iver[] =3D {
>  #endif
>  #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
>         { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G=
920_WHEEL) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGI=
TECH_CASA_KEYS_KEYBOARD) },
> +       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGI=
TECH_MX_KEYS_S_KEYBOARD) },
>  #endif
>  #if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_M=
AGICMOUSE) },
> --
> 2.34.1
>
