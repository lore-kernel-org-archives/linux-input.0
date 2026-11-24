Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795483706;
	b=GCqCIDlim0XdY6cmLiScRfeYN6lq3gnk2gFOT1I+XkWGD+IPIQtsrFeU6Lsq/7si++Xt
	 /KT/d9El7vp2xnQLqVsjHSLNZEGhbQ+tZJzbUVFmIo6uKUwVJOnEa+6rN7z/7t9C2asjd
	 hsfz/5MyZhQdSzRDTouAfyY0+arBiD2v+RMVH1ZYQTFf6dxZyfwPgTOgiptIZuceTPVW7
	 p/4apL05ApsaNl8CT3+JIZ2eHO6jZOE8Vn4y9qTSpyKbgtFPf8azTol9Z2Fyd5MxPVVto
	 P0HFZyY2Uf2VCcgSgHcYil4GU4UYeAti5BZggvlRxQ/pRipnT2v0gCwLVUzJrD0meeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795483706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=IqUna2kjFHvMrIO1OLa0ykP6eHWf+y9XmdVhagHZuFA=;
	b=y8fg9S392dviod/gaVOfCKEqLYRmm7AiaePopIBK0OUXsju5yAX1ITA6Lq0X0U5/LE2V
	 4/0gRhU6q5ezUxNLuNOyeMNjfttu8f1w31oNecxjg5t8tLz4MUVcXMZZf7sbFvWE40ujJ
	 aBThaNtINn632lz+z9RJfD6kggGW6+WhuAp/6NuU4n93m8O3gyOUfngXLyKsyymVGWaLu
	 TTKe6hm+VBpmxQzkI3O6bclHBaArUyVyf/dnHTsWnANMBnmCRrNOYBq0Up3YhZt19dU/o
	 QvFDIgflRDYp6CQ1F/AWqKWoiij+KtG8MuXhw7m8Nhu4A/iq8dpv0p3zCUs20Bbs9LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muDl+jhc;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80553606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 01:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80553606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=muDl+jhc
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3ada81853so4566812c88.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 17:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795483706; x=1796088506; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IqUna2kjFHvMrIO1OLa0ykP6eHWf+y9XmdVhagHZuFA=;
        b=muDl+jhcQiYfn6XCWnNAla5FGzr50gZWXWL0cAb2YlZP3RtU+V7fpngMFhyrAdvs3X
         /si1j1peUcZf/Q4j1Ky1wqmRsNN/6Ge/pGnDuB0Wb9xN7Wl6d+JFaQKMNoLRbdFrdeTi
         dOIKXzyvkRsPNZDfjBstBqczObYyj0j4syH7MokVEJwpQphJZQByJVR/pwMuBnsTcnL5
         6TXWhnKg6Ri9sZ8+orR0ozhAE//kcOdJIcxi98EqUfqQqngYg6/YAtO2gL9xr+mzIh4R
         BqadFhFMoGKnijJF8XoPNP8r8/RmtVMhPztG7I2boitz2LxnIRskqUqcw5CbacNWElaD
         Z8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795483706; x=1796088506;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IqUna2kjFHvMrIO1OLa0ykP6eHWf+y9XmdVhagHZuFA=;
        b=Sr+HaX2Qe3TKsWYMSnGpyQGACy5IfHqkyYFBEOZHT7Kv584G38kjKlaVMXDVdZAfk8
         prVFtO81aprHEumZ+fWpKcml/hPZKzQ7am55XSexCoQLwl+I06hmEyqU7zJsD79IKpEw
         vuakwe7LCOF86gvLR729FaUgujxHtny8/nfOTIQkvy8M/wnbVU2S1enszl7DN0HzOwoK
         XGdON5t/IuDxwIH6alzxuywxeERXpBgIW8+TpzUNc5k1jhnm2vnzsKc2ydiy5vSZVXDS
         nDxbA/7euNb47Lso2asLhwQKb+mRiUgHLY/CTgNkSElkjDiz1owt3zzq1p/kV7Pk5TwP
         Jq/g==
X-Gm-Message-State: APuU4Z+HbPvf/r7hyR8DULpQDwd45CsjGP+sHP2BylCuzSYCHWx0bKIq
	+izXYP4mqO65QgEEaQP3FtErCIhiNHbzo34oj7q038y4Ej5Jf5fVz9Hv
X-Gm-Gg: AZFdTZcuNgQ3TfgXlET+6TmBytpzNasj5j/brYysMAIDrv225J/cr9rk7tA0nJXRSJv
	IVu1GmtLQuUMB2JeYdhs0ouDXWIRdQ1Vho0iAB9HfjHYLLeUHBMhpznGXVmkxejTzPBnKCJ25A7
	2bmjulkfzVHTjt7Lo1bc4LXHcu/aSxxxGh40gUh9tfhrATEqxJdVmyHYUp88/OTgV4KeuNSFWzO
	vkBGiBdJEGtD2+jdvZvMa66VIXOB7mgg+Poa/vs+kbwBBjo5jxNtE4FYUESzb0MjTtSJ0sWmVGr
	uvRACM920CGkbbQrTx3gcBcZGu4Xnm38yv74I7bwCLwo2zpnExHU2nfjTAKJNt/XUiBfeGCiS7q
	B+rDA+kcs8bi6aqJzgcNMWq7osIqCJYCDchk8bifxJrXu5A3RN6iDaatW3sa6l4IKALXRqGvLmm
	HBZzLGxSAx6LAx0fFph/AEx/kDhuLk+sgFO54QxxMAqUg5VC8D1LH1SSOrTQSciAB7KDUQseTGr
	iT4fjZN8c2RMlsjMog4MdrokD0zqCmCBdhrzCc1U+tbad8p0Ob44t8Qy0GWX4W5+YIagjf6RM97
	coYJNxRFkewEqjBEHIdPEAwtyYnbZzL/AMG6hY+Gf6lWGTj/QhBo0THJMo3hhq5MQo75xA==
X-Received: by 2002:a05:7022:5e09:b0:1a0:b8f5:872d with SMTP id a92af1059eb24-1b5567c13a5mr12621491c88.4.1795483705400;
        Mon, 23 Nov 2026 17:28:25 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c3052sm31126403c88.1.2026.11.23.17.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:28:24 -0800 (PST)
Date: Mon, 23 Nov 2026 17:28:23 -0800
Message-ID: <84b917b9feb4a934e67d0e8f25707cc1@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: ahmad baghereslami <ahmad.b1995@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Input: synaptics - support the touchpad LED on RMI function $30
In-Reply-To: <20261116071906.30110-1-ahmad.b1995@gmail.com>
References: <7f9d0adf1f49c5a2b3919130caf0acb7@gmail.com> <20261116071906.30110-1-ahmad.b1995@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Ahmad,

On Mon, Nov 16, 2026 at 10:49:06AM +0330, ahmad baghereslami wrote:
...
> The reason I kept it on PS/2 is a side effect on this laptop: the
> embedded controller turns the keyboard backlight back on when it sees
> PS/2 input after the backlight has timed out. Over SMBus the touchpad's
> traffic no longer passes through the EC, so touching the touchpad no
> longer wakes the keyboard backlight; only typing does. Nothing else
> differed in daily use.
>
> If you still prefer the RMI4 route, I can send a series that adds
> "SYN3040" to smbus_pnp_ids[] and implements LED class support in
> rmi_f30.c, and drop the PS/2 backdoor. Or, if the backlight behaviour
> is a reason to keep this touchpad on PS/2, I would keep the current
> approach. Which would you prefer?

I would definitely prefer the RMI4 route: adding "SYN3040" to
smbus_pnp_ids[] and implementing LED class support in rmi_f30.c.

We already enable InterTouch on several other HP laptops in
smbus_pnp_ids[], and implementing F30 LED support in rmi_f30.c benefits
all RMI4 touchpads (over SMBus, I2C, SPI, or HID) without duplicating
RMI4 PDT scanning and register access over the PS/2 command backdoor or
having to deactivate the PS/2 stream and export psmouse_mutex on every
LED update.

Keyboard backlight management should be handled separately from the
touchpad transport: relying on the EC snooping legacy PS/2 traffic is
just an incidental side effect (an external USB/Bluetooth mouse or an
I2C-HID touchpad already bypasses the EC in the same way). Ideally the
keyboard backlight is exposed as a standard LED class device by the HP
platform driver (hp-wmi) and managed by userspace policy monitoring
input activity, or (if an in-kernel mechanism is desired) driven by
ledtrig-input-events (the "input-events" LED trigger) or an input
observer in the platform driver.

Thanks.

-- 
Dmitry
