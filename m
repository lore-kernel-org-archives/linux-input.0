Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC843DA5A8;
	Mon, 29 Jun 2026 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722669; cv=none; b=XhIN8Orbt92AMLnR07grt76VWQmkICD0mDJ430iiA5PMfJAtwbD1lcmJBp15nEykMD2hVFyhoZozQnIQDQlVpB+kUWfNxKj2jabRlXssfnPjesLyUQkGHwwIu6sqgj44IDTBeOlG911egXFhh/5Ij4/4fvs9OS4v5PLXi3+Zj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722669; c=relaxed/simple;
	bh=8sY948dw5+NQY+Z2SvepMQraB4yaZYhfW6aVI59k8w0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BMSuoRJ+zL+fCxl5crbXM8AMqSWihae3gJZQdSsFZZC2pFfe2BSOx27RJqFFQnFeGiJk7+tOD0K6ip+h3j/Kvu+8qumIgFtjPj61gbgFbLlISSHdDwS/I6d8Y1NoAHM8fI0tiRIdhA7f+HyYoBqWvvHPX9H2WaJ/YaWQBLhsjb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIA0z3FW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIA0z3FW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59191F000E9;
	Mon, 29 Jun 2026 08:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782722668;
	bh=fh7z5jCnuq19o75kzk8OXojwAnv5rzZaHy2dWcz5Zx8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GIA0z3FWhPorPo2fFRFfWSh58zYqTbatKLD3fVJx4wsQERfNducCj3VtJaMRkG+bj
	 1/1Tg75/2GexyMi3i4z8EB23HnzipwcumZ0qg+CfzItvmB8u2bXxyCeniB5N1DYBBS
	 wlsHxMV/Vo7y9AJd2MrcpoiYLaGQWGinWcv3901hOu6/NcmlvmF521BZZgSO4daFSR
	 2BJo/YOa8BM7Ioe+ocOmeEGYQKgh5tE2aVfy7mSgKtsXxxoWcCpbundXjH7OIMcoJ0
	 RFwQt0avJog4P3afGEn+jyiPQ8YBE53IF6jgADytZvyu54TaKj9OufEXIFnoOiG0PG
	 flzrLbsHrMC5w==
Date: Mon, 29 Jun 2026 10:44:25 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Manish Khadka <maskmemanish@gmail.com>
cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: appleir: fix UAF on pending key_up_timer in
 remove()
In-Reply-To: <20260515173252.77757-1-maskmemanish@gmail.com>
Message-ID: <0s652np0-522r-s11r-p4sp-n54r55952382@xreary.bet>
References: <20260515160218.4D39EC2BCB0@smtp.kernel.org> <20260515173252.77757-1-maskmemanish@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 May 2026, Manish Khadka wrote:

> appleir_remove() runs hid_hw_stop() before timer_delete_sync().
> hid_hw_stop() synchronously unregisters the HID input device via
> hid_disconnect() -> hidinput_disconnect() -> input_unregister_device(),
> which drops the last reference and frees the underlying input_dev when
> no userspace handle holds it open.
> 
> key_up_tick() reads appleir->input_dev and calls input_report_key() /
> input_sync() on it.  The timer is armed from appleir_raw_event() with
> a HZ/8 (~125 ms) timeout on every keydown and key-repeat report.  If a
> key was pressed shortly before the device is disconnected, the timer
> can fire after hid_hw_stop() has freed input_dev but before the
> teardown drains it.
> 
> A simple reorder is not sufficient.  Putting the timer drain first
> still leaves a window where a USB URB completion (raw_event) running
> during hid_hw_stop() can call mod_timer() and re-arm the timer, which
> then fires after hidinput_disconnect() has freed input_dev.  The same
> URB-completion window also lets raw_event() reach key_up(), key_down()
> and battery_flat() directly, all of which dereference
> appleir->input_dev.
> 
> Introduce a 'removing' flag on struct appleir, gated by the existing
> spinlock.  appleir_remove() sets the flag under the lock and then
> shuts down the timer with timer_shutdown_sync(), which both drains any
> in-flight callback and permanently disables further mod_timer() calls.
> appleir_raw_event() and key_up_tick() bail out early if the flag is
> set, so no path can arm or run the timer, or dereference
> appleir->input_dev, after remove() has started tearing down.
> 
> The keyrepeat and flatbattery branches of appleir_raw_event()
> previously called into the input layer without holding the spinlock;
> take it now so the flag check is well-defined.  This incidentally
> closes a pre-existing read-side race on appleir->current_key in the
> keyrepeat branch.
> 
> This bug is structurally a sibling of commit 4db2af929279 ("HID:
> appletb-kbd: fix UAF in inactivity-timer cleanup path") and has been
> present since the driver was introduced.
> 
> Fixes: 9a4a5574ce42 ("HID: appleir: add support for Apple ir devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Manish Khadka <maskmemanish@gmail.com>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

