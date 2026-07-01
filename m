Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137D728F949
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945192; cv=pass; b=XuI9M7/22AmGHBDIl51EP7Nl/p+kro2iKNZ27lz2NrNF4b3BZQYWQEDs1FnJyiVun+hKQ5uWj5CEyDaqipEaL0R1Y0YX18xVQc8yqHB7I+cpDEtd9MTj9WpVpkXVJVcuMykvviDr/3eR/Wxzj9AEc77Ft8FSbfLwWECVsX/I4Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945192; c=relaxed/simple;
	bh=APgyWXhWTMJBH6o476NYVmQ1Ykw4n6TvceECvXp9dy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ceoCJ65w3Jv+70CzP9MF7qre5U4X+K4z+WmFfyaoPUucXJpLI19u13LYWya7DTEMEK+EL+hTfCtSdjTWxw7Lw2h/JH2Prqk39Lmauv1yw1tCm8LGaQP3SB6g7SMwvj/chW+SVApNX13Mj2kXlJpz6sxY3pVhUB9HRExub2ltsr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2R6ZOZr; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2R6ZOZr"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-495b27007d0so898293b6e.1
        for <linux-input@vger.kernel.org>; Wed, 01 Jul 2026 15:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782945189; cv=none;
        d=google.com; s=arc-20260327;
        b=h6V6CxqtMPpGQ5upLTxyy9JZ7K3PG06ctRFXFGcBbi86sZIE+weO7jNdaJtCsHLEmw
         LzZHbs7pPIlk6YOSKjBmMPGJ4INPiLQG84UuzqoRh/MVQzPd+lumaVRXZrsJ9KQRPSod
         mlA4DnD0zTZo/meQ23lDFXKAdUAlkTSjcECOwvW32S42g/Oo+f6k12oNfcrmDwjwYPX0
         J35w5M8QOoFu0X6jv1NyUeNgdD/hrFYAiEWIVNctxclya8cWvqsKmDYtO9W2nsuaU9gh
         0RcmiIFU6J5t4AnFDPJfKh+smxyL6HAQbApr83wToFPy5haHUwI8kafyF6sjI8ghzml4
         qlOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RzBnQdzjJ443mB1fjL34nP1a1/DYAHnF8xige2HGEiM=;
        fh=l1AP/n4HAQ/9vHRqEexf6IiAxAqjltEguhhet2HCYvI=;
        b=N/VBooeQWmktssZXQen15vZVP4CfG4WS0OUaIZLqcuf06tvSQ7YBNt2U6ftjxf0DLu
         8OEuqU4xQTe2mxhvNg+mSMhkdLfyHZ/o4XorB5AJoMwGCBqYk/wR3nLZBRrbXBqvMuku
         9UeyfO7b5hpzMDy+wHzkCGK2090/h20MPMuy3RPKTVIDrnZNNgqobRx7ulB5lh5FzJ0O
         U9k3f5w4scziF9lWv9N39yMsBrVCJOwHJ10TokLpen343ZGbb3YgPZALxPz9f/VdatN9
         LYSoxha9VoKxl+wX0r2J69AJoCRAJlY2KhJGzK3ey81iY1wN9YEYBWdeZUQFIpEC60L6
         iGWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782945189; x=1783549989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RzBnQdzjJ443mB1fjL34nP1a1/DYAHnF8xige2HGEiM=;
        b=J2R6ZOZreTlhuFYdN3ESB0EBNTzVa3xuHFti+I59IM5cZLLqIdnVulCB0c/X4uXrVd
         I1KQf3wpPyNIG1MIZt8ShAz82Csf4WREOMUvPQMnMP2HqRZ12F1MPSwgJjSsaHHnOKtM
         cn9KwhV+cyfeEPMVPMbfizmUPrSbWBVQ6xYVq3Yzw4AZ7Kd+nXvU3Lm/pJP/FCK68TKy
         h9ZcY2cIStqmr2vdcS1TI2Qexwi+kktFkB4timCogKsiI5cXIyjoxrl/VaWZAGOayhIQ
         ux8exqJOXZh0AtfkUsONBn38CaTBfyEA8mCgl+MyxmOTbtkSIQSaMGxG3S7Gk3kTb0f4
         1tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782945189; x=1783549989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzBnQdzjJ443mB1fjL34nP1a1/DYAHnF8xige2HGEiM=;
        b=KdYJjo6IcdBG4OpnxD0n6AdzRpbdeSKxNTCUWzyb4LhZBE3eNEHKYH1YYQZueE1y0/
         2jPkCVcIrH1IUzRkON4bzRigi/3XZU5OBGz+J2NmYQooIBIG3KTeqbfTot/UNdUkTOR6
         unr3lGkWC5DuRw5N12fFHjE4vq1jI7/9NIO3Rfb+I0jhzFc+qpfYAwOETN477XN/esLp
         QptAsS5Gde1EvfjtFDbX7EQI2HeoejdNe6pVXx91XYeTmWBnIiNoJC38w6BNhtT5PiHq
         szt7SHm2bQuhnt6/BDgiFPpL3EhWukrinKQyCSV91HzaGPDfFZ7ILTR+hO0VeO8PDxSS
         YWgQ==
X-Gm-Message-State: AOJu0YxpCHYAYbpehKfFmUtKDvSIouzF7s0Qw3UrSLPRzaxfwEzxKnx1
	NWloqnDQ/lem7DTHJXAMo7I1lKUlch7GuvuwqOEFDmSzG3uIKrQVUMn+qSeW0DgST7Inu2qE1S+
	nNZNEReKlYwBcIkT2riFRCzCWmI3IB4I=
X-Gm-Gg: AfdE7ck3Y3p/ctgtPNexUUANo86yOIj2CSOA81BBi85HFUgGJVr4VS8MVhJ0spAT+Wc
	eMoI+ldFqylTCwI9A5MtXgit8Jn/uJB7xX3+h6zBrnReu/9k+EiTWOomg3qGAYGvnOcrGBkO2I8
	DwNs0rolWJExZ8tYZNsY4QnR0HRjTTzeCu8g49b3iJMQbwSWZcAPHwwEdTUFKYWDy6SpONir7RQ
	f76Pi+CTTfGzia5mUUdSlMOXQKeiMeQGVyxTy/yqb6JNEBmn+ubsrnR4jbq97gNCzCimmZS
X-Received: by 2002:a05:6808:3204:b0:495:ffb3:f4aa with SMTP id
 5614622812f47-4962481467amr1699773b6e.13.1782945188920; Wed, 01 Jul 2026
 15:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613175109.44365-1-edouglas7358@gmail.com>
 <20260613175109.44365-2-edouglas7358@gmail.com> <f741bafd41f7fc31fe0019020e14ad4f99fd193e.camel@hadess.net>
 <CAGt6S1r6ep_L-SdEPd7hcJ92zcBM1oj1NxOD25qjuE6iuGw8Ng@mail.gmail.com>
In-Reply-To: <CAGt6S1r6ep_L-SdEPd7hcJ92zcBM1oj1NxOD25qjuE6iuGw8Ng@mail.gmail.com>
From: Elliot Douglas <edouglas7358@gmail.com>
Date: Wed, 1 Jul 2026 15:32:39 -0700
X-Gm-Features: AVVi8CdFSDqC38cUQpi5Gam8XrcpwK4RKmYWnIochtILab2x73NKobk30XlTzHU
Message-ID: <CAGt6S1pqCNPeV-Hy6w-8eynKhKwzz5X4fefkJfM0gYGgQzGAwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add HID++ 2.0 reprogrammable
 button support
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, lains@riseup.net, jikos@kernel.org, 
	bentiss@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just wanted to poke on this thread again, Benjamin or Bastien, what is need=
ed to
push this forward or should I send the v2 at this point?

Thanks,
Elliot

On Wed, Jun 17, 2026 at 6:16=E2=80=AFPM Elliot Douglas <edouglas7358@gmail.=
com> wrote:
>
> Thanks, that makes sense.
>
> For Solaar, this is not continuously forced. The kernel only programs
> temporary diversion when the device connects. Solaar can still issue HID+=
+
> commands through hidraw, so if Solaar changes reporting for the same cont=
rols
> afterwards, the last writer wins.
>
> If Solaar takes over those controls for custom actions, the kernel would =
stop
> receiving the diverted button notifications for normal evdev reporting un=
til
> the kernel diverts the controls again, for example after reconnect. While=
 the
> controls remain diverted, hidraw clients should still receive the raw HID=
++
> reports.
>
> I have addressed the inline comments locally for v2:
> - replaced the profile/count wrapper with NULL-terminated mapping arrays
> - cached the selected mapping pointer in struct hidpp_device
>
> I'll wait for Benjamin's input to send Patch v2.
>
>
> On Wed, Jun 17, 2026 at 3:28=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
> wrote:
> >
> > On Sat, 2026-06-13 at 10:51 -0700, Elliot Douglas wrote:
> > > Some Logitech HID++ 2.0 mice can report diverted reprogrammable
> > > controls through HID++ feature 0x1b04, SpecialKeysMseButtons /
> > > REPROG_CONTROLS_V4, instead of the normal HID mouse report.
> > >
> > > Add a quirk-gated event path for those controls. The handler temporar=
ily
> > > diverts verified per-product controls, parses divertedButtonsEvent as=
 the
> > > current pressed-control list, and reports the corresponding evdev key=
 state
> > > for every mapped control.
> > >
> > > Keep the control mappings in per-product profiles so adding support f=
or
> > > another mouse does not change the evdev capabilities advertised by
> > > already-supported devices.
> >
> > How does this forced setting work/clash with the programmable buttons
> > in Solaar?
> >
> > I've added some inline comments below.
> >
> > >
> > > Documentation for feature 0x1b04 describes divertedButtonsEvent as a =
list
> > > of currently pressed diverted buttons, which is the event format hand=
led
> > > here.
> > >
> > > Link: https://lekensteyn.nl/files/logitech/x1b04_specialkeysmsebutton=
s.html
> > >
> > > Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
> > > ---
> > >  drivers/hid/hid-logitech-hidpp.c | 215 +++++++++++++++++++++++++++++=
++
> > >  1 file changed, 215 insertions(+)
> > >
> > > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logit=
ech-hidpp.c
> > > index 70ba1a5e40d8..24c9cfaa4f37 100644
> > > --- a/drivers/hid/hid-logitech-hidpp.c
> > > +++ b/drivers/hid/hid-logitech-hidpp.c
> > > @@ -76,6 +76,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
> > >  #define HIDPP_QUIRK_HI_RES_SCROLL_1P0                BIT(28)
> > >  #define HIDPP_QUIRK_WIRELESS_STATUS          BIT(29)
> > >  #define HIDPP_QUIRK_RESET_HI_RES_SCROLL              BIT(30)
> > > +#define HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS       BIT(31)
> > >
> > >  /* These are just aliases for now */
> > >  #define HIDPP_QUIRK_KBD_SCROLL_WHEEL HIDPP_QUIRK_HIDPP_WHEELS
> > > @@ -205,6 +206,7 @@ struct hidpp_device {
> > >       struct hidpp_scroll_counter vertical_wheel_counter;
> > >
> > >       u8 wireless_feature_index;
> > > +     u8 reprog_controls_feature_index;
> > >
> > >       int hires_wheel_multiplier;
> > >       u8 hires_wheel_feature_index;
> > > @@ -3601,6 +3603,209 @@ static int hidpp10_extra_mouse_buttons_raw_ev=
ent(struct hidpp_device *hidpp,
> > >       return 1;
> > >  }
> > >
> > > +/* -----------------------------------------------------------------=
--------- */
> > > +/* HID++2.0 reprogrammable controls                                 =
          */
> > > +/* -----------------------------------------------------------------=
--------- */
> > > +
> > > +#define HIDPP_PAGE_REPROG_CONTROLS_V4                        0x1b04
> > > +
> > > +#define HIDPP_REPROG_CONTROLS_GET_COUNT                      0x00
> > > +#define HIDPP_REPROG_CONTROLS_GET_CID_INFO           0x10
> > > +#define HIDPP_REPROG_CONTROLS_SET_CONTROL_REPORTING  0x30
> > > +
> > > +#define HIDPP_REPROG_CONTROLS_FLAG_MOUSE             BIT(0)
> > > +#define HIDPP_REPROG_CONTROLS_FLAG_DIVERT            BIT(5)
> > > +
> > > +#define HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED     BIT(0)
> > > +#define HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT        BIT(1)
> > > +
> > > +#define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED         0x00
> > > +
> > > +struct hidpp_reprog_control_mapping {
> > > +     u16 control;
> > > +     u16 code;
> > > +};
> > > +
> > > +struct hidpp_reprog_controls_profile {
> > > +     const struct hidpp_reprog_control_mapping *mappings;
> >
> > probably needs a __counted_by(), or maybe as it's static, it might be
> > better to not require an intermediate struct, and return a NULL-
> > terminated array instead.
> >
> > > +     unsigned int mapping_count;
> > > +};
> > > +
> > > +static const struct hidpp_reprog_controls_profile *
> > > +hidpp20_reprog_controls_get_profile(struct hidpp_device *hidpp)
> > > +{
> > > +     return NULL;
> > > +}
> > > +
> > > +static int hidpp20_reprog_controls_get_count(struct hidpp_device *hi=
dpp)
> > > +{
> > > +     struct hidpp_report response;
> > > +     u8 feature_index =3D hidpp->reprog_controls_feature_index;
> > > +     u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_COUNT;
> > > +     int ret;
> > > +
> > > +     ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd, =
NULL, 0,
> > > +                                       &response);
> > > +     if (ret > 0)
> > > +             return -EPROTO;
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     return response.fap.params[0];
> > > +}
> > > +
> > > +static int hidpp20_reprog_controls_get_cid_info(struct hidpp_device =
*hidpp,
> > > +                                             u8 index, u16 *control,
> > > +                                             u8 *flags)
> > > +{
> > > +     struct hidpp_report response;
> > > +     u8 feature_index =3D hidpp->reprog_controls_feature_index;
> > > +     u8 cmd =3D HIDPP_REPROG_CONTROLS_GET_CID_INFO;
> > > +     int ret;
> > > +
> > > +     ret =3D hidpp_send_fap_command_sync(hidpp, feature_index, cmd, =
&index,
> > > +                                       sizeof(index), &response);
> > > +     if (ret > 0)
> > > +             return -EPROTO;
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     *control =3D get_unaligned_be16(&response.fap.params[0]);
> > > +     *flags =3D response.fap.params[4];
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static bool hidpp20_reprog_controls_find_control(struct hidpp_device=
 *hidpp,
> > > +                                              u16 control)
> > > +{
> > > +     int count, ret;
> > > +     u16 cid;
> > > +     u8 flags;
> > > +     int i;
> > > +
> > > +     count =3D hidpp20_reprog_controls_get_count(hidpp);
> > > +     if (count < 0)
> > > +             return false;
> > > +
> > > +     for (i =3D 0; i < count; i++) {
> > > +             ret =3D hidpp20_reprog_controls_get_cid_info(hidpp, i, =
&cid,
> > > +                                                        &flags);
> > > +             if (ret)
> > > +                     return false;
> > > +
> > > +             if (cid =3D=3D control)
> > > +                     return (flags & HIDPP_REPROG_CONTROLS_FLAG_MOUS=
E) &&
> > > +                            (flags & HIDPP_REPROG_CONTROLS_FLAG_DIVE=
RT);
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > > +
> > > +static int hidpp20_reprog_controls_set_control_reporting(struct hidp=
p_device *hidpp,
> > > +                                                      u16 control, u=
8 flags)
> > > +{
> > > +     struct hidpp_report response;
> > > +     u8 params[5];
> > > +
> > > +     put_unaligned_be16(control, &params[0]);
> > > +     params[2] =3D flags;
> > > +     put_unaligned_be16(control, &params[3]);
> > > +
> > > +     return hidpp_send_fap_command_sync(hidpp,
> > > +                                        hidpp->reprog_controls_featu=
re_index,
> > > +                                        HIDPP_REPROG_CONTROLS_SET_CO=
NTROL_REPORTING,
> > > +                                        params, sizeof(params), &res=
ponse);
> > > +}
> > > +
> > > +static void hidpp20_reprog_controls_connect(struct hidpp_device *hid=
pp)
> > > +{
> > > +     const struct hidpp_reprog_controls_profile *profile;
> > > +     u8 flags =3D HIDPP_REPROG_CONTROLS_TEMPORARY_DIVERTED |
> > > +                HIDPP_REPROG_CONTROLS_CHANGE_TEMPORARY_DIVERT;
> > > +     unsigned int i;
> > > +
> > > +     if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS))
> > > +             return;
> > > +
> > > +     profile =3D hidpp20_reprog_controls_get_profile(hidpp);
> >
> > Could the profile be cached in the hidpp_device struct?
> >
> > > +     if (!profile)
> > > +             return;
> > > +
> > > +     if (hidpp_root_get_feature(hidpp, HIDPP_PAGE_REPROG_CONTROLS_V4=
,
> > > +                                &hidpp->reprog_controls_feature_inde=
x))
> > > +             return;
> > > +
> > > +     for (i =3D 0; i < profile->mapping_count; i++) {
> > > +             u16 control =3D profile->mappings[i].control;
> > > +
> > > +             if (!hidpp20_reprog_controls_find_control(hidpp, contro=
l))
> > > +                     continue;
> > > +
> > > +             hidpp20_reprog_controls_set_control_reporting(hidpp, co=
ntrol, flags);
> > > +     }
> > > +}
> > > +
> > > +static int hidpp20_reprog_controls_raw_event(struct hidpp_device *hi=
dpp,
> > > +                                          u8 *data, int size)
> > > +{
> > > +     const struct hidpp_reprog_controls_profile *profile;
> > > +     const struct hidpp_reprog_control_mapping *mapping;
> > > +     struct hidpp_report *report =3D (struct hidpp_report *)data;
> > > +     u16 controls[4];
> > > +     bool pressed;
> > > +     unsigned int i, j;
> > > +
> > > +     if (!(hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS) |=
|
> > > +         !hidpp->input ||
> > > +         hidpp->reprog_controls_feature_index =3D=3D 0xff)
> > > +             return 0;
> > > +
> > > +     profile =3D hidpp20_reprog_controls_get_profile(hidpp);
> > > +     if (!profile)
> > > +             return 0;
> > > +
> > > +     if (size < HIDPP_REPORT_LONG_LENGTH ||
> > > +         report->fap.feature_index !=3D hidpp->reprog_controls_featu=
re_index ||
> > > +         report->fap.funcindex_clientid !=3D HIDPP_REPROG_CONTROLS_E=
VENT_DIVERTED)
> > > +             return 0;
> > > +
> > > +     for (i =3D 0; i < ARRAY_SIZE(controls); i++)
> > > +             controls[i] =3D get_unaligned_be16(&report->fap.params[=
i * 2]);
> > > +
> > > +     for (i =3D 0; i < profile->mapping_count; i++) {
> > > +             mapping =3D &profile->mappings[i];
> > > +             pressed =3D false;
> > > +
> > > +             for (j =3D 0; j < ARRAY_SIZE(controls); j++) {
> > > +                     if (controls[j] =3D=3D mapping->control) {
> > > +                             pressed =3D true;
> > > +                             break;
> > > +                     }
> > > +             }
> > > +
> > > +             input_report_key(hidpp->input, mapping->code, pressed);
> > > +     }
> > > +
> > > +     input_sync(hidpp->input);
> > > +
> > > +     return 1;
> > > +}
> > > +
> > > +static void hidpp20_reprog_controls_populate_input(struct hidpp_devi=
ce *hidpp,
> > > +                                                struct input_dev *in=
put_dev)
> > > +{
> > > +     const struct hidpp_reprog_controls_profile *profile;
> > > +     unsigned int i;
> > > +
> > > +     profile =3D hidpp20_reprog_controls_get_profile(hidpp);
> > > +     if (!profile)
> > > +             return;
> > > +
> > > +     for (i =3D 0; i < profile->mapping_count; i++)
> > > +             input_set_capability(input_dev, EV_KEY, profile->mappin=
gs[i].code);
> > > +}
> > > +
> > >  static void hidpp10_extra_mouse_buttons_populate_input(
> > >                       struct hidpp_device *hidpp, struct input_dev *i=
nput_dev)
> > >  {
> > > @@ -3859,6 +4064,9 @@ static void hidpp_populate_input(struct hidpp_d=
evice *hidpp,
> > >
> > >       if (hidpp->quirks & HIDPP_QUIRK_HIDPP_EXTRA_MOUSE_BTNS)
> > >               hidpp10_extra_mouse_buttons_populate_input(hidpp, input=
);
> > > +
> > > +     if (hidpp->quirks & HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS)
> > > +             hidpp20_reprog_controls_populate_input(hidpp, input);
> > >  }
> > >
> > >  static int hidpp_input_configured(struct hid_device *hdev,
> > > @@ -3971,6 +4179,10 @@ static int hidpp_raw_hidpp_event(struct hidpp_=
device *hidpp, u8 *data,
> > >                       return ret;
> > >       }
> > >
> > > +     ret =3D hidpp20_reprog_controls_raw_event(hidpp, data, size);
> > > +     if (ret !=3D 0)
> > > +             return ret;
> > > +
> > >       if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
> > >               ret =3D hidpp10_consumer_keys_raw_event(hidpp, data, si=
ze);
> > >               if (ret !=3D 0)
> > > @@ -4264,6 +4476,8 @@ static void hidpp_connect_event(struct work_str=
uct *work)
> > >                       return;
> > >       }
> > >
> > > +     hidpp20_reprog_controls_connect(hidpp);
> > > +
> > >       if (hidpp->quirks & HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS) {
> > >               ret =3D hidpp10_consumer_keys_connect(hidpp);
> > >               if (ret)
> > > @@ -4436,6 +4650,7 @@ static int hidpp_probe(struct hid_device *hdev,=
 const struct hid_device_id *id)
> > >       hidpp->hid_dev =3D hdev;
> > >       hidpp->name =3D hdev->name;
> > >       hidpp->quirks =3D id->driver_data;
> > > +     hidpp->reprog_controls_feature_index =3D 0xff;
> > >       hid_set_drvdata(hdev, hidpp);
> > >
> > >       ret =3D hid_parse(hdev);
