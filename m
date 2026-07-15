Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2312B3126C0
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097443; cv=pass; b=CSQbd0BeLbzWtFU1/HTjNcPx7ynh2dAJ0i2QsoNdiHuXa5kKPt6loxmT9vrJsO71dux6RITPbh20UZlKgzKLndNDHDzp2LGfxkxi7AHXSGIoMFgAaSIokoC0rl8KEIZVdk6iXr7kYGzq8VPuzcyDbcCh5B0bVJbumtWMNuiJCw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097443; c=relaxed/simple;
	bh=A8eE6gYBEyawqXzPiLbSmLaGyQiPySXEY+8GIYReE+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WRPKBRpPK8OzNi1gzTzxIzh/2Kb9kWXp5S88sxj1LIyZ0EBlFj3823LIiyZgq1RY9YjkWcG04AAkgv9JepDXkifSipLS09TBITSMSNOL+9Y0clUHYoz4OiVbouV27teCH8H/qWciu8ZTN6EXC1oh4hH9h0ZNddhDVHvrV2B5kOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oprTH0Zb; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oprTH0Zb"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf8a2932a3so2582065e0c.1
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 23:37:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784097441; cv=none;
        d=google.com; s=arc-20260327;
        b=RrV8kkvz9lt8VS1iAPw+9hwCzOIn0lC1SYtXK4h+WIEeTmQ4s0meGRE0EppIiHEPQt
         ctHt7WCsp6uZGDyhBqyDZJ2tLarPNgSrZZdgvQdK/KMqTFGYEjY/spLOSkqgqnucp2Xz
         tJZuRF3g+t0VJpcg9gMKlYXqfKRZi1QG4z8bfzdpmNcwE4c2TiPV/X5OwjcvKM1k4RaX
         QjULi4Jc9hHuow5t/YcmT3ZqTc2vQOB/UXb7VKMoc/JZbMOChNM4LNIlVU8vwquopUoY
         hPSPcXl8mGhuBho3Av7aLIugdYUW+1r3PVvIGX6Ty/rTC14xyuwEQrlioCwD28NZ5NSV
         RkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A8eE6gYBEyawqXzPiLbSmLaGyQiPySXEY+8GIYReE+E=;
        fh=di5SO93/93Kdf1ycTXuw75HZxqhysolCaiTsbYpV7sY=;
        b=TAcgGuH8Y5ZZlV26aG/bKWryy74/m1xuV71Pp7Frrx/UAcnsov8zPkwjv/acnHQKt8
         T2eEs/fFTwmVERxVgJRz1tWstBSPdwaRUvDnICTK+7bcDQpdQS7WU3JzpxExnVHPDHRq
         ZuQyOdEWA3eBF/2uGumPMH1or5kiaA52KUm0/ckKn/Fx+cVKM1gnQWqaJSzbo9NhKFlR
         KMUBIqc+ZEdNtdkm7OHVW2u+5VKzMHc8eFZCH03phlm41xX5nPWyR7uqY1QzWOTN0FRK
         MqHwy6uqixnDENAw6raqpzBuWm0as+TF5S1/om4yLWBPXyu3TpXPNxTmr2S1YscflvuP
         d17A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097441; x=1784702241; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A8eE6gYBEyawqXzPiLbSmLaGyQiPySXEY+8GIYReE+E=;
        b=oprTH0ZbBpIFV3O+1pzsZibuSvtM0ulzvfLMAa8UmVavmBaejT66kx0iWTT39mH/Fw
         WY5DsnbiYGYdtGtSrbMwKK244d/ao4ckH//UZjbhvcjpAF64GiKWk/+04d5qzFl5nUeJ
         S/Yyl1cb7/QO7rQzqweg43ovByxTIcQw8e1nPuZ+gB1+/wYyjWs/ZLPW+bkuzrsntMZc
         yjiBxAZitk9DCJMO4cBh7lqTYRQmhFrMixQIfZA3d0vFMriB8cVLNszA/SavxlD3Q21w
         v2TBSw8QGIOiAUrPfpIHKhUJatu4fz3fjoe+L4siIrmkSzgehBrnVrEEeGRC+f5aZK28
         Hc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097441; x=1784702241;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8eE6gYBEyawqXzPiLbSmLaGyQiPySXEY+8GIYReE+E=;
        b=DR5SL9clWe80NBLYaq+k9l39W58FLhgmrGtQ2Rxa+m4VF32jWuTdu23e2krypRXVyI
         MOtINToaPRaJxzbg1x0DVtCbLezxxcFwGrpAC35oMEU3d/gGy6fFBBTHlsc2he2Z7+dF
         tMMr531jgbFgcgFiJc3f7a9MFJtFKArpAxi9NdhjpcYYULNhvvVXJBPSQFvngviOy0SW
         YlJ6PpBSMgybq7nuAnf3HG+YiwuUndmPCgMj18k65jcFA3kTxyUYk9I5w5uBe3VPzY3W
         Ui2avC/I2MldKUXuI0AKCeFDPx9t05I9i5MuXPpkRZJCcB4zFARugntO7i3+JIVdsYwK
         Hidw==
X-Forwarded-Encrypted: i=1; AHgh+RoQSDfbAntZ7XohPW6HItwp7nXMBZiknzXU9xF03VWuiDXje1kISTg4+Ux+1qhyaLjGF5zAX4D5yKcMJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzufVElzWzq5mgdr9GZXoSuw4O55vDW64N+hXHGC1k3ZJhILXmC
	l61G2dQC2ginvzX4sqNW187d8uRNXm+VFHGlFlncKpWJMdr0NMiDhBlPp+bamML2bDOIvuemDw+
	bwedyR9Dp8oA7kUbC9mf27K6f4NosPPyTCnnN
X-Gm-Gg: AfdE7cnV0FusGFHW/VAdmMbzqe9zmsu79LNf3cLSBLVis/9jl0iXRn2mzQguKHMWn+r
	zPKfXXF+78rpxkKePF8H65BNc2alhyL0PXQcZODHB7Sg0pQKiE9Ax5lzeAphGaE2btiFwptQD2Z
	kEHSENZRObCOirq39KZkxtTfmYDVsvrdtu4GBAkl7muAn4YotuhyT8B7T1MxoCCNYw5y+uBC9G0
	gouc+6tj34GIXAmNVAwE5DVF3lqtH30IOijRgAnIvrOvEgTSOBIJYKwFJFsNC8Trl92sHnb
X-Received: by 2002:a05:6102:3e0a:b0:631:2624:e5e7 with SMTP id
 ada2fe7eead31-745874d565emr3118969137.14.1784097441003; Tue, 14 Jul 2026
 23:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714120052.255085-1-chlgustn3171@gmail.com>
 <20260714121819.5FCC91F00A3A@smtp.kernel.org> <CAO2ma08Pap6PZKUV7iEpvu11zaKrzMK-cgBLBYKJEEfGH+0=1g@mail.gmail.com>
 <CAO2ma095Hu1kOTMds9yHqTvwde8Gu+GWOLUst5U2eCnSffkm=g@mail.gmail.com> <alcCgHzV730RKPmR@google.com>
In-Reply-To: <alcCgHzV730RKPmR@google.com>
From: chlgustn3171 <chlgustn3171@gmail.com>
Date: Wed, 15 Jul 2026 15:37:09 +0900
X-Gm-Features: AUfX_mwjZd2YMIMMrbzMJbJRc0izxkbpQ8dAx4mNcU239rK5k2q8oyfHjEkK-zQ
Message-ID: <CAO2ma09gV+kR5xY_MqVo5NhEEyD2vkZO7VnuE_bAQRYN1DiP7A@mail.gmail.com>
Subject: Re: [PATCH] HID: input: allocate input_dev name/phys/uniq using hid
 device devres
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, linux-input@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for the detailed explanation on devres lifecycle and device refcount=
ing.

I agree the patch is unnecessary, and that the syzbot trace is likely
a false positive or external memory corruption. I will drop this
patch.

Thanks again for the review.

Regards, Hyeonsu


On Wed, Jul 15, 2026 at 2:57=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi,
>
> On Tue, Jul 14, 2026 at 10:39:09PM +0900, chlgustn3171 wrote:
> > Adding maintainers and mailing list to CC. Sorry for the omission.
> >
> > On Tue, Jul 14, 2026 at 10:33=E2=80=AFPM chlgustn3171 <chlgustn3171@gma=
il.com> wrote:
> > >
> > > On Tue, Jul 14, 2026 at 9:18=E2=80=AFPM sashiko-bot wrote:
> > > > [Severity: High]
> > > > If a userspace process holds an open file descriptor for the evdev =
node
> > > > (/dev/input/eventX), the input_dev will outlive the parent hid->dev=
.
> > > > When the HID device is unbound, devres will free these strings.
> > > >
> > > > Can this cause a use-after-free when userspace later queries the
> > > > name, phys, or uniq strings via ioctl (e.g., EVIOCGNAME)?
> > >
> > > Thanks for the review.
> > >
> > > Using &hid->dev here is intentional.
> > > Using the input device for devm-managed input_dev strings is
> > > problematic; see CVE-2023-53454, where the allocation was moved to th=
e
> > > HID device because the input device unregister path may still use the
> > > name for uevents.
>
> Thank you for the patch. However, I do not believe it fixes anything, as
> moving to devres will not extend (and may even shorten) life time of
> name, phys and uniq. Normally they are character array members of HID
> device, and HID device continues existing past drivers disconnecting
> from it. OTOH devres-controlled resources will get freed when driver
> unbinds from a device.
>
> Additionally, HID devices are parents of input devices, and should stick
> around because input devices hold references to their parents until
> device_del() is called in input_unregister_device(). However before that
> it will disconnect this input device from all the handlers, including
> evdev, evdev will mark the device as !exist and evdev ioctl will not
> attempt to process ioctls for such device.
>
> I however am not sure why we see this syzkaller report. Maybe there is
> memory corruption somewhere or maybe syzkaller itself gets confused when
> tracing numerous allocations.
>
> Thanks.
>
> --
> Dmitry
