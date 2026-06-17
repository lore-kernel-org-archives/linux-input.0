Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFAD2FC037;
	Wed, 17 Jun 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713473; cv=none; b=gK1fsr1dC0IFvncpZOrYen4blBHaaGBccZrMvtWqSt56vRY2UbFeyZ7jJ2eBh/fj6PFXjEgwOk2FMBeyOK/d9H1zM0eunLWDFLFI/yQNe3pNfEA2nSmmqMkI6GrX1JH1YEjloWHh2A6OJp0PF+4Bmh7sYj26EvVz+SrpM9U4Tsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713473; c=relaxed/simple;
	bh=mM7e4pUEYwpCAwKLDizk/My/Z3nudAR2xIFn9XI/ue4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVJKWELl56jVYQ92zsrwIZyRICYU80KpCrOQbXXp+jmQPiD/AN8LY2S+MLJGK5Jo+5aTE0bOsAz83YI5TS6Vm6qvYbSlrYCwm54LGAk5/mMuixxKIpyAkrchyPc7Rtp4VJTrGbTMF6x3kgb3TY87y7rKHsd2piI/rmCI7X2Q8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2852nhL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2852nhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2763F1F000E9;
	Wed, 17 Jun 2026 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781713468;
	bh=8PRfeD0WaNjlPOD2pwDR8qkAru+d4JXzyqGIdifb2/E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P2852nhLPL8fwSorEL5mzDTSCerB1B9WU4SgYQRU826mWSX5aU6IfYMGMf5x3pBVK
	 2VDFOLVCuw1bCjXazlfqZ754dlZsB/KwhVG/wkJ8F9nxOxC7BP2CpUTwkKH0OsQKiN
	 TlG9C/3gfJuoCHeVPLH3zRpFdaRfEga6YUwjX/VsMI28wcO3pZuXlWonTxOlSt4Fuo
	 71n5U1MoPSPu9GhKdxCnMfAJd2p0yga+ffBDs6vKmsBwQ/tKhoWLOWrMEdywvZGDGX
	 nE1Dqu1wys7Hzl0dz3ujmcKC5ayu26sU0SFLKtgGcPuCdWFmNnBOXd0E2EMMLnNbv5
	 7uSbyUjXOvHHg==
Message-ID: <2e364a41-3726-4570-80f6-f702c240a2f3@kernel.org>
Date: Wed, 17 Jun 2026 18:24:24 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hid-lg-g15: possible use-after-free of devm data via work
 scheduled from a report
To: Maoyi Xie <maoyixie.tju@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <178169820506.2930960.12219303668828186338@maoyixie.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <178169820506.2930960.12219303668828186338@maoyixie.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 17-Jun-26 14:10, Maoyi Xie wrote:
> Hi all,
> 
> I think the lg-g15 driver can read freed memory on disconnect. I would
> appreciate it if you could check my reading before I send a patch.
> 
> The per device state is allocated with devm in lg_g15_probe().
> 
> 	g15 = devm_kzalloc(&hdev->dev, sizeof(*g15), GFP_KERNEL);
> 
> That struct contains a work item, and the report handlers schedule it
> straight from device input. For example in lg_g15_event().
> 
> 	/* Backlight cycle button pressed? */
> 	if (data[1] & 0x80)
> 		schedule_work(&g15->work);
> 
> The same schedule_work(&g15->work) call also runs in lg_g15_v2_event() and
> lg_g510_leds_event(). The worker lg_g15_leds_changed_work() does a
> container_of() back to g15 and dereferences g15->mutex and g15->leds.
> 
> The driver has a probe but no remove callback, and there is no
> cancel_work_sync() anywhere in the file. So if a report schedules the work
> and the keyboard is then removed, devm frees g15 while the work is still
> pending or running, and the worker touches the freed object.
> 
> The attacker model is a Logitech G15 class keyboard that sends one report
> with the backlight cycle bit set and then disconnects. That can be a
> malicious device or an unlucky unplug.
> 
> I reproduced the freed while pending pattern under KASAN on 7.1-rc7. The
> workqueue picked up the orphaned work after the object was freed, and KASAN
> reported a slab-use-after-free read.
> 
> The fix I tried is a small remove callback that cancels the work before the
> devm teardown frees g15.
> 
> 	static void lg_g15_remove(struct hid_device *hdev)
> 	{
> 		struct lg_g15_data *g15 = hid_get_drvdata(hdev);
> 
> 		if (g15)
> 			cancel_work_sync(&g15->work);
> 
> 		hid_hw_stop(hdev);
> 	}
> 
> and wiring it up with .remove = lg_g15_remove. The g15 NULL guard mirrors the
> existing check in lg_g15_raw_event().
> 
> Does this look like a real issue to you, and is the remove plus
> cancel_work_sync the approach you would want? If so I am happy to send a
> proper patch with a Fixes tag against 97b741aba918.

Thank you for reporting this. Yes this looks like a real issue (possible race
on device unplug).

As for your suggested solution, that looks good but g15->work is not always
initialized. For example in the g15->model == G13 case lg_g15_probe() does
not initialize it.

I don't think you should cancel an uninitialized work. Trying to queue it
will cause a WARN() backtrace to trigger, not sure if cancel also enforces
this.

So you should add a test for `g15->work.func != NULL` or just `g15->work.func`
before cancelling.

With that fixed, a proper patch fixing this would be much appreciated.

Regards,

Hans





