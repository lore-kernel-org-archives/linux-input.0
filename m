Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABFF41DDF0
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151261; cv=pass; b=kpyDOFsafVNwLhndSyK72DxLrkpjSWNISzT2gUBkU3PCvFvfGuTNtJo9HoH2i9lmhOGthIjy/VhZVZJ80/XOGN58gV5YB63wvgfc1Njf7lTfLGpGWBxWsz5kpVE7ltg19+T4ByNC6gyLkKIbLY8cgUQElvijOhMMvPOF8vNtgaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151261; c=relaxed/simple;
	bh=kkpIgfZ/ZiXjtoXZEZ3MFCi5t0lRiYOOOeVgCHb5/2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mip2p3Xxy34aVQnZFnZ5Yasz3mTTilJEKxK+nm5pXlgucdiCwiz/HmDGVbUwemLn72pDMD6I4Pr/UyJ01VSPeCl7+3PWrmO2RVnB/+4BwJiOx8cSjVZ6EmK9zW8G48HZ2CpPrNYA5DXu1bgyBL/t2NAyNXbGxiqjzqP6WiPk4Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRF22YQU; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRF22YQU"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so2571399e87.2
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 04:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792151258; cv=none;
        d=google.com; s=arc-20260327;
        b=c5J1wzJ/thysRx2gbpqnmcHUD5jQz8Tn58ZhlPJT1oCVFP3T/w6SEaxg8xxQrj/xiW
         3KaqgamT0ozARMokrKmRGPAqXBMU/G7RrFsP/+90gFij5hJvc5xpJEH2mL30Sy7NNi38
         sYcyVNW1igvRPlKa6cydLnScAe3s2+qmtZkZRW07OkxPTPMSWsHe0XsYG/EwuHJUIQ5I
         +YKNaZc+QJYviG7txcXP1gSG+TSyKi+5Rv+lO8qVHpNwFH8UDA1lIaTT+6WHClBtuXWs
         xT3KS8U0PjxVDU7m6Cf0BthzewzhkdHFdheh1xmaDVt2dFFM93b6BuGSV2vnkrOE/Ere
         7YiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0PS3hd2XF0BTImBuwJTgiAEri7mP6JZ48pK3wkCH8+U=;
        fh=/UStAM+eYd95kwkZ8HtqXLA7K2Zj73fTrNixXnA19jA=;
        b=TQeODdob/MtkqmL1ddm7EYn0u/NjcpMIDRFVn6PlEivxhiExEWB3NX260Af+ZGZ67u
         PQycMjEa1XSHHxHFE6w/JNBBD4uuNEmUU/X81uFwGzKKxUzuxknQECPq0BE++Tpxx6f9
         NwmLj1kWbc3u+dn+VvgoYDf6CFeP2oXma5XSC9H9rgOYaXhWqsHw1dRfyiXUUYULOysn
         Hxj+GEM2tUu2BGh/7zE5URZglViAj1PC1gbzlfbW4nL3PS1CJCVjXucvHHDJL4BNYalI
         4pHZya/DVuKL/zy30mFoFzZtlm8mFCkPfAnQRBq1Lm6VkALrcupKE0W3g/p2KmBtlrkn
         5tMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792151258; x=1792756058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0PS3hd2XF0BTImBuwJTgiAEri7mP6JZ48pK3wkCH8+U=;
        b=KRF22YQUvTwWOEt4Axnq/vviCtdNr7SBBU1f3ThiRrThiThz9kGyqxqeXYd2F1IEbC
         OwwUKtB/y7t3C0dyWSWUqPl2GCdeLChxdSxAx58vx0JFJntDF/sYC8n3/6F1LGP0PfQ+
         FWwrf5asdQ4yfJrJJFnN9YsQhC1JHjSHtF3/D1IxqjVW5yyq9wKzB/CkeXGbgsiEBov5
         dPp6YFyYjXz2So08p+U8scc8MomKOHpM5aZmEkaec299es8j6cF9gs48qm4MrMw+4UF6
         5qGb2UgUdAeXlQpMwupR64XsMmEw1XhutaqOzhV6c2gM9NlM5Qa7gFfZidcrQ9LzWNij
         5d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792151258; x=1792756058;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0PS3hd2XF0BTImBuwJTgiAEri7mP6JZ48pK3wkCH8+U=;
        b=dZZEgQIHEXkNUxJelNbFoUPHIpMye6qy/gWTIxbqgMJ0V/vRixq5zltHhUXTFE6tyK
         1cHZ0hD1k75DVSLNxF/fjSCDPfBRjnF/2siQKfeNVmEWfR2Y73wRfwBfC//EOk9Gxubh
         txgzvBHkx7TkDl3ymy4HiBUE1ecU1/D4GvZym86b/lsylC4U46wpI0YnCsbiZMKUmskJ
         zOL1v7Odk5HCMSXlGsztJBrC5hafbSqgSuYf82ZfNDuS3v4ZCwnneldk4vwWBgJ0/+I5
         Mbdn4Sl+iY1OJpBzscGs+2NqaVDFFJzJUDeHdkE13ghCtehB7Nj+1a71LX15Olu5X+69
         8zXg==
X-Forwarded-Encrypted: i=1; AKwUvBwn4ZOjD3UXg8/t34idmzvOCYbLHqVLoworuPRxGnwdzq9Jq0tTy3BfVoCabOhljrIUS2j9A5JrWlqBfA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKomJkFu/VMUjWks3zQa80+qeltVvz/EZwO2ZmHHbKaPV9SFsiX
	ZNqeLZlmJVnZRyG+NFK0NipVRiZh/8TxbnNobliySsVNNLyrm+em6tdFKN2PMmC6L11EmnR6VgD
	M04NjLg2JFCJzpdfvzpEHwW34cmaBtqmwqSb9
X-Gm-Gg: AYBFou3N6QIwWTkxqe0KNADw6HSeUgI40g9Rbq8+oCwPE/MV9UsSgQd4qBxMmkGPZ4A
	8Noa3ANzrulMedTvvaTDGWao09QY9j8JZ5icTdfL4SGHe4Oc45vVf+rUkyyeHz/U4PDMG1byyaV
	XwfzUV3ptSENz72KyvmVJ5vT9xfienCfj6P8gKgyhavfTBMzGQ21TeQ7oFxoQQyxqGdyYUFR3rQ
	+Cz77CJAg+3Ke6oh1OEN7C8MBc1SBjcllOFXh8ttmnYilW3YXxBPuRX9QAN3A+rE9ppx1ODbWTO
	OJQTiAysVAMEz6P+LPLr8XXY6WzPTXKpYfW+yRoXSRn9Mus+Ppt9zIrb9H/xBEKnXYNxk8Kt1jj
	HjEQNj4YfByzNpA==
X-Received: by 2002:a05:6512:1289:b0:5b8:ef97:e372 with SMTP id
 2adb3069b0e04-5bcde8c3d93mr8633085e87.46.1792151257596; Fri, 16 Oct 2026
 04:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011124110.62621-1-meven@kde.org> <217o9262-51s4-4r93-o651-27124010q4s5@xreary.bet>
In-Reply-To: <217o9262-51s4-4r93-o651-27124010q4s5@xreary.bet>
From: =?UTF-8?B?TcOpdmVu?= <meven29@gmail.com>
Date: Fri, 16 Oct 2026 13:47:25 +0200
X-Gm-Features: AclHuK9_fWzBKPBRk0XUBV_UHnFzVFkBU6hk81OAlTpsLOf2bViXI6Or9lgsTmo
Message-ID: <CAOvFf8O_a07M_jaxdnmeasgueNt1s_AXHB67aRkenvVPzwPgZg@mail.gmail.com>
Subject: Re: [PATCH v3] HID: logitech-headset: add a battery driver for the
 PRO X 2
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Subject: Re: [PATCH v3] HID: logitech-headset: add a battery driver
for the PRO X 2

On <date of his mail>, Jiri Kosina wrote:
> One question though -- is it really practical to have this as a user
> selectable option?
> I think it'd make sense to have just selected by HID_LOGITECH_DJ the same
> way as it selects HID_LOGITECH_HIDPP. What do you think?

Agreed, a separate prompt is not useful here. The driver only matters to
people with a Logitech receiver, and those kernels have HID_LOGITECH_DJ
enabled anyway. I missed this opportunity.

In v4, HID_LOGITECH_HEADSET is a hidden option, and HID_LOGITECH_DJ
selects it next to HID_LOGITECH_HIDPP. HID_LOGITECH_DJ already depends
on USB_HID, so the select leaves no dependency unmet. I will send it
shortly.

Thanks,
M=C3=A9ven

Le ven. 16 oct. 2026 =C3=A0 11:04, Jiri Kosina <jikos@kernel.org> a =C3=A9c=
rit :
>
> On Sun, 11 Oct 2026, M=C3=A9ven Car wrote:
>
> > The PRO X 2 LIGHTSPEED receiver does not speak HID++, so
> > hid-logitech-hidpp cannot read its battery. Its report descriptor has a
> > consumer collection for the media keys and two vendor collections, and
> > no report 0x10 or 0x11.
> >
> > The battery answers on usage page 0xffa0. A single 64 byte frame on
> > report 0x51 asks for it, with no handshake, and the reply gives the
> > level and whether the headset is charging. The driver asks every 120
> > seconds. It also reads the power frames that the headset sends on its
> > own. A switch-off frame marks the headset absent at once, and a
> > switch-on frame moves the next request to one second later, so the leve=
l
> > appears without waiting for the poll.
> >
> > hid-generic sets HID_QUIRK_INPUT_PER_APP, so this receiver had one inpu=
t
> > device per application collection, among them the Consumer Control node
> > for the media keys. A driver does not inherit that quirk, so probe sets
> > it and the input devices stay as they were.
> >
> > The power supply is registered with POWER_SUPPLY_SCOPE_DEVICE. The
> > headset is present from a reply until the next switch-off frame, and
> > capacity returns -ENODATA while it is absent, so a headset that is off
> > when the driver binds reports no level.
> >
> > The G522 LIGHTSPEED uses the same vendor protocol with a different fram=
e
> > layout. That device is left out until someone can test it.
> >
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: M=C3=A9ven Car <meven@kde.org>
> > ---
> > Changes in v3:
> > - Request the battery level one second after a power-on frame, so the
> >   level appears without waiting for the 120 second poll.
> > - Report the headset as absent until the first battery reply, and retur=
n
> >   -ENODATA for capacity while it is absent.
> > - Queue the poll on system_dfl_wq instead of the system_wq.
> >
> >  drivers/hid/Kconfig                |  11 +
> >  drivers/hid/Makefile               |   1 +
> >  drivers/hid/hid-ids.h              |   1 +
> >  drivers/hid/hid-logitech-headset.c | 319 +++++++++++++++++++++++++++++
> >  4 files changed, 332 insertions(+)
> >  create mode 100644 drivers/hid/hid-logitech-headset.c
> >
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index 48934c4f3..5c845b1b8 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -670,6 +670,17 @@ config HID_LOGITECH_DJ
> >       generic USB_HID driver and all incoming events will be multiplexe=
d
> >       into a single mouse and a single keyboard device.
> >
> > +config HID_LOGITECH_HEADSET
> > +     tristate "Logitech wireless headset battery"
> > +     depends on USB_HID
> > +     select POWER_SUPPLY
> > +     help
> > +     Support for the battery of Logitech wireless gaming headsets that
> > +     report it over a vendor collection instead of HID++.
>
> Thanks a lot for the patch.
>
> One question though -- is it really practical to have this as a user
> selectable option?
> I think it'd make sense to have just selected by HID_LOGITECH_DJ the same
> way as it selects HID_LOGITECH_HIDPP. What do you think?
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>


--=20
M=C3=A9ven
