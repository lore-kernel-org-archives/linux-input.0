Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91E42CB14
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824233; cv=none; b=F36RNV/2QngX6tnKaglqF8Hgjm9+Vw8clLkX/rVg6R75o2ly+ciWKrhkMKfQgkv+ISFX3KQAds2BBzzKdDoWBKpqtgo195RDJZHMoI20IA7ZUwNhpkS0PYJzRPEPWZU/ZTFAKLpp/vrBenrnkWoq017INCwk3EBc0e/T57HGLpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824233; c=relaxed/simple;
	bh=4tBaPgo2GIWAifI6EmP16VvhsBhMsaJ899ZFngZrVCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=baNSop0zL48Wjxcv3+iHNStMBtKxbcXMjmgCwc6cDdvVMP7Ebh2Fs1ey6eVnQRCGH0h7j3AfDk3I826ak0frulb6AzjzBE++4PU1UvMjN2B9FXoxVs8vZI7HwNnf438PkjDtsOyNblQI11Y48jfF5yzW818xL9V2ByT/PmypvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YKizcs0h; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YKizcs0h"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-46556b9e02cso866980fac.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787824225; x=1788429025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vM0/L21f9tot3vpFXvyjlc2gt/uZgvIf/L0mZwOnhSg=;
        b=YKizcs0hvtYtT4lgzzICdzH/nrCbgt6wgbPDpl3ky631QxkWSfRFoM5fLXMu1wCb8W
         dzBH7xHJeh4ymttkuHkWgQ4Alq/3nLzPztAiPgaDOFTipM2mBnNxiFlYaLG1f6AtvTZr
         /Z2zb8eMcrICXMXsg/9A4ihervTTR61iEdYO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787824225; x=1788429025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vM0/L21f9tot3vpFXvyjlc2gt/uZgvIf/L0mZwOnhSg=;
        b=pnX9w3utZulKPnyOZ+1kcdvYT0emfWKXt/S17T0IHFWr6GILbMurfp4QlmPTrCfAcB
         bn1O+DKBQRl7hXXo2wh8HvmqGTMxkUyODNlxhKOrCozoz+TYVNG/4wOYMCEO0qgM4y+u
         3lQGsQZHrEgsVcxcxJo0UVAI7I2tKuDDbNtYkPGoXztjdx4XaV61TUTEXojAeEWiCaH9
         11QkT3nF3tJLrzxtrMzWdkh/EY/csfkqsUsfWQb8JXm0X8I5Jgpy4ptPqF6AuKl9QGEx
         Iw54MUv06cOt4ykDV5D2NE0Z3LCn/J7vLx3+E8KgEbXgU4/Ve0VbX/bUS3R4x7fDKbD5
         A7yg==
X-Forwarded-Encrypted: i=1; AHgh+Roih+4tdC1WYIfbUREclg7aDJaucnS/BX/ZA5612aGsOiIZtB+FwZ9Wlhink4ioTshjtl/MQ68tzCKwJw==@vger.kernel.org
X-Gm-Message-State: AFuF++mR97hGm+AJkqjfPf8j/YaZTNjb6zHnH3GhetFgXZ4h4EtTLiC0
	jESBa9O5okWkkpwBWQs9fA+rnf8cj1S2ih5bEiawZGuBxIcnh7hLev3lCfCKMD3HPe/VN0QZIOu
	Wgwu5Aw==
X-Gm-Gg: AR+sD125/R7fQaset9Gjtm1J1vodlfs38S3NQJ1X4jsQ0OE6Ug9Lm7iZ6CH/FmAP2uW
	3OdjTb6wnPrs3X8rpDuvJreXxKPFb/y69OZcPzMLhfiefKlhjck6Cfm5vjrt/0KbE4GXeGLxdUT
	dsRrQaJQ0umnG7qi5mKAzRGqvdJbH9ZjfjWidks8c0xuYYgtlBTV6kHPVBU6pZeDls3ArikpENn
	veVdR8s3ItHK1FDWBm1yz+qnVhaTd3ta1YNcYZuuVCfFCmE236fLbC6O8mSvG2GdZlTJw4zpq31
	8G0hc8E8FmB488BpLeWXfam29z6iamc4EU11W2xMdmdlG+zaBAhcLzTrM2MvWbIpbsi4atMoqmU
	ARU8hXSzlHGoDxI/RDfBArKyCxI+YSVQtBca7ZnIc79erXVVtCr6kAHcFRdxK6o5JbygGYtb4nY
	RULEZzq6djr/N/O9/DmxQBpIEY5vi05AlOUZHwxicl3gRiujwXTXD8fqVu6hgpsBx+8qz14ccgp
	ayT1EUgrDR5D6L6wkm5sFVDSZq8/gaOfEOJZKY8
X-Received: by 2002:a05:6871:4e4b:b0:43b:516f:5f0e with SMTP id 586e51a60fabf-466e8978afdmr4578080fac.9.1787824225366;
        Thu, 27 Aug 2026 02:50:25 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46736445d6csm1529949fac.2.2026.08.27.02.50.24
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 02:50:24 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4b383347fa6so423876b6e.0
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 02:50:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpe3gIg2BVvMgwuTjVXYNA/cLAwIIXwbbQTytNrJX//i3uLaV/yALFoLex/mqDXmYFURSeCDbhjpIoUJg==@vger.kernel.org
X-Received: by 2002:a17:90b:5281:b0:396:4ce0:6400 with SMTP id
 98e67ed59e1d1-3969ba3a303mr7718113a91.2.1787823916368; Thu, 27 Aug 2026
 02:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-hid-ff-input-configured-v1-2-1dc9bbacd88c@gmail.com>
 <20260818120428.2546810-1-ribalda@chromium.org> <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
In-Reply-To: <2a757d6-c09d-c16c-43df-fe8fab3c1b2b@inria.fr>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 27 Aug 2026 11:45:00 +0200
X-Gmail-Original-Message-ID: <CANiDSCubAtxPLft=YF4Cq2aAO9c7ZEe_gYmvSQ5yT8UxGzzSEA@mail.gmail.com>
X-Gm-Features: AcwNN1Wg35VaoCPidKcyTWNXMAGNl7vbS8U51ZtBOmn-f-e6hSKjRXwP7gyXSqM
Message-ID: <CANiDSCubAtxPLft=YF4Cq2aAO9c7ZEe_gYmvSQ5yT8UxGzzSEA@mail.gmail.com>
Subject: Re: HID: add documentation and Coccinelle script for FF registration race
To: Julia Lawall <julia.lawall@inria.fr>
Cc: dmitry.torokhov@gmail.com, bentiss@kernel.org, cocci@inria.fr, 
	corbet@lwn.net, hadess@hadess.net, jikos@kernel.org, lains@riseup.net, 
	linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nicolas.palix@imag.fr, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[In plaintext this time, sorry for the previous HTML email[

Hi,

Just a heads-up that this this patch has landed in Linus tree, not
only in -next:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/s=
cripts/coccinelle/hid/ff_race.cocci?id=3D225c30812857f47cb42bfd945a15f448f5=
8e82cc

We should fix it before -rc1 is tagged

Regards!

On Tue, 18 Aug 2026 at 14:08, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Tue, 18 Aug 2026, Ricardo Ribalda wrote:
>
> > Hi Dimitry
> >
> > Looks like media-ci is not particularly happy about this patch:
> >
> > https://gitlab.freedesktop.org/linux-media/users/ribalda/-/jobs/1081279=
01
> >
> > /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file /bui=
lds/linux-media/users/ribalda/scripts/coccinelle/hid/ff_race.cocci --patch =
/builds/linux-media/users/ribalda --dir . -I /builds/linux-media/users/riba=
lda/arch/x86/include -I /builds/linux-media/users/ribalda/arch/x86/include/=
generated -I /builds/linux-media/users/ribalda/include -I /builds/linux-med=
ia/users/ribalda/include -I /builds/linux-media/users/ribalda/arch/x86/incl=
ude/uapi -I /builds/linux-media/users/ribalda/arch/x86/include/generated/ua=
pi -I /builds/linux-media/users/ribalda/include/uapi -I /builds/linux-media=
/users/ribalda/include/generated/uapi --include /builds/linux-media/users/r=
ibalda/include/linux/compiler-version.h --include /builds/linux-media/users=
/ribalda/include/linux/kconfig.h --jobs 16 --chunksize 1
> > Position variable r.p2 on line 20 must be attached to some other token =
using @.
> > coccicheck failed
> >
> >
> > The following change fixes the issue for me... but you probably want to=
 double
> > check it, I am not proficient at cocci.
>
> I would also like to improve this, as suggested in a previous mail.
> Could it be detached from the documentation change?  Then I can take this
> part and fix it up.
>
> julia
>
> >
> > diff --git a/scripts/coccinelle/hid/ff_race.cocci b/scripts/coccinelle/=
hid/ff_race.cocci
> > index 479f5d1e3184..7cf84936db13 100644
> > --- a/scripts/coccinelle/hid/ff_race.cocci
> > +++ b/scripts/coccinelle/hid/ff_race.cocci
> > @@ -9,7 +9,8 @@ virtual report
> >
> >  @r@
> >  identifier probe_fn;
> > -expression hdev, flags;
> > +identifier hdev;
> > +expression flags;
> >  position p1, p2;
> >  @@
> >
> > @@ -17,7 +18,7 @@ probe_fn(struct hid_device *hdev, ...) {
> >    <...
> >    hid_hw_start@p1(hdev, flags)
> >    ...
> > -  \(input_ff_create\|input_ff_create_memless\)@p2(...)
> > +  \(input_ff_create@p2\|input_ff_create_memless@p2\)(...)
> >    ...>
> >  }
> >
> >
> > Regards!
> >



--=20
Ricardo Ribalda
