Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9BE317161
	for <linux-input@vger.kernel.org>; Sun, 16 Aug 2026 12:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.247.164.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786881815; cv=none; b=BqIX4F2wM6I0/sNLBgXsZDMzAC5xME0PoaoUsquvO/JC7drwP8u5Q59mwnGifm3vYR4KDNpoBcUM/PiE4u917rq7pjgX0pp/XmFxePG2vJasBYMnvfF5HURcOlF3m/zx8/p//RyWM02MOX4fcN+bTZ2SktTbE3lT949Gme9h7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786881815; c=relaxed/simple;
	bh=M8s5yfh7jhPrGXcr3YI5ZVPojgwME9U3CfY1Cj834rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbMtwfj+L4HfdvKNu4fRuHg33seaiJZpLnEL7KrZbW6W7boqChAt2QLDmJ5BbIb3LGq2g34VqXggNcqlDvaJ+m6Kpto2ZGY4hYMZIpQVoLKOR29e5InvyITFl1YXGkfdc8NjYmHYumyLiAJz5jMzjqS3vFq5y1cs4KYcw50Sjrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info; spf=none smtp.mailfrom=koesling.info; dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b=KOOUJmz1; arc=none smtp.client-ip=84.247.164.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.b="KOOUJmz1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1280913203CE;
	Sun, 16 Aug 2026 14:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1786881809;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5YREvnpYKnd49W1mJex+P6JRRbIIzIBfldbNZ91T9zQ=;
	b=KOOUJmz1l/d15x3GriFh7NAVVyBklAhDK2A9lWDhjiDvvSu9Ez6rspi/TW5qpn3lE98c4x
	1fnZAnNVBS5+2gbGwkyQDgOfO8CmjKKDXpvXhmXgP8Pqm4mZvBmPXvH+8EWbu7hCbovYXz
	ZTXK1WM46pcrqNPFsE68lf4CYYpd9HQzmABqoJxvzv0+JjATfIzQgX7a9/hxmiud+qiDFb
	OpD7HFFpr+NUMSXtXQNdvynYYunNtzvsx3TKNnuhMQ/kfl7FRXpWWkyxzCTywRC7scjrrv
	wB3cXGJ0o7pFXSFd/hpsEoYc9rj7WhguW4gOY/AA/PwZBtZBGr+g0Wdasq8wzQ==
From: Nikolas Koesling <nikolas@koesling.info>
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Subject: Re: [PATCH v6] HID: pulsar: add driver for Pulsar gaming mice
Date: Sun, 16 Aug 2026 14:03:24 +0200
Message-ID: <x0pm_gy7QVChgX6PIKCvXA@koesling.info>
In-Reply-To: <20260816110521.8DB7E1F000E9@smtp.kernel.org>
References:
 <20260816105423.47305-1-nikolas@koesling.info>
 <20260816110521.8DB7E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

> - [Critical] The `drvdata` structure is freed before the battery power supply is unregistered, leading to a Use-After-Free vulnerability if userspace reads battery properties during device removal.

`devres_release_all` releases all nodes in LIFO order.
`devm_kzalloc`  and `devm_power_supply_register` are called on the same device, so the power supply is unregistered first.

> - [Medium] The fallback logic for non-Pulsar devices during battery initialization is bypassed on command timeout. 

The dongle answers commands even while the mouse is off.
So if the command times out there is a protocol missmatch or the device is malfunctioning.
Not registering a battery in this case is the right behaviour.

> - [Low] Syntax error in the `model` buffer size will prevent compilation.

It compiles with gcc 16.1.1.



