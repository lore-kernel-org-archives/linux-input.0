Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC24EE86F
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773871; cv=pass; b=VTzzvIUs7a43uYhL5MKyclJZhUjItXEB75ogPb++eJ4fjD+kNQTecbAacm4QOYoVjEzXUNdIOrX7u6yp0IvyhxgZPXS+MhGk3YAnUSEHsO2FBzwCja2vBVMxlZYtPmxT18mcT52uA7V+CtqTQXzNEs+AThbk9GiB3xPNQiGjR4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773871; c=relaxed/simple;
	bh=4jV0BBju2uKxn2fEQlx/Mgs1vvruRfjnBPrd30RjshU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZomZXnPEF7ToEENwbfjJFiqfbSfehf66yBysGK63XzkFS1bPU4VxUBfwBibBrFoTpblXcPQ5QDtCrcB2WKtsd9QLLArSdoxH65dZkue3qGSJEUIkd/jjxanTTxph0kTjpou6VCx89qOvGKAmAbP1hrlaOcRmEuNGcr9xqyUukM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dY8eQGHH; arc=pass smtp.client-ip=74.125.231.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY8eQGHH"
Received: by mail-oo2-f9.google.com with SMTP id 006d021491bc7-6d7ad305c8cso401663eaf.1
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 06:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790773851; cv=none;
        d=google.com; s=arc-20260327;
        b=R8CJ01cpKso9xfr89VKkiS22H7aCvPdCoV9QO4Lb9fvDA8uNLZo/sk9NCn0ZMRC0TV
         CGD/NHNrW2yoKNVXrMiI4vCiHUfueQP4G6b1mk0gZjhsNSV0z2YocDTjKB7TgdC32axG
         sTy3JjtNOq8pYXh95F7+w6bKXE93L5o8R28KKe4OgdExGEhBckDU3USFuvxLFlJFPoUE
         Z7rUp3m5aXESAMalSz3XHakrAV9J9JKUDOSyLumac3SNhkAACM/VHmY1GzmYvfn+t3qZ
         pimiE74zO9at7FZwm2B9xhk7VALyPk25q120y+pkwA3mW72WgbPzpxSHFrtge4qBvtwl
         R4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gQtg4eC4/C3SGxcXut+XpDI6IljnJk6iuQcsV10VYmI=;
        fh=fb/LA2HAPJE+TkCgdziaFBE6dtcTB0prGBJOaGmoqJQ=;
        b=ogpfoxjTAM1prJVLbMB/4QSARRmShLpQjGXb+X1tT0iZP5jLjn5Ev6X/j+1lGnVxHf
         AbtiXqPqjot5SQI5AccexrX/OQBYQmiaW9gE7mzVQbzX65icc1UdcqJXGEGz4qaFqgyO
         kvPnqHR7dUVdO66wd0Mo71ChI5NJZFq7TivQ3e76hbilHxNWi8O/WmVn+vt1bFdwIKOl
         phYplvEVqZf4bAhljIiepBaRtYYqe0RM8Q4gB1J+/jtUfD2GSXW3gXtj0GujhGJJEy/6
         ayql3veYtDOFbTLpruhvlyW9fnmhfiu4qbiQyJ1DSUDOEPTALTPcxZ7kceDiEaLHRKfa
         QcEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773851; x=1791378651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gQtg4eC4/C3SGxcXut+XpDI6IljnJk6iuQcsV10VYmI=;
        b=dY8eQGHHxj2ItMJ5f+bTTAJjOwQYmNhlUS4xPkpCjF6aGakt0C8Lv2+W4FJBJ2h9C9
         XUoowUgI3y5yXy1T2XztAGQ6VTbinKdu59gq5DPfoPejPtiT8k5/SwmTZprxXLFa96Fi
         htLvHUDa4xgBpSL8nuPWEfe2veeTJJMZwFf73ufjnlGbxjcKZs1bD+ZJfFzbQTbZcDlQ
         R4k/qnZb8t76J6AG2Gj01MmGHL9Na9pweZDn8eiJrURI/Hw9tgJOOJ7IkYrqLsSqWQh8
         muhqK1cS+x1nFHhIehYHSnZIl6Q91Yk9tab5q/p/lzX3u8aRg8/bti3wbSXoGY0w5f73
         Dfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773851; x=1791378651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQtg4eC4/C3SGxcXut+XpDI6IljnJk6iuQcsV10VYmI=;
        b=D5AFnh7/EgFnVcY1hpsrtDizO34GVszOEdIy7n6icda0CDgivjysNWLFaqEL/lSIzb
         1pLecoPi8Cab7sEprbbsr2qzFArhKL5K2mXYpMDS7xvgZWtxnE5GpK49HOKmN8Jzt0+w
         1pdKAfp/QJoDU1Vyi6hQZlD7NS5rZV1JRE34uIg69hiy80SWn2Ed8uP7QpZglH9zxiyA
         WDiH7i2R1ZlY/W0TF1+cbCboCCJdddfRt14+SSPbo1cMZoFOfSZa+qcm0KppBk1oHc8I
         B3ulVNHoEcmYNTEbGIzv5dYQmXjQOCt9xn7+KXQyr0+hqQHQuCFlxFBjdgrNOGQaDPg+
         nQaQ==
X-Forwarded-Encrypted: i=1; AKwUvBz3OfXF6uysLSaz+XtH+yF+284wDeEKX2CzcrMsvoQ/i5lg22+G70+IxdQQk+NUrSLqZrP4XRPNLm1hNg==@vger.kernel.org
X-Gm-Message-State: AFuF++mrEr/Z5H6Fnbf1+Yj84BkzZsN06xakbqes0QHLOP4qFtzWZdTj
	S8fT0dxXbYQOSKTgz1YhrNVSq6WeuWU/ypomzFEifFVYqxET/B98x8tomP8lJSG/XDPCnMDEGcg
	LVvwxF9Wn1lOCz5LyVMP8im1ZK5kZ/Zc=
X-Gm-Gg: AYBFou18qgH90jAW/AXu1X9nR9pjScux4Jp4tQSjJ/nUumRW0NP5VnSmjpvcyTi8rly
	PDciDVcvvkvPz2fiQnT+5zhJke1hOj1eXnnI+K6L0EA1Y74FwZRypXsedJX1ApyUisHCpwAHlse
	3esuiokXOW8O/pUbF15aF7O9s8B85m9yhqVsYstvGyvvzxoNbOT1D4aRjWUA93l1y8Gj2lTHDg7
	avsyuQOj72kcJ5rroR+XiJAPUmdrgyaucIow3wK619qEgSZp/2cPM9FS+g5mnlRTXQYlNCYzmRD
	57uz0sxGi4P232gxQ/FXC3lGvjF5ECegtnFxmFfGXjOLlAyyBaAOig==
X-Received: by 2002:a05:6820:188d:b0:6dc:b5:32c3 with SMTP id
 006d021491bc7-6dcf700cf17mr1237983eaf.89.1790773851184; Wed, 30 Sep 2026
 06:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625080807.74157-1-exalt.dev.team@gmail.com> <20260913044642.16058-1-exalt.dev.team@gmail.com>
In-Reply-To: <20260913044642.16058-1-exalt.dev.team@gmail.com>
From: dev exalt <exalt.dev.team@gmail.com>
Date: Wed, 30 Sep 2026 16:10:38 +0300
X-Gm-Features: AclHuK9hO7A5plwzOR2cFONCxheQXj8O1Y7Nkjy_x1vYZtSadZnrHMLmakmfwHM
Message-ID: <CAJaUH_8p8Na2U3VxhHXzv4Wbf3ykA7FJyrxwGUGc5tjgOH3dLw@mail.gmail.com>
Subject: Re: [PATCH v9] HID: logitech-hidpp: Add support for HID++
 Multi-Platform feature (0x4531)
To: jikos@kernel.org, bentiss@kernel.org
Cc: lains@riseup.net, hadess@hadess.net, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sari.kreitem@exalt.corp-partner.google.com, 
	hbarnor@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

We wanted to follow up on the HID++ Multi-Platform (0x4531) patch
series, as we have not yet received any feedback on the latest
version.

Thank you again for your time and review.

Best regards,
Baraa

On Sun, Sep 13, 2026 at 7:47=E2=80=AFAM DevExalt <exalt.dev.team@gmail.com>=
 wrote:
>
> From: "Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>
>
> Add support in the Logitech HID++ driver for the HID++ Multi-Platform
> feature (0x4531), which enables HID++ devices to adjust their behavior
> based on the host operating system.
>
> This patch:
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
> How the feature works:
>
> The HID++ 2.0 Multi-Platform feature consists of multiple
> platform descriptors. Each descriptor has a platform index and
> a 16-bit platform mask (`osMask`) identifying the operating
> systems it supports. A descriptor may support one or more
> operating systems when they share the same device behavior.
>
> When an operating system name is written to the platform attribute,
> the driver searches the device's platform descriptors for a
> descriptor whose `osMask` contains the requested operating
> system. The driver then selects that descriptor by its platform
> index and instructs the device to switch to it.
>
> When the platform attribute is read, the driver obtains the currently
> active platform index from the device, finds the corresponding
> platform descriptor, and reports all operating systems contained
> in that descriptor's `osMask`.
>
> For example, if the active descriptor supports both iOS and
> macOS, reading this attribute returns: ios macos
>
> The returned value represents the operating systems covered by
> the active platform descriptor, rather than a single selected
> operating system. The device reports only the active platform
> index and does not report which operating system name was
> originally used to select it.
>
> Userspace can therefore determine whether its target operating
> system is active by checking whether its name is present in the
> space-separated list returned by reading the platform attribute.
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
> Changes in V6:
>   * Address Bastien review comments.
>   * Index platform names by their platform mask values instead of maintai=
ning
>     parallel mask and name arrays.
>   * Remove the Casa Keys and MX Keys S keyboard entries from hid-quirks.c
>   * Make the platform sysfs attribute read/write, with the read operation
>     exposing the operating systems corresponding to the device's current
>     platform index for easier verification and testing.
>
> Changes in V7:
>   * Address Sashiko review comments.
>   * Update the commit message.
>
> Chages in V8:
>   * Address Greg Comments.
>   * Update the platfrom sysfs ABI documentation.
>   * Make the platform sysfs attribute one of the default attributes of th=
e
>     device and using is_visible callback to enable it.
>
> Changes in V9:
>   * Address Greg Comments.
>   * Update the commit message and the platform attribute ABI documentatio=
n.
>
>  .../testing/sysfs-driver-hid-logitech-hidpp   |  70 ++
>  drivers/hid/hid-logitech-hidpp.c              | 602 ++++++++++++++++++
>  2 files changed, 672 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp b/=
Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
> index d8f831f2d6b5..14c8c5d8eff9 100644
> --- a/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-logitech-hidpp
> @@ -17,3 +17,73 @@ Description:
>                 handling battery properties in the kernel. This way, upow=
er can
>                 add a udev rule to decide whether or not it should use th=
e
>                 internal unifying support or the generic kernel one.
> +
> +What:          /sys/bus/hid/drivers/logitech-hidpp-device/<dev>/platform
> +Date:          Sep, 2026
> +KernelVersion: 7.2
> +Contact:       linux-input@vger.kernel.org
> +Description:
> +               (RW) This attribute is present only on Logitech HID++ 2.0=
 devices
> +               that implement feature 0x4531 (Multi-Platform). It allows=
 the host
> +               to select which operating-system platform the device shou=
ld emulate,
> +               altering its key mapping and behaviour accordingly.
> +
> +               Reading it returns the platform the device is currently c=
onfigured
> +               with for this host. A platform may cover several operatin=
g systems,
> +               in which case all of their names are listed, separated by=
 spaces
> +               (for example "windows linux android").
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
> +               Reading returns -ENODATA when the device reports no platf=
orm
> +               is currently configured for this host.
> +
> +               How the feature works:
> +
> +               The HID++ 2.0 Multi-Platform feature consists of multiple
> +               platform descriptors. Each descriptor has a platform inde=
x and
> +               a 16-bit platform mask (`osMask`) identifying the operati=
ng
> +               systems it supports. A descriptor may support one or more
> +               operating systems when they share the same device behavio=
r.
> +
> +               When an operating system name is written to this attribut=
e, the
> +               driver searches the device's platform descriptors for a
> +               descriptor whose `osMask` contains the requested operatin=
g
> +               system. The driver then selects that descriptor by its pl=
atform
> +               index and instructs the device to switch to it.
> +
> +               When this attribute is read, the driver obtains the curre=
ntly
> +               active platform index from the device, finds the correspo=
nding
> +               platform descriptor, and reports all operating systems co=
ntained
> +               in that descriptor's `osMask`.
> +
> +               For example, if the active descriptor supports both iOS a=
nd
> +               macOS, reading this attribute returns:
> +
> +                       ios macos
> +
> +               The returned value represents the operating systems cover=
ed by
> +               the active platform descriptor, rather than a single sele=
cted
> +               operating system. The device reports only the active plat=
form
> +               index and does not report which operating system name was
> +               originally used to select it.
> +
> +               Userspace can therefore determine whether its target oper=
ating
> +               system is active by checking whether its name is present =
in the
> +               space-separated list returned by reading this attribute.
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 90b0184df777..1cb78096f31c 100644
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
> @@ -4423,6 +4426,598 @@ static bool hidpp_application_equals(struct hid_d=
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
> + * Reading it reports the platform currently selected by the device as t=
he
> + * space separated list of the platform names the selected platform desc=
riptor covers.
> + */
> +
> +#define HIDPP_MULTIPLATFORM_FEAT_ID                    0x4531
> +#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO           0x00
> +#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR    0x10
> +#define HIDPP_MULTIPLATFORM_GET_CURRENT_PLATFORM       0x20
> +#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM       0x30
> +
> +/* Host index selecting the host the device is currently connected to. *=
/
> +#define HIDPP_MULTIPLATFORM_HOST_CURRENT               0xFF
> +
> +/* Platform index reported for a host that has no platform configured. *=
/
> +#define HIDPP_MULTIPLATFORM_PLAT_IDX_UNDEFINED         0xFF
> +
> +/*
> + * Bit positions of the platforms within the 16-bit platform mask report=
ed by
> + * the platform descriptors. The mask of a given platform is BIT(value).
> + */
> +enum hidpp_multiplatform_platform {
> +       HIDPP_MULTIPLATFORM_PLATFORM_TIZEN      =3D 0,
> +       HIDPP_MULTIPLATFORM_PLATFORM_WINDOWS    =3D 8,
> +       HIDPP_MULTIPLATFORM_PLATFORM_WINEMB     =3D 9,
> +       HIDPP_MULTIPLATFORM_PLATFORM_LINUX      =3D 10,
> +       HIDPP_MULTIPLATFORM_PLATFORM_CHROME     =3D 11,
> +       HIDPP_MULTIPLATFORM_PLATFORM_ANDROID    =3D 12,
> +       HIDPP_MULTIPLATFORM_PLATFORM_MACOS      =3D 13,
> +       HIDPP_MULTIPLATFORM_PLATFORM_IOS        =3D 14,
> +       HIDPP_MULTIPLATFORM_PLATFORM_WEBOS      =3D 15,
> +};
> +
> +struct hidpp_platform_desc {
> +       u8 plat_idx;
> +       u8 desc_idx;
> +       u16 plat_mask;
> +};
> +
> +/*
> + * Platform names exposed through the "platform" sysfs attribute, indexe=
d by
> + * their bit position in the platform mask. Bit positions the specificat=
ion
> + * does not assign a platform to are left as NULL holes and must be skip=
ped
> + * when walking the array.
> + */
> +static const char * const multiplatform_names[] =3D {
> +       [HIDPP_MULTIPLATFORM_PLATFORM_TIZEN]    =3D "tizen",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_WINDOWS]  =3D "windows",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_WINEMB]   =3D "winemb",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_LINUX]    =3D "linux",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_CHROME]   =3D "chrome",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_ANDROID]  =3D "android",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_MACOS]    =3D "macos",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_IOS]      =3D "ios",
> +       [HIDPP_MULTIPLATFORM_PLATFORM_WEBOS]    =3D "webos",
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
> + * hidpp_multiplatform_get_platform_mask() - Find the platform mask for =
a platform index
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @plat_index: Platform index to find the platform mask of
> + * @plat_mask: Pointer to store the found platform mask
> + *
> + * A platform is the union of one or more platform descriptors, each cov=
ering
> + * its own set of operating systems. This walks all platform descriptors=
 exposed
> + * by the device and accumulates the platform masks of every descriptor
> + * belonging to @plat_index, yielding the full set of platforms covered =
by it.
> + *
> + * Return: 0 on success; -EOPNOTSUPP if the device exposes no descriptor
> + *         belonging to @plat_index; or another negative Linux errno on
> + *         transport failure.
> + */
> +static int hidpp_multiplatform_get_platform_mask(struct hidpp_device *hi=
dpp,
> +                                                u8 feat_index, u8 plat_i=
ndex,
> +                                                u16 *plat_mask)
> +{
> +       int i;
> +       int ret;
> +       u8 num_desc;
> +       u16 mask =3D 0;
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
> +               if (pdesc.plat_idx =3D=3D plat_index)
> +                       mask |=3D pdesc.plat_mask;
> +       }
> +
> +       if (!mask) {
> +               hid_dbg(hdev,
> +                       "Multiplatform: No platform descriptor for platfo=
rm index %d",
> +                       plat_index);
> +               return -EOPNOTSUPP;
> +       }
> +
> +       hid_dbg(hdev, "Multiplatform: Platform index %d covers mask 0x%04=
x",
> +               plat_index, mask);
> +       *plat_mask =3D mask;
> +
> +       return 0;
> +}
> +
> +/**
> + * hidpp_multiplatform_get_current_platform_index() - Query the device c=
urrent platform index
> + * @hidpp: Pointer to the hidpp_device instance
> + * @feat_index: Feature index of the Multi-Platform feature
> + * @plat_index: Pointer to store the platform index reported by the devi=
ce
> + *
> + * Sends the HID++ Multi-Platform 'GET_CURRENT_PLATFORM' command for the=
 host
> + * the device is currently connected to and stores the platform index it=
 reports
> + * in @plat_index.
> + *
> + * Return: 0 on success; -ENODATA if the host has no platform configured=
; or
> + *         another negative Linux errno on failure.
> + */
> +static int hidpp_multiplatform_get_current_platform_index(struct hidpp_d=
evice *hidpp,
> +                                                   u8 feat_index, u8 *pl=
at_index)
> +{
> +       int ret;
> +       struct hidpp_report response;
> +       u8 params[1] =3D { HIDPP_MULTIPLATFORM_HOST_CURRENT };
> +       struct hid_device *hdev =3D hidpp->hid_dev;
> +
> +       ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> +                                         HIDPP_MULTIPLATFORM_GET_CURRENT=
_PLATFORM,
> +                                         params, sizeof(params), &respon=
se);
> +       if (ret) {
> +               hid_warn(hdev, "Multiplatform: GET_CURRENT_PLATFORM faile=
d (err=3D%d)", ret);
> +               return hidpp_multiplatform_errno(ret);
> +       }
> +
> +       if (response.fap.params[2] =3D=3D HIDPP_MULTIPLATFORM_PLAT_IDX_UN=
DEFINED) {
> +               hid_dbg(hdev, "Multiplatform: Current host has no platfor=
m configured");
> +               return -ENODATA;
> +       }
> +
> +       *plat_index =3D response.fap.params[2];
> +       hid_dbg(hdev, "Multiplatform: Current platform index is %d", *pla=
t_index);
> +
> +       return 0;
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
> +       u8 params[2] =3D { HIDPP_MULTIPLATFORM_HOST_CURRENT, plat_index }=
;
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
> + * @mask: A single BIT(HIDPP_MULTIPLATFORM_PLATFORM_*) mask to apply
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
> + * hidpp_multiplatform_get_current_platform_mask() - Query the device cu=
rrent platform mask
> + * @hidpp: Pointer to the hidpp_device instance
> + * @mask: Pointer to store the device platform mask in use
> + *
> + * Asks the device which platform is configured for the current host and
> + * resolves it into the mask of operating systems that platform covers.
> + *
> + * Return: 0 on success, -EOPNOTSUPP if the device does not implement fe=
ature
> + *         0x4531 or exposes no descriptor for its current platform, or =
another
> + *         negative Linux errno from the underlying HID++ command.
> + */
> +static int hidpp_multiplatform_get_current_platform_mask(struct hidpp_de=
vice *hidpp, u16 *mask)
> +{
> +       u8 plat_index;
> +       int ret;
> +
> +       if (!hidpp->multiplatform_feature_index)
> +               return -EOPNOTSUPP;
> +
> +       ret =3D hidpp_multiplatform_get_current_platform_index(hidpp,
> +                       hidpp->multiplatform_feature_index, &plat_index);
> +       if (ret)
> +               return ret;
> +
> +       return hidpp_multiplatform_get_platform_mask(hidpp,
> +                       hidpp->multiplatform_feature_index, plat_index, m=
ask);
> +}
> +
> +/**
> + * platform_show() - Report the device's current platform
> + * @dev: Pointer to the device instance
> + * @attr: Pointer to the device attribute
> + * @buf: Buffer to store the platform names in
> + *
> + * Queries the platform mask the device is configured with for the curre=
nt host and
> + * emits the names of all the platforms it covers as a space separated l=
ist.
> + *
> + * Return: Number of bytes written to @buf on success, or a negative Lin=
ux errno
> + * on failure.
> + */
> +static ssize_t platform_show(struct device *dev,
> +                            struct device_attribute *attr, char *buf)
> +{
> +       struct hid_device *hdev =3D to_hid_device(dev);
> +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> +       unsigned long mask;
> +       unsigned int idx;
> +       int len =3D 0;
> +       u16 plat_mask;
> +       int ret;
> +
> +       mutex_lock(&hidpp->multiplatform_lock);
> +       ret =3D hidpp_multiplatform_get_current_platform_mask(hidpp, &pla=
t_mask);
> +       mutex_unlock(&hidpp->multiplatform_lock);
> +       if (ret)
> +               return ret;
> +
> +       /* Mask bits the specification assigns no platform to are skipped=
. */
> +       mask =3D plat_mask;
> +       for_each_set_bit(idx, &mask, ARRAY_SIZE(multiplatform_names))
> +               if (multiplatform_names[idx])
> +                       len +=3D sysfs_emit_at(buf, len, "%s%s",
> +                                            len ? " " : "", multiplatfor=
m_names[idx]);
> +
> +       return len + sysfs_emit_at(buf, len, "\n");
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
> +       unsigned int idx;
> +       int ret;
> +
> +       strscpy(platform, buf, sizeof(platform));
> +       string_lower(platform, platform);
> +
> +       /*
> +        * multiplatform_names[] contains NULL holes, so sysfs_match_stri=
ng()
> +        * cannot be used here: it stops at the first NULL entry.
> +        */
> +       for (idx =3D 0; idx < ARRAY_SIZE(multiplatform_names); idx++)
> +               if (multiplatform_names[idx] &&
> +                   sysfs_streq(multiplatform_names[idx], platform))
> +                       break;
> +
> +       if (idx =3D=3D ARRAY_SIZE(multiplatform_names))
> +               return -EINVAL;
> +
> +       mutex_lock(&hidpp->multiplatform_lock);
> +       ret =3D hidpp_multiplatform_set_platform(hidpp, BIT(idx));
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
> +static DEVICE_ATTR_RW(platform);
> +
> +static struct attribute *multiplatform_attrs[] =3D {
> +       &dev_attr_platform.attr,
> +       NULL
> +};
> +
> +/**
> + * multiplatform_is_visible() - Determine whether the platform attribute=
 should be exposed
> + * @kobj: kobject of the device the group is being evaluated for
> + * @attr: Attribute being evaluated
> + * @n: Index of the attribute within the group
> + *
> + * The "platform" attribute is only meaningful for devices that support =
the
> + * HID++ Multi-Platform feature (0x4531), which is only known once probe=
() has
> + * queried it. Hiding it via this callback, rather than creating/removin=
g the
> + * sysfs group at runtime, lets the group be registered as one of the dr=
iver's
> + * default device attribute groups so it is added atomically by the driv=
er
> + * core as part of binding instead of racing with userspace.
> + *
> + * Return: The attribute's mode if the attribute should be visible, or 0=
 to hide it.
> + */
> +static umode_t multiplatform_is_visible(struct kobject *kobj, struct att=
ribute *attr, int n)
> +{
> +       struct hid_device *hdev =3D to_hid_device(kobj_to_dev(kobj));
> +       struct hidpp_device *hidpp =3D hid_get_drvdata(hdev);
> +
> +       if (!hidpp || !hidpp->multiplatform_feature_index)
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
> +static const struct attribute_group multiplatform_attribute_group =3D {
> +       .attrs =3D multiplatform_attrs,
> +       .is_visible =3D multiplatform_is_visible,
> +};
> +
> +static const struct attribute_group *hidpp_groups[] =3D {
> +       &multiplatform_attribute_group,
> +       NULL
> +};
> +
> +/**
> + * hidpp_multiplatform_init() - Initialize HID++ Multi-Platform support
> + * @hidpp: Pointer to the hidpp_device instance
> + *
> + * Checks if the device supports the HID++ Multi-Platform feature (0x453=
1) and, if so,
> + * initializes the hidpp_device structure to track the feature index.
> + */
> +static void hidpp_multiplatform_init(struct hidpp_device *hidpp)
> +{
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
> +}
> +
> +/**
> + * hidpp_multiplatform_cleanup() - Cleanup HID++ Multi-Platform support
> + * @hidpp: Pointer to the hidpp_device instance
> + *
> + * Destroys the mutex used for synchronizing access to the Multi-Platfor=
m feature.
> + * This function should be called during device removal or driver cleanu=
p to ensure
> + * proper resource management.
> + */
> +static void hidpp_multiplatform_cleanup(struct hidpp_device *hidpp)
> +{
> +       if (!hidpp->multiplatform_feature_index)
> +               return;
> +
> +       mutex_destroy(&hidpp->multiplatform_lock);
> +}
> +
>  static int hidpp_probe(struct hid_device *hdev, const struct hid_device_=
id *id)
>  {
>         struct hidpp_device *hidpp;
> @@ -4545,6 +5140,8 @@ static int hidpp_probe(struct hid_device *hdev, con=
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
> @@ -4557,6 +5154,7 @@ static int hidpp_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
>  hid_hw_open_fail:
>         hid_hw_stop(hdev);
>  hid_hw_start_fail:
> +       hidpp_multiplatform_cleanup(hidpp);
>         sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>         cancel_work_sync(&hidpp->work);
>         mutex_destroy(&hidpp->send_mutex);
> @@ -4570,6 +5168,7 @@ static void hidpp_remove(struct hid_device *hdev)
>         if (!hidpp)
>                 return hid_hw_stop(hdev);
>
> +       hidpp_multiplatform_cleanup(hidpp);
>         sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
>
>         hid_hw_stop(hdev);
> @@ -4782,6 +5381,9 @@ static struct hid_driver hidpp_driver =3D {
>         .input_configured =3D hidpp_input_configured,
>         .input_mapping =3D hidpp_input_mapping,
>         .input_mapped =3D hidpp_input_mapped,
> +       .driver =3D {
> +               .dev_groups =3D hidpp_groups,
> +       },
>  };
>
>  module_hid_driver(hidpp_driver);
> --
> 2.34.1
>
