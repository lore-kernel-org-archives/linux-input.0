Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465544;
	b=Me3BjVUMRgjVTWT0sM85JGHhBhL3sToqQOWXhxvjYHFQJydLpqXStPWqbrN3cEFeiSmk
	 FyKfo2jovgQ6IsatKBCG2QhoThD4lRj8wc6k/nlTYuDjD/KX4bykM3z7gWSzApf0YKXjD
	 28x5lmLMGyCPP2ilTrkJgI+YsYSOOltFKkTGBwcJ3C+ds8B5XX35zSPghHa/jnkSJjrx7
	 uyd1eChKbFhoeEZ3NO/2ybqgPmxaUzruYW0Z8q7vfP1GDd+ef66jntsEcUxUlF4XYgspV
	 GKIX7DY1LgEcn2Trw23Nrowsi5IM4jV2WzWkRbtN9g6bwJKgRVmSeMt3E5xP3bNFphQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=htaRIjRweiLZjcs4Tzl0zEgyIU7UNaepRLCTi+oWXpM=;
	b=jGA7hFxEUMF7UEWM3yuZbeEEap48jgpDZrKzuBMvr5tJ88WojPtG8HHpFf+iKGqdwKB1
	 j/B/tTj1T8RgnZCEzarpmfQNyWwc2EzSC+8pusMnDVkGALzASgHCdL+GvAm0NHffyFIIi
	 xRGcu88OgXAcNpKKmb/1X5m7/aB/S8b0I+M4ewreJlCHsEpnUOm1DVyIzUXQ1WfAz+d2C
	 BS1SkRYbPiFMbWm7vpyblWNo8kcjHOoHAi46CPC3Kr51Q9Qjrao475ouOriW7Dx+oEIew
	 BJi1zdC/++3Ps6ORKQLRA+J3rBwxiwU7ut7wsA0xKO9h/lOsRp8Fkg+SNlHBJisckyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGoQEP38;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E7606A326
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 20:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC6E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LGoQEP38
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38644aedba1so5668570eec.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795465543; x=1796070343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=htaRIjRweiLZjcs4Tzl0zEgyIU7UNaepRLCTi+oWXpM=;
        b=LGoQEP38QC3mznKKpYLgQAySy0alTcR0n0d7eNlMT3FTZ1BpQLcmGokdl0DN0D4DEi
         47ol5mg9dX4fE+VZWjDPKzH2w00w48XuQmGfvKWD30EwXq4wBxe2OswhF+w8cYXN8Yvh
         GXWkJ4OuH/HOLmkq91vhcZdPy2oROb6p1SQsZzZC49xdJZVUd0doiVxlS2wNVTRB1Zf1
         swaGUIsQ4cEvd35wpIMB3iECKpLwpiSKr8ymAleMNompx+7dgzkqhjVtbNdU7D1+KLbS
         4UqVK2cEA/Gnqkl6pXK7FD3rEANBEflkhlpTtkxAXmeEQWmOIp72hjpMQ1KC9MFWoxje
         HGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465543; x=1796070343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=htaRIjRweiLZjcs4Tzl0zEgyIU7UNaepRLCTi+oWXpM=;
        b=R4PzOqd+sBXsMrYQ6l0F17oPnB09KNDH7QJMlasb3WGsJJ/vjge8ast5trcAPqwCgW
         Zw4XnvU0OuMxjmzZjaVCLjoT9xrvdw9NDTI0RdpJhXj6HRvmI4qOZnhP/EPCm172MlAs
         C6MhsgjM2/n4/9njmoV4FD/LuO4pon5EfwSN7Q+cQCVB/Org7vH6REcib/uFu+GF1rSj
         YtjRzbR3NdroS5klM1+9XMVeFzi0zbrDrDEClcG0rqFqyccWJvgYmdW0NjqYevtazCWl
         OXI+0D1tpg2f7hDjVBxIjnW7HS3MlXn69zwuDArwt2bL3bLFKqNt2O9i/faTNhKyAoVu
         TOJg==
X-Forwarded-Encrypted: i=1; AL+hErFJ8VdI7oxJfff03Lhb7zOFblxPPAmyWO7OadtwMXCE6CwHqkXkNWsYjibABZlE8SgQJhePI29rhD7oKw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/8cDrRShd9b8zd1MwSdlLle3mohi/CCzpo/NAItT0EEQpEkKUQ
	YfPgnOlgDXq/pjYdTchwF6+Op+mzKDl3vCnZfnledtAWCiAj7CuEiX9N
X-Gm-Gg: AZFdTZemRCJ+6WMjrDOsY6C9zi1rOvmzlBkVqSY5nS3510TJsVyLta+KA7GusaXTKwk
	hA0kIqJQ/xj/ZD9TVMr7BijRME7hhaVK/H9WWANJMgDhLkAJ2qQrJ3B9AEh+H5RjHnVYmpgQNru
	GCEpU9CObVuhL9iuhiDwqJ2zZJfqwHlhBJVCVnC1KiG5csRDU6+JIliSu17K8FJKbUeEW8mYzUR
	lr8pgWoYIRo2YZKZFqvWSLBD4ZSmmNKlKlQJkrKjavjfNVPgMtm88yC90DSaDWRZ2NlB7McX6pT
	JyvH0VoEnO9Pu2FoG6XYl1VEYPOFZSph5fElUU2L0tyt1SxMspy+zDqeW9hIdt3mD0PedEe119Y
	AMWX0R4+Vs6YLzW3HqeAAJoYKgWahrJpTyn8xXUwsIHhTrvfnPE120BoaY7tO+kMWfmHsvmlfT5
	HsXMAURFtZjkdPoj+YPsaEVFtQzbqcXgx8iKEpjCqr0SUTPfG7Y20ZNce+ohSn0/T+XbjLWoN7B
	ve9AWO0bBDuiPgI+4B3UzWm4T+cVm+RkuD4zHEoerM866EVmcyIEGCLK8ODj23St1NJl3djpRvk
	2AbPGqlhJLKkJBcUev1FSNzR1z9YtrGxOfHUgqbzYBVSSDsWP79FpCIoKm7JzK8lwkf3MOqenwP
	0yw328e6d0wo/zirb
X-Received: by 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id 5a478bee46e88-38570c36e7cmr11463927eec.37.1795465542635;
        Mon, 23 Nov 2026 12:25:42 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd46c5sm46389898eec.11.2026.11.23.12.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:25:40 -0800 (PST)
Date: Mon, 23 Nov 2026 12:25:37 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 09/10] Input: pinephone-keyboard - request IRQ before
 registering input device
Message-ID: <awShPfjuvVjlw-Kj@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-10-lee@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261123183200.3900004-10-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:15PM +0000, Lee Jones wrote:
> ppkb_probe() registers ppkb->input before installing its threaded
> interrupt handler with devm_request_threaded_irq().
> 
> As soon as input_register_device() exposes the keyboard (including
> synchronous open by the console keyboard handler), ppkb_open() enables
> matrix scanning.  If a key is held during this window, the controller
> asserts its level-triggered interrupt line before the handler is
> registered, causing the kernel to disable the unhandled IRQ.  In
> addition, devres unwinds in reverse order on unbind, freeing the IRQ
> handler before input unregistration invokes ppkb_close() to disable
> scanning.
> 
> Request the threaded IRQ before calling input_register_device() so the
> handler is in place before scanning can be enabled and outlives input
> unregistration on teardown.
> 
> Fixes: 17406967ec0f ("Input: pinephone-keyboard - add PinePhone keyboard driver")
> Closes: https://sashiko.dev/#/bug/linux-f24d8390-cd48-42d7-a3ea-c075b69c127a
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Applied, thank you.

-- 
Dmitry
