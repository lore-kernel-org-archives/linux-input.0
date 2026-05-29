Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8022401A2E
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079357; cv=none; b=HQUj20v10QPOAfpopugZDJNBiCbU664gJZYgtF7KrnhllUU1fz3EDOZSc1X28+qaghaEtVnAr20URfv9M2YZHuBRZZK4V5bZRLwwkJe2bUafEFjQwtM1qycu1h5w4YrMxizN1cy6LQKVYXOvQOPXeEpv4zuLz7M5T+fjQ2e3vh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079357; c=relaxed/simple;
	bh=aOFXYeYQFmbVEiOM0RrY9tgq/Y6rzuZG4+/QB/IHSdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUcZqMkPiqgQz3N2UxXjr0JXnr64iMwI6oW0DS37BUnGfjAKEHp8Eb4Hz7vgqrEjJ4As+EcsDPaRe9DuC2vSUDwbOU2IzvPgADJS/rRnxfloaJDCHqwZT/Xy2MHVC3U7FQ/G4HLl8SaersA/eVlqucqAyg4BCvNvVr9Dsss5sL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LayyVWiN; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LayyVWiN"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137d457acd4so103929c88.0
        for <linux-input@vger.kernel.org>; Fri, 29 May 2026 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079355; x=1780684155; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+ybPONvBT+3PzQ9QpwIpiAUUWA5fZia2AyuCUimrO6U=;
        b=LayyVWiNsvPQFfTlYVCT0RbqLuMfez/HO6Spvge2gXROWOiC0tSkCgMVRVp3vDimXj
         rk8qCt9rdwqJvolY/aPjnxuxlFAW5ZXycj68rilumJk8WECQfPvAefpbh7+M2ZSdr0WQ
         DHojxgQjQHgbUz67QC6hzC/riDawsBdwj8+aRGokiizvz/fXLKQrvSQiF1JJK0nkyVWY
         SzgHW0FOUUKzn87+EomIcGcEBQR/zzXpzYvKwzdXm4aNTQRmFvMDNNBFU/LABPvbEbb0
         ntajqBJCQ942pJoKzbmCLsIrn1Afr7Jwo7ZJqpco0VArfxl8m4EX7TlbVoGbWffhy3OW
         Hu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079355; x=1780684155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ybPONvBT+3PzQ9QpwIpiAUUWA5fZia2AyuCUimrO6U=;
        b=ZRJMU7HfwVZCfBi8VehVVprIOWPUKiOvqfGw9fTYFW64eBQsI+laE6E5hOnxk43HVu
         K9WjOoaAq1gyB2XnA8xR3wOtoNe+ZAIfc98MH7xWPNiZAPe21wBzrTx4d47SVo/YVJsV
         nz5uPXkV+QmVCIK/JJYdwSqkFVnDcluktYa0MOsWpNpkBqdLPjGIYqCe4gV6o0ekEOn/
         BDQahL5oK2aCGsEcIZF+5QgcqfKFVTn0B5JlPQZVZQi2EeFkyDJ+AS0+ur7mdKtkzzv+
         Bx4zpWlbKJMAAXsaGLEgENVTjd+qBQmR0Ou/D4tfGiBl0GPmZrQ8mskbH+UKC5V4C7A1
         8q0g==
X-Forwarded-Encrypted: i=1; AFNElJ+wpXac6alaWqgElq9ANKOEY2N6itI/sOCAmoRKugZS8iYa3TBm7KdSSQKNY15QdFxNnW/M9RVHkaMbPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztRakcrJhEO9II1wLYwQtjtinsE7vTiHRVEEgsYyF9Wcn57ZQj
	NzJ8rBC4Wy7koG85z394oUNcb3Cn9BcxJOwIvyIfy1rE3HqiANf1tHb1
X-Gm-Gg: Acq92OEN/xgyw4ORIxiXs4+pMXoaurcQ/zG/DXifGUSdJ5RiSpPZ/tNYgYTF2vgFuwZ
	LapSE4kssS/APkmQDPs7b86ijW+JSdlDoV8palp4BuFjWa9m90c5cEKswKsflPBoPv95eHD1PqD
	IJ2+Ma64r+gg0Y3ceC6HADC8YyP8XO325bkRjJaXMAxNDABixIb77tn1VKB1+37n/RybCMIaUyx
	VXhgn9aOLvkJP58YMjdRhnD2Ncx1BBhVSLnrX5AkYE72yXa8fH6KJ1s3Y2w4T85Xj+BFpKyQlvI
	sCsYNpUMR+d0ti5TPQ60ooAO0ZPM7HeW4dUquYk7RGgMYf+9hm/qms15ch+0eju0e/8UWKndcri
	7Iv1yV7NU272nXr6P1s9sq6TGOhVwuB4tgc/sMzuUnBKMIE3yP9ot23fxtTxa4rQA3hd4fq+Byu
	H3wAX9nW9qYvGpVlDM1/8f9Bq6RIk8uPR15gnK2bQYSkKC9HeKPtA9rebV0VvYDgFwMbibDY7Zt
	H0=
X-Received: by 2002:a05:7022:6a3:b0:136:4faf:eb09 with SMTP id a92af1059eb24-137ae5127e2mr1268920c88.7.1780079354594;
        Fri, 29 May 2026 11:29:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:307d:2a52:8823:4a01])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b35a6cf0sm1664069c88.3.2026.05.29.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:29:13 -0700 (PDT)
Date: Fri, 29 May 2026 11:29:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
	Denis Benato <denis.benato@linux.dev>, Zhouwang Huang <honjow311@gmail.com>, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 1/4] HID: hid-msi: Add MSI Claw configuration driver
Message-ID: <ahnYeAbzO5K3feRn@google.com>
References: <20260527222122.10620-1-derekjohn.clark@gmail.com>
 <20260527222122.10620-2-derekjohn.clark@gmail.com>
 <ahfQW54YoHj2Pal_@google.com>
 <CAFqHKT=zRMW4gu09xz2WAukjXB0i9d-z-SfkxU67yJkCA0DZvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFqHKT=zRMW4gu09xz2WAukjXB0i9d-z-SfkxU67yJkCA0DZvQ@mail.gmail.com>

On Thu, May 28, 2026 at 11:34:18PM -0700, Derek John Clark wrote:
> On Wed, May 27, 2026 at 10:32 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Derek,
> >
> > On Wed, May 27, 2026 at 10:21:19PM +0000, Derek J. Clark wrote:
> > > Adds configuration HID driver for the MSI Claw series of handheld PC's.
> > > In this initial patch add the initial driver outline and attributes for
> > > changing the gamepad mode, M-key behavior, and add a WO reset function.
> > >
> > > Sending the SWITCH_MODE and RESET commands causes a USB disconnect in
> > > the device. The completion will therefore never get hit and would trigger
> > > an -EIO. To avoid showing the user an error for every write to these
> > > attrs a bypass for the completion handling is introduced when timeout ==
> > > 0.
> > >
> > > The initial version of this patch was written by Denis Benato, which
> > > contained the initial reverse-engineering and implementation for the
> > > gamepad mode switching. This work was later expanded by Zhouwang Huang
> > > to include more gamepad modes. Finally, I refactored the drivers data
> > > in/out flow and overall format to conform to kernel driver best
> > > practices and style guides. Claude was used as an initial reviewer of
> > > this patch.
> >
> > I wonder why do you need to roll asynchronous probing and asynchronous
> > resume by hand? This I think complicates the driver greatly and forces
> > you to use a ton of works, spinlocks, and checks.
> >
> > Thanks.
> >
> 
> Hi Dmitry,
> 
> I suppose being asked this means my cover letter and  commit
> descriptions need some additional context.  The MCU in these Claw
> devices is quite temperamental. There are a few specific issues that
> cause the need for multiple work queues, a serialization mutex, and
> subsequently spinlocks to prevent stale data reads.
> 
> 1.) The MCU will halt function if it receives any output reports
> before ~500MS after probe or resume. This can either manifest as the
> device never responding to a command, or it can cause the entire
> system to become unstable and reboot. This creates the need for
> cfg_setup to query the MCU and then add the gamepad attrs, led_mc
> device, and rgb attrs. As a side effect, because a system could
> technically be suspended during that 500ms delay, there exists the
> need to re-queue the work if it was never triggered, hence the resume
> queue.
> 2.) The MCU will not always respond in order if two or more output
> reports are sent within a few ms of each other. Since many of the
> commands use a generic "ACK", or share an "ACK" type but don't provide
> specific context about what sub-function called them, we could
> potentially have cross talk where data is saved in the wrong attribute
> or errors propagate because of a missed message.  To get around this
> serialization issue we hold a mutex through a completion triggered in
> raw_event and, for most events, save a state machine on what command
> is expected and what sub-command was the initiator. (I.E. profile
> events handle the M1, M2, RGB, Left rumble, and right rumble). Since
> the state machine is accessed on both sides, we need spinlocks
> guarding the reads. This essentially serializes the data and makes it
> predictable. Using this pattern I haven't had any issues reading from
> or writing to the MCU.
> 3.) Some commands will never return their "ACK" while a completion is
> held, so we have a workaround to basically ignore them and hope the
> command worked. This is only needed for SYNC_TO_ROM, from which we
> don't need to set anything on its "ACK", and switching the gamepad
> mode, which causes USB disconnect/reconnect and the driver fully
> reloads, so we'll never be able to read it anyway.
> 4.) The RGB work queue is used to free the userspace write while the
> completion is held. I found that use without it could stall userspace
> quite significantly if it has multiple writes back to back. I
> experienced this using Steam's customization menu, which sends a
> single write for every increment of its color and brightness sliders.
> when traversing the full length of the slider it is possible to have
> effects changing for nearly a minute after stopping. With the queue,
> only the most recent write is eventually sent to the MCU. This issue
> also affects the Go 2 driver as well, though not to the same extent,
> but for which I'll be adding a similar de-bounce queue soon. Go S is
> also technically affected by this bug, but that returns quickly enough
> that it isn't really feasible to trigger the bug with much frequency.
> I'll still fix that one as well though.
> 
> TBH I'm not "happy" with the complexity of the driver, but I don't see
> a reasonable alternative. If you have any specific suggestions that I
> could try that might simplify it, I'd be more than happy to give it a
> shot. That being said, I'm not very optimistic about it. Development
> on this device has been like wrestling a bear.

Thank you for this detailed explanation. I would like to concentrate on
the #1 first. What happens in the driver is you are essentially rolling
asynchronous probing and asynchronous suspend/resume in the driver
itself, and end up fighting with the kernel and the driver core
specifically.

As far as suspend/resume goes: HID subsystem already enables
asynchronous resume handling (checkout the call to
device_enable_async_suspend() in
drivers/hid/hid-core.c::hid_allocate_device()). Therefore I think you
just need to stick the necessary delay in your resume method() and call
it a day.

For the probing I would look into annotating the driver as 
PROBE_PREFER_ASYNCHRONOUS and relying on that. Again, if you stick the
required delay in probe then sysfs attributes will not be created too
early, same for the rest of concerns with the device being exposed to
userspace before it is ready to handle requests.

If there are issues with HID subsystem honoring
PROBE_PREFER_ASYNCHRONOUS I would look into fixing the subsystem rather
than try to work around it in the driver.

Thanks.

-- 
Dmitry
