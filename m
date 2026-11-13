Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794534308;
	b=2kbTKla5R2uTtfZJnypvATvlWHEjYgIrMQLKcTCXGvGFvjStmTgXv9QsGGTb2Wx92CGh
	 VTrxnCOkNc55p0T9/8DxfZ/I6ReAmlpdGTwyYYjtSvyzpzSIe/w3KT/6UWnW+PUZ96q5h
	 OiTpILIGOeomzLXGj/zL2MsGWvb1GJzJvT1B7RXSP19lFGhWzzan4KWIlFkpDAP/RIzmw
	 nxJcF8FlDcRnXKRL91OVtwTZZR3XoaYLJz/KER2NHYIMY4+hPxW7lCoGU41MyC3cStgnR
	 /DqTiRZWW/ndT00U6VmOj2ml8rlLJrPzZyq+RO+kwd64dEQ4W1He5QtynzUL4XEH1dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794534308;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P5NuqAuZj13zvoIOQWMYD1tFS00nLHpnLoeJwkAF4zY=;
	b=vooJ2r5pI04rxq5Ngr/FR4hwcOK9TmGvjpOUBbxgxICO/AKMack6Jy/dP467VF833Wbo
	 4p1lSx51ir0Gf8eDYZLjGXsmlY3d8kURZ/hMw2e3A/bSdb0p860Z3Fnv+k2aD98ERh+PR
	 xVE1OgoWBIzzySy6bPBqoI8+LFLZlBLxbmCeY0Q2Zx/e6PKUL+fsdwhCzcD6wE25qDoGO
	 etHbsTASOpNiYZdYG0TiXaZ8vZ7np7ESEIA3EurmotLGuHNU77ohW/nidaic8gtNs6LdB
	 HDy6KscOlQIC4oOVnH0Is0gLSppqzYm/Vj0hk3o3z5e1exWHxzj45iyUY9etQxHzlVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHZIbkYH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35880606A31C
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHZIbkYH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909EA1F000C4;
	Fri, 13 Nov 2026 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794534307;
	bh=P5NuqAuZj13zvoIOQWMYD1tFS00nLHpnLoeJwkAF4zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dHZIbkYHCxQ4k3uIklU+WilY9xC25ouHmlV+/US7gujw2tYCxBtwtJ9NT25Lquynz
	 6CRnoAbVQ4zMeIoRUYnpg5s5tdsoY/z0H6vmQmsMdOQ/oAazGcJruFaqlLkr6YNiWq
	 BRr9xXb5k8EmTTqFj8+bmT3awjwKm1mh5hiJeO1PjvHRBk5rByHyCX0evObBzy131w
	 fWWTO49LtnBKXkdxfR1pm2ZgwuXMZVVWv+GI5nMJ8rRlAQpzu1C+o0QyjVPESg0gYk
	 BpV55ehgZ/f8sMYDgwXPRwKAR0njsZlzahNdeRZklO+S3tkFMpdFKRVjn7xw9srJEo
	 DSBW1UZxD1iHA==
Message-ID: <sashiko-outbox-212073@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: mcp2221: Keep IIO initialization retries per
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: tuhaowen <tuhaowen@uniontech.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <4861CDE55CCD8365+20261113014036.1430473-1-tuhaowen@uniontech.com>
References: <4861CDE55CCD8365+20261113014036.1430473-1-tuhaowen@uniontech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:45:07 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] HID: mcp2221: Signed-off-by and Author use account handle
  instead of real name
--

commit 0750e741db2254c14f91e93fd256287b28060c69
Author: tuhaowen <tuhaowen@uniontech.com>

> HID: mcp2221: Keep IIO initialization retries per device
>
> mcp_init_work() uses a static retry counter, so all MCP2221 devices share
> the same retry budget. Initializing one device can exhaust the retries
> available to another device, including a new instance after unplugging
> and reconnecting the bridge.
>
> When the counter reaches zero, the post-decrement also changes it to -1.
> A subsequent instance that receives -EAGAIN will then keep rescheduling
> its initialization work instead of stopping at the intended limit.
> Different devices can also update the shared counter concurrently.
>
> Store the retry budget in struct mcp2221 and initialize it before queuing
> the IIO initialization work. Check for exhaustion before decrementing so
> the counter stays at zero once the retry limit is reached.
>
> Fixes: 960f9df7c620 ("HID: mcp2221: add ADC/DAC support via iio subsystem=
")
> Signed-off-by: tuhaowen <tuhaowen@uniontech.com>

[Severity: High]
The Author header and Signed-off-by trailer use the single-word account
handle "tuhaowen" instead of a full real name, which does not meet the
Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/4861CDE55CCD8365+20=
261113014036.1430473-1-tuhaowen@uniontech.com?part=3D1
