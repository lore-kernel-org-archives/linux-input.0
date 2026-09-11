Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150F46AA98;
	Fri, 11 Sep 2026 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117485; cv=none; b=ahwY4jjsCOwjHLnhJXx30cXwB7/Lto9z5dk3RWnR6Hvo8DogT5WDD3U7wtela3DhtBCC1kdP+d+LDT9ytCWjSr+898uWsTY8YD23VrDw140QVyue0hzXTJ6ieY3w0w5uRfMg18+pHdZ04OX8yfsi0TLWSMWI4Rcny3npccv7afQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117485; c=relaxed/simple;
	bh=6F1OQXCbhjWWScxoEOjZmIoi2dyF1muRbk1gOX7JEls=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WWdyijX/FDQUwsqIAaUVRd5q+0qC3z81+77Lxn6UqkmPMcz/PyJXImE8QKIQ1WeDEyMq8MlArINFSDuVY4U1CoitrTkk3AjF5l3jQ7MyFJk0aZaGrAwfLVVHuMNj/AIZIGhgImkewkuTdvxXHO6L7m35YHOGvzP4PHDTTq1SLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bB+Q3dgw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bB+Q3dgw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7DE1F000FF;
	Fri, 11 Sep 2026 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117483;
	bh=NRTZCKZeq95b1ws+y+Tfh1yEqllqmdV1Vop/HAKa34E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB+Q3dgwDNFPs6ISk0jodHqTG9Xn9tqMvryPsuLc3lI10oZAzcuwNIqJTrBog65JQ
	 YfGdaUpMaefk5tHLevirZNg6MqrITQK+OOkMKp2g01f5KTZx3kYK0KIjuWP7j2wYXc
	 ua4i0h3BVZmG+sVZ8o6WoM0ipv6H3CHU+Xe/tbe5hSszD+HLp/NYykGwEbu2aQiL4L
	 pMifz4ZrOrz4SFemzleNXoSROyvmeS/bGvh7DXjAHMN1qZo21H7ACM3aAyni0BXV+2
	 eWW25UZVoO4YW7bRqNsA9YkkUwNrwU8LoEe37R0oibHU9fvVoNJ9x5lvuQozg+7V2F
	 Nydm/4iEF3HhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/10] arm64: dts: qcom: sm6125-xiaomi-ginkgo:
 enable display, backlight and touchscreen
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?WcSwxJ7EsFRDQU4gS0FWQUtMSQ==?= <kavakliyigitcan@gmail.com>
Cc: dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
References: <20260911-ginkgo-submission-final-v1-0-0e68e63a18d4@gmail.com>
 <20260911-ginkgo-submission-final-v1-10-0e68e63a18d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:04:42 +0000
Message-Id: <20260911090442.DE7DE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>
>=20
> Enable the display subsystem (MDSS/MDP/DSI0), Kinetic KTD3136 backlight,
> and Novatek NT36672A SPI touchscreen on the Xiaomi Redmi Note 8 (ginkgo).
>=20
> Hardware nodes added:
> - Fixed LCDB regulators (lcdb_lab and lcdb_ibb at +/- 5.5V)
> - MDSS and DSI0 with Tianma 1080x2340 FHD+ video panel
> - I2C1 backlight node at 0x36 with PMI632 GPIO 6 hardware enable
> - SPI2 touchscreen node at CS0 with GPIO 88 interrupt and panel follower
>   reference
> - Touchscreen active pinctrl definition on GPIO 88
>=20
> Signed-off-by: Y=C4=B0=C4=9E=C4=B0TCAN KAVAKLI <kavakliyigitcan@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-ginkgo-sub=
mission-final-v1-0-0e68e63a18d4@gmail.com?part=3D10

