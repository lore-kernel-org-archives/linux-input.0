Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236B35F19D
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785440044; cv=pass; b=NOH2UOLYyUww7wznqe7r9YiAN9piMewt344tjLlvhe/FGKOoY8o1S8IRoH+zqnqX3wM4nWbO2zgXa1ttiXMwiVapnH+KzMyKROGjlwcUL8/g8hUT2IuwnE9rSnre3DHytpjiZqsY2maRQWXrFPUpyUAZzVGSdJGAV9c906k/h8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785440044; c=relaxed/simple;
	bh=/lI5XI2KNtXCzJu7N3TC4oGMh3TlCtrLy6y3hLHrfAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Et08d4AfNDYDq3YlX/2sMfqvqgoOLok4xAv7c7x8l49hcuVAncT8s7zf8cTIE0BXmTzdHiRNVkKDAQuHXw/13pW96syNaBMt813+ejRlzFDYwseUmosmH5F2OHjDqVtioKTEzsfmPfwHl2gIqhnQW3w6LuurUUUl71ryznkur6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKuudd2Y; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKuudd2Y"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43b7e186a0cso149621fac.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 12:34:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785440039; cv=none;
        d=google.com; s=arc-20260327;
        b=ewyU8kJkjSzhH7s8EDqzO1KTrWOO/OYuJG8dmMb10SiVILspHhEvf/3nErm5RcFsGE
         KPIAGlFnWPb/Gd1rD2gnRhH27VG/3NJR/eZzBNgxMubLbnQj1muC8Prp3fbjxF2y573x
         pn3bxFwwoVYu8F4WCWMVOUR4DSoz8/9h2kYsBhXWoETBcGazSsFburSOThrIRFbTg8Jh
         BXHhCB66rc8vQeuz4886oQUQXa4lWL3SogP6rfYTxewSWBuRDJamPT8KEHhYuMmbMeXE
         U7Cm2CJXrTAjoi1TUFRQLDM/rlSSzrZZc0fovY50lZjzZmnRXtnRrs/jQkkQmDcFSnAZ
         UHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OER/PrjpR2ePDxGtg4rSGKG360JXfsYXkKMI8tkl8r4=;
        fh=l1AP/n4HAQ/9vHRqEexf6IiAxAqjltEguhhet2HCYvI=;
        b=QRH/QDbAcLhLsPjofDkvLStC1X2+XKHm5CgKQZ7fHxAZ7xjklOJUbBhOrj3EXj5Dkz
         16WWq5kauiFHvI3ROmkkEMwdIDCFiaBjmv6LaG5fIWELlqJmNDLhABSQWD32JvBbjc0E
         AJoM/CIz/AY7LFMLUftIq8wjioZ+er1bxL4UzFO0Q5MTDdSKff/y0630Ufl5QHAFZdNK
         5asZcL9SA3VzqAufaQpDE5bRJApdM/OfRj8Wt+RN4mBwkGxN3d/keHwQczhxHlC9DBmw
         bFAf3/5QI5elOXl6k+Drwwjm6QXyUVvRCW9iPdMln9fF9Q+v8m/AJKGDT7iDflUP59Vs
         ZReg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785440039; x=1786044839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OER/PrjpR2ePDxGtg4rSGKG360JXfsYXkKMI8tkl8r4=;
        b=iKuudd2Ypn2Zlpyf3u25S7rnV+x3/7tG80pi57GI7pK21jIO/5WG6r0cBi7hORO4el
         w+rB85xZvqSKVeUv8g2/62HVWhUGtQlzNQKEvez+hFTWI8pSOna8xqwlrEVryDGoU8Lf
         jhmaQuULyw5uFDll9rFnvGsOiCx181lbJJUjaFKwBItYdynjbTSg/mac2rRZ38TQjYlK
         AnyfH1nha9tf1sSD/OQdyEWfQHPJSHltJx4gK1HWmFlX2GS5YBvFJMUBE23B95bCXW6j
         QWqCdsif9dp+9PsQjkonPbJrIPTex4GG1izIdi3i3qYQ2Vig8abzrvCyPSHSXjI0rCrg
         sofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440039; x=1786044839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OER/PrjpR2ePDxGtg4rSGKG360JXfsYXkKMI8tkl8r4=;
        b=Cx2sgGD8ChOhvCUYEk3pgFFxlh0FkazFxiEZHZV5e0+CXhx2jpsDAjRduJVWP/83E2
         6rtwAcrQEIgPC6IOwTgANxL2velPCVFNBpvXUZ5pBt1tSiknZoyF2j3cAQgt9GpfZDjP
         Udz9j6yS54xaL967m7Rt3oNy2IGHnATndsWpeDoDGOHHHOlpxUgj+EssfMZjt8MTDS2N
         r4M9c8o7x45nArtcHFyeE64NY4qVe3HBtI384ZRWTcPOWsvrkdCGrxHcriLcFTKPIIa4
         oK2MoFftEK2ccC6iXKQm03PBGk+2ogDQ/BTRuBqtgVlsz1bhXmM6LoyMdUQm/EE3q+eP
         jVYg==
X-Gm-Message-State: AOJu0YyAO0jq8+RNhdVK9aTkr4Bv330HyCY27l+DMVSZf//l+O21jU/+
	L1nlWrrWJ1biSoFujesxVaPdjpG+zpCsy092DdN1rIn3y76Ebcxaho/BZzPWoRc+zZEbO64jwuU
	WHLczAGHSzEqP/BIxYBH+hNQU8A1dfko=
X-Gm-Gg: AR+sD12Nj7Sg/CcviMnR+9HJ1PDtlYUJOpYVS7dBTnq9XGAT2frB+1KqeWEhgSYaK5W
	egV9q3ZVT9L2RuV7Ic6DTeXDal/bKzf+U1SxXV41dnbRxYvIpg4vbZov6IYyH3pwHXnSxPzy5wH
	ZPy8j8UVH/eGrgVd6vbYszkin1Q/1Duxa+p4gPp9DmjNjJ+rYoL2BKieEAm6Qn8GVgs3rfgLtQQ
	YAJrProdkBMOabB8OyNtRiAoW2SyFIdhPpuiEkfezAMDqNVYtlZPfMwfJ+DlZDMJWdcPYRT9Fas
	QGh/MeVYGY57nBBXfJfKmf3M8USTlEzl7QGg0rrvJCAJXzSkyoEc4jL0yzORVTbRQrdFK/Sj6f0
	x7oo22F+CkV2L+w==
X-Received: by 2002:a05:6808:1783:b0:496:301:36b9 with SMTP id
 5614622812f47-4ad873ca645mr3324420b6e.0.1785440038998; Thu, 30 Jul 2026
 12:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783094954.git.edouglas7358@gmail.com> <2e719e56029386f148d748a7d555023f4efe3862.1783094954.git.edouglas7358@gmail.com>
 <a98072328950f6b45a358086cbd6a16c5b645416.camel@hadess.net>
In-Reply-To: <a98072328950f6b45a358086cbd6a16c5b645416.camel@hadess.net>
From: Elliot Douglas <edouglas7358@gmail.com>
Date: Thu, 30 Jul 2026 12:33:38 -0700
X-Gm-Features: AUfX_mz6oijK-oDuEGQNHoKFUcd6Pvm_7LF5gSUg54kK2DNdKW4vY3Ywmu-P5Rg
Message-ID: <CAGt6S1oVO1zE9+HZWfvVBEfgLEc6cisfG-SonUVFf+XSTft2+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: logitech-hidpp: enable reprogrammable buttons
 on Signature M650
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, lains@riseup.net, jikos@kernel.org, 
	bentiss@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback. I just left for a trip, but I'll be back and
should be able to work on it on Tuesday, August 11th.


On Thu, Jul 30, 2026 at 1:07=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Sat, 2026-07-04 at 16:10 -0700, Elliot Douglas wrote:
> > The Bluetooth Signature M650 exposes its side buttons through the
> > normal
> > mouse report, but the observed events are short click-like events
> > emitted
> > around release rather than physical press/release state.
> >
> > The device appears to use the held side-button state for its built-in
> > gesture and side-button + wheel horizontal-scroll mode. As a result,
> > holding a side button long enough
>
> s/long enough/more than approximately 2 seconds/ ?
>
> >  can prevent the normal mouse report from
> > emitting a usable button event at all.
> >
> > HID++ REPROG_CONTROLS_V4 diversion for control IDs 0x0053 and 0x0056
> > provides real press and release timing for those same controls.
> > Logitech
> > documents the Signature M650 side buttons as Back/Forward buttons, so
> > report the diverted controls as BTN_BACK and BTN_FORWARD.
> >
> > The HID++ 0x1b04 documentation lists those control IDs as Back and
> > Forward. The driver still verifies that the controls are present in
> > the
> > device control table and advertised as divertable before changing
> > their
> > reporting mode.
> >
> > Link:
> > https://support.logi.com/hc/en-nz/articles/4414473810583-Getting-Starte=
d-Signature-M650
> > Signed-off-by: Elliot Douglas <edouglas7358@gmail.com>
>
> Tested with my M650 mouse connected through Bluetooth.
>
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
>
> > ---
> >  drivers/hid/hid-logitech-hidpp.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> > logitech-hidpp.c
> > index f9189e14fb78..e71dd2457e80 100644
> > --- a/drivers/hid/hid-logitech-hidpp.c
> > +++ b/drivers/hid/hid-logitech-hidpp.c
> > @@ -3624,14 +3624,30 @@ static int
> > hidpp10_extra_mouse_buttons_raw_event(struct hidpp_device *hidpp,
> >
> >  #define HIDPP_REPROG_CONTROLS_EVENT_DIVERTED 0x00
> >
> > +#define HIDPP_REPROG_CONTROL_BACK 0x0053
> > +#define HIDPP_REPROG_CONTROL_FORWARD 0x0056
> > +
> > +#define HIDPP_PRODUCT_SIGNATURE_M650 0xb02a
>
> If you want to add a product ID constant, please do it in hid-ids.h
> instead.
>
> > +
> >  struct hidpp_reprog_control_mapping {
> >   u16 control;
> >   u16 code;
> >  };
> >
> > +static const struct hidpp_reprog_control_mapping
> > m650_reprog_control_mappings[] =3D {
> > + { HIDPP_REPROG_CONTROL_BACK, BTN_BACK },
> > + { HIDPP_REPROG_CONTROL_FORWARD, BTN_FORWARD },
> > + { }
> > +};
> > +
> >  static const struct hidpp_reprog_control_mapping *
> >  hidpp20_reprog_controls_get_mappings(struct hidpp_device *hidpp)
> >  {
> > + switch (hidpp->hid_dev->product) {
> > + case HIDPP_PRODUCT_SIGNATURE_M650:
> > + return m650_reprog_control_mappings;
> > + }
> > +
> >   return NULL;
> >  }
> >
> > @@ -4911,7 +4927,9 @@ static const struct hid_device_id
> > hidpp_devices[] =3D {
> >   { /* MX Vertical mouse over Bluetooth */
> >     HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb020) },
> >   { /* Signature M650 over Bluetooth */
> > -   HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb02a) },
> > +   HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
> > +        HIDPP_PRODUCT_SIGNATURE_M650),
> > +   .driver_data =3D HIDPP_QUIRK_HIDPP_REPROG_CONTROLS_BTNS },
> >   { /* MX Master 3 mouse over Bluetooth */
> >     HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
> >   { /* MX Anywhere 3 mouse over Bluetooth */
