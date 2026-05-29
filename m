Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021BC34107F
	for <linux-input@vger.kernel.org>; Fri, 29 May 2026 23:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096351; cv=none; b=mxDex4KX97TlK1HooqGShM3ftYAK3S2IbiumqB0AXy6rtMJtIoS0PFRVsCzgaM83eDiJkYaAg88gaCuIiqcpzRJnUoeNAsOG6W4ss8b7b3eNbZ9ySKFdAFDCX7aVvP+F5NUFH5qq4DZ6Y2q/wxIQeoTOcSe7yC+jiJAX03dbWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096351; c=relaxed/simple;
	bh=GcRYV9djhZvw4+e4m5D/NvSJuQOWRuCLeTeXuDkAA7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gcU6grHOWvuQLfHmt/EHjwoU7DUJDTszu8gFcr+G+QdozkaO5Cunof0T4Yais7Mr7W7yunJLub01TuoVGSOR/APYSnnq3iBDO3QE2sHljLuxFvaLkwZ5OJ18ftrnez2dw60oMOYqJ+PAE5XfY7YTnbSoDAIlLJjRGDgwiTP6kiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMCXF8xu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMCXF8xu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBD41F00893;
	Fri, 29 May 2026 23:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096349;
	bh=W0keMF1LdiOQNFO4ZPTWsxIg6sLFVxGvG6D8JZ8AP5I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oMCXF8xuO0M7mzS1/YbY/9aLY/sW8/X8Plk3Sl4JluhDloD95f2h5NMMLM2y5U8+O
	 zgo88dbQijavKZalkMLNox1kcdIkkwDNt1Bc/HdHiha4sHY+/4RaMk4OeLYoExv5fE
	 S9C1TNb+JvrYXYwFKs1i16HIMlbyHTXI02YfuV43CvH1Xw8732Z4vf1/1oMi0RgK5L
	 0oNDL/HxsCZ39sSuMRKrYMUuWTQ9fCyFM7onpRwT4LyJCLRqSgsKwRaWzkH+/zebvg
	 2IE4oyw0rhPbIgWfLPzeSphd54Hlb6u3KCsL7TJrk7P6lCVgud0FzECSJ54Vn0B4QA
	 kqWbf+gBFfzvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-quickspi: reset touch IC on
 system resume
Reply-To: sashiko-reviews@lists.linux.dev
To: d3z-the-dev <d3z.the.dev@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 29 May 2026 23:12:29 +0000
Message-Id: <20260529231229.8EBD41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unconditional hardware reset during system resume destroys pending=
 wake events and breaks Wake-on-Touch.

Pre-existing issues:
- [High] Using wait_event_interruptible_timeout in a system resume callback=
 can prematurely abort device resume.
- [High] Concurrent execution of `reset_tic()` from the PM resume callback =
and the IRQ thread without proper locking.
--

commit e9088cb0484bc3fbc7b5dd49968293dc14d55d36
Author: d3z-the-dev <d3z.the.dev@gmail.com>

HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume

This commit modifies quickspi_resume() to perform a full reset of the touch
IC during system resume. It mirrors the hibernation restore path to fix an
issue where the touch IC loses power during s2idle suspend on certain platf=
orms.

Link: https://github.com/linux-surface/linux-surface/issues/1799

> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c b/dr=
ivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index f669235f18839..d59278a3e5c10 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
[ ... ]
> @@ -780,24 +780,54 @@ static int quickspi_resume(struct device *device)
>  	thc_interrupt_config(qsdev->thc_hw);
> =20
>  	thc_interrupt_enable(qsdev->thc_hw, true);

[Severity: High]
This is a pre-existing issue, but does enabling interrupts right before cal=
ling
reset_tic() introduce a race condition?

If the touch controller generates an error interrupt during the reset seque=
nce,
the OS schedules the IRQ thread, which calls try_recover() and executes
reset_tic() again. Since both the PM thread and the IRQ thread execute
reset_tic() concurrently without a mutex:

PM thread
quickspi_resume()
   reset_tic()

IRQ thread
quickspi_irq_thread_handler()
   try_recover()
      reset_tic()

Can this corrupt the device state and cause both threads to wait on the same
reset_ack_wq?

> =20
> -	ret =3D thc_dma_configure(qsdev->thc_hw);
> +	/* The TIC may lose power across system suspend, reset it to recover */
> +	ret =3D reset_tic(qsdev);

[Severity: High]
This isn't a bug introduced by this patch, but since reset_tic() is now
used in the primary system resume path, is it safe for it to use
wait_event_interruptible_timeout() internally?

System resume callbacks are often executed by a user-space process which
might have a pending signal from the task freeze phase. If
wait_event_interruptible_timeout() aborts immediately and returns
-ERESTARTSYS, won't reset_tic() fail with -ETIMEDOUT and completely abort
the device resume?

>  	if (ret)
>  		return ret;
> =20
> -	ret =3D thc_interrupt_quiesce(qsdev->thc_hw, false);
> +	ret =3D thc_dma_configure(qsdev->thc_hw);
>  	if (ret)
>  		return ret;
> =20
> -	if (!device_may_wakeup(qsdev->dev))
> -		return quickspi_set_power(qsdev, HIDSPI_ON);

[Severity: High]
Does unconditionally calling reset_tic() here break Wake-on-Touch for
platforms that don't lose power?

Previously, this function had a check to avoid disturbing a wake-enabled
device:

-       if (!device_may_wakeup(qsdev->dev))
-               return quickspi_set_power(qsdev, HIDSPI_ON);

Will a hard reset wipe the internal buffers of the touch controller before
the OS can fetch the wake-triggering touch event, resulting in permanently
lost events?

> +	thc_ltr_config(qsdev->thc_hw,
> +		       qsdev->active_ltr_val,
> +		       qsdev->low_power_ltr_val);
> +
> +	thc_change_ltr_mode(qsdev->thc_hw, THC_LTR_MODE_ACTIVE);
> +
> +	qsdev->state =3D QUICKSPI_ENABLED;
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260529222210.1532=
876-1-d3z.the.dev@gmail.com?part=3D1
