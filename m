Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25E2E7379
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974917; cv=pass; b=Ys09mJa2BlqHMQQwhuVncapjHeohNQwZEjWUrL6sQuGUqaGh0lDvuEWaNZn3ewb9ejZqO/fCqVWiZkeCAC/nnl3zYwvM4mcj+X38ZC47lFZDGr0HdLJAD9mcKBmgQ0b9DWxinoe8krOwiYCjrcIqalOaMyhyotomMAoEolBdQas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974917; c=relaxed/simple;
	bh=1iu5d+I5/K4BVPrMkCaJZCHy0u+IaD5kCta9cXPqI9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlgM3mzia/sxPNHSZGpNk5WEzkFN0h/6ES3dhfj4VyxurTFxChAI1d4I2CR6HVvDdKG+fn+pHSPM8McNihMNbswhxNllrdXtg/K+fwp8ORnQvuxE7mQ+z/Iv84fCOevcnM71IzWSmf4PdL3w2Gd2BFd4GfGmAbP7O7bgg1C6b2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svtDcUcn; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svtDcUcn"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1733592a91.0
        for <linux-input@vger.kernel.org>; Wed, 05 Aug 2026 17:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785974912; cv=none;
        d=google.com; s=arc-20260327;
        b=Zeg2TI8bqNNjj7WsaFO0P08XaB68pFvSLObA9KYL7X0lYJvt50riniwyEbNpWXrA4O
         UJykn+QUUs+DzS26dvCgW5Khze7hXsfcajrkIsngaWrxFOtG5YnLfnhgSzbcOX4WPIr9
         Xr4mKLLzpjJCO1VNuYuQfyzPzmuIL+JDHbf8TpYU+eKC0dHCQNxrEsWP85PNTtnYk2XU
         EkAnT4SvFDxk96IaExbKaHUw5SqpxsT1lk/lbc1Pd1mn/5crMBL3UG7c5PAA0IhyjjfY
         IuZShhhEn7RevxIgKBxFyXm+Nt3f+xsFEuSW3ECjHMfQWvVrXut6KouRFzW0LoNzJQwY
         UtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5vW05tTD3g3Q72ERS87XMCcMXQMeuaxyt2ovrslKYZ4=;
        fh=KHrXx9yTg+mXy3SbHTlQQe/MIWe0C/C3k2kfWTetw5U=;
        b=FiS5ERYSZcEjO5c60/1j0gO1pIVtLqMqg1UmezdA8SLxWEaF2rwNi7SNUj0dxwvB2J
         ipxCV6iw1icslUqKKahEO61smRom7hkcGDfwg4hmohNB9bbZHjIHfNg3m1yH32YFutnp
         OYl++XnY8XyArB9AMLf8EoNlHbNyG4DXHmlrWEZeLrZumn0pbzvbWyBQN8DonkxCduvE
         5Kueh5ZXK2ChVkn1A5fyM2WwLVkp48uUJbkSIkWJf4XYpFprzr3MNptoPHHurtgLKdrx
         iTQN0RIZU60/PZZAS75XTWfG2Gcz1F9GkWFv49J9pwbefyE/5YB0TybVO0v9bx+0ajrk
         g/kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785974912; x=1786579712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vW05tTD3g3Q72ERS87XMCcMXQMeuaxyt2ovrslKYZ4=;
        b=svtDcUcnrW6iP4cDqc+Pp2KlIvFKw7TVFMRP7v0NtQxQPK9+pfi+iK/wLtvXEaSCVa
         dtD79TNKXy1xzGfBz8PWj6i9vcZ72ABzuVpLQHFfPC4YmXdasdL2BfW8XcFfauqAJrUW
         FN9korxrdzDXJHZaDvzgZ3hzNkZMorVj+WqU/9p+HDeW9pc0xGwLdVhm7kjPW+TFjw/i
         SanzT6jUSgD9ujBKt0ALo+ei/1T+YJEr7GT5zQ1rIbjsXBPxAoOUaSuLlgEmJcvEFg9f
         xd3YR2+0NDdzkAuOh+A1Fb3AEbiXtvB7pwA8KJ4mn5a7l8WjNudl9+3eoo7s2nSRMEal
         Svig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785974912; x=1786579712;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vW05tTD3g3Q72ERS87XMCcMXQMeuaxyt2ovrslKYZ4=;
        b=UsjowiFwBrmF5kFzpT1pErOuQfB2Lq/qi1KIokX7Z9wRg4jWm78nAaYdi2zjp7o5xf
         T9jL5FWojkz3c0J/o+l8gFD6siyJPpDX9nVeequZeE7Zcg0NyrZDZf4XcumIwIqFbBM0
         ZkNYzWIqfYNWJzHEniv2RRSiDUX3QOr5P5FLwD5mq8005D7Mw1hRIYBSe/YFRaQHkPmq
         EVOTTNvYaH6L+JPRb+4pwhCpGQDH+yS4Uy9mbSdJD55qrTABEvDu1cQiOVwmsBuE4PiU
         6Q20DwoqXTaBXRmvj6uCduSG4shliw+D481U4J67uXvUNM++i10Y7JiMcX+ZSGzyfp4j
         W+aw==
X-Forwarded-Encrypted: i=1; AHgh+Rr1k9r5JFLrT/xOn/gNwkKxDCQbGoMXn0P8YykPmba/Ie1OJXEubq6i61i9cVyfmiY9bG3Ok5gaE6kMFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQvtw1prECqv6RsQdIPARsX0fOCAJEhZ2huFsRHRUnqJTGLB0
	3UfiDI6wKv8Q1rrnigGePeUANW0svWnFA7PhaAwvCPtp/FrlC0vW9Hlyu5dTSNIDA3YhJVOobPN
	eCGNM2KsroaUqeiH4LAL9EB7g8i9zZvA=
X-Gm-Gg: AR+sD12RvShwnoAVLbq+paynYf1LSjq4ZjWe0MEHPosI0s7eqtGxXP3+ccPWUTEePQv
	GbHpcQUOn4iUKPvuEj7Z9jBstomsF2q95kuhDp0nrc4uwpz6vtgAxM+apzq7Bm+IUN+a8SuuJOR
	EJyNQsYAbyp1wbXqriB5fDsCxjUcWlIFB2XMRGSiJJ+FoGq+Px8lTAAMotNj3vwsCdp908kk/Jw
	dCt0+ES19NNowj22upwnRCswQJr4PHznMZtnfFLhhfRBtseZiwAKiZnypZHDG3HJhDltEkoZXMo
	dKFSV/7vkeQR5s993zRRE/h/txOIZwakXBcm/Tca+aBzbKAx/QYfLDIOnL+7Lq1xs7GcvRHJaE1
	31bft2PQfDbw83uvHti6EjxgOg+T/feC7n2G9ZDMMi2tPKQBcLIqYr+ymUZM=
X-Received: by 2002:a17:90b:3a8d:b0:38e:57a3:f218 with SMTP id
 98e67ed59e1d1-3903c5b9f70mr9408859a91.13.1785974911569; Wed, 05 Aug 2026
 17:08:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
 <anIhyHL4Kl-DX2G_@eggarch> <CABWMpWQEfycicrctrW3RD1yNf0rv1ZrioY9FcjoZZGEz4GAm_Q@mail.gmail.com>
In-Reply-To: <CABWMpWQEfycicrctrW3RD1yNf0rv1ZrioY9FcjoZZGEz4GAm_Q@mail.gmail.com>
From: Jamie Stephens <jamie.stephens@gmail.com>
Date: Wed, 5 Aug 2026 20:08:19 -0400
X-Gm-Features: AUfX_mzWccQa-XGJ0eOY4WMfNWGqgAW-Qd5A9IgdUUwdNC3nZgowQzhwzISJkns
Message-ID: <CABWMpWTn3H7UKqYzr7JP9tkQCEJHsXX-F103nyyey_srn7mvHA@mail.gmail.com>
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, regressions@lists.linux.dev, 
	gregkh@linuxfoundation.org, stern@rowland.harvard.edu, 
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks again for all of the suggestions. I wanted to provide an update
after spending some more time testing.

At this point I'm no longer convinced this is simply a kernel regression.

I've now tested the UPS across multiple kernel generations, including:

- 6.0.x

- 6.18.40

- 7.0.2-6

- 7.0.14-8

- 7.2.x

The behavior varies somewhat between versions=E2=80=947.0.2-6 gets the
farthest=E2=80=94but none of them provide stable long-term communication wi=
th
the UPS.

On 7.0.2-6, the driver successfully:

- Claims interface 0

- Reads the HID report descriptor

- Detects the UPS correctly as a CyberPower LE1000DG (VID:PID 0764:0501)

- Retrieves battery charge, runtime, voltage, load, and other values

- Completes several successful polling/update cycles

Eventually communication stops. At that point the running driver
repeatedly logs:

    libusb1: Could not open any HID devices: insufficient permissions
on everything

and upsd reports:

    Data for UPS [ups] is stale - check driver

One thing I find particularly interesting is that the UPS never
disappears from the USB bus. Even after communication becomes stale it
is still present in lsusb:

    Bus 001 Device 007: ID 0764:0501 Cyber Power System LE1000DG

There are also no USB disconnects, resets, xHCI errors, or other
kernel USB errors after the device has initialized.

What makes this especially confusing is that this does not appear to
be a normal permissions problem. The driver clearly has permission to
open the device initially=E2=80=94it successfully claims the interface, rea=
ds
the HID report descriptor, and communicates with the UPS for several
polling cycles before failing. Once it enters this state, however, it
repeatedly reports "insufficient permissions on everything" until the
driver is restarted.

Since I can reproduce essentially the same failure across 6.0, 6.18,
7.0, and 7.2 kernels, I'm beginning to think the kernel version only
affects how long the driver remains functional, rather than being the
underlying cause.

Over the next few days I plan to test the UPS using a dedicated PCIe
USB controller based on an ASMedia chipset to determine whether the
behavior is specific to the Intel xHCI controller. I'll report those
results back to the list once I've completed that testing.

Has anyone seen this pattern before, where usbhid-ups initializes
successfully, polls normally for a short period, then loses
communication and repeatedly reports:

    libusb1: Could not open any HID devices: insufficient permissions
on everything

while the USB device itself remains present and enumerated?

Thanks again for everyone's time and suggestions. I'll follow up once
I've completed the additional USB controller testing.

On Tue, Aug 4, 2026 at 8:01=E2=80=AFPM Jamie Stephens <jamie.stephens@gmail=
.com> wrote:
>
> Hi Lovekesh,
>
> I have now tested 02-resume-reset.patch separately on Linux 7.1.5 with
> the CyberPower device 0764:0501.
>
> The patched kernel was active:
>
>   7.1.5-ups-reset-resume
>
> The device was detected by lsusb, but USB initialization still failed:
>
>   usb 1-3: new full-speed USB device number 4 using xhci_hcd
>   usb 1-3: New USB device found, idVendor=3D0764, idProduct=3D0501
>   usb 1-3: New USB device strings: Mfr=3D3, Product=3D1, SerialNumber=3D2
>   usb 1-3: can't set config #1, error -71
>
> The UPS therefore never attached to hid-generic and NUT could not use it.
>
> I then returned the same USB cable and UPS to the PiAware NUT server,
> where it immediately resumed working normally:
>
>   ups.status: OL
>   battery.charge: 100
>   input.voltage: 122.0
>   output.voltage: 122.0
>   ups.load: 23
>   driver.version.data: CyberPower HID 0.8
>
> Results so far:
>
>   01-no-lpm.patch: did not resolve the regression
>   02-resume-reset.patch: did not resolve the regression
>
> I will proceed with the requested git bisection unless you would like
> any additional targeted logs or tests first.
>
> Regards,
> Jamie Stephens
>
> On Tue, Aug 4, 2026 at 2:56=E2=80=AFPM Lovekesh Solanki
> <lovekeshsolanki00@gmail.com> wrote:
> >
> > Thanks for the report,
> >
> > On Thu, Jul 30, 2026 at 03:28:02PM -0400, Jamie Stephens wrote:
> > > sudo lsusb -v -d 0764:0501
> > >
> > > reports:
> > >
> > > wDescriptorLength     504
> > >
> > > Warning: can't get report descriptor, LIBUSB_ERROR_PIPE
> > >
> > > cannot read device status, Resource temporarily unavailable (11)
> > >
> > > As a result, usbhid-ups is unable to reliably communicate with the
> > > device and NUT cannot reliably monitor UPS status.
> > The lsusb failure and NUT seem to be seperate, lsusb failure could
> > simply be device property.
> >
> > Few possibilities I can think of worth testing:
> > 1) It may be related to LPM, the device may be advertising this but may
> > not be handling it properly.
> > 2) Commit 8020c41b39f5 (usb: core: allow ACPI-managed hard-wired ports =
to power off)
> > lets acpi managed ports be powered off even if hub does not advertise
> > power switching. The UPS may be sitting on such port and its power coul=
d
> > be cycled out and leave it in a stale state.
> >
> > I'm attaching two patches to see if they have any effect, please apply
> > and test them seperatly and let us know the results.
> > And, as per Thorsten's advice above, run git bisection regardless.
> >
> > Regards,
> > Lovekesh
