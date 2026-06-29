Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968833F660E;
	Mon, 29 Jun 2026 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722619; cv=none; b=fcmp/MowfumoaUSuSkJgbkNYlm3q5aSzPt18ymSa1xVO0K6ZDr3nLUzuvRO7Asz2T0OThTzSUHSTakj6Kg0pcUXbw/35IGh1WUd1qQe0IdCHwP6GDHguT8awJKNUkBsvr0YqG1VFAfZSswmIstUuWSnSyLqmK3zdZr1cSTOF3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722619; c=relaxed/simple;
	bh=V3Y+pjznqNTWp2nOluAcCZvvK+lhVbhY24Px/m0H+/Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KjmvGsQKae0rMENJDIlpMR37IlsEkbvjTItx2RThRYOScDz6w/V5MFIuoGLN0uNpYHTlOGIOCz+L6P5IHKz7tfrEjveNUaKQu5569BoPitBPrOa8leWJyotQyrUR+DjZ2NZ1l+h5PqKU0Y85arDhfY8pNwW4jQAbavIRQMMzMPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUBECE7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUBECE7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32BB1F000E9;
	Mon, 29 Jun 2026 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782722617;
	bh=af5o0Wo9E+lxGSHD9ekQ2p0DXrtqndt6rSuYe2jfLFs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=TUBECE7K90HyG6XyBKl6WOkI4HmBlwaa3P1JH8Tlrqyn3M5qztn5lbVd4UcJb6Vfq
	 YpIpI0xG3sBIJarT4QziUuWWK0D3AMbdxZr1vSPK1zoWOvzv8b44iZLPDx6z1shcf4
	 mAPeQphuDWrnXW3YrOctPmkngZiX+OK6IOt4hjnq9gsjsmn2EqLqQs3n++FQ3Qv3cr
	 GakFy/pJ5nEMxt/S4iFit2V/Pnr6X7KU0/kMl4hnzkAqrKfSoBZ0bfRRpzYTDb0x51
	 /w9kmN/kl6YpMZSYh9af8DB9sNbB4m20zxbYx+X1fenm2+vFG/M5Hl4b1KULVSTI3E
	 HOfSJpB9llkiQ==
Date: Mon, 29 Jun 2026 10:43:34 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Manish Khadka <maskmemanish@gmail.com>
cc: linux-input@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: letsketch: fix UAF on inrange_timer at driver
 unbind
In-Reply-To: <20260515164200.77039-1-maskmemanish@gmail.com>
Message-ID: <s02920o0-rq04-31pp-960o-868n59s0q52p@xreary.bet>
References: <20260515155838.B4247C2BCB3@smtp.kernel.org> <20260515164200.77039-1-maskmemanish@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 May 2026, Manish Khadka wrote:

> letsketch_driver does not provide a .remove callback, but
> letsketch_probe() arms a per-device timer:
> 
>     timer_setup(&data->inrange_timer, letsketch_inrange_timeout, 0);
> 
> The timer is re-armed from letsketch_raw_event() with a 100 ms
> timeout on every pen-in-range report, and its callback dereferences
> data->input_tablet to deliver a synthetic BTN_TOOL_PEN release.
> 
> letsketch_data is allocated with devm_kzalloc(), and its input_dev
> fields are devm-allocated via letsketch_setup_input_tablet().  On
> device unbind (USB unplug or rmmod), the HID core runs its default
> teardown and devm cleanup frees both letsketch_data and the input
> devices.  Because no .remove callback exists, nothing drains the
> timer first: if raw_event armed it within ~100 ms of the unbind,
> the pending timer fires on freed memory.  This is a UAF read of
> data and of data->input_tablet, followed by input_report_key() /
> input_sync() into the freed input_dev.
> 
> The same problem can occur on the probe error path: if
> hid_hw_start() enabled I/O on an always-poll-quirk device and then
> failed, raw_event may have armed the timer before devm releases
> data.
> 
> Fix by adding a .remove callback that calls hid_hw_stop() first.
> hid_hw_stop() synchronously kills the URBs that deliver raw_event(),
> so once it returns no path can re-arm the timer.  timer_shutdown_sync()
> then drains any in-flight callback and permanently disables further
> mod_timer() calls.  Apply the same timer_shutdown_sync() in the probe
> error path so the timer is guaranteed not to outlive data.
> 
> Fixes: 33a5c2793451 ("HID: Add new Letsketch tablet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manish Khadka <maskmemanish@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

