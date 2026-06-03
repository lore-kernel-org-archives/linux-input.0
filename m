Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443ED2749C1
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453990; cv=pass; b=LHiViaJHTBAvLi0ysfvmsshyqfzG1dByiCN/pUlwwnhoKdhMYyPFivuVNTSh92orCaHUxSygcrUJAMBniacy2a5GBwlnW1wqjm2sWqxsKAg+xstZPnMOoU8CAlKxn9q2eF+/xR1cd+hgErEZiLe2L6rC+TMyemFDK9EciMdMsdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453990; c=relaxed/simple;
	bh=B5D6CLLoPVetalo0iR0aHY58CILhdyNTKmLkx6nm3Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPRPgTOiMV8S6CcByNGvc1NI3LLk33xH87Y++lZhcDVxijmo7DPzkdrsLIrDJzYTilUG7UXicwh8Xu1JShgDA1mtMx2zgPwY0yCT9grK6OTzvfv9HzDz0Cl08HzNMMk2J/awLAPNfHNEOcOq6J4pZQXKG+WKm4KEoooV75f5rlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5o2DZlB; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5o2DZlB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8ccef25789fso31369256d6.3
        for <linux-input@vger.kernel.org>; Tue, 02 Jun 2026 19:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780453988; cv=none;
        d=google.com; s=arc-20240605;
        b=VJ0wkQfjEFUZt4K9KvInSLT21b2b8YUX0DF2MqiyvdlXqg8JAZDA8qi7scJenLgv9W
         ZRayMXI4h5yMolFpsrdP269o4TwfI36DHQaRX/2XBbx115stf+Ezqp7ZFoVZs3076kpz
         rRPGMbqtuHZEJdO06+nef7YAzhOb6Ww2b1G6l2gARQp5uu25kML/Zrw9Nu9CrDAub2dR
         fOeIJn1NxnEFcrLlgKMTqfH6Fv+uckq/dtSVUKiXMHAriOlsgb46eJQsmdpRaj/eNcrZ
         eCUk31Pc2hLoUoLOQekasMzTSHMcgEOrUHr3RxCSUmb+PU4sv1bXjPZ5/+ih/XDIDkkT
         AnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R1hHnwu4UKQ78UvXuhtdfSY1js4owGHvjcyByjH9Yk4=;
        fh=cNWdlfdNVqAUJXz5ZDUxsbdA3gs4gWEqRmaWRWdDAMw=;
        b=WsnNKrXv9TGLSqfodCxmR5MQ25zVxqaCzKY7ajsIacU2WH2c2UyP0IKvpTUgukl7SE
         NARMZ/rNJYcHFljzccT7Ypt6drgD+pvTPfU5Wmrj9VXJnLcCDW//snEkVc/q/4nLNVZR
         i7DdDVJBJcQKmzCx9VbJKhJh/ZTzuNbKFKCivTVaKf7SC97Pq6GCvaPX0c+Elr/ePj8J
         QLoOMMywq33eFP+tS/RmG+iev13CXRLGqneJlxkGMWLG58OxcJjRc3hhvAJrjPQm94nH
         LPoUUd88eqNJTAJCAz59bK6/+zwuAclv8JIpyQsQLshLGhPkF1epuLn1ASbX7iLzPZlG
         eXzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780453988; x=1781058788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1hHnwu4UKQ78UvXuhtdfSY1js4owGHvjcyByjH9Yk4=;
        b=N5o2DZlBOJc6jZGzs9MwNpJq/8U9mmpt1peMrRZdcUvoHwNcqHqquhBU3mIO/IX529
         pgiUnHpFzLRCtqqKbF7nnPEnsAjMsqngH0woc6iJdRPB8YPCQKm5XFp8QhP7F14DW75A
         pH+Q5Sddywlomz3cx43v+t9wghCIVIiJKG6ZXOSuAZv3RP+NaZCk401QV6/yq9lI6drm
         bMErPekdFDoROYNk//7b9dGo/+aIWuA8kmKXLBQM96R8883nov31Uj+DbJWzWWahSdUu
         Ly0WLS6LtVcc0OkqS6hmJJneGuoPncOhuZqD+tQIatKUHiF5DzWnatA37ejNqVWbCn3G
         9HPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780453988; x=1781058788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1hHnwu4UKQ78UvXuhtdfSY1js4owGHvjcyByjH9Yk4=;
        b=FbI7LqJ9kc25CJ63wyuGt/o0Q40lseASDb7nBoDTRSdvfc7AM5CLB1S22aJOUE2vIj
         TLx/wECyYxbeAzU1tyX/Ig2DMO21zUQThZNcBb2PKDCtw0JNpmT0qF0a/QxL5fqYOl9h
         Pn3Vs3+tSxxJRnFwJe1ZMbM6I5kXH10qtkc2hoWf2zoe443XSQXqDWm9h06JvH6baoWi
         fPJi04H6tnVdcl1Ta0eYvvkgDWyx/oLNTxrSf5lq1skHuDB/vZiD7GMh2+a8I/gv10Tq
         45UZ3SQWrf/wKLkQLz1RGQPKzuZq50i4VQ+wX1q1vE/j7qoT6zyg87iSjBszBOhZp0Ga
         P3vw==
X-Forwarded-Encrypted: i=1; AFNElJ86WVBnRjy6QPj0nPXLdI5R1iFKuXboowOeZ5c2dHq8AVBY+eUoYBZ1A3eJdwv6s4YUY6QuYlsCju8e8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyocivqrMuTI/ukseu5pvDcNurfWXUCUdPwvA7eYAECe4LPa1tk
	dwd3TAEvSK6siVu4qOsW/H3cz727QOhOhV3xqEHlX9zUTgeGkAcQvZJm8pt6LVb4Y6af5XxPUN8
	SOFweduJg4vJBfdfIVj/Mus3gEV8sGww=
X-Gm-Gg: Acq92OEeH+/O7wWEYk471jqL5hhKEzuQtzv5rqzzcHg0D4tAf1mqhQBcM/2ZXkrygjd
	JTo5avH8U1ZNfGdHvIynkbSwjtSZsQLLQHmUbBKB2auzJ22L925Vdai42Y7ooDtYwhbBngoI3ew
	FxF4q0Z9RHB4QeuRwCt0z45AmwAEWJJen0X2llVDmTIrsJU4FcjdFmvqFYMpt8AqGsOfAwbw960
	GwF5ZcRtdF0wEnM+sta/36NSpjay2x+i8xsv7o5XUXRMv3Mik6Wqms5G5ZCo8efkpLBAabjamIP
	9Yvp0kMbTYLMF/qLU10=
X-Received: by 2002:a05:6214:3ca0:b0:8ca:1ea9:d9af with SMTP id
 6a1803df08f44-8cece152ef7mr18859336d6.42.1780453988217; Tue, 02 Jun 2026
 19:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527222122.10620-1-derekjohn.clark@gmail.com>
 <20260527222122.10620-2-derekjohn.clark@gmail.com> <ahfQW54YoHj2Pal_@google.com>
 <CAFqHKT=zRMW4gu09xz2WAukjXB0i9d-z-SfkxU67yJkCA0DZvQ@mail.gmail.com> <ahnYeAbzO5K3feRn@google.com>
In-Reply-To: <ahnYeAbzO5K3feRn@google.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Tue, 2 Jun 2026 19:32:55 -0700
X-Gm-Features: AVHnY4KU2GxEJvnSXzx6ZxsBIJkIyxmbjmt0pWWQGiz1t0od313xiLMX9DydjHY
Message-ID: <CAFqHKTnGpv5=4zGXQY99NDSwtTAGuZpBpZ3C2w+TRbuHCbS=WA@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] HID: hid-msi: Add MSI Claw configuration driver
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Denis Benato <denis.benato@linux.dev>, 
	Zhouwang Huang <honjow311@gmail.com>, linux-input@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 11:29=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, May 28, 2026 at 11:34:18PM -0700, Derek John Clark wrote:
> > On Wed, May 27, 2026 at 10:32=E2=80=AFPM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Hi Derek,
> > >
> > > On Wed, May 27, 2026 at 10:21:19PM +0000, Derek J. Clark wrote:
> > > > Adds configuration HID driver for the MSI Claw series of handheld P=
C's.
> > > > In this initial patch add the initial driver outline and attributes=
 for
> > > > changing the gamepad mode, M-key behavior, and add a WO reset funct=
ion.
> > > >
> > > > Sending the SWITCH_MODE and RESET commands causes a USB disconnect =
in
> > > > the device. The completion will therefore never get hit and would t=
rigger
> > > > an -EIO. To avoid showing the user an error for every write to thes=
e
> > > > attrs a bypass for the completion handling is introduced when timeo=
ut =3D=3D
> > > > 0.
> > > >
> > > > The initial version of this patch was written by Denis Benato, whic=
h
> > > > contained the initial reverse-engineering and implementation for th=
e
> > > > gamepad mode switching. This work was later expanded by Zhouwang Hu=
ang
> > > > to include more gamepad modes. Finally, I refactored the drivers da=
ta
> > > > in/out flow and overall format to conform to kernel driver best
> > > > practices and style guides. Claude was used as an initial reviewer =
of
> > > > this patch.
> > >
> > > I wonder why do you need to roll asynchronous probing and asynchronou=
s
> > > resume by hand? This I think complicates the driver greatly and force=
s
> > > you to use a ton of works, spinlocks, and checks.
> > >
> > > Thanks.
> > >
> >
> > Hi Dmitry,
> >
> > I suppose being asked this means my cover letter and  commit
> > descriptions need some additional context.  The MCU in these Claw
> > devices is quite temperamental. There are a few specific issues that
> > cause the need for multiple work queues, a serialization mutex, and
> > subsequently spinlocks to prevent stale data reads.
> >
> > 1.) The MCU will halt function if it receives any output reports
> > before ~500MS after probe or resume. This can either manifest as the
> > device never responding to a command, or it can cause the entire
> > system to become unstable and reboot. This creates the need for
> > cfg_setup to query the MCU and then add the gamepad attrs, led_mc
> > device, and rgb attrs. As a side effect, because a system could
> > technically be suspended during that 500ms delay, there exists the
> > need to re-queue the work if it was never triggered, hence the resume
> > queue.
> > 2.) The MCU will not always respond in order if two or more output
> > reports are sent within a few ms of each other. Since many of the
> > commands use a generic "ACK", or share an "ACK" type but don't provide
> > specific context about what sub-function called them, we could
> > potentially have cross talk where data is saved in the wrong attribute
> > or errors propagate because of a missed message.  To get around this
> > serialization issue we hold a mutex through a completion triggered in
> > raw_event and, for most events, save a state machine on what command
> > is expected and what sub-command was the initiator. (I.E. profile
> > events handle the M1, M2, RGB, Left rumble, and right rumble). Since
> > the state machine is accessed on both sides, we need spinlocks
> > guarding the reads. This essentially serializes the data and makes it
> > predictable. Using this pattern I haven't had any issues reading from
> > or writing to the MCU.
> > 3.) Some commands will never return their "ACK" while a completion is
> > held, so we have a workaround to basically ignore them and hope the
> > command worked. This is only needed for SYNC_TO_ROM, from which we
> > don't need to set anything on its "ACK", and switching the gamepad
> > mode, which causes USB disconnect/reconnect and the driver fully
> > reloads, so we'll never be able to read it anyway.
> > 4.) The RGB work queue is used to free the userspace write while the
> > completion is held. I found that use without it could stall userspace
> > quite significantly if it has multiple writes back to back. I
> > experienced this using Steam's customization menu, which sends a
> > single write for every increment of its color and brightness sliders.
> > when traversing the full length of the slider it is possible to have
> > effects changing for nearly a minute after stopping. With the queue,
> > only the most recent write is eventually sent to the MCU. This issue
> > also affects the Go 2 driver as well, though not to the same extent,
> > but for which I'll be adding a similar de-bounce queue soon. Go S is
> > also technically affected by this bug, but that returns quickly enough
> > that it isn't really feasible to trigger the bug with much frequency.
> > I'll still fix that one as well though.
> >
> > TBH I'm not "happy" with the complexity of the driver, but I don't see
> > a reasonable alternative. If you have any specific suggestions that I
> > could try that might simplify it, I'd be more than happy to give it a
> > shot. That being said, I'm not very optimistic about it. Development
> > on this device has been like wrestling a bear.
>
> Thank you for this detailed explanation. I would like to concentrate on
> the #1 first. What happens in the driver is you are essentially rolling
> asynchronous probing and asynchronous suspend/resume in the driver
> itself, and end up fighting with the kernel and the driver core
> specifically.
>
> As far as suspend/resume goes: HID subsystem already enables
> asynchronous resume handling (checkout the call to
> device_enable_async_suspend() in
> drivers/hid/hid-core.c::hid_allocate_device()). Therefore I think you
> just need to stick the necessary delay in your resume method() and call
> it a day.
>
> For the probing I would look into annotating the driver as
> PROBE_PREFER_ASYNCHRONOUS and relying on that. Again, if you stick the
> required delay in probe then sysfs attributes will not be created too
> early, same for the rest of concerns with the device being exposed to
> userspace before it is ready to handle requests.

Hi Dmitry,

I've done a bit of a deep dive into this to try and get it to work
without work queues while using PROBE_PREFER_ASYNCHRONOUS and regular
sleeps. While it does simplify the driver, I can't get it to function
properly. No matter how long I wait the probe fails with an -EBUSY as
raw_event never fires during the probe context, and my completion
handler times out. The most likely explanation I have found is that
the MCU must require all interfaces to be fully bound before it will
respond to interrupt URB completions (vice needing to sleep for 500ms
for the MCU to be ready as I previously thought). During probe the
driver core holds the parent USB device lock for the duration of each
interface's probe. Since the other interfaces cannot start binding as
they are blocked waiting for the parent lock, and the MCU is waiting
for them to bind before responding, no ACK arrives within the timeout
window and the probe fails. The other interfaces only begin probing
after the config interface probe returns and releases the parent lock,
as confirmed by dmesg timestamps. When using the work_queue method all
interfaces have finished probing, so the MCU is responding to
interrupt URB completions and everything works.

> If there are issues with HID subsystem honoring
> PROBE_PREFER_ASYNCHRONOUS I would look into fixing the subsystem rather
> than try to work around it in the driver.

Since a lock is held on the parent while each interface is attached,
and USB devices have multiple interfaces, this happens synchronously
even in "async" context. The HID core calls driver_attach, which
detects the async flag and calls __driver_attach_async_helper, which
then calls driver_probe_device after locking the parent.

From drivers/base/dd.c:
static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
{
    struct device *dev =3D _dev;
    const struct device_driver *drv;
    int ret;

    __device_driver_lock(dev, dev->parent);
    drv =3D dev->p->async_driver;
    dev->p->async_driver =3D NULL;
    ret =3D driver_probe_device(drv, dev);
    __device_driver_unlock(dev, dev->parent);

    dev_dbg(dev, "driver %s async attach completed: %d\n", drv->name, ret);

    put_device(dev);
}
...
 * driver_probe_device - attempt to bind device & driver together
...
 * This function must be called with @dev lock held.  When called for a
 * USB interface, @dev->parent lock must be held as well.

One possible solution might be to add a way to match on
bInterfaceNumber in hid_device_id and allow the interfaces I don't
care about to stay bound to hid_generic. Another would be to
parallelize the interface probing. I'm not sure about the feasibility
of either approach since they would have significant changes and broad
implications for all USB/USBHID drivers. I also don't know if that
would even solve the problem.

Thanks,
Derek

> Thanks.
>
> --
> Dmitry
