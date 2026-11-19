Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795124538;
	b=RN+mJJVqHhB12nwK8gngjGOneFMByB0AUAJCEoZU916vquZe3xjqVNmcl5eKk/Ai/D5w
	 bVG0Uyk9rOku17ywiaarWw6xNnx8Yp7z4LzE1SUdR3UcrJbOaHUYO1qEhNn43oh18V/4V
	 VHfUvZp13ddc9OuUGRPfZczxAZI0dO3DbcJfuzGhR8rwwWz5wQ/OOzDlAZN1DVVW4CIac
	 FW1fXe/bcHeRU8FCyUDEjWfFxvcPS+cvemSX0numbsVjjVpHibbBjmr6JNoImd6SwuE2F
	 K8SQpttTFvNMyc2F+k/7X8vceNJYTyRrC7Vh2g/EcnbwY7g1uFb4zAy6MI3MUC+vAnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124538;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=RweZj/1TUoc4rtIBYfUS/HLl+WylhOgLLsA47vbDTKE=;
	b=TJWPrKpnOH2A9gh3aAo31mmxOmKRuG203o5Qk7FDhrWJDhWDAgP6ghDxYRLxOKHvfcyj
	 /VV85m0Nul0or1EXPB9cn3W6gMT8B2fa+JiEwPtWnl8au1HPwTfayHW/FR5cEqaSegVzz
	 pWxie158j8mgbvvyf077TrtexQx39JXVcWDPdnIJR9xHC/j+TxvoKK09T0d5BcvDgMWv5
	 C7Y+0E9I/WrG2KLBSc4Au1hqSZHjuQBDC82z2bHEhC5FhaIfPdD+ZA67OsMzxwZ++qyl6
	 dteBNS4OTX6E2UHAuVy1nUfpq0pWdxyqvGNz+ywMXZJtdrU25YQlE0VweDqGgvQkw1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPDtNyt2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD5606A325;
	Thu, 19 Nov 2026 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPDtNyt2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC4C1F000C0;
	Thu, 19 Nov 2026 21:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795124538;
	bh=RweZj/1TUoc4rtIBYfUS/HLl+WylhOgLLsA47vbDTKE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=BPDtNyt2N8IH0c9dksntcJoOQmJyIJ+iNPs5wjWF8UnWCK/QvKCfUlcy4WmNJfsKQ
	 wLYkV5w2UqjFyk1Y0r0JmDr/iz8SVpR3WOejweKFHYgENVkdkBovcX7G2qilT9meF/
	 OyLm1FbAQrCk3510O7fnEY9KS5sVypHcpARqr8RKbdAZe/iF8na7YoNfg5I/3sUL3m
	 hNFSSjepDX6xz0Q5ck6er0Gx9Pi1QyT4WhJtkhHmBNo0TYgqyIXKnH7tvBjAAQFKfb
	 S5+kfeHTVIGuktwdNwWuNTPr4NW/JXst9Z+rc6RXCE3XtYBR6wPFeWrHvF1kMyFbYf
	 3CmmoZohqzfVQ==
Date: Thu, 19 Nov 2026 22:42:15 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Marcel Holtmann <marcel@holtmann.org>, 
    Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
    Michael Zaidman <michael.zaidman@gmail.com>, 
    Rishi Gupta <gupt21@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
    Andrej Shadura <andrew@shadura.me>, 
    Johannes Roith <johannes@gnu-linux.rocks>, linux-input@vger.kernel.org, 
    linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] HID: hidraw: Encapsulate struct hidraw and make
 hidraw.h private
In-Reply-To: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
Message-ID: <99s2r0r2-pprp-o100-p5o2-op9n64r9qr90@xreary.bet>
References: <20261016-test-hidraw-base-v2-0-153f67a20cad@gmail.com>
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

On Fri, 16 Oct 2026, Dmitry Torokhov wrote:

> This series cleans up internal HID core and hidraw header boundaries.
> 
> First, internal HID core declarations and unused symbol exports are
> moved out of include/linux/hid.h into a private drivers/hid/hid-core.h
> header. Next, a hidraw_instance() accessor is introduced in
> include/linux/hidraw.h so HID drivers that only need the hidraw minor
> number for naming or debug logging no longer dereference struct hidraw
> directly. After converting the drivers and dropping unused
> linux/hidraw.h includes, hidraw.h is moved to drivers/hid/hidraw.h and
> struct hidraw along with its internal buffer and list structures are
> made private to drivers/hid/hidraw.c.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> Changes in v2:
> - Rebased onto latest linux-next (next-20261016) / hid.git for-next
> - Updated hidinput_connect() declaration in drivers/hid/hid-core.h in
>   patch 1/5 to use unsigned int connect_mask instead of unsigned int
>   force to match upstream changes
> - Link to v1: https://patch.msgid.link/20261014051326.3784498-1-dmitry.torokhov@gmail.com

Now in hid.git#for-7.5/hidraw. Thanks, and sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

