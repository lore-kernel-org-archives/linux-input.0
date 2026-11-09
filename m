Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245552;
	b=BrLKcIOyxtYJUElw3lAJcGMv3TGytKg+sYPRisBTEEhAKPGvFq7VmEiIWN4R7owx51c1
	 570H1pLPzyzOLDt84vhEStLdiLsCVGqZSNgP9y7VrvZqU8sR/pRX1P6hU6a+0WHMeuYQa
	 IZWTB/0JMJ3SuHl3DhyECFco3PY3laFRQDvm4KUUq1gTL5+miF6ZVlBJQ5kJGkMtTrsWX
	 utKtLjBnZw7lac68jaO7ddFR22ROnhmNENW5Fn464Q5ZSvW1JGBw6BJEl2SpzFZIPKwDk
	 QLsRZYy8qm1Ht0LJXfv8da45BSaYpA4nMUmzQYzkCgFTtw+zq7ZbPUy0BnQALOm1GvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245552;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BxCM7jFQeHlawz7cZzQYOBpJuZhxUeDlGEoNmH8KZTQ=;
	b=4KbNBTw/10NEIvO9SsoEYJUKvP0bQOZyi04siWNsPwekzbIVowD9UGCZ4zVEbfVXHozm
	 gnaBLErTgolnNHcQ31xa+jlZ6v+qSO2Fu89g4pWABkilyQ23DdkGzTunpoBchtwlL22Pu
	 FrX6yZLhwdp6Ck6uWtUf38LkSq9wK8D35bEEWdbdXz/q4ya5dU85becYVTO3x80AOjMKV
	 aqiKUYenMy9EPsKiuXxjiV8/8prlHW+nKQc7OzHfTlGZM2bGbLgzItLmrqVN46WZ56QTr
	 vHWfIbPbzZr3MY0CCrca1cWifZmUJkA7aGs4GiApEidK7134UDtEonMwnyDI4ISSI/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=d1eVXDtW;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F816606A330
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 17:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F816606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=d1eVXDtW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=BxCM
	7jFQeHlawz7cZzQYOBpJuZhxUeDlGEoNmH8KZTQ=; b=d1eVXDtWXLo3bcwptFqy
	6L7tUrrk82U9mSYS097ZctpV5AmkOmVycGIMgsa0f6X/HrO2m+z2Fwrawc9nxl4D
	ESevWePqXaLrYsld2jL1AbgEY+Tromxe4PW/zdpMTI4GsjYICZnbdneC1L4F6P5u
	pAz9zYHK3qjQ1CezK/4wYt5C6LSNn455Is1x5JKizXulq2AtfhyZKuSVSEYlKgUq
	L3ViOvVx+9Bom5UxKJJsYC1K6pxFqz3dWkEJQ4PE3UDvIhUSZcxkFTf8IetFe2Ic
	I/sVK1/AppoSnsJm+VeGHz1ilcTOECbshP5I00rP8aZF9aT51lPxFHuAJnOBr5Ju
	lA==
Received: (qmail 3347870 invoked from network); 9 Nov 2026 18:32:28 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 9 Nov 2026 18:32:28 +0100
X-UD-Smtp-Session: l3s3148p1@qAeRWNtfSsYujntg
Date: Mon, 9 Nov 2026 18:32:27 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Felipe Balbi <balbi@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Hyunjung Ko <hj351016@gmail.com>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: lm8333 - remove driver
Message-ID: <avIDqzhyWD6DxgHq@shikoro>
References: <20261109072950.3474308-1-dmitry.torokhov@gmail.com>
 <20261109072950.3474308-3-dmitry.torokhov@gmail.com>
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
In-Reply-To: <20261109072950.3474308-3-dmitry.torokhov@gmail.com>

On Sun, Nov 08, 2026 at 11:29:50PM -0800, Dmitry Torokhov wrote:
> The LM8333 keypad driver relies exclusively on legacy platform data,
> has no Device Tree or generic device property support, and has no
> users in mainline. The BSP board file it was originally written for
> was never upstreamed, and the original author Wolfram Sang confirmed
> in the mailing list discussion that it will likely never be converted
> to Device Tree and agreed to dropping it.
> 
> Remove the driver and its platform data header.
> 
> Link: https://lore.kernel.org/r/Zr6I9RB5mibU_12N@google.com
> Link: https://lore.kernel.org/r/Zr6PnlsdoyLoX261@shikoro
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

