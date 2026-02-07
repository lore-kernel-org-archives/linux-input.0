Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C1823DD
	for <linux-input@vger.kernel.org>; Sat,  7 Feb 2026 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770465628; cv=none; b=uckW3lgMBwBP0soKScwg1dcN8bbGM/Uy6idgiBBzWc1ath9aJfFPXHj/M0u+d2Elx89QEgqvIjQyAjMyhWGkwt569BOjIeMhPdux9Hnv+gG2X9z8FFKdWxjOaglSnilAK3ggcgG22SfiOXmK2ip9GXkirZZtnUaApUNk76bNdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770465628; c=relaxed/simple;
	bh=OVIVpNzUp2OBZ6+ABT8cT0Px5TSJdPYO0EiTIGUDwIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lenB4v305ksqpYfUuvq5lZhYNreSvMLHBpRTOMXvZ2PhnLCGd7ztcOxGncA+89bO1kW0yon5FiUdmq7FAwKG/stH5T4+qQqZa2LMcarwFAYlp4go9eT5vjhn6opN3LdQlZPoxrGPr3kdO/sfvU/jqoN1rNBw9Ewxka6+jojMJGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=eV/cVO5m; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="eV/cVO5m"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id A4050BD19C
	for <linux-input@vger.kernel.org>; Sat,  7 Feb 2026 14:00:18 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id DC5B0BD40F
	for <linux-input@vger.kernel.org>; Sat,  7 Feb 2026 14:00:17 +0200 (EET)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 636DF1FEC6C
	for <linux-input@vger.kernel.org>; Sat,  7 Feb 2026 14:00:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1770465617;
	bh=o98dUsx/gJO9sLWs/evZortySYc1uIL1B0bewJFZTEs=;
	h=Received:From:Subject:To;
	b=eV/cVO5mavLTNFJwp5VM8b854e8p5GgTHUsfKONztiDfzY0o6qnBaYDeGzLdQo2rx
	 iehYGgIVBK9SAXjkZCJqEIYGLJ4++UKubFUpiuun15EthZkGO8Nf9u3PUx7cV0LvQF
	 qzMUFIVsIWb39q6I9ZwTYdhr/Tv43Y8pg4y4HPIHMXMW53AlpPHuXvxE+Et6KMH3/c
	 1ZZqCjMOMiwpUTyeBWd3O+rnqmgIbbp7nLD8+glbeEzMbiv+bcVDDaf2z/OkyZsPqY
	 UAZ4GxV+H9WG8RkZpj3Eey6gjCuwrezD/vZepJK8tQVK91j/jCeaaCsS+QtZbHjYZn
	 ratvx1QcehbKQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-385d9fb297dso28344401fa.2
        for <linux-input@vger.kernel.org>;
 Sat, 07 Feb 2026 04:00:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCW/gfrTqgHWAjz7lkYCw0yNFWmdWRCbRNgCkg0dmerZvGFWv1PR0tmdPKz33K2rOBTQlVI1yb+PNoIJfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhT2kBwvHTI7iQ9+ho13Jq3uZLajVNCUymLz3fKc8pONHcLYGg
	M7dpHKTwweH2tTbhBrBXSQaZQP5kWNsBCJ79x/9E6qqc+C6DKGvU3Q8ko6w35jCwxULZ+YBqQpd
	3vYbxBZVEmEJVwh0AMkCSuLf1bTx79qQ=
X-Received: by 2002:a2e:bd85:0:b0:338:10c9:5871 with SMTP id
 38308e7fff4ca-386b513b192mr20799671fa.34.1770465616752; Sat, 07 Feb 2026
 04:00:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <TY4PR01MB1443218CD6B7089D3DBF893989899A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
 <TY4PR01MB144320C2F5B24AEA833ECFB2E9867A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY4PR01MB144320C2F5B24AEA833ECFB2E9867A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 7 Feb 2026 13:00:05 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFXmye4kJzjFbZzUmgmhHn0YyX2eEwidkUJBs7ZhpXhNw@mail.gmail.com>
X-Gm-Features: AZwV_QhQc5G930lJFDpF8RoH_PK43WR2QgvrymW4O9R0IzBW3L9s7e3sj5rzU94
Message-ID: 
 <CAGwozwFXmye4kJzjFbZzUmgmhHn0YyX2eEwidkUJBs7ZhpXhNw@mail.gmail.com>
Subject: Re: [PATCH v1] input: xpad: Add support for BETOP BTP-KP50B/C
 controller's wireless mode
To: Shengyu Qu <wiagn233@outlook.com>
Cc: dmitry.torokhov@gmail.com, vi@endrift.com, niltonperimneto@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <177046561761.770052.4877182961493853330@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sat, 7 Feb 2026 at 05:57, Shengyu Qu <wiagn233@outlook.com> wrote:
>
> Update on commit info: seems these controllers support Xbox mode when
> using wired mode, however, their firmware has some weird enumeration
> logic that won't work with current xpad driver(It would enum as xbox
> first if no driver is loaded, then disconnect and re-enum as NS
> controller, finally something else), and by default wired mode would end
> with nintendo driver.

Hi,
if I recall, this logic abuses some HID descriptor logic to cycle the
mode depending on the OS. The arch wiki has a potential fix for
certain controllers.

This makes you end up in Android mode since linux kernel. Nintendo
uses a BSD-based kernel, and the Windows NT kernel is different. So by
breaking the protocol in different ways they get it to cycle.

Antheas

> =E5=9C=A8 2026/2/5 22:15, Shengyu Qu =E5=86=99=E9=81=93:
> > BETOP's BTP-KP50B and BTP-KP50C controller's wireless dongles are both
> > working as standard Xbox 360 controllers. Add USB device IDs for them t=
o
> > xpad driver.
> >
> > Both controllers can't work as Xbox controllers when using wired mode a=
nd
> > have different USB IDs.
> >
> > Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> > ---
> >   drivers/input/joystick/xpad.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
> > index 363d50949386..260dd41ea6e5 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
> > @@ -360,6 +360,8 @@ static const struct xpad_device {
> >       { 0x1bad, 0xfd00, "Razer Onza TE", 0, XTYPE_XBOX360 },
> >       { 0x1bad, 0xfd01, "Razer Onza", 0, XTYPE_XBOX360 },
> >       { 0x1ee9, 0x1590, "ZOTAC Gaming Zone", 0, XTYPE_XBOX360 },
> > +     { 0x20bc, 0x5134, "BETOP BTP-KP50B Xinput Dongle", 0, XTYPE_XBOX3=
60 },
> > +     { 0x20bc, 0x514a, "BETOP BTP-KP50C Xinput Dongle", 0, XTYPE_XBOX3=
60 },
> >       { 0x20d6, 0x2001, "BDA Xbox Series X Wired Controller", 0, XTYPE_=
XBOXONE },
> >       { 0x20d6, 0x2009, "PowerA Enhanced Wired Controller for Xbox Seri=
es X|S", 0, XTYPE_XBOXONE },
> >       { 0x20d6, 0x2064, "PowerA Wired Controller for Xbox", MAP_SHARE_B=
UTTON, XTYPE_XBOXONE },
> > @@ -562,6 +564,7 @@ static const struct usb_device_id xpad_table[] =3D =
{
> >       XPAD_XBOX360_VENDOR(0x1a86),            /* Nanjing Qinheng Microe=
lectronics (WCH) */
> >       XPAD_XBOX360_VENDOR(0x1bad),            /* Harmonix Rock Band gui=
tar and drums */
> >       XPAD_XBOX360_VENDOR(0x1ee9),            /* ZOTAC Technology Limit=
ed */
> > +     XPAD_XBOX360_VENDOR(0x20bc),            /* BETOP wireless dongles=
 */
> >       XPAD_XBOX360_VENDOR(0x20d6),            /* PowerA controllers */
> >       XPAD_XBOXONE_VENDOR(0x20d6),            /* PowerA controllers */
> >       XPAD_XBOX360_VENDOR(0x2345),            /* Machenike Controllers =
*/
>

