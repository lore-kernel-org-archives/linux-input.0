Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519893;
	b=BprYF/DCwK4oGbrHnGTStD+IX0fzfLW3SglxtFbBvZJ2eFm+To3Y4XvHExViah05WW0F
	 HwYGcfd0cSJeiNAU2g5TMQJg76p4otxkU+cJZ69Z6kgyvk0Fm7A9l6KQHh7gPTyeW1gsW
	 KGG/HeLTxY6oCgLEleJqNckTknEkeJ/9ttxCw1RErMkK9DdkU5Z5FH7qqQo11AAD1UMuh
	 Tv95/jPNo8Fp/Qv6F5SfLIDQUdw5/wDeS1vy82k3RiEoVeCjIS7e/fTwktm9WxesvejWo
	 KKZa6di6BqZ8s1NrelyddL+wqw2jF1oO5w6wWlFkNVmlckCQkL3lOotX3uvgCkjYeKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519893;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QRZ2OHv+W/MZtU5x/SLd86H93qWbQcIzkOUoCRAkJG0=;
	b=lcQCI4R6oD+hthbsnojK08LLna92w8uGoYvgjtZh7ksMcFZ960+4f96Gb7AaWwrzaosl
	 8uDXI7XL/y0r9WYhsZpycE+q9m/9A+mL3aCPAioCN3ceb/J3C1lNFMKNB5f+iNp3LiWN/
	 ByCLMO1to6pgn28tUJ9RMO0KhsOuTEo1qTzd1VVwvTYtQ/sOnsTGa2B8Iw2MoU36hypxA
	 4lun/L8bBSzBkTzjzVzQCD6E6SU++50ywUA18NsSeGwNJLCNgFEekmhk88Nj/j1701X8d
	 tOPMzrStieTg+hwoxqsZ+Y4Wk0YKMW/Vfu28ybQy9k1EnpnoSyVP6XUMmnHEiZUlldQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiK4nVSp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16505606A330
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 11:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiK4nVSp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6921E1F000D8
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519892;
	bh=QRZ2OHv+W/MZtU5x/SLd86H93qWbQcIzkOUoCRAkJG0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IiK4nVSpepM8ljJG69Rd4H14xhmxeode27C9O0WPN2TGbFT9Z51V/45CalYe+3T1a
	 72UsfkaPt3CBbgu66RCIVR8VNstPEa3xH9pt9nPcnaAoE7GSQ9ug0B35/HWOBunLNU
	 bzEo9tQZpmQG3feJfWaycRosXIirkUj5hQApvTN5mJjiZf95lBR1vt0tU3w8qWeK3J
	 oFzakZs4rnNTXDRfwaeil6ztGMZvo4v9YrC7Ov5vp7yDSYs136Mu3N6hRXtrGbYJpS
	 H2IbYIxJAXhy27z1fcV6M0W8vS38Koli8L58q/3N4vjMVQhlc+20gBnGD4c2HgxU4A
	 baB5wf4ug0dAw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be3ed646a5so5990838e87.1
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 03:31:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHEMD/+3juAVfdfcwT9a1vqtG1ZBUTZtrruepKstoiu6ffQEIcQWppvJxnSnlCF/Dp18VdlCjLqM/0JMw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+p8I9I/gy6DDsCAYfR+BU4cEQnXz4wBGIjGydDCIAXb5Kto8+5
	ko/TyhRXDBARd7KiRLYfOiJxpENrhw1K87cp/CfmTKgSEgyZU7MeLU7wLhQReORWVEQluEo3diP
	71MNQkmKCKs7Ts2KUhGdTw7UnXeTZl64=
X-Received: by 2002:a05:6512:304a:b0:5c1:c4d4:2f53 with SMTP id
 2adb3069b0e04-5c1c4d430b3mr3666407e87.58.1795519890796; Tue, 24 Nov 2026
 03:31:30 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120194507.593601-1-sashal@kernel.org> <20261123212630.1203859-1-sashal@kernel.org>
In-Reply-To: <20261123212630.1203859-1-sashal@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 24 Nov 2026 12:31:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gAwqHNkLGkoKx=mSxeC4UuHdpY=71O3UDxBK99WshULQ@mail.gmail.com>
X-Gm-Features: Aa3M54qy4cxI7h6w5kV70lvkD1UYd-Ukiv2kA4FJCRoVK3wUJleTkb0zlDrtIJs
Message-ID: <CAJZ5v0gAwqHNkLGkoKx=mSxeC4UuHdpY=71O3UDxBK99WshULQ@mail.gmail.com>
Subject: Re: linux-next: semantic conflict between the hid and pm trees
To: Sasha Levin <sashal@kernel.org>, Jiri Kosina <jikos@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Joshua Leivenzon <hacker1024@users.sourceforge.net>, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:26=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> On Fri, Nov 20, 2026 at 02:45:07PM -0500, Sasha Levin wrote:
> > d220bf485598 ("HID: asus: Cycle the platform profile from the Zenbook
> > Duo profile key") in the hid tree checks
> > IS_REACHABLE(CONFIG_ACPI_PLATFORM_PROFILE), and 699041135f75 ("platform
> > profile: Extract the core from ACPI") in the pm tree renames that symbo=
l
> > to PLATFORM_PROFILE. With both, the check is always false and the
> > profile key does nothing.
>
> Ping. next-20261123 has the hid tree again, and hid-asus.c still checks
> CONFIG_ACPI_PLATFORM_PROFILE in both places. The fix in my first mail
> still applies.

I think I'll create an immutable branch with platform profile changes,
so that the hid-asus can be rebased on it.

Will that work?
