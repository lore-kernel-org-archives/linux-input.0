Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896D352927;
	Sat, 28 Mar 2026 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774713351; cv=none; b=QoU5XA4NMh180NS+rB+EjyBSZ96uQn/KpOezz0M7kvBwweCdmmE8NOAf+a5D/B4a/xXAyOGgyu61Lar1WMz4lh7mWUMZGtOp+K7aJcB0fzYOqMEOwJlUsAHokzfD9BEGYMMWoQTZqzgRygGCjUWkGgswGVhBjsM8f68rfu65a+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774713351; c=relaxed/simple;
	bh=P7YkcLByhCVatdaLBX2CKcby11UXQZFz8qz/3hqqEnU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R4oONj/NS//3qS/io/9WVfucLAK2FVe2W2LORNh4zDWows/TAO0aCZ4/DCB4eU/879YWf2B2a93rWbh1Blu3D2DK6X48aTT3BNBqc645wxssJO2y0XYtiT1sAcsxAsYM8/wZF9junna7SiS9Mn92hCcMshHs+3w1aXn2xmjVk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/wapYY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/wapYY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3FFC4CEF7;
	Sat, 28 Mar 2026 15:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774713351;
	bh=P7YkcLByhCVatdaLBX2CKcby11UXQZFz8qz/3hqqEnU=;
	h=From:Subject:Date:To:Cc:From;
	b=f/wapYY8xzOVX1LjPSfj8GHNj7cf3+ZAnZpY6ecoXFxbfce8rselwFK1TrjdzF2FX
	 w22Ed45TrJV/Z3QPcputAhcUXzpMHI0Czp+JUje7DM8EcBafCjIEUa78TRs1YQsc1n
	 cvBIzL71NS2QK9eGBR4G8VopZ6/bpD+1YkD6EqpaNFLPLXLXnUCO36/npp7OTn3Cmc
	 o1WpgGOii0i3zVY5jq3gZuZPEHTU7U3IlIgQyXDvHukQCNKDvTlSSNCbXeJjhCSGuT
	 UI/xBm/7jhgomvwUSQsyB2vLH2aY4ywv64z0EmBQT6dinakFjEyiMCYq187ctCxAN2
	 T8LvnaGVdQ1mw==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH 0/2] MIPS RB532 GPIO descriptor conversion
Date: Sat, 28 Mar 2026 16:55:46 +0100
Message-Id: <20260328-mips-input-rb532-button-v1-0-98e201621501@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSQqAMAxA0atI1gZq6nwVceEQNQtraasI4t0tL
 t/i/wc8O2EPbfKA40u8HCYiSxOYtsGsjDJHAykqlaYKd7EexdgzoBsLTTieIRwGdcN5rupioKW
 BWFvHi9z/uevf9wNcy/CIaQAAAA==
X-Change-ID: 20260327-mips-input-rb532-button-39e44085a2f9
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mips@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

This moves the MIPS Mikrotik RouterBoard RB532 over to using
GPIO descriptors by augmenting the two remaining drivers using
GPIOs to use software nodes and device properties.

This is part of the pull to get rid of the legacy GPIO API
inside the kernel.

It would be nice if someone can test of this actually works,
I've only compile-tested it.

If we can agree on this method to move forward with this machine
it would be nice if the MIPS maintainer could merge the end
result with ACKs from the input and MTD maintainers.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Linus Walleij (2):
      MIPS/input: Move RB532 button to GPIO descriptors
      MIPS/mtd: Handle READY GPIO in generic NAND platform data

 arch/mips/rb532/devices.c         | 83 ++++++++++++++++++++++++++++-----------
 drivers/input/misc/rb532_button.c | 35 ++++++++++++++---
 drivers/mtd/nand/raw/plat_nand.c  | 24 ++++++++++-
 3 files changed, 113 insertions(+), 29 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260327-mips-input-rb532-button-39e44085a2f9

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

