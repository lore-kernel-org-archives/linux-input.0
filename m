Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F02C15BB
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 01:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745404; cv=pass; b=uSodl4f4eyfrR3h1MIpyquRaMlv+JcT16YbqBNW3+Z0yPPgwde8vNEinl+jXcepteAYD4qnnaeFBKGqTRcOeqrt1Bqm4aofDk5f0BVX7SYadFv+A8gjsbdvBg3iAGdGJ9BOSBoD3zp3ra+egSNqFvomW6FFyneSYBr/mFGCuM/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745404; c=relaxed/simple;
	bh=FBxHV5F9bbyVhsSRyrpVM0XuJiD1ADoYcX+CdxwpJeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5zeJOYBmOHiL8mPkiBecCQqmm5sb57q8XNG7l0lp7Bo0WxtLctJ1AQf8RDJtHmQvtU77U+tAf0vw/U1QWyHbFWFAPaFV6G1pLMnfbdsAy3x/MFCfKqwltHBKI7SlCtDHYh4lcJp3+f8chedGBu9jQ6nOof6DSjXX5FB+wVvWGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQ4EuIjf; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQ4EuIjf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-486304fa184so356956b6e.1
        for <linux-input@vger.kernel.org>; Wed, 17 Jun 2026 18:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781745400; cv=none;
        d=google.com; s=arc-20240605;
        b=OduDp/JvGlCk0IbnVVlTk25J17h+yQyGjDnq4/Lo8+K7H4b4clP7fC+ZL+XECU2VWN
         Ls2pFRaLljgjahugeBssLDJHr0CECVPPMcvQph6IznQC6jp3drDecXWRRn6x9nXcThxF
         SasiydKK2TMVlEJmMe6CLgFJHt7hCqG318ZImmytoaaKoGzH7VjFZMxHq9TCxoWQ/Hw9
         33XKXsC3AUOODYd6kWtUxSTZUpOoTLn/tQ8jGTdDmy0+mVhY5YT6SEuIEJIFGLg0rklR
         gW1ZBnqT8GZp6T9WpALsimO71IUV02rJnfeWoU1cMO8XIvDUed8mn/CsPZRj+YjsrZvp
         Ogow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4JifWE2V5IAGHLjYWR170mCe7PZgqGKANeJJawEoUa0=;
        fh=l1AP/n4HAQ/9vHRqEexf6IiAxAqjltEguhhet2HCYvI=;
        b=FwiYovTdU9x9ISKkpC2LT3RB5BaphF8X5gmpNyOPtiwrP9wvdT48/HD1Z8o3LALDhX
         0XhZOxOuhbZyt3Aw9h3UevlaAvHOQh4BEaxliryWjmu9+PigE7LrIybK/Y+I2khgsOnZ
         +XPBJZcUtbJlEO3xKY1/IsQa/9bUkeHLkyXmlK75T3uAK0zSWwZE+AcxX2BHSE27YfwX
         mHkVH38N+yLOykz6ZFARCRrm4XjE4dX+06kj/KPyqxBXxfpEhHuITYwgp3rrqgsLBdpd
         nnrW5yOc0TRjkAxauHDH6mKjMYYThTPWkVaJxQetQGzdqKvhOzYUtyyDj5Ph34PDhukW
         1ESA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781745400; x=1782350200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JifWE2V5IAGHLjYWR170mCe7PZgqGKANeJJawEoUa0=;
        b=RQ4EuIjf4kNusiO5/uyYUEsXi+eGjFdUadVi9Lv1dNZu64oDYP4DMf7rpv8NjHq9/z
         L71ODdadUtsxPu5M4dDCsPVbQvzgSWX1BShnJzziL8sGbCHrww4peoqBf8xrpM3pszb/
         86Cd63bgmg9BOCYogBwxrd2fdapjkEmFnLkeLylLoBiATez9THXFSn6jcxIQK5ossED8
         i+4tKe/CsSNbHy0PXxI5MVNq/5h0Uy60rW5ZPZKk4LxoJpwtBZsFkJzRKKijB2SYL1gq
         ++SfPVXC4sWJxLRqxxBMvo9BHPjsnl+z17737KifhoUJO4TgrblAi9FfLLSMcg+87bw+
         FpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781745400; x=1782350200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4JifWE2V5IAGHLjYWR170mCe7PZgqGKANeJJawEoUa0=;
        b=hSKYh3SXZTW//a87lAgCf/RY4ypAKxXmCMcsAbj4CGdZxoui/V3mGHOkdnvVLRmbpr
         kYKeky9g3Aj3yIXwjV1aM3H48J0V3Ah5WPLWFBSFx2XlA4X1KahewCmeN++IFso+W3vh
         +JtEswq6BOFpz1hKszZM+ZZeltF1c6geex+jfaydXoesPIHW1f/Opi/KE58sc6XNLUeL
         BH+CecwUAfLpp4d/MLqSOIQJ0LijzQ5LCpgzuqIbb4l37tDnJ/6v6bpr8HlqKVK/65nT
         k50F5SuXkWunHkNaApNOnaskCtgJ30I41Glhy27nK+TUPmzXoew7cJjwHuVmvEHIZSnN
         11sw==
X-Gm-Message-State: AOJu0YwIP0vBiDfp4+osFgQ5qRYK0lOIv38qOZahfcrKAezCGyl5dP7N
	XpOu5oXcOzAf+pYAOV1w+NS70LwmC+wcl0jYVr5FJJnj+qTqdJpdzfJ+fwN08k2R1AWmumcIrNE
	QucVp2MuNYknGZB79jl+vRQYnCVGZG2s=
X-Gm-Gg: Acq92OGEDsqYrbdp+cGjBXYKwad6+AdyTP1dKcPf70m/kXxnMjjXhFG9zp5SZbNavIo
	lsbCLgOv8M4+LMiHLcqwEP6JQl8imu/b3ewLEbXh/5Cs4T47KPp2hit5T2Bfj/I3qSqYUmTd5GY
	vlzSeqfbXcWEPFlZkdEm9zYYy6WT2PBafuYoStWm4FtneNk0uL1i3HgOQ4iCxevb+UiZlp2F7yJ
	2dT/CeXwTyceT3t2zNhr3Sc8uJ3D4oLNh4rFF73F5XkWFHBHh6YBcxMF4530BsOkE0zJG6M7LyV
	80hQQVHRqcCRCDGs/dT6G8824PV5
X-Received: by 2002:a05:6808:1783:b0:489:34da:f600 with SMTP id
 5614622812f47-4895d126eaamr278958b6e.11.1781745400308; Wed, 17 Jun 2026
 18:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613175109.44365-1-edouglas7358@gmail.com>
 <20260613175109.44365-2-edouglas7358@gmail.com> <f741bafd41f7fc31fe0019020e14ad4f99fd193e.camel@hadess.net>
In-Reply-To: <f741bafd41f7fc31fe0019020e14ad4f99fd193e.camel@hadess.net>
From: Elliot Douglas <edouglas7358@gmail.com>
Date: Wed, 17 Jun 2026 18:16:17 -0700
X-Gm-Features: AVVi8Ce4863FUpbFoL4Q6rTT3ZXTuwGDMtwZ2qlAmLZY32HkpNA12TN43muwnrU
Message-ID: <CAGt6S1r6ep_L-SdEPd7hcJ92zcBM1oj1NxOD25qjuE6iuGw8Ng@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add HID++ 2.0 reprogrammable
 button support
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, lains@riseup.net, jikos@kernel.org, 
	bentiss@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, that makes sense.

For Solaar, this is not continuously forced. The kernel only programs
temporary diversion when the device connects. Solaar can still issue HID++
commands through hidraw, so if Solaar changes reporting for the same contro=
ls
afterwards, the last writer wins.

If Solaar takes over those controls for custom actions, the kernel would st=
op
receiving the diverted button notifications for normal evdev reporting unti=
l
the kernel diverts the controls again, for example after reconnect. While t=
he
controls remain diverted, hidraw clients should still receive the raw HID++
reports.

I have addressed the inline comments locally for v2:
- replaced the profile/count wrapper with NULL-terminated mapping arrays
- cached the selected mapping pointer in struct hidpp_device

I'll wait for Benjamin's input to send Patch v2.


On Wed, Jun 17, 2026 at 3:28=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Sat, 2026-06-13 at 10:51 -0700, Elliot Douglas wrote:
> > Some Logitech HID++ 2.0 mice can report diverted reprogrammable
> > controls through HID++ feature 0x1b04, SpecialKeysMseButtons /
> > REPROG_CONTROLS_V4, instead of the normal HID mouse report.
> >
> > Add a quirk-gated event path for those controls. The handler temporaril=
y
> > diverts verified per-product controls, parses divertedButtonsEvent as t=
he
> > current pressed-control list, and reports the corresponding evdev key s=
tate
> > for every mapped control.
> >
> > Keep the control mappings in per-product profiles so adding support for
> > another mouse does not change the evdev capabilities advertised by
> > already-supported devices.
>
> How does this forced setting work/clash with the programmable buttons
> in Solaar?
>
> I've added some inline comments below.
>
> >
> > Documentation for feature 0x1b04 describes divertedButtonsEvent as a li=
st
> > of currently pressed diverted buttons, which is the event format handle=
d
> > here.
> >
> > Link: https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebuttons.=
html
> >
> > Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 215 +++++++++++++++++++++++++++++++
> >  1 file changed, 215 insertions(+)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitec=
h-hidpp.c
> > index 70ba1a5e40d8..24c9cfaa4f37 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -76,6 +76,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
> >  #define HIDPP_QUIRK_HI_RES_SCROLL_1P0                BIT(28)
> >  #define HIDPP_QUIRK_WIRELESS_STATUS          BIT(29)
> >  #define HIDPP_QUIRK_RESET_HI_RES_SCROLL              BIT(30)
> > +#define HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS       BIT(31)
> >
> >  /* These are just aliases for now */
> >  #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
> > @@ -205,6 +206,7 @@ struct hidpp_device {
> >       struct hidpp_scroll_counter vertical_wheel_counter;
> >
> >       u8 wireless_feature_index;
> > +     u8 reprog_controls_feature_index;
> >
> >       int hires_wheel_multiplier;
> >       u8 hires_wheel_feature_index;
> > @@ -3601,6 +3603,209 @@ static int hidpp10_extra_mouse_buttons_raw_even=
t(struct hidpp_device *hidpp,
> >       return 1;
> >  }
> >
> > +/* -------------------------------------------------------------------=
------- */
> > +/* HID++2.0 reprogrammable controls                                   =
        */
> > +/* -------------------------------------------------------------------=
------- */
> > +
> > +#define HIDPP_PAGE_REPROG_CONTROLS_V4                        0x1b04
> > +
> > +#define HIDPP_REPROG_CONTROLS_GET_COUNT                      0x00
> > +#define HIDPP_REPROG_CONTROLS_GET_CID_INFO           0x10
> > +#define HIDPP_REPROG_CONTROLS_SET_CONTROL_REPORTING  0x30
> > +
> > +#define HIDPP_REPROG_CONTROLS_FLAG_MOUSE             BIT(0)
> > +#define HIDPP_REPROG_CONTROLS_FLAG_DIVERT            BIT(5)
> > +
> > +#define HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED     BIT(0)
> > +#define HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT        BIT(1)
> > +
> > +#define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED         0x00
> > +
> > +struct hidpp_reprog_control_mapping {
> > +     u16 control;
> > +     u16 code;
> > +};
> > +
> > +struct hidpp_reprog_controls_profile {
> > +     const struct hidpp_reprog_control_mapping *mappings;
>
> probably needs a __counted_by(), or maybe as it's static, it might be
> better to not require an intermediate struct, and return a NULL-
> terminated array instead.
>
> > +     unsigned int mapping_count;
> > +};
> > +
> > +static const struct hidpp_reprog_controls_profile *
> > +hidpp20_reprog_controls_get_profile(struct hidpp_device *hidpp)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static int hidpp20_reprog_controls_get_count(struct hidpp_device *hidp=
p)
> > +{
> > +     struct hidpp_report response;
> > +     u8 feature_index =3D hidpp->reprog_controls_feature_index;
> > +     u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_COUNT;
> > +     int ret;
> > +
> > +     ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd, NU=
LL, 0,
> > +                                       &response);
> > +     if (ret > 0)
> > +             return -EPROTO;
> > +     if (ret)
> > +             return ret;
> > +
> > +     return response.fap.params[0];
> > +}
> > +
> > +static int hidpp20_reprog_controls_get_cid_info(struct hidpp_device *h=
idpp,
> > +                                             u8 index, u16 *control,
> > +                                             u8 *flags)
> > +{
> > +     struct hidpp_report response;
> > +     u8 feature_index =3D hidpp->reprog_controls_feature_index;
> > +     u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_CID_INFO;
> > +     int ret;
> > +
> > +     ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd, &i=
ndex,
> > +                                       sizeof(index), &response);
> > +     if (ret > 0)
> > +             return -EPROTO;
> > +     if (ret)
> > +             return ret;
> > +
> > +     *control =3D get_unaligned_be16(&response.fap.params[0]);
> > +     *flags =3D response.fap.params[4];
> > +
> > +     return 0;
> > +}
> > +
> > +static bool hidpp20_reprog_controls_find_control(struct hidpp_device *=
hidpp,
> > +                                              u16 control)
> > +{
> > +     int count, ret;
> > +     u16 cid;
> > +     u8 flags;
> > +     int i;
> > +
> > +     count =3D hidpp20_reprog_controls_get_count(hidpp);
> > +     if (count < 0)
> > +             return false;
> > +
> > +     for (i =3D 0; i < count; i++) {
> > +             ret =3D hidpp20_reprog_controls_get_cid_info(hidpp, i, &c=
id,
> > +                                                        &flags);
> > +             if (ret)
> > +                     return false;
> > +
> > +             if (cid =3D=3D control)
> > +                     return (flags & HIDPP_REPROG_CONTROLS_FLAG_MOUSE)=
 &&
> > +                            (flags & HIDPP_REPROG_CONTROLS_FLAG_DIVERT=
);
> > +     }
> > +
> > +     return false;
> > +}
> > +
> > +static int hidpp20_reprog_controls_set_control_reporting(struct hidpp_=
device *hidpp,
> > +                                                      u16 control, u8 =
flags)
> > +{
> > +     struct hidpp_report response;
> > +     u8 params[5];
> > +
> > +     put_unaligned_be16(control, &params[0]);
> > +     params[2] =3D flags;
> > +     put_unaligned_be16(control, &params[3]);
> > +
> > +     return hidpp_send_fap_command_sync(hidpp,
> > +                                        hidpp->reprog_controls_feature=
_index,
> > +                                        HIDPP_REPROG_CONTROLS_SET_CONT=
ROL_REPORTING,
> > +                                        params, sizeof(params), &respo=
nse);
> > +}
> > +
> > +static void hidpp20_reprog_controls_connect(struct hidpp_device *hidpp=
)
> > +{
> > +     const struct hidpp_reprog_controls_profile *profile;
> > +     u8 flags =3D HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED |
> > +                HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT;
> > +     unsigned int i;
> > +
> > +     if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS))
> > +             return;
> > +
> > +     profile =3D hidpp20_reprog_controls_get_profile(hidpp);
>
> Could the profile be cached in the hidpp_device struct?
>
> > +     if (!profile)
> > +             return;
> > +
> > +     if (hidpp_root_get_feature(hidpp, HIDPP_PAGE_REPROG_CONTROLS_V4,
> > +                                &hidpp->reprog_controls_feature_index)=
)
> > +             return;
> > +
> > +     for (i =3D 0; i < profile->mapping_count; i++) {
> > +             u16 control =3D profile->mappings[i].control;
> > +
> > +             if (!hidpp20_reprog_controls_find_control(hidpp, control)=
)
> > +                     continue;
> > +
> > +             hidpp20_reprog_controls_set_control_reporting(hidpp, cont=
rol, flags);
> > +     }
> > +}
> > +
> > +static int hidpp20_reprog_controls_raw_event(struct hidpp_device *hidp=
p,
> > +                                          u8 *data, int size)
> > +{
> > +     const struct hidpp_reprog_controls_profile *profile;
> > +     const struct hidpp_reprog_control_mapping *mapping;
> > +     struct hidpp_report *report =3D (struct hidpp_report *)data;
> > +     u16 controls[4];
> > +     bool pressed;
> > +     unsigned int i, j;
> > +
> > +     if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) ||
> > +         !hidpp->input ||
> > +         hidpp->reprog_controls_feature_index =3D=3D 0xff)
> > +             return 0;
> > +
> > +     profile =3D hidpp20_reprog_controls_get_profile(hidpp);
> > +     if (!profile)
> > +             return 0;
> > +
> > +     if (size < HIDPP_REPORT_LONG_LENGTH ||
> > +         report->fap.feature_index !=3D hidpp->reprog_controls_feature=
_index ||
> > +         report->fap.funcindex_clientid !=3D HIDPP_REPROG_CONTROLS_EVE=
NT_DIVERTED)
> > +             return 0;
> > +
> > +     for (i =3D 0; i < ARRAY_SIZE(controls); i++)
> > +             controls[i] =3D get_unaligned_be16(&report->fap.params[i =
* 2]);
> > +
> > +     for (i =3D 0; i < profile->mapping_count; i++) {
> > +             mapping =3D &profile->mappings[i];
> > +             pressed =3D false;
> > +
> > +             for (j =3D 0; j < ARRAY_SIZE(controls); j++) {
> > +                     if (controls[j] =3D=3D mapping->control) {
> > +                             pressed =3D true;
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             input_report_key(hidpp->input, mapping->code, pressed);
> > +     }
> > +
> > +     input_sync(hidpp->input);
> > +
> > +     return 1;
> > +}
> > +
> > +static void hidpp20_reprog_controls_populate_input(struct hidpp_device=
 *hidpp,
> > +                                                struct input_dev *inpu=
t_dev)
> > +{
> > +     const struct hidpp_reprog_controls_profile *profile;
> > +     unsigned int i;
> > +
> > +     profile =3D hidpp20_reprog_controls_get_profile(hidpp);
> > +     if (!profile)
> > +             return;
> > +
> > +     for (i =3D 0; i < profile->mapping_count; i++)
> > +             input_set_capability(input_dev, EV_KEY, profile->mappings=
[i].code);
> > +}
> > +
> >  static void hidpp10_extra_mouse_buttons_populate_input(
> >                       struct hidpp_device *hidpp, struct input_dev *inp=
ut_dev)
> >  {
> > @@ -3859,6 +4064,9 @@ static void hidpp_populate_input(struct hidpp_dev=
ice *hidpp,
> >
> >       if (hidpp->quirks & HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS)
> >               hidpp10_extra_mouse_buttons_populate_input(hidpp, input);
> > +
> > +     if (hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS)
> > +             hidpp20_reprog_controls_populate_input(hidpp, input);
> >  }
> >
> >  static int hidpp_input_configured(struct hid_device *hdev,
> > @@ -3971,6 +4179,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_de=
vice *hidpp, u8 *data,
> >                       return ret;
> >       }
> >
> > +     ret =3D hidpp20_reprog_controls_raw_event(hidpp, data, size);
> > +     if (ret !=3D 0)
> > +             return ret;
> > +
> >       if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
> >               ret =3D hidpp10_consumer_keys_raw_event(hidpp, data, size=
);
> >               if (ret !=3D 0)
> > @@ -4264,6 +4476,8 @@ static void hidpp_connect_event(struct work_struc=
t *work)
> >                       return;
> >       }
> >
> > +     hidpp20_reprog_controls_connect(hidpp);
> > +
> >       if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
> >               ret =3D hidpp10_consumer_keys_connect(hidpp);
> >               if (ret)
> > @@ -4436,6 +4650,7 @@ static int hidpp_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
> >       hidpp->hid_dev =3D hdev;
> >       hidpp->name =3D hdev->name;
> >       hidpp->quirks =3D id->driver_data;
> > +     hidpp->reprog_controls_feature_index =3D 0xff;
> >       hid_set_drvdata(hdev, hidpp);
> >
> >       ret =3D hid_parse(hdev);
