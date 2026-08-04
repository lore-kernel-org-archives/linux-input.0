Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E216349CE2
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838120; cv=none; b=XNt1DhaLH2NlYchYaeqSXAPuh+Z463IpXnaCcuQQCnYSXXIOAHju9PMY4SIpE5Dh6dIiJwe96HbXvSd9cb6MFEqWP+MP9+CaXHI9hdWrPVpH0o2kb4Dcd1g0rnQc5DZTXoL2w6x2JknKK+0THT7UUH+FQgyNOEBMNCDrKOB1GTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838120; c=relaxed/simple;
	bh=dJGND05g9U6TJBGvoJHo9FrRRr+W+VUL9or/3OTtXWs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QmFAQ/CMrO7gmrZtvScBCw/niV+QlnRX4BstBmvKzxo5OALIYykT7H1SXTPTtSrZddueC3phVhLcuZPZ2+pLLx0CQMwvpE3oC2ec2yL7sdBgmpiYCtMjSDBv6SwbOP5Y5JOBsxQC4MY8kkzYM3Z3moO44oIwL8YHOICp9H56fXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2wJYoUT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2wJYoUT"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so3149755e9.2
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 03:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785838115; x=1786442915; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eKvQegePYqOrYt0JNkWU6KOxbIgN4O4nE+seVNDXYDc=;
        b=m2wJYoUTLBTjFciWRalmO3/9AOpnNDWr9ZIQjb1Tt1yDqQfCol72NN8xjPcMy9toa0
         gG9HwPc2J5he8gTLWQp57lVojLUqfDAfh4vxEzNwzS7lEXT8IUdtIoC7d0k9NzwOq1el
         /I/el4+VK1ahBdfwD8Vmo5CHEENK5Lw5oJdX18IvwswsX+lxCE2S2cwnn301DM2+/JG7
         ANHSAwH4/nPGzfn+gBrxlMTFkj86jar+R0HqHkM4L2pjRX6ftnNum0Xm9G1DEY8jaOEk
         /YtC2TvjQirfEVaGQLLkIv6+eKXDPJvB3AH3Ott7Hiw79T0LRHvWG6pee8kAzEd5uG7w
         GJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785838115; x=1786442915;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :disposition-notification-to:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eKvQegePYqOrYt0JNkWU6KOxbIgN4O4nE+seVNDXYDc=;
        b=HEY8X7k4fgxb6iO2cGZhuv7nY+I4cp4aSLdlFu4Eo3S0bVNJlZ/1ic8RXS8+7LkR+U
         IGQT+JS/YtaPqlyZnmKdEEOPd8yH6rkqpkUyxnH3kuzmuwXinh2zloAqmgWbxbAGblBI
         xRg6XA+KTzZ1AfeVTrwI1dRNdi7fmsdExhcx3BAGmHlASM62MBbBSXOdHhlNuhXeKNAJ
         /2M38vgLx1EzxFuac9lYusu4k/rp0mfGXPsDwc1ecjBWp1b4O3bpE4NdiUo/S/C64FaH
         lbzcBYFPW+AYR9fclB22ArFZdqhy9+CphoO6y7qpdGPiSlYkjHrZVHt9K4WqapEWn2dR
         5+CA==
X-Gm-Message-State: AOJu0Yw+7IYUjS3dxb/Txmvs+U2YnJhCZP9n5xTlFzvUbxu7Q1QMp8HV
	033pLmJY0QJNLhoTEUNsbppXMaMn/6t1xvDQVycBfNVCNkTmXYhK5HWb
X-Gm-Gg: AR+sD10gUe2DmU5pTk+JFb51pBHe9r3PBLlC+zOtfxhOdjMB45EgTsC7508mQRCqj2P
	Ctzhp1os98PBJCnvsmxq4/FxF4rQaWrXB1m7Oejl/mwYm7l0A5OSQ4BLgzjGckC3ZNaIEnI6HyO
	wmnP6J+fb/uBmwls3Yv1yAW89AWAQSElGBKgklzeTPQV0ixYY5CggCndwcgUocsY3GuKMd4bd37
	UkZFTbFMrsEOnzSIj3T+bUhXjPDCf5MwJUk1RiWoYTlVhllGtVESvoXmTSMCy1t6N9eOqvaOdbL
	KG7hsusP1Z8Wc4c53NIW8Qweb6pgzH4tvajCFJS14vK39JcA+zwrVWRm+MvLVFSsErNAZzmdkJf
	hYtfFEAD/dNWcUtu4irq6RY/QH+flfB2QP34KrW7A7pzVtCrHAC51u0QZ2fOnqOxpBL8jXI3E0d
	cCsufkpt9C9hjOQpmkLnkR3+mKpTJ2+YK5kNdESqON5eP16bm2JzCu89JH2fgF+HDL4EV+qB8Ec
	FYVAHl0cQbMfL0nPIWAZXLmeFpn0lozdwAkaGtrqVw9NE2H
X-Received: by 2002:a05:600c:a01:b0:493:bea7:6b67 with SMTP id 5b1f17b1804b1-4980c6a1082mr153581505e9.3.1785838115061;
        Tue, 04 Aug 2026 03:08:35 -0700 (PDT)
Received: from [192.168.1.239] (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91b3sm44990590f8f.14.2026.08.04.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 03:08:34 -0700 (PDT)
Message-ID: <12023556fec63125e8daaf0c732926568ce742ec.camel@gmail.com>
Subject: Re: [PATCH] HID: universal-pidff: stop the device when
 force-feedback init fails
From: Tomasz =?UTF-8?Q?Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg
 Makarenko	 <oleg@makarenk.ooo>, Jiri Kosina <jikos@kernel.org>, Benjamin
 Tissoires	 <bentiss@kernel.org>
Date: Tue, 04 Aug 2026 12:08:31 +0200
In-Reply-To: <CAEM_DMFjJvREv_PujRp2zb5eTnPKZW_evHMDr1ZtKr_kcjQ69w@mail.gmail.com>
References: <20260729142432.16184-1-baul.lee@xbow.com>
	 <9ce239858b358c60a243e34f2d61def2f986966a.camel@gmail.com>
	 <CAEM_DMFjJvREv_PujRp2zb5eTnPKZW_evHMDr1ZtKr_kcjQ69w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-04 at 14:38 +0900, Baul Lee wrote:
> Thanks for looking at it.  I agree with the rule, but I don't think those=
 two
> exits can take the stop, and I would rather explain why than send a v2 th=
at
> changes them.
>=20
> After hid_hw_start() there is exactly one error return in
> universal_pidff_probe(), the init_function() one this patch changes.  The=
 two
> exits on lines 92 and 101 return 0, which means the probe succeeds, and t=
hat
> is the whole difference between them.  Because they succeed, hdev->driver
> stays set, and since universal_pidff has no .remove callback,
> hid_device_remove() falls back to the default remove, which is hid_hw_sto=
p().
> The device those two exits leave running is therefore already stopped for=
 us
> when it is unbound or unplugged, and nothing leaks there.  The leak exist=
s
> only on the path where the probe fails, because __hid_device_probe() clea=
rs
> hdev->driver on failure and hid_device_remove() then skips the unwind
> entirely.
>=20
> If we call hid_hw_stop() on those two exits as well, it ends up running t=
wice
> on the same device, and usbhid_stop() does not survive that.  It clears t=
he
> three URB pointers on the way out - that is what the "don't mess up next
> start" comment is about - but the buffers it releases immediately afterwa=
rds
> through hid_free_buffers() are left dangling: inbuf, outbuf and ctrlbuf g=
o
> back through usb_free_coherent() and usbhid->cr through kfree(), and none=
 of
> those four pointers is cleared.  There is no HID_STARTED check at the top=
 of
> usbhid_stop() either, so the second call frees all four again.  Every unp=
lug
> of a device that took one of those exits would be a double free, which is=
 a
> good deal worse than the leak this patch is fixing.
>=20
> The other problem is that stopping there takes down the very device those
> exits exist for.  hid_hw_stop() calls hid_disconnect(), which unregisters=
 the
> input device through hidinput_disconnect() and the character device throu=
gh
> hidraw_disconnect().  The additional "device" you mention, the one that i=
s
> there just for the extra buttons and axes, is by definition the one witho=
ut a
> PID usage page in its descriptor, so it is exactly the one that takes the=
 exit
> on line 92.  Stopping it would leave this driver bound to a device with n=
o
> input node and no hidraw node at all, and returning an error there instea=
d of
> 0 does not help either, because hid-generic will not adopt the interface:
> hid_generic_match() walks the bus and gives up as soon as it finds anothe=
r
> driver that matches the device.  Either way the buttons and axes disappea=
r,
> which I do not think is what you are after.
>=20
> 2026=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 5:41, =
Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
> >=20
> > On Wed, 2026-07-29 at 23:24 +0900, Baul Lee wrote:
> > > universal_pidff_probe() starts the device with hid_hw_start() and the=
n, if
> > > force-feedback initialisation fails, returns the error through a labe=
l that
> > > only does "return error".  The device is left started.
> > >=20
> > > The HID core does not unwind on the driver's behalf.  __hid_device_pr=
obe()
> > > releases the devres group, closes the report and clears hdev->driver:
> > >=20
> > >       if (ret) {
> > >               devres_release_group(&hdev->dev, hdev->devres_group_id)=
;
> > >               hid_close_report(hdev);
> > >               hdev->driver =3D NULL;
> > >       }
> > >=20
> > > The hidraw character device that hid_hw_start() registered through
> > > hid_connect() is allocated with kzalloc() and added with cdev_device_=
add(),
> > > so it is not devres-managed and survives that.  With hdev->driver NUL=
L,
> > > hid_device_remove() skips hid_hw_stop() as well, because it only unwi=
nds
> > > while a driver is still attached.  The registration therefore outlive=
s the
> > > device on both paths.
> > >=20
> > > Opening the surviving /dev/hidrawX writes into freed memory.  KASAN r=
eports
> > > a use-after-free write from hidraw_open() -> hid_hw_open() -> the
> > > transport's open callback, which takes a spinlock inside the freed ob=
ject.
> > > A descriptor that carries a PID usage page and no input reports is en=
ough:
> > > hidraw claims the device so hid_hw_start() succeeds, while hid->input=
s
> > > stays empty so force-feedback init fails.  The other failure returns =
in
> > > hid_pidff_init_with_quirks() - no output reports, an allocation failu=
re,
> > > pidff_init_fields(), pidff_check_autocenter(), an unusable effect cou=
nt,
> > > input_ff_create() - all reach the same label.
> > >=20
> > > Stop the device on that path.  hid-dr.c and hid-emsff.c, which start =
the
> > > device with the same HID_CONNECT_DEFAULT & ~HID_CONNECT_FF mask, alre=
ady do
> > > this.  The two earlier gotos must keep returning without hid_hw_stop(=
),
> > > since neither has a started device, so give the path that fails after=
 the
> > > start its own label.
> > >=20
> > > Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> > >=20
> > > Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and support=
ed device ids")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Baul Lee <baul.lee@xbow.com>
> > > ---
> > >  drivers/hid/hid-universal-pidff.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-univ=
ersal-pidff.c
> > > index 549dac555d40..60180467a0bf 100644
> > > --- a/drivers/hid/hid-universal-pidff.c
> > > +++ b/drivers/hid/hid-universal-pidff.c
> > > @@ -104,12 +104,14 @@ static int universal_pidff_probe(struct hid_dev=
ice *hdev,
> > >       error =3D init_function(hdev, id->driver_data);
> > >       if (error) {
> > >               hid_warn(hdev, "Error initialising force feedback\n");
> > > -             goto err;
> > > +             goto err_stop;
> > >       }
> > >=20
> > >       hid_info(hdev, "Universal pidff driver loaded successfully!");
> > >=20
> > >       return 0;
> > > +err_stop:
> > > +     hid_hw_stop(hdev);
> > >  err:
> > >       return error;
> > >  }
> >=20
> > Actually, now that I look at it, this isn't the only place where the
> > stop should happen. Any error after successful hid_hw_start() should
> > trigger hid_hw_stop().
> >=20
> > So for this to truly matter, you should replace
> >         return 0;
> > with
> >         goto err_stop;
> > on lines 92 and 101. Just add error value clearing so error =3D 0 becau=
se
> > even though we're exiting there, it's not an error. Some devices just
> > show up as multiple separate HID devices.
> >=20
> > Tomasz
> >=20

Okay! Thanks for the detailed explanation and for the contribution. I
tested this by mangling PID descriptor and indeed, like you said, it
would completely disable input from the steering wheelso the current
version is proper.

--=20
Reviewed-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
