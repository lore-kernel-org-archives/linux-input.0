Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8E37204D
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 19:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563627; cv=pass; b=duTNg+AFgjvn18kGtoHG7rbZXsDasB6lGZmd0EUzOYfS/PZT2zGIivPt9iasM5jn+wX8UA7dB+prar96gYsYfEvMZUef/FMErhU4HVSQZL/7x55IVwxZN0qGH4b2X/KjyKxGWYmr5AILKhym+Ly5MbCO9vPszIrcvv3mM2RsfxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563627; c=relaxed/simple;
	bh=CfrGgZ6VxGLxovtt2BIZKz9epgFlxKOxCqQQ0DcRNOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AOXzm6cFjxKu584TPxT8AMKgv/PMLJars8B7LVpwu19vgDFvlnrfYqPtT044uiVuVcAyzboVTHjrXKviZDUi4fCy7Vyzqd8DtgSU7ca+SHvGYtLGU+scKHjVc3spK1wzrhswCZ0R83d/mcFEzD0uDpkH6pYRLHfoCxkN0ieFb6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvwXnD5K; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvwXnD5K"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6688dfaed31so1907916d50.3
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 12:40:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786563624; cv=none;
        d=google.com; s=arc-20260327;
        b=iT/WsRfYH/xz5E79jgYUja2f0lup3QkAx/FmAONg310ETDPDkpWL07Ls3fAYKvAxCs
         3KWRAiiv9zsfF5OuW+dYlOlvFDXYOo6Qaa9TM/H0v/7MNqCFUjMbGMKSwSrxIolf0twH
         OLcz+sMuxfuU8JSUFbTpFzhqmz0olb7VrRsVp8Kd4o/OefqoOUksMR2uq/PvhMK81TGx
         qNm2I1JjkMbDwGFlUusKdMKrfCsTBDBFeewJlzHfbEubgWbqlZMj/vdqczo0a1XXJTbo
         xz+RiRrlnRrWXc2spahgVpr1Pb1RCLTSOclmMsAF8jc7iz4n/HHin1fQPWAvLJNHpIMK
         a2Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Af7eIo184rlHdYdH/CT8QKsmlreVY7D6aE4TgrRXRhU=;
        fh=l1AP/n4HAQ/9vHRqEexf6IiAxAqjltEguhhet2HCYvI=;
        b=BjFH485kKe2+ruCzIVg1axRphC8mmP1ARDYSY5yJT+BSYSfMQZ2DDx20Xfbsz52RXd
         vUg+Z7QvdOUAw8syssslrwwTsgf/A7n9wkfULJEAiAucbniAkM3eEfSlVh2TK25cKLuX
         8SYN5rJqIp5cmGDGmm1LPP+o3YX4QKpLJLItS0j7atnfcgvlmpF2ORJ4FlEloS9V/bEv
         1sZGDMstmricxVn80rLZyfAW4ZevLTtuSVwGrsdJ7rOAT+xGiiWRsewYLMQiihs59SUN
         +L+K9QhV61osNkNUyrp4QOXUuoZBqoM4aR4OMgUOkhAuYymFbqFOhNNAUniEF7wDz7DN
         K/OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563624; x=1787168424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Af7eIo184rlHdYdH/CT8QKsmlreVY7D6aE4TgrRXRhU=;
        b=hvwXnD5Ksx+IfC4Ckv3vKx5nD9uKrh94AxJK8tGI5tOiCMFXTNdHPv+/0Lhr8eJ3+2
         vSDZOSgq6iJABZOoFucwFBk/c4e04zuVgsd9Um0BJnzH4ABZl9cn5FJO0rPGd0JxoXdl
         6/IW8+4pejSsddju6RAa+dqetXFf6EPMbsl2oDXTgLFqofL9CTJg0O29h2efhi5YJxVz
         GIPBNAy2Ftc9jm/gBxN+IU0Fw92pF2u5Ilq51iyI8bydLO6fcR1T2bznk8ZfDOVGlZZM
         Q2RF5Yq4c8xAZkYiQoTHNVz1NF73DkLAAB9Ydg1+eDl6GltFyeGXLRz85JwbEfAj5RX+
         0SUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563624; x=1787168424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Af7eIo184rlHdYdH/CT8QKsmlreVY7D6aE4TgrRXRhU=;
        b=K387v+MnJmTGA1n7OBoWh7LMhR3hGhHmCNyNXao92UIDN5Gu1+iMVQnOvi2culcDOR
         T40pkcdeqmO/OY1Ria09dIaAdq3/bJFIMiOXIUt8YpslU29HxE9bF3PjlWDgjYRBVowz
         LIHjFb+Vo/XN/AA0fKdk6SvGZx7jk8vBiEbtu3cXQZuSwTxyhQPctT7jpfVFKy+PY6DE
         P9BtrhI2sgnFLqoIcLvAePrDIl9WXop5VS3tC0+jKwxn5EeGMkckeQZR5BaniUDbX0Ea
         Y6WzOlnpRfqg0I8wXOvTwMPz8/SKh2nIT8C11it9MpAdjbBkNpJq/9HQNqUTY/gQ95NK
         tLAA==
X-Gm-Message-State: AOJu0YyxZQET4kwWW14GvPhJ7HfM5WOCIdA4t3AfgSin/L7R2qglYY3R
	JQwUjT0tS6na/1+ejbwnDpV5OCqg/U/4gxl06MO0kQsCZYipVtFqtXYnEwpbVy4rQ/mdeBCovzp
	0bETzKq0DFbohcz6W9BLYmb6xj6BTYYA=
X-Gm-Gg: AR+sD11DXIHXNGI0hFz01oA/qTbfh5woALBRKect0wJf/8lUdbFtuPcLwaAUAiMOWox
	YM9WYBw7Worvo85M4R/lmBf/41y+uuse1A6cYCLKhyrgLaTXe8aCtb0gAWnylOyMerFNIZJNy4D
	QtunJ0WM1sBQ+rg9vyLzR39qU0QGKlTg5aSPvbRqEKJ1o4VyZOIyE8bq1Mjnf4ddYokZMKuFwhy
	AhTIBOUfla5fTa4cROjxrEfdvAHDXkl+Yv6r2fWuz86h1vv+GShX8ABCNHn+KMDRyc1ICgpiOTl
	wgh+Tz6FQLkdXme6f9YbiET1CD0gVT6w74fClyRvhkA=
X-Received: by 2002:a53:acc4:0:10b0:664:caf6:c041 with SMTP id
 956f58d0204a3-66c514bff98mr304942d50.19.1786563624052; Wed, 12 Aug 2026
 12:40:24 -0700 (PDT)
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
Date: Wed, 12 Aug 2026 12:40:01 -0700
X-Gm-Features: AUfX_mwxFjSvwzJebJ_3ICPYRuB07k4QSeSOyyvcsDdsK-BPMr52G2tpBH9VJME
Message-ID: <CAGt6S1rUrE7tt7-HiY8Tm36WTSWswQtkwWPwCVk_YLYhoUaK2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: logitech-hidpp: enable reprogrammable buttons
 on Signature M650
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, lains@riseup.net, jikos@kernel.org, 
	bentiss@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

It was about 2 seconds, I measured it.

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

I'll address this in the next patch revision.

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
