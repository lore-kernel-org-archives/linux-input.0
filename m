Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119897;
	b=gLkQVjEHW0axArG2u6LTHii6U9DsD30/2/iKgQ2mgYKmMMmzfLkl71YOVI0WeQbELvRj
	 Ho47DeStQ8UYrMk8V8XbYw+JbUhlQuXq03sWVsQlIU1Sv+MyqA/WkyZrOirK3gI4zMAzQ
	 bD+ZYj45crYVxjg+gimwBfL1c6j7jZZ1+bAnL70uUhjPCy9Tttl1fsZykgP9hS2WIatJ2
	 TpTxvoDDSzjs+ZBTEBOqFKpmVuXa562fiz0Rl/1kN5UVJ61ncYdPatyM4MhEz/KWSZhog
	 G6MoMky59DHU4Zcz6wJTy46tkAE5jywGZn7Zl6jML7HEsrM25g/5tJiv1hTBJ/o9Xlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119897;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=iH9eWAh6qoDp+Ns4AVrRbkCgSY9ayYyfQqAcKbxxxDk=;
	b=SBzwfkh8I1saFM9GPw38kvqkgydoklI5lxrAZXXZAn/XXfEXqYQJnlSJam8jKdBsRk0J
	 dSWbh1QL1b1/vWT9UTVAr7tAhspFqr565GV/XIBB3bIvTjyWUkvXzbm2CAmd7dPCEbOVg
	 7fgHCgXYYyHuPvCVjNq9BN7K41NnG7e2bvT4q2+zvkoPraI7SjLvQOP3oFykthRIYa12/
	 47qcT0VP/4LWWGjy8zd3Z8G90zoRKp2lmAk0j2hPSdSOIpD6g8YS7C+t8qGKO1soc73L3
	 NQyW9rQwAAuDDKjSgBkHds5S9t1ijY+eCsT2qBZVUZoSjWNxYk+B/2X7rrv+T/h7qyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SB+WR4j9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D30606A325;
	Thu, 19 Nov 2026 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SB+WR4j9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9EB1F000D0;
	Thu, 19 Nov 2026 20:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119896;
	bh=iH9eWAh6qoDp+Ns4AVrRbkCgSY9ayYyfQqAcKbxxxDk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=SB+WR4j9BDtL0MxJYWRi/hgBj/LMLk8X6h3zIQD/b4RZDVIBIhga5WrRExmTyCIeI
	 vVNn9RMLe0riI6bWZh0KxxChHpjUd0PzRNZ0uETLOTEtzBhpTlXQaVgj0NWbQmbq0Z
	 Nani0wZTBzbUkbSaNbwmQQ1t7QUYmcMgqaZw12jIrrWpVQGIqY1gLE0VDcz7fZAL1t
	 f7pC0vKtHCrbTSDRwGWVMV78Y8sStbY7cduXWhHEreM4O//Vv8RiZVqRh1XBsWI41M
	 EzVQaKNnWZGdCuja7vyLpGyC6xiheGs0C7M/kXfp5cYJkt7ebP5CMM4oYsDSNKjW0l
	 QN+AX9hIOeRHw==
Date: Thu, 19 Nov 2026 21:24:54 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
cc: Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>, 
    Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Myeonghun Pak <mhun512@gmail.com>, 
    Sashiko AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH] HID: wacom: Cancel init_work when probe fails after
 scheduling it
In-Reply-To: <PAXP251MB001050EFD88752318EBA75F5C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
Message-ID: <0291r4so-4p5q-61n5-59qq-761s5s45o2s9@xreary.bet>
References: <PAXP251MB001050EFD88752318EBA75F5C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 5 Sep 2026, Aamir Ahmed wrote:

> wacom_parse_and_register() schedules wacom->init_work with a one second
> delay from wacom_query_tablet_data(), and only then opens the hardware
> for devices with WACOM_DEVICETYPE_WL_MONITOR, that is the wireless
> receiver's monitor interface and the ExpressKey Remote. If that
> hid_hw_open() fails, the error path stops the hardware and releases the
> driver's resources but leaves init_work pending.
> 
> wacom_probe() then returns the error and the HID core releases the
> devres group it opened around probe(), which frees the wacom structure
> allocated with devm_kzalloc(). When init_work runs a second later,
> wacom_init_work() derives the wacom pointer from the work item, so
> _wacom_query_tablet_data() and wacom_led_control() read and write freed
> memory.
> 
> This is the only work item that can be pending at that point. The
> others are scheduled from incoming reports, and the HID core drops
> reports for the whole of probe() by holding driver_input_lock, which
> this driver never releases early. The neighbouring BAMBOO_TOUCH error
> path already cancels init_work before failing for the same reason.
> 
> Cancel init_work on the shared error path, after hid_hw_stop() as
> wacom_remove() does. The cancel is harmless where the work was never
> scheduled or was already cancelled.
> 
> Fixes: a544c619a54b ("HID: wacom: do not attempt to switch mode while in probe")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-input/20260905102908.ADE1F1F00A3D@smtp.kernel.org/
> Assisted-by: LLM
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>

Ping, Jason, your review of this one would be appreciated as well. Thanks,

-- 
Jiri Kosina
SUSE Labs

