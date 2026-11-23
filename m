Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795476475;
	b=vdKcQAv333rm8Xul/A4Rv8DL1IcX5kIXle1PxT+D9jfeRDmtpeV162RVo8VjZZ0/aIlr
	 l9sfhz85DVL2Riqj5irtVUXUh7hyTYD2v4ZeObln5zZStvex9L8YdwqiFFS64cziy/xss
	 L9P2hjiKAeajYoOAq9K000CpXkYhFnNLfFEumLIou1PGHs4eEEA0fT/OwBb7fvBJVzAFq
	 iqDbhxtR9iN0SVaU5AHyu9/8I4wTLb+WAO7AGlre0oSVACdSvDvrA+oxbFvxaPCRXw1yb
	 Ob3wE2//nDaGvas6CwFT5x2F03qx7iB2SYzokBNUKdQ4jAOPdQLXoq0e+ijEfIv3mlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795476475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=j99f7KwqCGFPCQ5UxSgKf/Q6ehYNM1RCLTZobLCSX8U=;
	b=yW1T5SVKcQelR5X9yWQDdh8hDc8R/7Vge54d+5WCk92iq7pijczwd2chysBb4iuhCJzk
	 QwQzlgKDb3Jkcj7rxASPFxC7uSU+ES2kaIJ6F9YSugmPa2Hkd5uCch7HQ1jZqtGuvc2Os
	 VKmUX1LzDTxmstsByHdaYXnX/OLtzua9gw84EKHt95A5I/eiPhmRYG/H2h5nhJIsRu8Aw
	 mcIPyZJyRd/Wo3v7fYuSqJ+scrfN+sypfDEyqhdK1IL3ONh82Xmgi43iEOhzPyGDCFYfw
	 Hqhmiq5iTRrfGvxlIDtOdt4JiXpwwpa+TWhrKS0mtu2zF0u33giEENHWTF3A7ba1/JA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NMcT+Z3E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16BD606A321
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 23:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F16BD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NMcT+Z3E
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso3232929e87.3
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 15:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795476472; cv=none;
        d=google.com; s=arc-20260327;
        b=LVdHCrHJyCcn6o/yN/rty62SMEVSfnyAnfxWPevX+js0fNv8AC+v4jg2ErFNuKV2JJ
         AUd/hlhYUT6z4N/mQO3kticQynM6TKypNySwxvPCW2z9Y5+M0jYO+YWBuxv7AN6AcRFY
         XAP6CqEpeMVBfciNRNJgbAMmmfaa+vgiEG3gtodgsFq/NYxHpyayr134hBlGpIrntkdt
         neQ0AxpaJ1TLWICF8BKbw3fl2QBjSpr/btHhy4X6LA+5SC4RP8upUw35gQ6em501dq79
         JQT16UJpVYn7WiSiTBA9hon2KsvWD8k3uGPoiz//6OrClq3lzmVXnGEdMXevNPgiGvxx
         waIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j99f7KwqCGFPCQ5UxSgKf/Q6ehYNM1RCLTZobLCSX8U=;
        fh=g1MasjcvI9xhdkOrwv5VKpb9/nzZwOOs4vidZrc1r4g=;
        b=arGTLOemg7Ym+0nL9/UfxSBvfYfhgV8d1twmKwUdieXd2cOeohu53e/mehVFkgFmyt
         LHL37gyvdWhLNKEdK9UUV+MZaf1oLGCuQ8wqQ/1PKKPARnDjzPKGi2ul2R//cyog57UH
         0a2fk0MlZ7yL41Y2oi/nQBZ04mbrqgpTZ5tEXKi8ILfkHMSSX0YuyCiHrnGCF09ITlLM
         AU9II4CIDSDIDQwrlI9s/6EOGK5obKSHKCn+CEaWFaVooA2R3nf8ki9bgdy2FGqAYH3n
         ebdCsFBa/j0/x5S68gwexqCr1819+zzLcYIG3zTC2OUzWhfuml6Yixpy300Ffps1A3Z1
         0Cbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795476472; x=1796081272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j99f7KwqCGFPCQ5UxSgKf/Q6ehYNM1RCLTZobLCSX8U=;
        b=NMcT+Z3EWVSltCE/coZjzMnbe3jyoET7db2g3MvPumVoKqrqYuKj3k15iFKvzhn3dw
         /7+k8pCIZ1sKbn7QJ0qUPbq/vvZ6MWRfK6fH6UI9dj5fN2g1mM9z90CZpHy+ikqYj84k
         Lc0CE+CB58imOUkfsfliZZAvyz6xBlT+op858RjEk+sMC74LRtS6MXIKqV1Y4Ozs4NzI
         pfb8jZvcWbpUGt2m1xHoXkg0iFhFNxl4qqQtVvsJj9t38u6S6c9YmiTsNY6Xgzg7aJWk
         +MHl81Rv2Ns1vgXuvZ+6aJaa9t/mSIvXLxRNSlJx9Ox48MoVDZgdNW43jMft7IifD8/q
         cONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795476472; x=1796081272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j99f7KwqCGFPCQ5UxSgKf/Q6ehYNM1RCLTZobLCSX8U=;
        b=aCs3mDgxwOWMC8Em3lElARftZ4Nw28HCP6IwCTm3PaV0DbXT5io7LkxiVdAg8ELr36
         ji/IPintoaA6xcuJC9QGLcgILgETG/TpelZzREZhLCPht3deytkdsv3OroB33mGBiggX
         kn4TyhbU/jaOQqub9Pt36CW3h+6M6nNgS1BY0zJSCcPExHMMBgvvFWFzeC+7q//Kokez
         StdmEf5q4EKecsgwVU0tbtT/creJf/cmsPK6zlPlloatRp/BYl2t22A7ot/1P4Vdy8xl
         xvHlzArt8aNiqGhASog0JDdbfDkaGYNgyy+feztB6OXEfPS6SAOj3R4KwdCW8p2B01xh
         NC0Q==
X-Forwarded-Encrypted: i=1; AL+hErFg3llm+mFzHd1PKrAY3mInhXypFaBOig8WhVo2n128unh7wfrfvVclqWIIpfniyrOKUS7eU5s3I/IVTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/f/CT+da/uFzpvcE/EHTf/JKp4AN1JJj7k3vP+bjHbg/Jfaedr
	D3DlILvuCbTz6MhVX3uvD48fmbfCXQsLVZn5ls3+XxGmU3Axx+jFUe6VlCtaliL/bfnqrhHh7Vj
	wZKkqEjZ+q3QS232PLJ7zckMaJqR5+pc=
X-Gm-Gg: AZFdTZfmzH+zKlmMwLVjgvhyIYLj0MRw0EpkhUj+MnxCfbuqaX3kGrQ795P1W37hyd9
	nVm+vDb/exQ0PhCW0MUt7lRB/nJgCn3imFO2a43FRrX8I0Sfm69RG+bI9xa9fRwwJtH2Jb+UZgK
	GLGgrAX97gN2R8kpvjgd4jOcmUbK88Ar0V0WpTaTsuoJBcyCmU1fsM0JU5VURQHWBuDFgeKNP1Y
	wxyOGtaek7+7XV0Qyal1KDnNe7/z/JeKaNUt+vXxId/+Oh6BOyGX5bGwMKMoRmj8Q2ct350gLBo
	zyLM1ulS0t1KsTW/8IZYCl57ADb1RnBZyfzPsrv2BGjtI921b60qXX2jzj8BCruApNezrxfifcA
	fkk8hDEQ5/Nlgpb/SFeqnlsdc2GnUmaPB3xqtM+ZhpvMKM7QAp6Q6l5t29VrnfQ5PBaqcHoppaA
	k+J+1PLUtih9ZbhMbJJou+HdNtofIkoWK4VB/h/s/HtUBn01nvR3UFW0qMC9fz
X-Received: by 2002:a05:6512:3041:b0:5bf:d26e:7992 with SMTP id
 2adb3069b0e04-5c1bc81c6femr3148270e87.28.1795476471695; Mon, 23 Nov 2026
 15:27:51 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021200841.75370-1-vishnuocv@gmail.com> <6e562b92-afbe-4c01-a703-81d55f2fdc65@app.fastmail.com>
In-Reply-To: <6e562b92-afbe-4c01-a703-81d55f2fdc65@app.fastmail.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Tue, 24 Nov 2026 08:27:13 +0900
X-Gm-Features: Aa3M54qGkSlPb6AAF4Q4xv6wOZZMDja4nj8z44oGFfWi0CKH1H0cvTYAtZkZBFM
Message-ID: <CABxCQKuRk3ZV0bRbcautcfkOWWQF1Y+_DrtHzk2+cfiuDVOVZQ@mail.gmail.com>
Subject: Re: [PATCH] HID: lenovo: Add keyboard backlight support for the X13
 detachable folio
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J . Clark" <derekjohn.clark@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vishnu Sankar <vsankar@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, Benjamin, Derek,

Gentle ping on this one - posted on Oct 21, and I have not had any
feedback yet.

It still applies to the current mainline and I have
retested on the X13 Detachable.
Is there anything you would like changed before this can be picked up,
or would you prefer that I resend it rebased as v3?

Mark - Thanks for the "Reviewed-by" tag.

Thanks,
Vishnu

On Fri, Oct 30, 2026 at 10:02=E2=80=AFPM Mark Pearson <mpearson-lenovo@sque=
bb.ca> wrote:
>
> Thanks Vishnu,
>
> On Wed, Oct 21, 2026, at 4:08 PM, Vishnu Sankar wrote:
> > The keyboard backlight of the ThinkPad X13 detachable folio is reached
> > over HID rather than through the EC, so thinkpad_acpi exposes nothing
> > for it and userspace can neither read the level nor set it.
> >
> > The folio takes and reports the level over the same vendor reports this
> > driver already uses for the Fn-lock, mute and mic-mute indicators, so
> > register a kbd_backlight LED class device on top of them.
> >
> > The firmware cycles the level on Fn+Space by itself.  Report the
> > resulting state to the LED class device instead of the keypress, which
> > userspace would otherwise act on a second time.
> >
> > Tested on a ThinkPad X13 Detachable (17ef:62af), BIOS R3IET32WM.
> >
> > Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> > Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> > ---
> >  drivers/hid/hid-lenovo.c | 122 ++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 119 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> > index 3976d7b53b14..956c26128f40 100644
> > --- a/drivers/hid/hid-lenovo.c
> > +++ b/drivers/hid/hid-lenovo.c
> > @@ -24,6 +24,7 @@
> >  /*
> >   */
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/module.h>
> >  #include <linux/sysfs.h>
> >  #include <linux/device.h>
> > @@ -51,6 +52,8 @@ struct lenovo_drvdata {
> >       struct mutex led_report_mutex;
> >       struct led_classdev led_mute;
> >       struct led_classdev led_micmute;
> > +     struct led_classdev led_kbd_bl;
> > +     struct work_struct kbd_bl_sync_work;
> >       struct work_struct fn_lock_sync_work;
> >       struct hid_device *hdev;
> >       int press_to_select;
> > @@ -75,10 +78,19 @@ struct lenovo_drvdata {
> >  #define TP10UBKBD_FN_LOCK_LED                0x54
> >  #define TP10UBKBD_MUTE_LED           0x64
> >  #define TP10UBKBD_MICMUTE_LED                0x74
> > +#define TP10UBKBD_KBD_BL_LED         0xc4
> >
> >  #define TP10UBKBD_LED_OFF            1
> >  #define TP10UBKBD_LED_ON             2
> >
> > +/* Above the levels, 0x04 selects the firmware's own automatic mode. *=
/
> > +#define TP10UBKBD_KBD_BL_MAX         2
> > +
> > +static bool lenovo_has_kbd_backlight(struct hid_device *hdev)
> > +{
> > +     return hdev->product =3D=3D USB_DEVICE_ID_LENOVO_X13_TAB;
> > +}
> > +
> >  /* Function to report raw_events as key events*/
> >  static inline void report_key_event(struct input_dev *input, int
> > keycode)
> >  {
> > @@ -87,8 +99,8 @@ static inline void report_key_event(struct input_dev
> > *input, int keycode)
> >       input_sync(input);
> >  }
> >
> > -static int lenovo_led_set_tp10ubkbd(struct hid_device *hdev, u8
> > led_code,
> > -                                 enum led_brightness value)
> > +static int lenovo_send_led_report_tp10ubkbd(struct hid_device *hdev,
> > u8 led_code,
> > +                                         u8 value)
> >  {
> >       struct lenovo_drvdata *data =3D hid_get_drvdata(hdev);
> >       int ret;
> > @@ -97,7 +109,7 @@ static int lenovo_led_set_tp10ubkbd(struct
> > hid_device *hdev, u8 led_code,
> >
> >       data->led_report[0] =3D TP10UBKBD_LED_OUTPUT_REPORT;
> >       data->led_report[1] =3D led_code;
> > -     data->led_report[2] =3D value ? TP10UBKBD_LED_ON : TP10UBKBD_LED_=
OFF;
> > +     data->led_report[2] =3D value;
> >       ret =3D hid_hw_raw_request(hdev, data->led_report[0], data->led_r=
eport,
> > 3,
> >                                HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
> >       if (ret !=3D 3) {
> > @@ -114,6 +126,33 @@ static int lenovo_led_set_tp10ubkbd(struct
> > hid_device *hdev, u8 led_code,
> >       return ret;
> >  }
> >
> > +static int lenovo_led_set_tp10ubkbd(struct hid_device *hdev, u8
> > led_code,
> > +                                 enum led_brightness value)
> > +{
> > +     return lenovo_send_led_report_tp10ubkbd(hdev, led_code,
> > +                     value ? TP10UBKBD_LED_ON : TP10UBKBD_LED_OFF);
> > +}
> > +
> > +static int lenovo_read_led_state_tp10ubkbd(struct hid_device *hdev, u8
> > led_code,
> > +                                        u8 *state)
> > +{
> > +     struct lenovo_drvdata *data =3D hid_get_drvdata(hdev);
> > +     int ret;
> > +
> > +     guard(mutex)(&data->led_report_mutex);
> > +
> > +     data->led_report[0] =3D led_code;
> > +     ret =3D hid_hw_raw_request(hdev, data->led_report[0], data->led_r=
eport,
> > 2,
> > +                              HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> > +
> > +     if (ret !=3D 2)
> > +             return ret < 0 ? ret : -EIO;
> > +
> > +     *state =3D data->led_report[1];
> > +
> > +     return 0;
> > +}
> > +
> >  static void lenovo_tp10ubkbd_sync_fn_lock(struct work_struct *work)
> >  {
> >       struct lenovo_drvdata *data =3D
> > @@ -725,6 +764,7 @@ static const struct attribute_group
> > lenovo_attr_group_cptkbd =3D {
> >  /* Function to handle Lenovo Thinkpad TAB X12's HID raw inputs for fn
> > keys*/
> >  static int lenovo_raw_event_TP_X12_tab(struct hid_device *hdev, u32
> > raw_data)
> >  {
> > +     struct lenovo_drvdata *data =3D hid_get_drvdata(hdev);
> >       struct hid_input *hidinput;
> >       struct input_dev *input =3D NULL;
> >
> > @@ -764,6 +804,15 @@ static int lenovo_raw_event_TP_X12_tab(struct
> > hid_device *hdev, u32 raw_data)
> >                       return 1;
> >               case TP_X12_RAW_HOTKEY_FN_SPACE:
> >                       /* Keyboard LED backlight toggle*/
> > +                     if (data && lenovo_has_kbd_backlight(hdev)) {
> > +                             /*
> > +                              * The firmware has already cycled the
> > +                              * backlight; reporting the key as well w=
ould
> > +                              * have userspace change the level again.
> > +                              */
> > +                             schedule_work(&data->kbd_bl_sync_work);
> > +                             return 1;
> > +                     }
> >                       report_key_event(input, KEY_KBDILLUMTOGGLE);
> >                       return 1;
> >               default:
> > @@ -1178,6 +1227,60 @@ static int lenovo_led_brightness_set(struct
> > led_classdev *led_cdev,
> >       return ret;
> >  }
> >
> > +static int lenovo_kbd_bl_brightness_set(struct led_classdev *led_cdev,
> > +                                     enum led_brightness value)
> > +{
> > +     struct hid_device *hdev =3D to_hid_device(led_cdev->dev->parent);
> > +
> > +     return lenovo_send_led_report_tp10ubkbd(hdev, TP10UBKBD_KBD_BL_LE=
D,
> > +                                             value);
> > +}
> > +
> > +static enum led_brightness
> > +lenovo_kbd_bl_brightness_get(struct led_classdev *led_cdev)
> > +{
> > +     struct hid_device *hdev =3D to_hid_device(led_cdev->dev->parent);
> > +     u8 state;
> > +
> > +     if (lenovo_read_led_state_tp10ubkbd(hdev, TP10UBKBD_KBD_BL_LED, &=
state))
> > +             return led_cdev->brightness;
> > +
> > +     if (state > TP10UBKBD_KBD_BL_MAX)
> > +             return led_cdev->brightness;
> > +
> > +     return state;
> > +}
> > +
> > +/* Reading the state sleeps, so it cannot be done from the report hand=
ler. */
> > +static void lenovo_kbd_bl_sync(struct work_struct *work)
> > +{
> > +     struct lenovo_drvdata *data =3D
> > +             container_of(work, struct lenovo_drvdata, kbd_bl_sync_wor=
k);
> > +     enum led_brightness value;
> > +
> > +     value =3D lenovo_kbd_bl_brightness_get(&data->led_kbd_bl);
> > +     data->led_kbd_bl.brightness =3D value;
> > +     led_classdev_notify_brightness_hw_changed(&data->led_kbd_bl, valu=
e);
> > +}
> > +
> > +static int lenovo_register_kbd_backlight(struct hid_device *hdev)
> > +{
> > +     struct lenovo_drvdata *data =3D hid_get_drvdata(hdev);
> > +
> > +     data->led_kbd_bl.name =3D devm_kasprintf(&hdev->dev, GFP_KERNEL, =
"%s::%s",
> > +                                            dev_name(&hdev->dev),
> > +                                            LED_FUNCTION_KBD_BACKLIGHT=
);
> > +     if (!data->led_kbd_bl.name)
> > +             return -ENOMEM;
> > +
> > +     data->led_kbd_bl.max_brightness =3D TP10UBKBD_KBD_BL_MAX;
> > +     data->led_kbd_bl.brightness_set_blocking =3D lenovo_kbd_bl_bright=
ness_set;
> > +     data->led_kbd_bl.brightness_get =3D lenovo_kbd_bl_brightness_get;
> > +     data->led_kbd_bl.flags =3D LED_HW_PLUGGABLE | LED_BRIGHT_HW_CHANG=
ED;
> > +
> > +     return led_classdev_register(&hdev->dev, &data->led_kbd_bl);
> > +}
> > +
> >  static int lenovo_register_leds(struct hid_device *hdev)
> >  {
> >       struct lenovo_drvdata *data =3D hid_get_drvdata(hdev);
> > @@ -1344,6 +1447,7 @@ static int lenovo_probe_tp10ubkbd(struct hid_devi=
ce *hdev)
> >               return -ENOMEM;
> >
> >       mutex_init(&data->led_report_mutex);
> > +     INIT_WORK(&data->kbd_bl_sync_work, lenovo_kbd_bl_sync);
> >       INIT_WORK(&data->fn_lock_sync_work, lenovo_tp10ubkbd_sync_fn_lock=
);
> >       data->hdev =3D hdev;
> >
> > @@ -1374,7 +1478,16 @@ static int lenovo_probe_tp10ubkbd(struct
> > hid_device *hdev)
> >       if (ret)
> >               goto err;
> >
> > +     if (lenovo_has_kbd_backlight(hdev)) {
> > +             ret =3D lenovo_register_kbd_backlight(hdev);
> > +             if (ret)
> > +                     goto err_leds;
> > +     }
> > +
> >       return 0;
> > +err_leds:
> > +     led_classdev_unregister(&data->led_micmute);
> > +     led_classdev_unregister(&data->led_mute);
> >  err:
> >       sysfs_remove_group(&hdev->dev.kobj, &lenovo_attr_group_tp10ubkbd)=
;
> >       return ret;
> > @@ -1477,6 +1590,9 @@ static void lenovo_remove_tp10ubkbd(struct
> > hid_device *hdev)
> >       if (data =3D=3D NULL)
> >               return;
> >
> > +     cancel_work_sync(&data->kbd_bl_sync_work);
> > +
> > +     led_classdev_unregister(&data->led_kbd_bl);
> >       led_classdev_unregister(&data->led_micmute);
> >       led_classdev_unregister(&data->led_mute);
> >
> >
> > base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
> > --
> > 2.56.0
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Mark



--=20

Regards,

      Vishnu Sankar
