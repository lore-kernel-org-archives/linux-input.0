Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469193;
	b=unPisVE1tRr2Ip9V7vOg9QWLqwDaAU2WTTV4PCaG1RowD0Be+OTgfUmTnEpGNmPBjcrE
	 NSLqTpXkcwUE5eIVG0jAl7snQCeFEX3xdj7MkROL2IzHE1zr27VPrryzMypk450wZvS6J
	 YygwZPpXrXZOKwp5mKZeqfQddjeYMCB/pthi6YJSkxxl+UjYOo1mkpTJgW7bwwKcKHMXe
	 xG+feM0gB8E4UTr2VJBn00ToozhlG5PWauz2zwSVduqWmv04SrN/LzgJg4tvvAt5UNITO
	 DOZ+rvNHsKvtnP86+pzwlW+OVfaDcgM5yb4iYcRGFyIQFmoWV0f+0vvwbSa4+qmeStw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469193;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+5XQrlj4DgcxN8ZJSSekOv8THp0HCbXd/T4gJ+eW8uU=;
	b=JUVG6URe2YLbtofD58zYyDWyR855WMWPDAVx+ycOQaJuNcqPwAo86b50HWvmRKB1G1HN
	 LenJ4oTlcVUOg7ZX7rhohyvZC3ODhyvammzF9LAdEhVeCcnKn3MuEAHVIDXKdTsXtc107
	 X5ROhXDk/HLP+Oo33vGEH3/6Ug2GoLHafUqHSmVrqEChJFne1vBySkNQLbXPu6JcRhqOn
	 b8rMYCRh259X7qcWCy696ZuTSuSO7Lo6QutpuCzwiYr6itOQPiU7D52pFKs8VtvHj2Msc
	 OqXBuETh5npX6tst/qn/O21iMbxmVAtK1ano25/AApbFdbENbNa8gZQxnnParKaHLTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6bID0Ph;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F9606A69D;
	Mon, 23 Nov 2026 21:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y6bID0Ph
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA73E1F008B2;
	Mon, 23 Nov 2026 21:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469192;
	bh=+5XQrlj4DgcxN8ZJSSekOv8THp0HCbXd/T4gJ+eW8uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y6bID0Ph9+xCG5/eu0ldXujAg57x1ht43X5TIjQL4AeYX50R8VSCJB5d8gWvPRp3T
	 B4+LIswNIQeQ5aFdp36S+gfLQPOT/A2s1Z0jsAh7SaAMkxUP2a7unCwtj3KPShHCc6
	 H7hUquHporeGsysSLHz1Pb3dCvAw8k3VkGdrP9/9ahWoBaOHNHwV4lrhZy67VbFaFR
	 Md6Cbs4lsOY/wRSPJpxf2yp849A/yLajVIX9pbhnYqcsKZ+9U57sSOJt0qRkUVGiKA
	 ASdIrnGX0ep9+5q57mWbbe1POwcohAxJbwRcVtKmWTYgeg3Mk3KXMOn7Wemk12izCU
	 EtXZ70uJicVcA==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Joshua Leivenzon <hacker1024@users.sourceforge.net>,
	linux-input@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: semantic conflict between the hid and pm trees
Date: Mon, 23 Nov 2026 16:26:30 -0500
Message-ID: <20261123212630.1203859-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120194507.593601-1-sashal@kernel.org>
References: <20261120194507.593601-1-sashal@kernel.org>
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

On Fri, Nov 20, 2026 at 02:45:07PM -0500, Sasha Levin wrote:
> d220bf485598 ("HID: asus: Cycle the platform profile from the Zenbook
> Duo profile key") in the hid tree checks
> IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE), and 699041135f75 ("platform
> profile: Extract the core from ACPI") in the pm tree renames that symbol
> to PLATFORM_PROFILE. With both, the check is always false and the
> profile key does nothing.

Ping. next-20261123 has the hid tree again, and hid-asus.c still checks
CONFIG_ACPI_PLATFORM_PROFILE in both places. The fix in my first mail
still applies.

-- 
Thanks,
Sasha
