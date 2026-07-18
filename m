Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F038F643
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386886; cv=none; b=SB4WXgNvHgtdyRGRq18FUydmWRUaQ46eMvOmoUDxwqYDiTZXcTZBjDMBmt1jwIBsMUt61hH0IY/00bdcxbigY0F9Vb+7a5Zwku3q6/g7TT1ehyNv8GIz8hV2dy2ISB/umUp6yQJfqS9mZfN7kY0VdMPXSwNd+VmWac46WpLbr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386886; c=relaxed/simple;
	bh=0BBbO8idrlEftA6EXPFrajZONFabalR928ywKzb21fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeE7UT4dohwMRFyuyZygb7K5K8H2UfyN1gEMcDvXIv2bJ8+msjBEybMVmSmw9XjmGAHS03pAboMG7K28mVHrnFmv5cJE2Jpa4/ERJ4PJJgqbX4wZK5FcvZqTHgCIbNAlygMQpFglLuh2yBhoUdGxQtBddcji1acTzKT+kyOYJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks; spf=none smtp.mailfrom=deq.rocks; dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b=WY9fzQA/; arc=none smtp.client-ip=91.216.248.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.b="WY9fzQA/"
From: Andre Eikmeyer <dev@deq.rocks>
X-Lima-ML-UUID: ddd24289-6c60-432a-9272-a5cb89f0440d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1784386881;
	bh=0BBbO8idrlEftA6EXPFrajZONFabalR928ywKzb21fM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WY9fzQA/tWRvw5MvckdaXSVQbkbynIxQsSKjP4JJY6EaDT0Tg0FHJJuuj9IcxqVyZ
	 yVg6hqwz/IKIwfK0ibP91WRxgMQ+VXc1XXBXceFcoEB+f3Dhm16AF9TEmRkYp8IXFT
	 voFzo63rQPAYp8M53XwUSqwsz8qnoiTGIMcZlJ2b9eBg4OC6xg3BDZxO2NwrowK4L8
	 1qlxxCvka+gCcAzdfUQ9h4Ormzn8hrKDcjN2GFdrl3KGlBJlm/thaGe+DxxFiIiQVS
	 A4fiJlJhquAZ5RhScndQYhY0tP2cXZg9VHZiGorqArNcBQ1A85K1CSUAZGESwzNV2s
	 1qw8t9OVN4QgQ==
To: sashiko-reviews@lists.linux.dev
Cc: Andre Eikmeyer <dev@deq.rocks>,
	linux-input@vger.kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	gargaditya08@live.com,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH 1/2] HID: apple: preserve keyboard backlight across T2 resume
Date: Sat, 18 Jul 2026 17:00:51 +0200
Message-ID: <20260718150106.7774-1-dev@deq.rocks>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718123558.0ABF41F000E9@smtp.kernel.org>
References: <20260718121527.15924-1-dev@deq.rocks> <20260718123558.0ABF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for pointing this out.

LED_CORE_SUSPENDRESUME was needed with the older apple-bce suspend
implementation for which the original fix was tested. I maintain the
apple-bce source consumed by T2Linux as well as its split replacement,
t2bce.

Both current implementations now suspend the VHCI deterministically and
re-enumerate its devices after resume. The transport takes the keyboard
device offline during suspend, so its backlight does not remain powered
when LED_CORE_SUSPENDRESUME is removed. On resume, however, the flag makes
the LED core issue a synchronous request through the stale HID device
before re-enumeration completes, resulting in -ENODEV.

The new behavior was tested on a MacBookPro15,1 with a butterfly keyboard
and a MacBookAir9,1 with a Magic Keyboard. In both cases the backlight is
off during suspend and restored correctly after resume.

