Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FFE3F54B7;
	Tue, 25 Aug 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653034; cv=none; b=a+lJhaPwXiWGD1iva0zZubfAO3TsbKYMzCMkPbHLXcAM4NuPVGy8wJtcLiSOJA7E/JrW52grNFeregTXbYh+pUreX66cPiqFeHX81sHDwyBkKnKC7KWErfx2qE07GkjwUkKVoJETP3m4KrCyvEfnN3T65M++bXKev1HAiBD/bh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653034; c=relaxed/simple;
	bh=ujr3KEgo1NVcUlkVbsgFvfWP66JcPkPXygGaOOt0zW8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lZ9TdCdfYtHEf8WKtpj/G5BzMbZQduDyi7Adt9x1G81CdesRFK4LAItfc3ScI4v+BKp0CIm+ft/z0nuY+mDr/Ove8HbHZ++K4mnWwep9wJ9BainGQJJ4WQmSYxP1SJbU76Se/hCEv88w0Klw9qIhAbMnM581jemQDSy3oR3xux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bc74JwJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bc74JwJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF8A1F000E9;
	Tue, 25 Aug 2026 10:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787653032;
	bh=UMi/DavPTOkKaGZ1a/dxvwQrewuGp/8YxtXwDqLpM5Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Bc74JwJ6DNQl9zN5hu52njc0lpAZ8+jdyq7zI3rly/vkKqWLYjKnd9UEAbc2Du+Bn
	 +31mE+f7kwpfdURJBXGQZxpECxoevqWUlNdxNGvmQyIDTdsUOSE2NCx7wK++aZIddj
	 lVQnw/BsEiWxwyYOEAiPvEV+ZBXMQW1w3YE9paBLa13O5NASji/qeH2iV1bhhTR2iO
	 xd2m4vu7GJh5YckYBhlj4Cq5y3wmYwGNQJxBvGmM987ZFaZXsgIn/asIvFLOUV4TGC
	 NaRCmhgt35yA2hXUVnKBWF21QB4D9iohyWUvuILJQ+IRlhbDaN2XzsPeUeQBZFQZ1i
	 c6rdd3xSku27g==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Vadim Klishko <vadim@cirque.corp-partner.google.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vadim Klishko <vadim@cirque.com>, Hans de Goede <hansg@kernel.org>
In-Reply-To: <20260728041718.32954-1-vadim@cirque.com>
References: <20260728041718.32954-1-vadim@cirque.com>
Subject: Re: [PATCH v3] HID: i2c-hid: Add a quirk for a Cirque I2C device.
Message-Id: <178765303092.1516012.15844323248427966406.b4-ty@b4>
Date: Tue, 25 Aug 2026 12:17:10 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 27 Jul 2026 22:17:18 -0600, Vadim Klishko wrote:
> Cirque touchpads with PID D0C1 generate an error when probed
> by the I2C HID driver, resulting in no hidraw device created.
> Adding I2C_HID_QUIRK_NO_IRQ_AFTER_RESET fixes the issue.

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.3/upstream-fixes), thanks!

[1/1] HID: i2c-hid: Add a quirk for a Cirque I2C device.
      https://git.kernel.org/hid/hid/c/1c942462c396

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

