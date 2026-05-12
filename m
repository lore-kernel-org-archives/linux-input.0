Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585213C1F37
	for <linux-input@vger.kernel.org>; Tue, 12 May 2026 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600171; cv=none; b=JrZHh1sgE92jT1ZGVgNDa6rgLXmP+LV//nicopnD9bFA5fevhnYKbYN2YXVV/T63W36MziZLRDM+lFSL6LdpEOPFnpXVqd/ZLWWwO8KbpPYZj3owy/16C9JmiIUnn06xj8pz1uqx60UZ/QnpQNoJbEDzUeOBHUTaJwsCIl/xrxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600171; c=relaxed/simple;
	bh=L/VKjxMV4W5c+C3JyoVcTY1wMBlvKq0zKd18OsnmOJY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qJmu+KXd1ZIDCnRPF7nkOAtvux5uSF0tapTHLLA2+WStw0F7QP1oCX4jjKPAloNrN6dmtbnye66W4SUldrQ5uor+ZyEiaL4CCDukVbDqJLM3QQ0L88/xTIe1uVzedZnLZO/+xWgPrZbq+X+FnwFL1d8M4SDMj2gClJFu6hDIwgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVeC++JP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVeC++JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1665C2BCB0;
	Tue, 12 May 2026 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778600171;
	bh=L/VKjxMV4W5c+C3JyoVcTY1wMBlvKq0zKd18OsnmOJY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=lVeC++JPozaJDGx28kiivEfgpERgxIIYgUwgiWJOiGlYOse1wOmkWhMc3mAlwk47P
	 rSjVE4O0JUa3gzkmQ+v1hEY6woezzZtMZwPLDxbk1huxNITxiW3nOKzg4xsQpVwMfa
	 XVb146W2fqrwt55wMGw6+OFK1gDFOTsYB7rsSwsNVZP1ZRMcKTjYuBq5LM/0W/uQMH
	 tSM+J7MMpsHP2XXQ58vK9q2m83jP9HlxrQZtd9F4PpMl6mH9Kh4/onUXGHIWto2wrh
	 DqPI6/8r7riCKxyiBkkUlLWbBRT0R4UpCRKERlXvq6uqjrAlikUtHJdvhmcKRTY9IQ
	 +FLdVRzsmS48w==
Date: Tue, 12 May 2026 17:36:08 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitri Ollari <dmitri.ollari@protonmail.com>
cc: linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: magicmouse: enable battery polling for 2024 Magic
 Trackpad
In-Reply-To: <20260411163806.35759-1-dmitri.ollari@protonmail.com>
Message-ID: <rs9pnn54-1551-121n-24s9-o8ppss96o755@xreary.bet>
References: <20260411163806.35759-1-dmitri.ollari@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 11 Apr 2026, Dmitri Ollari wrote:

> The 2024 Magic Trackpad USB-C (PID 0x0324) does not report battery
> strength via HID descriptor fields over Bluetooth. Instead it requires
> an explicit HID_REQ_GET_REPORT request to retrieve the battery level.
> 
> This patch makes the following changes:
> 
> 1. Replace the battery_timer (timer_list) with battery_work (delayed_work)
>    so that HID_REQ_GET_REPORT can be issued from a sleepable context.
>    Timers run in atomic context and cannot block, which caused deadlocks
>    on the Bluetooth transport path.
> 
> 2. Extend the fetch guard and probe scheduling block to include the 2024
>    Magic Trackpad USB-C when connected over Bluetooth (vendor 0x004C,
>    product 0x0324 via BT_VENDOR_ID_APPLE).
> 
> 3. Schedule battery_work immediately at probe (delay=0) instead of
>    issuing a direct magicmouse_fetch_battery() call. The direct call
>    bypassed the cold-start correction logic and could publish a stale
>    value before the work handler had a chance to validate it.
> 
> 4. Add a cold-start
>  double-poll: the device may return a stale battery
>    value (e.g. 4%) on the very first GET_REPORT after power-on. On the
>    first successful poll battery_validated is set and a second poll is
>    scheduled 3 seconds later to obtain the real value. Subsequent polls
>    use the normal 60-second interval.
> 
> 5. Remove the early-return guard that skipped polling when
>    battery_capacity equalled battery_max. This prevented the second
>    corrective poll from firing when the first stale response happened
>    to equal 100.
> 
> Signed-off-by: Dmitri Ollari <dmitri.ollari@protonmail.com>

Dmitri,

thanks for the patch.

It has however been badly line-wrapped and whitespace-damaged by your mail 
client.
Can you please look into fixing it and resubmit?

Thanks,

-- 
Jiri Kosina
SUSE Labs

