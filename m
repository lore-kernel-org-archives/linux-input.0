Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528753;
	b=LFVIcb72WtU7GRUnduj66Khlcy9olA0nNU9KqxmQWJYwzM3YXORRNskA7BbMrIpNQNGr
	 rRCWIxu2sxlbiz4tDHGEGKcdNRlZBQ/hGLBA6jrZFgLRzKxk8+etJ7GUxc4eYyvMa25s/
	 /cD/i8k2imtuMEPK2EHgxKu8iw56zwNu39Cmn7K4u6kOSfIGcoYus2+DFCKwBkqQGd5Sw
	 4Iqx9Xjpo/FbazyLuMCayU8KWqI4E5Ezjv2liLvGoDJdZBU5okdtHv9tukoiNJEkyUvZ3
	 1sg3UllvaV33osspsVt/D2tLXj7Qjs0GKZjWhnqiKyduHSfGchvWEJ9YRxiDmuEO+2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0DbDHzcKMGdEVlcCpDZDB02dBzPmPWIVELzX4wOJjjg=;
	b=v5RtyY5im/qaz49oRsBjM4JRkRoHyhBkMSsu7Vw12QmAFjxhezGd1WtR1PrphK35GrBk
	 IafRCAAALYR1Pac6JqSX13AnXHWZGp+9ZNHvrkfG+kWHmJPR+2vZ2WrLYw3V0/RSN9sYK
	 /hUOiKpPbhMSfKTZ6UeFHe8gpmfOdxR5Epn5O5sBDffTlvmG693WxOAYxwai2m5zbCltt
	 32OZZCL6SnBlUPk8CDjL/rMoitxVJKoxw9TLaPYs2IML5swm+CY5/RsxY+rAn5gQprtHx
	 K/lGd2fgGma8VVWPGeySpRqdussiwuf6YzwgVmJGQGmatYSOLTzt/GbcWfzgXdk3BBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o050Mjk2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E4606A321;
	Tue, 24 Nov 2026 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o050Mjk2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677BC1F000C0;
	Tue, 24 Nov 2026 13:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528752;
	bh=0DbDHzcKMGdEVlcCpDZDB02dBzPmPWIVELzX4wOJjjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o050Mjk221Dm32s3NEIWL0dnB5M63rz5TV6m9hlnrq7yi+qJIl8hsPpPqfIKjLJDh
	 IJ+W4ZKnL0rqSKcS4PcyW9CWhbE9Uf/xiR9ejCSBUhvB/XIUQJcRpERntzGmzpsN8B
	 PD7eujQWzKRITaybc6RycDj1kyw/5Nc8PQUXDfdvFGi5ZI9M31LG/7QGpX2HBh9PDM
	 CEm9MrhWE/kBChTqQcYe2Bnbv96rbVDKeV5/+CDpRLg2vpQoQyKCGYXKzScDThhmWH
	 +O1vhzm1dqPDExAwfvn0v4tBAsR7PbLg929RnrDT6D+9SwRXyeBqGPJz9mMZgLMepc
	 vy/IR/8veIY9g==
From: Sasha Levin <sashal@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: semantic conflict between the hid and pm trees
Date: Tue, 24 Nov 2026 08:59:09 -0500
Message-ID: <20261124135909.3358923-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJZ5v0gAwqHNkLGkoKx=mSxeC4UuHdpY=71O3UDxBK99WshULQ@mail.gmail.com>
References: <20261120194507.593601-1-sashal@kernel.org> <20261123212630.1203859-1-sashal@kernel.org> <CAJZ5v0gAwqHNkLGkoKx=mSxeC4UuHdpY=71O3UDxBK99WshULQ@mail.gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 12:31:17PM +0100, Rafael J. Wysocki (Intel) wrote:
>I think I'll create an immutable branch with platform profile changes,
>so that the hid-asus can be rebased on it.
>
>Will that work?

Yes. Once the hid tree is on top of that branch, the two
CONFIG_ACPI_PLATFORM_PROFILE checks in hid-asus.c can become
CONFIG_PLATFORM_PROFILE there, and linux-next won't need a fixup.

-- 
Thanks,
Sasha
