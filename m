Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F129408
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195555; cv=pass; b=NZXWotYO0bGFLHRwOvX0DG6U479wgtUUDIO4FLN67f4Vrh3phCau5CX44RJkOyEvKyPaKimWipv1iek9Dt+L+BDfwo8dsB9kPBr3UfKxZv77sH6dUKzKTWZnHZcs6uNSbHGAXVkuma9YLgssA/CpxebVep2jCjOc8l0tBQW771s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195555; c=relaxed/simple;
	bh=02BQi84FUAtE5RV52UueDOwghGcWGs0jqPnkAQ/Biq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnOJi0WAbbAAK6aQW89AP4NdZIYyQ7k29sXjQu5yRTNd8bXfJw+HRfx0ndWZpWUsBYJFRcUYMAXENmz3ckdhENmxg+F3G1KG4nX4ddBqaFTfkaZfJVjDVYhgwm/Ww/qpPERkXPLMtS3JKEEs28llM3DYkohZIESZ+kz4F/57xeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Da5ntQ; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Da5ntQ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917d595138fso2903356d6.3
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 17:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792195553; cv=none;
        d=google.com; s=arc-20260327;
        b=MZ3vUgdiWU+I2wVY3XpHHoAgu5QWSE54vWRqnz03cl1JAsZ1JyNI2Qumso53iTioCP
         EJnd07CF9boJo4XkHMo3ZlOPZsxI2KoKyNrAXFNi9P4PMHZX0FVtI8vF2AYEfrZi3SwQ
         OkrOEfANMzKipnHAlTF7ULA4Z6JcpqYfBIm57uBRfabA5q2ImCJb91ERlVFIkyW2VJoj
         qev8UB7kUl+Gza3/JynpaDew2u50gDGmOESTMNaA6s7Py7Dmtg6H/zvOXi2y1BA1JYnO
         0XK7H8JTJjSSmVaHeRw9Wo2XsumXR7aSNUAHDlkTbXbhEcJ8cbOPIeUgPZCRlJGXxesl
         JoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kK9dd5FfOGQnyxwJqESSjuJBP8NcOkq7nYMyK9tV4Xo=;
        fh=08lTvKJBjJNw7nYgWBtBxjMd/r5o4DxIKXC+Q6l9lpg=;
        b=J2nPlURJhhDBMRdLKiW3cjQ2CgiyYc8lINtvxFXz2s+dFnM8BFtYYLOwQoUWzBRTY0
         6aAZwLF8r/UdHYMIyKoCHt0B6Nd7u7MiJxcz9YsdjeWsJY09cWSKQL6HQWSdqetZCOAq
         AUzHG/infDuZx71pvoaUQiaMhLsgFTR/cV3d6jLGlFI7ktTYxpAPuP3D4zCH9LvNc0qs
         s7nc+PpuZXTYWCxOLiMbai57YNwXDAcetNhxELQOej8HTRB6708x+WbVH8UI36/iH8KU
         OnwvqCMQ0ysDNT20d9VDZGSGw1JEMHjoeXp+Ndek0FwUTMZWwGRE2JnAFRTetE2wrM1n
         6h2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792195553; x=1792800353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kK9dd5FfOGQnyxwJqESSjuJBP8NcOkq7nYMyK9tV4Xo=;
        b=I2Da5ntQy1wRwm2IWbBknBmBrfuYQ0AxYfreIOE3eg1BxZQ/Zo3843Fx4zoRlhC0j9
         EK/943LyhOquLgI/LHjRFArE1V4htatDRk5X6+MXETpGwzgUJOmrhRjuJfHEb8l+hpr3
         ewNVEoo62MDbKwOvIAyRaAAJH6F8JclYVm7eNGzTTM9n2MyTlR5O1MGHpxvB24zAoE+o
         o+A4Dv4Gj8pXw/kuzSAYD6Fqv1F8ROZpyR3mxvT/Supi9MgLtJr89Gvkbk0POl7BvCwG
         WwIM2e7AI9t/LK0IKAXJmIBGPOJTr2OHhCCK+9F/brkEULWChtCMCdOZ7Fohmb9RDVGg
         Jl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792195553; x=1792800353;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kK9dd5FfOGQnyxwJqESSjuJBP8NcOkq7nYMyK9tV4Xo=;
        b=TPWyhYjaKHPmO1hypHw5XR5pcsVYiv1eOJzl7h+A6T4fhx6pgI4qj30H/4jTDME2BJ
         Hie1oqu4YAdbBgcGatsVF6VWIBYUjOtIZSZgxG6h6vl8na6epXbaGZ+K5N1oMrb64tn6
         a6GLDBiaKSF44FNX+MASY8up8gpkc8O+kcBGsCTcd5sHRS2OMWkwYAeSgaVt0NdfjUri
         LmOb3l5DG31ZrvBBR2HcQ6W81A9emuH5epBuyheEB2AzvlgXsKect+ImMvhX18VbclKX
         AiK3B7RqxNka4yTeQrB76BAsgAh+2kTe5EjFp24bgVmlfdeVu8vcHfPOnemzMORoYRXE
         EJyw==
X-Forwarded-Encrypted: i=1; AKwUvBwutyqUmbP2KnUqU/M/iIiqGOW2x0eEWVugTJPA1730hcB7jSPu0EBlzyaST23acOAJ5IQ/Pn0oeMXoPQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIhe9TX66whhvKLja2Mjtu5Jt7Snns16Lde09IQ0wRX/95pDzoC
	GlFCXbRBjcDe9TGS+EGb8/Zj2xXwaNqVezMKgG5zthk4pZYKHtyMvS58yKxZObP20k3a+ShmZpJ
	ZcFG63ZI0/X06wQ6hgzorCH12Z62WUdc=
X-Gm-Gg: AYBFou09NpAzlt73lD4AiOSdYWTjuds3FWy5GWOl52a/IkBcsx1GcgcoEVPXz/81Avv
	zw/kiXFhoCNIFzRiZKp70q4pHXDU0OvqXHObHmnjZPBak55T9PxNuCSt2NtRq7t+k8sVsPP2AtQ
	1QZXb/g+VC0JcqI3zb/bHfkeNa7A15mVZo8idV6tlacou0FzsCSFt47G2cjeBPcfKAifHgG2Vhj
	1cWrgRsYYajlyea56Eh+hOrnjh2rp6vTRs5n1nBEtYk7g+a+Yvy2hTvPts1L51Pff/3mIILJdTH
	kf3ZIgrbbvC82edm2yZpxnoL6m67dmhPVmsMH3Oq4FUIhv2URxQiTo0=
X-Received: by 2002:a05:6214:766:b0:917:8783:341 with SMTP id
 6a1803df08f44-91bdf3e1e3bmr28225306d6.45.1792195553124; Fri, 16 Oct 2026
 17:05:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579o8so3-09o3-o312-4sq0-0qp6n672q46p@xreary.bet>
 <20260927041138.4112920-1-jinmo44.yang@gmail.com> <20260927041138.4112920-3-jinmo44.yang@gmail.com>
In-Reply-To: <20260927041138.4112920-3-jinmo44.yang@gmail.com>
From: Jason Gerecke <killertofu@gmail.com>
Date: Fri, 16 Oct 2026 17:05:41 -0700
X-Gm-Features: AclHuK_pqOM0nh2PKLmkogbaRyb0DRMy3kSfOq2Ob-BWY6-XdtMjof79nHSmSJM
Message-ID: <CANRwn3SL3_1ees-D6CQviQRLjwLjCp4Ssjqwj4M_wbb8Fefprw@mail.gmail.com>
Subject: Re: [PATCH 2/5] HID: wacom: check the input devices in the legacy irq handlers
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: ping.cheng@wacom.com, jason.gerecke@wacom.com, jikos@kernel.org, 
	bentiss@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 9:12=E2=80=AFPM Jinmo Yang <jinmo44.yang@gmail.com>=
 wrote:
>
> wacom_penpartner_irq(), wacom_pl_irq(), wacom_ptu_irq(),
> wacom_dtu_irq(), wacom_dtus_irq() and wacom_graphire_irq() take
> pen_input, and the latter two also take pad_input, without checking
> either.
>
> As described in "HID: wacom: check the input device in the shared
> report helpers", a partial interface leaves one or two of the three
> input devices NULL on a fully successful probe, and wacom_wac_irq()
> still dispatches to these handlers. Seven locations fault, each
> reproduced on linux-next 20260925 (x86_64, KASAN) from one /dev/uhid
> device plus a single UHID_INPUT2 write:
>
>   wacom_wac.c:137   wacom_penpartner_irq    pen_input
>   wacom_wac.c:227   wacom_pl_irq            pen_input
>   wacom_wac.c:244   wacom_ptu_irq           pen_input
>   wacom_wac.c:303   wacom_dtus_irq          pad_input
>   wacom_wac.c:326   wacom_dtus_irq          pen_input
>   wacom_wac.c:391   wacom_graphire_irq      pen_input
>   wacom_wac.c:444   wacom_graphire_irq      pad_input
>
> for example, with vendor 0x056a product 0x0030 (PL) and report id 2:
>
>   BUG: KASAN: null-ptr-deref in input_event+0x44/0xb0
>   Read of size 8 at addr 0000000000000028
>    wacom_wac_irq+0x2b27/0xb3f0
>    wacom_raw_event+0x68f/0xb60
>    __hid_input_report+0x398/0x4d0
>    uhid_char_write+0xa99/0xfc0
>
> Check each pointer where it is taken. wacom_dtus_irq() and
> wacom_graphire_irq() serve both pen and pad reports, so the checks are
> placed per branch rather than at function entry: an interface that has
> a pad but no pen must keep delivering pad events.
>
Such a device does not exist for the cases handled by
wacom_graphire_irq and wacom_dtus_irq. A pen interface is expected for
all of these device types, and a pad interface is expected for all but
the GRAPHIRE case. The wacom_setup_device_quirks function takes care
of ensuring that the pad type gets added to the same interface as the
pen (for all but GRAPHIRE) so that wacom_setup_pad_input_capabilities
does not cull the interface later.

It should be safe to move the checks for valid pen and touch
interfaces to the top of both of these functions (again, with the
additional condition that wacom_graphire_irq must must ignore a NULL
pad in the case of a GRAPHIRE type).

> wacom_dtu_irq() gets a check too. Its only dereference is in a
> dev_dbg(), so it does not fault with CONFIG_DYNAMIC_DEBUG=3Dn, but it is
> unconditional in the source.
>
> Fixes: 2a6cdbdd4cc0 ("HID: wacom: Introduce new 'touch_input' device")
> Fixes: 862cf5535c0c ("HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD de=
vice_type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
> ---
>  drivers/hid/wacom_wac.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 177a1e09fd05..794c2865064a 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -128,6 +128,9 @@ static int wacom_penpartner_irq(struct wacom_wac *wac=
om)
>         unsigned char *data =3D wacom->data;
>         struct input_dev *input =3D wacom->pen_input;
>
> +       if (!input)
> +               return 0;
> +

As with patch 1, each of these checks is for an unusual error
condition so a dev_warn_once or hid_warn_once before returning is
suggested.

Jason (she/they)
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....


>         switch (data[0]) {
>         case 1:
>                 if (data[5] & 0x80) {
> @@ -174,6 +177,9 @@ static int wacom_pl_irq(struct wacom_wac *wacom)
>         struct input_dev *input =3D wacom->pen_input;
>         int prox, pressure;
>
> +       if (!input)
> +               return 0;
> +
>         if (data[0] !=3D WACOM_REPORT_PENABLED) {
>                 dev_dbg(input->dev.parent,
>                         "%s: received unknown report #%d\n", __func__, da=
ta[0]);
> @@ -233,6 +239,9 @@ static int wacom_ptu_irq(struct wacom_wac *wacom)
>         unsigned char *data =3D wacom->data;
>         struct input_dev *input =3D wacom->pen_input;
>
> +       if (!input)
> +               return 0;
> +
>         if (data[0] !=3D WACOM_REPORT_PENABLED) {
>                 dev_dbg(input->dev.parent,
>                         "%s: received unknown report #%d\n", __func__, da=
ta[0]);
> @@ -263,6 +272,9 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
>         struct input_dev *input =3D wacom->pen_input;
>         int prox =3D data[1] & 0x20;
>
> +       if (!input)
> +               return 0;
> +
>         dev_dbg(input->dev.parent,
>                 "%s: received report #%d", __func__, data[0]);
>
> @@ -299,6 +311,8 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
>                 return 0;
>         } else if (data[0] =3D=3D WACOM_REPORT_DTUSPAD) {
>                 input =3D wacom->pad_input;
> +               if (!input)
> +                       return 0;
>                 input_report_key(input, BTN_0, (data[1] & 0x01));
>                 input_report_key(input, BTN_1, (data[1] & 0x02));
>                 input_report_key(input, BTN_2, (data[1] & 0x04));
> @@ -307,6 +321,9 @@ static int wacom_dtus_irq(struct wacom_wac *wacom)
>                                  data[1] & 0x0f ? PAD_DEVICE_ID : 0);
>                 return 1;
>         } else {
> +               if (!input)
> +                       return 0;
> +
>                 prox =3D data[1] & 0x80;
>                 if (prox) {
>                         switch ((data[1] >> 3) & 3) {
> @@ -363,7 +380,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>         }
>
>         prox =3D data[1] & 0x80;
> -       if (prox || wacom->id[0]) {
> +       if (input && (prox || wacom->id[0])) {
>                 if (prox) {
>                         switch ((data[1] >> 5) & 3) {
>
> @@ -438,7 +455,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>         switch (features->type) {
>         case WACOM_G4:
>                 prox =3D data[7] & 0xf8;
> -               if (prox || wacom->id[1]) {
> +               if (pad_input && (prox || wacom->id[1])) {
>                         wacom->id[1] =3D PAD_DEVICE_ID;
>                         input_report_key(pad_input, BTN_BACK, (data[7] & =
0x40));
>                         input_report_key(pad_input, BTN_FORWARD, (data[7]=
 & 0x80));
> @@ -453,7 +470,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>
>         case WACOM_MO:
>                 prox =3D (data[7] & 0xf8) || data[8];
> -               if (prox || wacom->id[1]) {
> +               if (pad_input && (prox || wacom->id[1])) {
>                         wacom->id[1] =3D PAD_DEVICE_ID;
>                         input_report_key(pad_input, BTN_BACK, (data[7] & =
0x08));
>                         input_report_key(pad_input, BTN_LEFT, (data[7] & =
0x20));
> @@ -468,7 +485,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom=
)
>                 break;
>         case GRAPHIRE_BT:
>                 prox =3D data[7] & 0x03;
> -               if (prox || wacom->id[1]) {
> +               if (pad_input && (prox || wacom->id[1])) {
>                         wacom->id[1] =3D PAD_DEVICE_ID;
>                         input_report_key(pad_input, BTN_0, (data[7] & 0x0=
2));
>                         input_report_key(pad_input, BTN_1, (data[7] & 0x0=
1));
> --
> 2.53.0
>
>
