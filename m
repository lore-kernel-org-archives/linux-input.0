Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96719606E999
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 13:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96719606E999
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wDYL6vVI
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9495c633eb5so66566985a.1
        for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 05:10:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794661799; cv=none;
        d=google.com; s=arc-20260327;
        b=a0GNmHEpPjCoazIQRLw9ugp/5n7d6NXojwPA1N6spDshUuSgSr3Iw5Hc1xQ/zOvG7L
         XlBuTUvn6e7enrA8NbJjYEQMaECalto1DU5FpPFysx+UaulqbJcAiZSnFfZkFgIQn2ZF
         ehmEs9d8gnQfT58Mcf6XLLaHhHkL45qBzGPKzv++b1xyyHBhxNqoHo5sfYaU8tdyWN1n
         ZL7RGQNG+t1z+yPIrwZxVi91Ot5eLLLFJdBlyxOB1WM8KDyAqMjQ8Zo318Av8/xnrCDr
         ERraJHNycqw9+PjVYOOuvr418rhCvM9FMBIqYX9Ykyv1hoLMk/2YLDdtfbvQMFIaBv2t
         +qng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U6aPzjQz0I4393BXaraTm1sEujHHhSD7mUhZkqvD2RU=;
        fh=e9+5G42TwF3e38Sjrn/34fXZVKfo0qC/PVAyn0juB3E=;
        b=aSlzASfVzeTTv0NYUW0rJPU1P97XUP8O6xyHrxzksCsDAAej+BJEzLNVSY0eIGaOtZ
         xfRIOIUWQs6yIag7sdmdrrbaf7nyQzgdQzwh/rT4LEnEsYHnNQDbmHKqNg1yICwcqOVN
         U1VdW8JDDFMY1zNRe8jtJ+Xj+mvImdGD2d1bfwd0tOnXCGrCfAW6Zkg/4a3hffXe34c9
         6UhCnZ7cQc1oPOVjQIeeuuLEXapL154sv08mrVZC78rfYWIUZ2ElIcn7HA65UTMVJ2lT
         SKQJ92vDQ/HkazsiztqSfPeNGPOigWqUm+h1ZC9DPh6TK7Nk6h7NsPd1fimLMGOzfvnE
         7+Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794661799; x=1795266599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U6aPzjQz0I4393BXaraTm1sEujHHhSD7mUhZkqvD2RU=;
        b=wDYL6vVIFs4pMekKC052MINLwdLO3oWY2dpAxArHG/FCj6bRb+zzLvCIbkIpDM5ElW
         eqLlkMmWFaYJmDIzxeuwOE4FWThCrd5SkwJWQ0yXj1CLxCxtLDXeCJvORw6sQbQ/AT7P
         cNi10/9IvWwErcLb3esPceQI5LJe9Dh04leHnJPIspl1AABivSaRgCPInsT/Q6D4tAWd
         P3KtwiZQJLaZXnK0chNj2/By1RkDIHyuc7j5Cd3QZmfiSsdOajUdhBarB3UhNR8fAU5U
         b5aIrQwQ6tW1GAKbEjRzPl6txU/n1jDf/nfraJ6mePp+sQ8xa0fT9hhyrpvkjehknvPU
         JMvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794661799; x=1795266599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U6aPzjQz0I4393BXaraTm1sEujHHhSD7mUhZkqvD2RU=;
        b=pTT6ZXFUIk736s9QNZF1bF3MPYnccwgq4vJ38+97igkDAngmor60B3gCTlE1B4zmrd
         JwOgPNws0XDdibZQLB5gUChugGq6je60okYpnqNduW2W33eJtrhzdj+IlqXl6OjAnR0i
         kaTvzNZWCXUS8uaoQw28ZwTKpLfo5OVmmke9IHOaI8KttZYP3A3S1GrapU0GdhSKk4A7
         tjcrff3Qj5vwz6lFAaNZL5XH9HCbJIAORyiQxVVUT8y07Fh5SMEeCCzQW3+JHXbtXVTO
         R2mwqMm6myNqcRlkRVZgMn7lnOFFw4JhVs+dsWJzu/zoaII5/1q7uKq20mSyfGToWdAS
         IJaw==
X-Gm-Message-State: APuU4Z8XDC+Gwg80NdUQ2Eb/Fm/yM/+FBJSCMD4yuBC5OiHp6ItFD7hC
	+84iEvqym3FXdP72CwVtWzygHJ96PEdUiuEp7t4S6NSLoYlSipiOZl8FHu5dtuBVeFKdfNLaMva
	YXCPOolweQon4nAMFYZZ96tDQQniuOxU=
X-Gm-Gg: AYBFou0QrO9qXSpJ/6BZ+SU6uNXpyfGens+NG54Y+VjPkM1JSRrt9N9Y0+MWEYIi5np
	vYW9yK/axcKoLqDPbZKqWu3x3Jut/9EPF6SzPwQb3QFJP/n4bEIu9FvM7CZXzBJKZCE74fK3ToK
	u+xuYaV363QvTF6YKRSztn5xC5pGLNs3/0F24vJyX1fXZyRe5Ic8neIbdhUyxjy7MiYRF20x0zL
	rDSjh+y0Ze1ogeeuqyaiXnPVaKnP3GXPGa5rSaug8yUZwB173ogLwPSzxKYU6idPcp6HV5YrP6X
	CsiKJ+GnkseNa3TnD87te1CENphSSyGkydrG+/WXyJa2xGiiNwxAYj9ggPrtQ+O/jazEKHe+blu
	Yd/eKCYVQYrNTqhpWaUoCDw8rYxDSz9IJlN+UaKuIYT+tVND+ejpwn6XMOpMzEJLF9A1hg9o=
X-Received: by 2002:a05:620a:2811:b0:949:6dc5:2a77 with SMTP id
 af79cd13be357-9496dc556c2mr95033485a.50.1794661799471; Sat, 14 Nov 2026
 05:09:59 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMX8SmaXHh-dzH2n6pRhQr8q=iN=Ui7T3TC42e35LBUjvMaH1Q@mail.gmail.com>
 <36fc271e-eeae-48ec-ae9e-4fa284605112@leemhuis.info>
In-Reply-To: <36fc271e-eeae-48ec-ae9e-4fa284605112@leemhuis.info>
From: Ali Lin <alexlin901107@gmail.com>
Date: Sat, 14 Nov 2026 21:09:48 +0800
X-Gm-Features: AclHuK8A4QzU47YQEYYfrdYZoEwsqcBOII6towWo4Sz1ZfP0mPio_yW5yRpqkZk
Message-ID: <CAMX8SmbiJ1Nub+pmQkfZcbisiok7d41L4OEzcWDhHWgbdgUD=A@mail.gmail.com>
Subject: Re: [REGRESSION] HID: Corsair K70 RAPIDFIRE interface 1 times out on
 Linux 7.3.4
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-input@vger.kernel.org, regressions@lists.linux.dev, jikos@kernel.org, 
	bentiss@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for pointing me to these fixes.

I attempted to build a custom Arch Linux 7.3.4 kernel with the
upstream xHCI patches applied. The patches applied cleanly (after
accounting for a minor comment spelling difference in the Arch
source), so they look like promising candidates.

Unfortunately, my system is currently down to 8 GB of RAM due to a
failed memory module, and the build ran out of memory and froze before
completing (using the default Arch config with DWARF/BTF enabled).
Because of this, I wasn't able to boot the patched kernel to verify
the fix for the Corsair K70 RAPIDFIRE (1b1c:1b3a).

I'll hold off on local kernel builds for now to avoid further
instability, and will retest once the fixes land in a future
distribution kernel update.

Thank you for your time and assistance.

Best regards,
Weibo Lin

Thorsten Leemhuis <regressions@leemhuis.info> =E6=96=BC 2026=E5=B9=B411=E6=
=9C=8814=E6=97=A5=E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=884:01=E5=AF=AB=E9=81=
=93=EF=BC=9A
>
> On 11/14/26 07:56, Ali Lin wrote:
> >
> > I would like to report a possible Linux HID regression affecting the
> > Corsair Gaming K70 RAPIDFIRE keyboard (USB ID 1b1c:1b3a).
> >
> > On Linux 7.3.4-arch1-1, the keyboard works for normal typing, but the
> > Num Lock, Caps Lock, and Scroll Lock indicator LEDs do not function
> > correctly after boot.
> >
> > Unplugging and reconnecting the keyboard restores normal operation.
> > [...]
> > Relevant kernel messages on Linux 7.3.4:
> >
> > [   36.929377] usbhid 1-4:1.1: can't add hid device: -110
> > [   36.930405] usbhid 1-4:1.1: probe with driver usbhid failed with err=
or -110
> >
> > The USB topology on the affected kernel shows:
>
> Not my area of expertise, so take this with a grain of salt, as I might
> send you in the wrong direction. But it sounds somewhat like the problem
> this patch tries to solve:
>
> xhci: give back TDs and clean up ep0 after disconnect
> https://lore.kernel.org/all/20261029204324.658845-2-mathias.nyman@linux.i=
ntel.com/
>
> You might want to compare your error msg with earlier reports that led
> to that patch:
> https://lore.kernel.org/lkml/20261010064407.11030-1-yiyu@yiyuzhou.io/
> https://lore.kernel.org/lkml/20261010071811.20483-1-yiyu@yiyuzhou.io/
> https://lore.kernel.org/linux-usb/20261023132616.339833-1-diogochaves@me.=
com/
>
>
>
