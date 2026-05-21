Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6D36A02F
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355641; cv=pass; b=F9kPOikClBjIHSLU6D2TvF2rdBUsogXKMnb1Z7/xwPh+gkKkUo8cmYH00wZh1pF8WpmZMAF5QxddiYfYXPAtmIdZEQ+ccQ4HpnQ0DZdufJWPnAzGq9gFODgD/Dl6VkgFkE5OUzmNoW41/BAueahmagXGFnRH623ylAIHRoidpsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355641; c=relaxed/simple;
	bh=hbvyv8rnteTewKh3fb47ZXEN1vmBFCWrgyjVd13XSXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+vz/islXzyN5EDfE7+GdLVHwsUBSkvvm6TAttbrpl+UEpMy2AnJZQrGfcVx31/p8cX3p3WSJkmtlfCiSFxajBl6Et+W7AQ8ZEiG/ILuHykRCtQtJS5Oqw3qZiU8cRni9lqCkJYxhBlCrbsYPwBmxQvP1xKQvYx/4uHyxS20RBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNxYA4SY; arc=pass smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNxYA4SY"
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-47cba53479aso4120738b6e.0
        for <linux-input@vger.kernel.org>; Thu, 21 May 2026 02:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779355637; cv=none;
        d=google.com; s=arc-20240605;
        b=jeyQNCPg2Z8MruEARHT5pHShJKuIKqSWbRC/VdKOQu/5Vi7s9YxtOlBit58ZWZhdsL
         PY06OSkdAKeecjKpDW4zHdQyB2f88ps08BbXks/IBl+K1XeWmA0HejAoBj2oGBHFEFrr
         vwtXabDgavPEWylzonSph8LUsANhspFGL2NvCvIDNraS7dC2JdU1MhxoyjodAiOdyttl
         5bwXAlPwt5KS8tWo774IxzF8s0PLrMf4E4gN6rQTgYkXlDIdSOWgr10HMtcbG+ZWsu5F
         255/OCSUBxgq6GjXMORhmwBMSW13dSImeFwVcCc0sn3J/IvTqPRSKvVSyzZqH0GJXFuf
         JDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T40mBleF4D4lWMITKEDhURONZ/OwrEF12YbANQ2Ydts=;
        fh=yF3rp1wpX26RJLPEqLlcj8G/EgverHw/Nw3oRN7rMi4=;
        b=bAt3cdSWQRKQqTruk9sR0N+XJ5q8OhQMkKOWUcOPcv5DxwH1R6kZK+rC65y/lJy1H1
         Lx1SS6uVysj2kzai8BFWUagl6xx99lD17HGrUyEcBRXibDGrviAaGV+9VTJgtL8YZYGm
         VzYicGZNry1AzoqWsTTx4jXixKACtkUB5PUXWPVuIx4zpXC8f/lc3lNU/srZVZNhN8w4
         UBuo/oyx9DvjWSdcLFmPR8XxhUJ88zTCBy7EjHQdB0odsVh9s72+sgBRUAIJ1o8E14SL
         DmKPLERHJdHjUIxDV5yth3xLdOBeS6ddCozn2lYh+8EimM9O3KwtWOze+m7f2fTd8+BG
         B+Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779355637; x=1779960437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T40mBleF4D4lWMITKEDhURONZ/OwrEF12YbANQ2Ydts=;
        b=oNxYA4SYcp+kpiiUe3QJDGuaGXXHECNb0DtCvUPPbsGrOm1Y9I04kAnEMvhRzDal8s
         Sw9l4HHASeesW0+Pctw4jnu8/JQnNOUgazJs41m1U3dCB+1SGOCJBwVA0TTp7H2bZtv1
         q7wtaTv7v0e8BleEHz6+/NB2RD9bm3rVow49hxbLDWq6wMw5K5r1cUxTiNoN8mRGxZPi
         GZVu7Tea9IZJz5JpYoEFxXsO1D/gn8hkN8OLoPQ5WSJIyq7VbvWfwMrualbtfxBRn0GL
         RBu9CVIB3GcKBgMGjm3rGVthQCYUlbubbBMwSKQtXE2mgAAa3Cv2Ncu6BevqQj2hhBA+
         2iUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779355637; x=1779960437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T40mBleF4D4lWMITKEDhURONZ/OwrEF12YbANQ2Ydts=;
        b=bp6BQOpS2A53o74LxiQdUpiu9rasnCYN12mlvzI+YtXBMNfZfAEpV9iFVbhQS2c8BB
         pC+eID1bud/Fmldpv4L8isyRHgsqcf9OS87jYEiHDKcHA7aWGyd/7YVX4UgPsVRNWwJ0
         MtG2tiRKNn87bZNrKj54KS0j7PcJXUREbX4eatqfSVIrPm2xkrLtmLE1ymzthAJ7LE89
         OFcPnMZTBfcKbzesUti5h78hhHS3UzI3fVRboO7fg4d+s0PvxEoSiasd4j5u6TOUwDZ7
         Er3ldIb8Ik0SLjIE3rnY014maxzd6J7ehCRS7VsoSROcowz7+FLYNkeX+L+IQjRPUuKj
         XqRg==
X-Forwarded-Encrypted: i=1; AFNElJ+wTGy2pLK9bLO04fKNtNrbjqdRZIZWsgI/BgYK0XMx/EmsMzxAFjoYvPB036x4j7EB6oqadvKi6ZXr1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRLveMbl5PihatH+cyNrIVMLjWWYXclqZIuqKDJQX43vMDYH2l
	qav5tsoOGip6Gctqy30w2P6erMAa9sjELwnZL0wLkarrpfUdQDSH1sNPQWGmmcU+kzfqLO02mwz
	/Ax9SwXFWWJBRmFmpXhIRd0g4zIJ58XY=
X-Gm-Gg: Acq92OFdwGluKJYok9DQiobOcrQb052Fc92fYJzWX505aYNtpZQfEWY882Cz4hv9Hn2
	SjPyPI8S+5CTVA72zF7RPRCYZp4IWm6dObBWOPbW7mTCeavlS+uhTbtYjQoDPRooy75BzUCt6b6
	kaWMW0CLVP2s3jzbeW65sGMRkQn65t7EIOBYAAdVOirmuBRE/OG7JvB7VI6isNs/UwGCxqVJA0b
	UEV0Hm3IvLJpH1wQTZwSg4Qp5byKzhcJZa2EVsvv1Id0lurfLBQUZk+eEVCgMZdqzBfekLtcnk+
	dgoIzFGT
X-Received: by 2002:a05:6820:1b08:b0:69d:6bbf:3feb with SMTP id
 006d021491bc7-69d6ef1da63mr858739eaf.42.1779355636653; Thu, 21 May 2026
 02:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215125319.33261-1-exalt.dev.team@gmail.com>
 <b1a7b5ab35c5dc16753e6a4ce98837d26c0eb98a.camel@hadess.net>
 <CAJaUH_-0vDrXTr==n=eKJH+BmhDRjzpd6s9by2yTMJH9VuD+gA@mail.gmail.com> <CAJaUH_-aPMopA90xthPMVhktyyL6WHJPgn748yQ95UAVgaaaFQ@mail.gmail.com>
In-Reply-To: <CAJaUH_-aPMopA90xthPMVhktyyL6WHJPgn748yQ95UAVgaaaFQ@mail.gmail.com>
From: dev exalt <exalt.dev.team@gmail.com>
Date: Thu, 21 May 2026 12:27:05 +0300
X-Gm-Features: AVHnY4Kkz4eLa2NekjOQguNNWEma9V5816TgXvc-xcOfSzh7MrWPHLm0ylFrogc
Message-ID: <CAJaUH_8Tg=QCB96aFBu_zvJd03EN6zgBvS8RGGvN4UonjTJ7_w@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Add support for HID++ Multi-Platform
 feature (0x4531)
To: Bastien Nocera <hadess@hadess.net>
Cc: jikos@kernel.org, bentiss@kernel.org, lains@riseup.net, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sari.kreitem@exalt.corp-partner.google.com, hbarnor@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Following up on this thread regarding HID++ Multi-Platform feature
(0x4531) support.
Please let us know if you=E2=80=99d like us to proceed with a V2 patch base=
d
on the discussed approach.

Thanks,
Baraa

On Sun, May 10, 2026 at 9:36=E2=80=AFAM dev exalt <exalt.dev.team@gmail.com=
> wrote:
>
> Hi Bastien,
>
> Just following up on this thread in case you had a chance to review
> our latest response.
>
> Would you be OK with us proceeding with the implementation and
> preparing a v2 patch based on it?
>
> Thanks,
> Baraa
>
> On Thu, Mar 19, 2026 at 12:05=E2=80=AFPM dev exalt <exalt.dev.team@gmail.=
com> wrote:
> >
> > Hi Bastien,
> >
> > Thanks for the review. Please see our responses inline below.
> >
> > On Mon, Mar 9, 2026 at 11:53=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et> wrote:
> > >
> > > Hey,
> > >
> > > Sorry for not looking at this earlier, it slipped through the cracks =
as
> > > it arrived on the mailing-list as I was away.
> > >
> > > On Mon, 2025-12-15 at 14:53 +0200, DevExalt wrote:
> > > > From: "Baraa Atta (Dev Exalt)" <exalt.dev.team@gmail.com>
> > > >
> > > > Add support in the Logitech HID++ driver for the HID++ Multi-Platfo=
rm
> > > > feature (0x4531), which enables HID++ devices to adjust their
> > > > behavior
> > > > based on the host operating system (Linux, ChromeOS, Android).
> > >
> > > Can you please explain what the feature actually does ? (the Logitech
> > > docs say "Set the right keyboard layout for your computer operating
> > > system" and mention that some multimedia keys are inoperable unless a
> > > compatible OS is set).
> >
> > The HID++ Multi-Platform feature (0x4531) allows a device to select a
> > platform profile that determines how the device firmware behaves for a
> > specific operating system.
> >
> > In practice, this affects how certain keys and functions are exposed
> > to the host. Depending on the selected platform, the device may emit
> > different HID usages or key combinations for the same physical key.
> >
> > For example, on the Logitech MX Keys S keyboard a specific key
> > produces different events depending on the configured platform. When
> > the platform is set to Linux the key generates the combination Shift +
> > Ctrl + Alt + Meta + Space, while when the platform is set to Chrome
> > the same key generates a dedicated Emoji key event (HID usage code
> > 585).
> >
> > The exact behavioral differences are device-specific and defined by
> > the device firmware.
> >
> > >
> > > >
> > > > This patch:
> > > >  * Adds device IDs for MX Keys S (046d:b378) and Casa Keys
> > > > (046d:b371).
> > > >  * Introduces the module parameter "hidpp_platform" to allow
> > > > selecting a
> > > >    target platform.
> > > >  * Detects whether a device implements feature 0x4531.
> > > >  * Validates that the requested platform is supported by the device=
.
> > > >  * Applies the platform index when valid, otherwise leaves the devi=
ce
> > > >    unchanged.
> > > >  * Keeps default behavior when "hidpp_platform" is unset or invalid=
.
> > >
> > > Can you explain the benefits of setting this module parameter, compar=
ed
> > > to using the keyboard shortcuts to switch to a specific OS
> > > configuration?
> >
> > The distribution can configure the parameter and have the OS configure
> > the device automatically without user interaction. Devices will just
> > work as expected out of the box. Users can still override it using the
> > keyboard shortcut.
> >
> > >
> > > What happens when 2 Logitech devices with different supported OSes ar=
e
> > > used?
> >
> > If a device does not support the platform specified through the module
> > parameter, the driver does not modify that device and its default
> > platform configuration remains unchanged.
> >
> > During initialization, the driver queries the device for the list of
> > supported platform descriptors exposed by the HID++ Multi-Platform
> > feature (0x4531). The requested platform is only applied if the device
> > advertises support for a compatible descriptor.
> >
> > For example, if two devices are connected and the module parameter is
> > set to linux, a device that supports the Linux platform descriptor
> > will have its platform updated accordingly, causing its firmware
> > behavior to switch to the Linux profile. A device that does not
> > advertise support for the Linux platform will not be modified and will
> > continue operating on its default configuration.
> >
> > >
> > > > Supported values for hidpp_platform:
> > > >    Android, Linux, Chrome
> > >
> > > Any reason why there aren't more supported OSes?
> > >
> > > The Logitech docs[1] lists:
> > > WebOS iOS MacOS Android Chrome Linux WinEmb Windows Tizen
> > > as possible values.
> > >
> > > [1]:
> > > https://drive.google.com/file/d/1KyiBA5m_5V1s6jQ9eQrgRJN0SbbbI9_I/vie=
w
> > >
> > > I recently got a K980 which has this functionality, it only documents
> > > Windows, macOS and Chrome, but Solaar also lists Linux as an option.
> > >
> > > So my questions would be:
> > > - why not support the whole range of possible OSes in this option?
> >
> > Our initial focus during development was primarily on Android, and we
> > subsequently added Linux and Chrome. However, if it is preferred for
> > completeness, we are happy to add the rest of supported OS platforms
> > listed in the documentation.
> >
> > > - why is it a module option instead of, say, a sysfs attribute that
> > > could be changed per device?
> > > - why not implement this in user-space through a udev callout?
> >
> > The module parameter was initially chosen to provide a simple,
> > system-wide default that distributions can configure at boot. This
> > ensures the devices work out of the box without relying on user
> > interaction.
> >
> > Following your question, we can also add a per-device sysfs attribute
> > alongside the module parameter. This hybrid approach accommodates
> > compatibility with all systems, since udev is not supported by all
> > distributions.
> >
> > >
> > > Cheers
> > >
> > > >
> > > > TEST=3DPair MX Keys S and Casa Keys over Bluetooth and verify:
> > > >      * Feature 0x4531 is detected.
> > > >      * Valid platform values are accepted and applied.
> > > >      * Invalid platform values result in no update.
> > > >      * Devices without 0x4531 retain default behavior.
> > > >      * Platform-specific key behavior is observed once applied.
> > > >
> > > > Signed-off-by: Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>
> > > > ---
> > > >  drivers/hid/hid-ids.h            |   2 +
> > > >  drivers/hid/hid-logitech-hidpp.c | 280
> > > > +++++++++++++++++++++++++++++++
> > > >  drivers/hid/hid-quirks.c         |   2 +
> > > >  3 files changed, 284 insertions(+)
> > > >
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index d31711f1aaec..12de1194d7fa 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -866,6 +866,8 @@
> > > >  #define USB_DEVICE_ID_LOGITECH_T651  0xb00c
> > > >  #define USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD       0xb309
> > > >  #define USB_DEVICE_ID_LOGITECH_CASA_TOUCHPAD 0xbb00
> > > > +#define USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD    0xb371
> > > > +#define USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD    0xb378
> > > >  #define USB_DEVICE_ID_LOGITECH_C007  0xc007
> > > >  #define USB_DEVICE_ID_LOGITECH_C077  0xc077
> > > >  #define USB_DEVICE_ID_LOGITECH_RECEIVER      0xc101
> > > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > > > logitech-hidpp.c
> > > > index d5011a5d0890..e94daed31981 100644
> > > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > > @@ -4373,6 +4373,280 @@ static bool hidpp_application_equals(struct
> > > > hid_device *hdev,
> > > >       return report && report->application =3D=3D application;
> > > >  }
> > > >
> > > > +/* ---------------------------------------------------------------=
--
> > > > --------- */
> > > > +/* 0x4531: Multi-Platform
> > > > Support                                             */
> > > > +/* ---------------------------------------------------------------=
--
> > > > --------- */
> > > > +
> > > > +/*
> > > > + * Some Logitech devices expose the HID++ feature 0x4531 (Multi-
> > > > Platform) allowing
> > > > + * the host to specify which operating system platform to use on t=
he
> > > > device. Changing device's
> > > > + * platform may alter the behavior of the device to match the
> > > > specified platform.
> > > > + */
> > > > +
> > > > +static char *hidpp_platform;
> > > > +module_param(hidpp_platform, charp, 0644);
> > > > +MODULE_PARM_DESC(hidpp_platform, "Select host platform type for
> > > > Logitech HID++ Multi-Platform feature "
> > > > +              "0x4531, valid values: (linux|chrome|android).  If
> > > > unset, no "
> > > > +              "change is applied.");
> > > > +
> > > > +#define HIDPP_MULTIPLATFORM_FEAT_ID                  0x4531
> > > > +#define HIDPP_MULTIPLATFORM_GET_FEATURE_INFO         0x0F
> > > > +#define HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR  0x1F
> > > > +#define HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM     0x3F
> > > > +
> > > > +#define
> > > > HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX               BIT(10)
> > > > +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME     BIT(11)
> > > > +#define HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID    BIT(12)
> > > > +
> > > > +struct hidpp_platform_desc {
> > > > +     u8 plat_idx;
> > > > +     u8 desc_idx;
> > > > +     u16 plat_mask;
> > > > +};
> > > > +
> > > > +/**
> > > > + * hidpp_multiplatform_mask_from_str() - Convert platform name to =
an
> > > > HID++ platform mask
> > > > + * @pname: Platform name string
> > > > + *
> > > > + * Converts a platform name string to its corresponding HID++
> > > > platform mask based on
> > > > + * the Multi-Platform feature specification.
> > > > + *
> > > > + * Return: Platform mask corresponding to @pname on success,
> > > > + * or 0 if @pname is NULL or unsupported.
> > > > + */
> > > > +static u16 hidpp_multiplatform_mask_from_str(const char *pname)
> > > > +{
> > > > +     if (!pname)
> > > > +             return 0;
> > > > +
> > > > +     if (!strcasecmp(pname, "linux"))
> > > > +             return HIDPP_MULTIPLATFORM_PLATFORM_MASK_LINUX;
> > > > +     if (!strcasecmp(pname, "chrome"))
> > > > +             return HIDPP_MULTIPLATFORM_PLATFORM_MASK_CHROME;
> > > > +     if (!strcasecmp(pname, "android"))
> > > > +             return HIDPP_MULTIPLATFORM_PLATFORM_MASK_ANDROID;
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * hidpp_multiplatform_get_num_pdesc() - Retrieve number of platfo=
rm
> > > > descriptors
> > > > + * @hidpp: Pointer to the hidpp_device instance
> > > > + * @feat_index: Feature index of the Multi-Platform feature
> > > > + * @num_desc: Pointer to store the number of platform descriptors
> > > > + *
> > > > + * Retrieves the number of platform descriptors supported by the
> > > > device through
> > > > + * the Multi-Platform feature and stores it in @num_desc.
> > > > + *
> > > > + * Return: 0 on success, or non-zero on failure.
> > > > + */
> > > > +static int hidpp_multiplatform_get_num_pdesc(struct hidpp_device
> > > > *hidpp,
> > > > +                                          u8 feat_index, u8
> > > > *num_desc)
> > > > +{
> > > > +     int ret;
> > > > +     struct hidpp_report response;
> > > > +     struct hid_device *hdev =3D hidpp->hid_dev;
> > > > +
> > > > +     ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> > > > +
> > > > HIDPP_MULTIPLATFORM_GET_FEATURE_INFO,
> > > > +                                       NULL, 0, &response);
> > > > +     if (ret) {
> > > > +             hid_warn(hdev, "Multiplatform: GET_FEATURE_INFO
> > > > failed (err=3D%d)", ret);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     *num_desc =3D response.fap.params[3];
> > > > +     hid_dbg(hdev, "Multiplatform: Device supports %d platform
> > > > descriptors", *num_desc);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * hidpp_multiplatform_get_platform_desc() - Retrieve a platform
> > > > descriptor entry
> > > > + * @hidpp: Pointer to the hidpp_device instance
> > > > + * @feat_index: Feature index of the Multi-Platform feature
> > > > + * @platform_idx: Index of the platform descriptor to retrieve
> > > > + * @pdesc: Pointer to store the retrieved platform descriptor
> > > > + *
> > > > + * Retrieves a single platform descriptor identified by
> > > > @platform_idx from the
> > > > + * device and stores the parsed descriptor fields in @pdesc.
> > > > + *
> > > > + * Return: 0 on success, or non-zero on failure.
> > > > + */
> > > > +static int hidpp_multiplatform_get_platform_desc(struct hidpp_devi=
ce
> > > > *hidpp, u8 feat_index,
> > > > +                                              u8 platform_idx,
> > > > struct hidpp_platform_desc *pdesc)
> > > > +{
> > > > +     int ret;
> > > > +     struct hidpp_report response;
> > > > +     u8 params[1] =3D { platform_idx };
> > > > +     struct hid_device *hdev =3D hidpp->hid_dev;
> > > > +
> > > > +     ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> > > > +
> > > > HIDPP_MULTIPLATFORM_GET_PLATFORM_DESCRIPTOR,
> > > > +                                       params, sizeof(params),
> > > > &response);
> > > > +
> > > > +     if (ret) {
> > > > +             hid_warn(hdev,
> > > > +                      "Multiplatform: GET_PLATFORM_DESCRIPTOR
> > > > failed for index %d (err=3D%d)",
> > > > +                      platform_idx, ret);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     pdesc->plat_idx =3D response.fap.params[0];
> > > > +     pdesc->desc_idx =3D response.fap.params[1];
> > > > +     pdesc->plat_mask =3D
> > > > get_unaligned_be16(&response.fap.params[2]);
> > > > +
> > > > +     hid_dbg(hdev,
> > > > +             "Multiplatform: descriptor %d: plat_idx=3D%d,
> > > > desc_idx=3D%d, plat_mask=3D0x%04x",
> > > > +             platform_idx, pdesc->plat_idx, pdesc->desc_idx,
> > > > pdesc->plat_mask);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * hidpp_multiplatform_get_platform_index() - Find platform index
> > > > for a mask
> > > > + * @hidpp: Pointer to the hidpp_device instance
> > > > + * @feat_index: Feature index of the Multi-Platform feature
> > > > + * @plat_mask: Platform mask to search for
> > > > + * @plat_index: Pointer to store the matched platform index
> > > > + *
> > > > + * Iterates through all platform descriptors exposed by the device
> > > > via the
> > > > + * Multi-Platform feature, retrieving each descriptor and comparin=
g
> > > > its
> > > > + * platform mask to @plat_mask. A descriptor matches if its mask
> > > > overlaps with
> > > > + * the requested @plat_mask (i.e. (pdesc.plat_mask & plat_mask) is
> > > > non-zero).
> > > > + *
> > > > + * When a matching descriptor is found, its platform index
> > > > (plat_idx) is
> > > > + * written to @plat_index and the function returns success.
> > > > + *
> > > > + * If no descriptor matches, -ENOENT is returned.
> > > > + *
> > > > + * Return: 0 on success; -ENOENT if no matching descriptor exists;
> > > > + *         or non-zero on failure.
> > > > + */
> > > > +static int hidpp_multiplatform_get_platform_index(struct
> > > > hidpp_device *hidpp,
> > > > +                                               u8 feat_index, u16
> > > > plat_mask,
> > > > +                                               u8 *plat_index)
> > > > +{
> > > > +     int i;
> > > > +     int ret;
> > > > +     u8 num_desc;
> > > > +     struct hidpp_platform_desc pdesc;
> > > > +     struct hid_device *hdev =3D hidpp->hid_dev;
> > > > +
> > > > +     ret =3D hidpp_multiplatform_get_num_pdesc(hidpp, feat_index,
> > > > &num_desc);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     for (i =3D 0; i < num_desc; i++) {
> > > > +             ret =3D hidpp_multiplatform_get_platform_desc(hidpp,
> > > > feat_index, i, &pdesc);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +
> > > > +             if (pdesc.plat_mask & plat_mask) {
> > > > +                     *plat_index =3D pdesc.plat_idx;
> > > > +                     hid_dbg(hdev,
> > > > +                             "Multiplatform: Selected platform
> > > > index %d for platform '%s'",
> > > > +                             *plat_index, hidpp_platform);
> > > > +                     return 0;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     hid_dbg(hdev,
> > > > +             "Multiplatform: No matching platform descriptor
> > > > found for platform '%s'",
> > > > +             hidpp_platform);
> > > > +     return -ENOENT;
> > > > +}
> > > > +
> > > > +/**
> > > > + * hidpp_multiplatform_update_device_platform() - Update the devic=
e
> > > > platform
> > > > + * @hidpp: Pointer to the hidpp_device instance
> > > > + * @feat_index: Feature index of the Multi-Platform feature
> > > > + * @plat_index: Platform index to set on the device
> > > > + *
> > > > + * Sends the HID++ Multi-Platform 'SET_CURRENT_PLATFORM' command t=
o
> > > > the device to
> > > > + * update its platform index to @plat_index.
> > > > + *
> > > > + * Return: 0 on success, or non-zero on failure.
> > > > + */
> > > > +static int hidpp_multiplatform_update_device_platform(struct
> > > > hidpp_device *hidpp,
> > > > +                                                   u8 feat_index,
> > > > u8 plat_index)
> > > > +{
> > > > +     int ret;
> > > > +     struct hidpp_report response;
> > > > +     /* Byte 0 (hostIndex): 0xFF selects the current host. */
> > > > +     u8 params[2] =3D { 0xFF, plat_index };
> > > > +
> > > > +     ret =3D hidpp_send_fap_command_sync(hidpp, feat_index,
> > > > +
> > > > HIDPP_MULTIPLATFORM_SET_CURRENT_PLATFORM,
> > > > +                                       params, sizeof(params),
> > > > &response);
> > > > +
> > > > +     if (ret)
> > > > +             hid_warn(hidpp->hid_dev,
> > > > +                      "Multiplatform: SET_CURRENT_PLATFORM failed
> > > > for index %d (err=3D%d)",
> > > > +                      plat_index, ret);
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +/**
> > > > + * hidpp_multiplatform_init() - Apply the HID++ Multi-Platform
> > > > (0x4531) feature
> > > > + * @hidpp: Pointer to the hidpp_device instance
> > > > + *
> > > > + * Initializes the Multi-Platform feature by selecting the device
> > > > platform
> > > > + * corresponding to the module parameter @hidpp_platform, if
> > > > provided.
> > > > + *
> > > > + * The function performs the following steps:
> > > > + *   1. Convert the @hidpp_platform string into a platform mask.
> > > > + *   2. Check whether the device supports the Multi-Platform featu=
re
> > > > (0x4531).
> > > > + *   3. Look up the device's platform index whose mask matches the
> > > > host
> > > > + *      platform mask.
> > > > + *   4. Apply that platform index to the device via
> > > > 'SET_CURRENT_PLATFORM'.
> > > > + *
> > > > + * If the module parameter is unset or invalid, or the device does
> > > > not support
> > > > + * the feature, or no matching platform descriptor is found, the
> > > > function exits
> > > > + * silently without modifying the device state.
> > > > + *
> > > > + * On success, the device's platform configuration is updated.
> > > > + */
> > > > +static void hidpp_multiplatform_init(struct hidpp_device *hidpp)
> > > > +{
> > > > +     int ret;
> > > > +     u8 feat_index;
> > > > +     u8 plat_index;
> > > > +     u16 host_plat_mask;
> > > > +     struct hid_device *hdev =3D hidpp->hid_dev;
> > > > +
> > > > +     if (!hidpp_platform)
> > > > +             return;
> > > > +
> > > > +     host_plat_mask =3D
> > > > hidpp_multiplatform_mask_from_str(hidpp_platform);
> > > > +     if (!host_plat_mask) {
> > > > +             hid_warn(hdev,
> > > > +                      "Multiplatform: Invalid or unsupported
> > > > platform name '%s'",
> > > > +                      hidpp_platform);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     ret =3D hidpp_root_get_feature(hidpp,
> > > > HIDPP_MULTIPLATFORM_FEAT_ID, &feat_index);
> > > > +     if (ret) {
> > > > +             hid_warn(hdev,
> > > > +                      "Multiplatform: Failed to get the HID++
> > > > multiplatform feature 0x4531");
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     ret =3D hidpp_multiplatform_get_platform_index(hidpp,
> > > > feat_index, host_plat_mask,
> > > > +                                                  &plat_index);
> > > > +     if (ret)
> > > > +             return;
> > > > +
> > > > +     ret =3D hidpp_multiplatform_update_device_platform(hidpp,
> > > > feat_index, plat_index);
> > > > +     if (ret)
> > > > +             return;
> > > > +
> > > > +     hid_info(hdev,
> > > > +              "Multiplatform: Device platform successfully set to
> > > > '%s'", hidpp_platform);
> > > > +}
> > > > +
> > > >  static int hidpp_probe(struct hid_device *hdev, const struct
> > > > hid_device_id *id)
> > > >  {
> > > >       struct hidpp_device *hidpp;
> > > > @@ -4467,6 +4741,8 @@ static int hidpp_probe(struct hid_device *hde=
v,
> > > > const struct hid_device_id *id)
> > > >       if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
> > > >               connect_mask &=3D ~HID_CONNECT_HIDINPUT;
> > > >
> > > > +     hidpp_multiplatform_init(hidpp);
> > > > +
> > > >       /* Now export the actual inputs and hidraw nodes to the
> > > > world */
> > > >       hid_device_io_stop(hdev);
> > > >       ret =3D hid_connect(hdev, connect_mask);
> > > > @@ -4664,6 +4940,10 @@ static const struct hid_device_id
> > > > hidpp_devices[] =3D {
> > > >         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb034) },
> > > >       { /* MX Anywhere 3SB mouse over Bluetooth */
> > > >         HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb038) },
> > > > +     { /* Casa Keys keyboard over Bluetooth */
> > > > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > > USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD) },
> > > > +     { /* MX Keys S keyboard over Bluetooth */
> > > > +       HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > > USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD) },
> > > >       {}
> > > >  };
> > > >
> > > > diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> > > > index c89a015686c0..99ca04b61bda 100644
> > > > --- a/drivers/hid/hid-quirks.c
> > > > +++ b/drivers/hid/hid-quirks.c
> > > > @@ -520,6 +520,8 @@ static const struct hid_device_id
> > > > hid_have_special_driver[] =3D {
> > > >  #endif
> > > >  #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
> > > >       { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > > USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
> > > > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > > USB_DEVICE_ID_LOGITECH_CASA_KEYS_KEYBOARD) },
> > > > +     { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > > > USB_DEVICE_ID_LOGITECH_MX_KEYS_S_KEYBOARD) },
> > > >  #endif
> > > >  #if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
> > > >       { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
> > > > USB_DEVICE_ID_APPLE_MAGICMOUSE) },
> >
> > Thanks,
> >
> > Baraa Atta (Dev Exalt) <exalt.dev.team@gmail.com>
