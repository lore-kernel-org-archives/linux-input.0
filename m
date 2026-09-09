Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF6458FD28
	for <linux-input@vger.kernel.org>; Wed,  9 Sep 2026 20:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987016; cv=none; b=dTGmNw7S7rrX6YWBOZFoPR326VOLGSRYpBz93ornAm4mca1zTqq9QvP4RshwbnOg8WCOnEnqkPaUC19kE6iCQHxtR0ZEQ4Z2LdSsO9ylbxoKeydtdhcYreqiUDBICzsRXhafrf2pUzybXVUgnkamPBVN/VJ38Y2eg7zzpvG00M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987016; c=relaxed/simple;
	bh=jMty4ajwnELhURTjsE6eNqa3g/f3bJYi9e2DCx52xvk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TjVb3lyg32EE3DXnzvufPbckQO1L8GrM/FlcHrNdTrnuJDxDB182wdu5HMgHAWBYmo3Cw2NI1+RmtmwTai3NRUr5QTMh5mDh5dFd/Khe1b5qlFRduEfDOBl4g5WYwPet7BJ2e7DFJCAZxrVpCsLRxeAJRh9Umybz7Fhx/4VSTXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYQzffz4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYQzffz4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BB51F000FF;
	Wed,  9 Sep 2026 20:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987012;
	bh=sEYSNtkQsHWLYM3PXCQWIlCK3l7SMDlKCMnAzv0/c04=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=mYQzffz4iJWLFzAeKlRWQ6Y78+8/BN45ywaEueIUKzTP+0uOnxiQG8+2gT5o3mXUu
	 CW3brhr7ZIKgWjPSv4QK1PatRn5Z1LwAvFH6LqnvpMhiRFXSIfApL4X/nfxaSkoVDu
	 86e07vPbRRqLiU7CvOGzrGDSglDrsXXjf3S9LTUZekc1bvoIlMQRnV0kfHwpXBpA6C
	 205Aszy+bBWyNW0uSGsxa4SC5SBLlVgDdJK1ruBNKdUn1NXtEim55COnvTVTx06wLD
	 4V7geTbiM3o9pQG1OkGORdRWAa0bNzrRuOPv2Cmp1MFaYC7ZpVihso71ZBM26G/qX2
	 AEFYFCarvmGGw==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id C2B03198003A;
	Wed,  9 Sep 2026 16:50:10 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:50:10 -0400
X-ME-Sender: <xms:gMahahDNLKkgf41aoJ7QltWnM6RjqnFpLfXsEojPI_9JWYuPk2iNog>
    <xme:gMahaqWDng7vjgrXuNAJZtouBbnOu9dKHOb_H84YyQJQkj3qP0y8S-vvvD1z-CQ7u
    tpVSYnCSUxwrq2nqgQjHhARBIoqOZDKM8W--cYdHTAmXZL6hXtrCpuW>
X-ME-Proxy-Cause: dmFkZTG0uhuAwommTLNbPA5zod+Ry1qWg/m7XlAGS9AdDnt3HTzO0NGzxkWWcRme1Tw0h6
    2oy+SYxgKztzRfyTjPJiM9vSe+eacDZh4DciJUPEIZV25DTKFUp824VkumpHvRrGOv/0uZ
    ITnJQHUUoBa9V3Il4KqyRBk26etkkKEVTIsIjSYZfhjUr+jIr27VYJ4CUq9E6v0MqhyHHT
    Pa0UQQrdGQNuqNG6ZLgVgfay6/rIuK7BT7LhjOY8wUuwIQoryxN6QuDg5BU2J/1X+OK6Ua
    OrBdMMNlKJPGlQuVV1BHGhlCy9po7rYP0YrFEfYf4v1gpVIY+KoUh0HRsQhWy9Z1NcphWX
    W8sG8Mtoj6S1OZxYPWVZPKkNHhvIs7VSSqEjX33Rj6p04iZ+bqaVzR/Xcb0c5IeJD0evQr
    +eBpaz3wbej2T+yt4olZbvQCvZMP88jwwKNZFqZCdJC4uemKpuNXA9uqW0Xh3TyuuzQRMq
    qmYBwykaCczZAe/Vls5T0E9LtGoPESTCNComwicK60COcZaapRYsW1HNZw0sdFhXKPPK/S
    5wQD0N+O3DZpgl/p6Gg6ikRyWnFIKINIurficUB19XTpSUuiqo8cL0VbFqagd6oxH6kRLi
    cm8qR4ZH1F1Y3jJ+GxSwPhDHaQvfeIom0Om/ZrEbgHhWGxbgAzdfgFyt0zqg
X-ME-Proxy: <xmx:gsahagC8DuynwTStL5ScvWsLHE4Pod8CYU1jOS5DnTK-BttUxCdX9w>
    <xmx:gsahau3Vr7wX7MCFw_jYXNrh6a-x0a8e6SQ0Zmt9VHhZY4VyWakx8g>
    <xmx:gsahalOmgsfnZ8TiK2vbZqQHgFzdb5bOjWnkh5RJ2MWqpmVwb-td2Q>
    <xmx:gsahaj4i2OtfLp4fLGOgmxvOaUJeQPp0JAqE7M3ADtmx_KbHPQpJaA>
    <xmx:gsahaqbk07EfSSONzdTia82tGwneMbOHRyPdPWn7pCFmJT79vSYE6br9>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 81AA132A007B; Wed,  9 Sep 2026 16:50:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Arw8dbDHChV7
Date: Wed, 09 Sep 2026 22:49:48 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: mfd@lists.linux.dev, "Lee Jones" <lee@kernel.org>,
 linux-rtc@vger.kernel.org,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 linux-input@vger.kernel.org, media-ci@linuxtv.org,
 "Conor Dooley" <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>, linux-leds@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Message-Id: <9cd2bbe1-6e0a-4387-b082-5ea4d70c7379@app.fastmail.com>
In-Reply-To: <20260909133929.AB9A01F00A3D@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-11-arnd@kernel.org>
 <20260909133929.AB9A01F00A3D@smtp.kernel.org>
Subject: Re: [PATCH 10/14] mfd: remove unused rc5t583 driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 15:39, sashiko-bot@kernel.org wrote:

> [Severity: Low]
> Does this removal break Kconfig consistency and leave dead code in the tree?
>
> The config GPIO_RC5T583 in drivers/gpio/Kconfig still depends on MFD_RC5T583,
> which violates Kconfig rules since the target dependency is now missing.
>
> Additionally, drivers/gpio/gpio-rc5t583.c is left in the tree and still includes
> the deleted <linux/mfd/rc5t583.h> header, making it unbuildable, and its entry
> is still present in drivers/gpio/Makefile.
>
> Should the GPIO driver be removed in this patch as well?

Right, I had this as a separate patch but folded that in here now.

      Arnd
