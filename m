Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69512DFF3F
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821948; cv=pass; b=AuTsEQMzrayQI8TYS/Nw7U3PFeBcLYgFvvk39v7dUXGyrV8j/pQK3fJKF8ZiNJ9HnXb+EHhfrCkA/397dZJRyv12D2xdGCc2DaisAWzYD/9D0zaTIFsemucPrKTJSpCw5ECiBHCz5TX1v1a9QJp5YW5EoLS6URkPagcvRXtOjvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821948; c=relaxed/simple;
	bh=TsrplT6fuTf581uCGedhh+peoK5x1XCNdqrKNbMcDqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MofnVQlttr2GotnGXcDbcDfYiwNclPWkaKyClxSK6m6fh/DEU5H1axPVy9fwpTCQ/J+ixzokQIPdv1hg0mTKi592vs9aTDLF01om5Pf9+KCABlfE45FWAOPcn6JLobO7ukrS9rL9+Auf/WJjuNyG6L3k4fOj/Rm0UVSQZdc/Bpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=PrVs3OHf; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="PrVs3OHf"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-967327a0c7dso1014140241.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 22:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785821946; cv=none;
        d=google.com; s=arc-20260327;
        b=XpIKOPla/nnZlIfBtJkgJNZZ8sPlP2YsNG+v4dDRsQNS3YkhWdGgWrgf1m1A9CPN9Q
         mRQNisHlOmqE8DWeJCW7WY7dTJw3ESZ1H8F0I59RjSKAFrIljKeqiPKhwin5huQhAIGl
         HFSE3v+CVbi1j+DDSsQiQD/n5pQQSGSCZtHwc/dNDOkjsMEUT7C8is+yWA/UHunwV5cm
         L+48hG5/KrlfHaU3jMLdrukiGE8NoG+Mjv1camamdrQur7d3FE4ghfUh3O4CQfzacaqR
         mYMfNdo9NeNaIJVbDNEJcWG26yHPgs/N7bC2EdgzxAJp1gPnmOURqwsp6/BYW2mpawWB
         g1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BNiWRl8o1VBpQDre2OIJ/G/YGDBEjVAvowh445wkuT4=;
        fh=7IfqA1dL4LuH5VLsv5ldUORerSs5rtQyKETnbkCOCa4=;
        b=BHCPz+psuYQwz+VaVzzIlB+vlY2MkgPURyeAAQokDJ4fGCNJjA0zctXdXaEZWLX/vE
         sUDuKoh5uX326K7/Bobh2mMx3ARi4E0iVj5OXRxWEeVB6ulJkzn2t/SzPlwhoQQOl7lH
         /RvEL1kZ6JfezKvV4SupmGEEiAExPj7GVX495unZTBA0RYjAXuUN95ZVHztojOh9MYER
         Fbxr/T+IOVIbnrHvfU8Kf2cv8MmaHA46ME+1uJtCSprnAbIWjlxr9EKxtjxRtRi2EDpx
         W58mKEyGUaarosdn421535D2RINSsBTg++iYbUSTCW6YeZijTRZ0TdsG13ay/PSRfj8Z
         CHHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785821946; x=1786426746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BNiWRl8o1VBpQDre2OIJ/G/YGDBEjVAvowh445wkuT4=;
        b=PrVs3OHfqpi97LqKEiM2swt8hZcLbNgQSmmv2uq0kkTw6EmNJ1pttUOS52ngvwPWW/
         QXCVChMtV1b5TuyCWEJVF+GZNTzUAOPzEsBOSbGV5gwQzgn8fTJGTGRwiVFiZCpuzZRm
         x3G0UQVKR9LFDzMxgACKuIyLL9sWDwBFje8XH73bO3+X4xytdvLQXTbxGyoB4BpqyGqJ
         u9Q9OprHcxJWk9wN41ne2GLpKJhknHoGNPe2t1U5IvfAjdL9HEiEWipBiKvTXHrGpPor
         XWqjsGDMW3qgTOrcEHELopw+Bep1gE6DhhpHjH5jSLY+oMGADE3RwMlbdV03jTyPlbHD
         wzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821946; x=1786426746;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BNiWRl8o1VBpQDre2OIJ/G/YGDBEjVAvowh445wkuT4=;
        b=KL9QQcYqA43KKICF8e9kKFVtt+QykbcVMeFnft3LtTNw0IYwd0tY/x9f/1lckqpOvA
         O/r5cDlDC/Ezb3Pa2fO+pQ1L5SBwaUz93oKtg6lEX9m1a6BTA7VygnvAutb/Kb5lGXz9
         h4e9XuHk6kaavbzvfwKpQH0yG3ZalPV9v4MnhS+d++am0alkRt+GFUY+90fsuPEBwITo
         ml4+CljXZVyH7eOHxMBR2Ie6IAtcLgTD0gw555VzaC810oXcpxI7nUsCAnIzU5lU3tKm
         Ijqx1ilRXRXguwFLphsFv7/P/9zLFf2oIwzLGgSRkD9LvHqhK6OetwA1YYb2XhfnFCdS
         IAig==
X-Gm-Message-State: AOJu0YxzQ6ugGXohVLWhKrnu1JSa7+D6xpCtTWMCAExGfStX7qdyhmCA
	jaTDtlYcliaqRkWEynAW/l4sDyZRR5HbkoBptIuWx9xxhWOeOTdOcSpvfJTkBkaF0yTI34zCcW8
	YE0N+9KA/urfH1hRPy5wH8QlUxyIocd9ooREo7Lbx1w==
X-Gm-Gg: AR+sD108Yz1Px3tto2MAs6CgVu5if2scyHXD/KRWoBgcDf6GouEuOKO2HWsKeUsBOZL
	+B8W43m/XmAF+nWnQMgEkEKGvOROSmxNsoGnV2/zyBS+XURtFn2wbJuwwSKQvQqkSHfEvinKjZu
	oHWQRXBSyfW5/tq1LuKiYhRESV1ZyL2zM1Uk+KUYnABo/ACSflJ90fqnSr0egeYkU++JHL8PN3z
	UXenir01eITtJrTO4CCXgp30hbWOnVttOZA3oqC05lcJsgii+WLI0Vftn3MLLBW3Gz6OCFl7BBr
	ZEfe1N2qCMRb6JM57jYQ8LUa6ZLL5uOQzQP8TTTdgq4xkuh9VpdnDclgNfVIj6vvNmylhX71/Fv
	YU1Y=
X-Received: by 2002:a05:6102:4b02:b0:728:53be:7c87 with SMTP id
 ada2fe7eead31-75b22266452mr7760096137.7.1785821945598; Mon, 03 Aug 2026
 22:39:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729142432.16184-1-baul.lee@xbow.com> <9ce239858b358c60a243e34f2d61def2f986966a.camel@gmail.com>
In-Reply-To: <9ce239858b358c60a243e34f2d61def2f986966a.camel@gmail.com>
From: Baul Lee <baul.lee@xbow.com>
Date: Tue, 4 Aug 2026 14:38:52 +0900
X-Gm-Features: AUfX_mwkxwzMjo3RaXwjjwGOIK5JByPtw_f4L9GDvtFVAS_fvQ9esFmCecC7oYI
Message-ID: <CAEM_DMFjJvREv_PujRp2zb5eTnPKZW_evHMDr1ZtKr_kcjQ69w@mail.gmail.com>
Subject: Re: [PATCH] HID: universal-pidff: stop the device when force-feedback
 init fails
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oleg Makarenko <oleg@makarenk.ooo>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for looking at it.  I agree with the rule, but I don't think those t=
wo
exits can take the stop, and I would rather explain why than send a v2 that
changes them.

After hid_hw_start() there is exactly one error return in
universal_pidff_probe(), the init_function() one this patch changes.  The t=
wo
exits on lines 92 and 101 return 0, which means the probe succeeds, and tha=
t
is the whole difference between them.  Because they succeed, hdev->driver
stays set, and since universal_pidff has no .remove callback,
hid_device_remove() falls back to the default remove, which is hid_hw_stop(=
).
The device those two exits leave running is therefore already stopped for u=
s
when it is unbound or unplugged, and nothing leaks there.  The leak exists
only on the path where the probe fails, because __hid_device_probe() clears
hdev->driver on failure and hid_device_remove() then skips the unwind
entirely.

If we call hid_hw_stop() on those two exits as well, it ends up running twi=
ce
on the same device, and usbhid_stop() does not survive that.  It clears the
three URB pointers on the way out - that is what the "don't mess up next
start" comment is about - but the buffers it releases immediately afterward=
s
through hid_free_buffers() are left dangling: inbuf, outbuf and ctrlbuf go
back through usb_free_coherent() and usbhid->cr through kfree(), and none o=
f
those four pointers is cleared.  There is no HID_STARTED check at the top o=
f
usbhid_stop() either, so the second call frees all four again.  Every unplu=
g
of a device that took one of those exits would be a double free, which is a
good deal worse than the leak this patch is fixing.

The other problem is that stopping there takes down the very device those
exits exist for.  hid_hw_stop() calls hid_disconnect(), which unregisters t=
he
input device through hidinput_disconnect() and the character device through
hidraw_disconnect().  The additional "device" you mention, the one that is
there just for the extra buttons and axes, is by definition the one without=
 a
PID usage page in its descriptor, so it is exactly the one that takes the e=
xit
on line 92.  Stopping it would leave this driver bound to a device with no
input node and no hidraw node at all, and returning an error there instead =
of
0 does not help either, because hid-generic will not adopt the interface:
hid_generic_match() walks the bus and gives up as soon as it finds another
driver that matches the device.  Either way the buttons and axes disappear,
which I do not think is what you are after.

2026=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 5:41, To=
masz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>=EB=8B=98=EC=9D=B4 =EC=
=9E=91=EC=84=B1:
>
> On Wed, 2026-07-29 at 23:24 +0900, Baul Lee wrote:
> > universal_pidff_probe() starts the device with hid_hw_start() and then,=
 if
> > force-feedback initialisation fails, returns the error through a label =
that
> > only does "return error".  The device is left started.
> >
> > The HID core does not unwind on the driver's behalf.  __hid_device_prob=
e()
> > releases the devres group, closes the report and clears hdev->driver:
> >
> >       if (ret) {
> >               devres_release_group(&hdev->dev, hdev->devres_group_id);
> >               hid_close_report(hdev);
> >               hdev->driver =3D NULL;
> >       }
> >
> > The hidraw character device that hid_hw_start() registered through
> > hid_connect() is allocated with kzalloc() and added with cdev_device_ad=
d(),
> > so it is not devres-managed and survives that.  With hdev->driver NULL,
> > hid_device_remove() skips hid_hw_stop() as well, because it only unwind=
s
> > while a driver is still attached.  The registration therefore outlives =
the
> > device on both paths.
> >
> > Opening the surviving /dev/hidrawX writes into freed memory.  KASAN rep=
orts
> > a use-after-free write from hidraw_open() -> hid_hw_open() -> the
> > transport's open callback, which takes a spinlock inside the freed obje=
ct.
> > A descriptor that carries a PID usage page and no input reports is enou=
gh:
> > hidraw claims the device so hid_hw_start() succeeds, while hid->inputs
> > stays empty so force-feedback init fails.  The other failure returns in
> > hid_pidff_init_with_quirks() - no output reports, an allocation failure=
,
> > pidff_init_fields(), pidff_check_autocenter(), an unusable effect count=
,
> > input_ff_create() - all reach the same label.
> >
> > Stop the device on that path.  hid-dr.c and hid-emsff.c, which start th=
e
> > device with the same HID_CONNECT_DEFAULT & ~HID_CONNECT_FF mask, alread=
y do
> > this.  The two earlier gotos must keep returning without hid_hw_stop(),
> > since neither has a started device, so give the path that fails after t=
he
> > start its own label.
> >
> > Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> >
> > Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported=
 device ids")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Baul Lee <baul.lee@xbow.com>
> > ---
> >  drivers/hid/hid-universal-pidff.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-univer=
sal-pidff.c
> > index 549dac555d40..60180467a0bf 100644
> > --- a/drivers/hid/hid-universal-pidff.c
> > +++ b/drivers/hid/hid-universal-pidff.c
> > @@ -104,12 +104,14 @@ static int universal_pidff_probe(struct hid_devic=
e *hdev,
> >       error =3D init_function(hdev, id->driver_data);
> >       if (error) {
> >               hid_warn(hdev, "Error initialising force feedback\n");
> > -             goto err;
> > +             goto err_stop;
> >       }
> >
> >       hid_info(hdev, "Universal pidff driver loaded successfully!");
> >
> >       return 0;
> > +err_stop:
> > +     hid_hw_stop(hdev);
> >  err:
> >       return error;
> >  }
>
> Actually, now that I look at it, this isn't the only place where the
> stop should happen. Any error after successful hid_hw_start() should
> trigger hid_hw_stop().
>
> So for this to truly matter, you should replace
>         return 0;
> with
>         goto err_stop;
> on lines 92 and 101. Just add error value clearing so error =3D 0 because
> even though we're exiting there, it's not an error. Some devices just
> show up as multiple separate HID devices.
>
> Tomasz
>
