Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F66955C1D4;
	Wed,  9 Sep 2026 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788961026; cv=none; b=eu5TIo7NxUWjj4dCdKsi4ab+VBqdiiSk2y3ZRie5Yd3rArDyAQtPO8iLqHbvkTdxNYdNFhMdQI7xBftBT88A6cbH9tsMbTXP/kV60IDOuiFpCylp5xMvb2V/du/uVIVcGEDvOTw1ahlFfJzNVhnWj/jvsmPD00CXSk9zTpFiYR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788961026; c=relaxed/simple;
	bh=gP2J3Cxis167N9i4GkT0UHGuHaQXVlyYWuVTPiqTku8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rPwxyYj0vjY0wa78L6/yRux6g8+mwZeD+tjodz3X2wKgGTLAgg3cWvUgLnsHIZG6V8OdRcQeXdEZndPrhLSNQoC4ssokUlCn9dePoRKhUzvkjdDRjPZArRCGvdf8t3M5sKO1yAk5vowsU6iTeut+sLSuJHZ6J4Kpn8zeVeUdcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnhsT7tY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnhsT7tY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7381F00A3E;
	Wed,  9 Sep 2026 13:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788961023;
	bh=gP2J3Cxis167N9i4GkT0UHGuHaQXVlyYWuVTPiqTku8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QnhsT7tYqtVP4BwisJTxLkTlV5J3GPFfdeCo03AGE+GliYqNriirpdxg12t+dU/b6
	 reYDXWJVaWvYICLrVwYXLBbzxBF/9wV/cxlqq503aV3YIId1w4UxH4VuAijffEcJiC
	 lRUiosTb5K1MSxnKOE+fJo+/BVu+9bVJW5WNX8tO7lWOtkgMkOl8NicA/Az73gnuY0
	 Hx4AC5+olnu8zRn/8M1pG25o/TAtKQcKhJX9qxjdmK+dD8dbpvbtse2XlOwFBen3TD
	 ogLGzdt03UL5sGbQiO5tR0umQPjexXfcOc+JsPZg7Q6Q/C3pqn2DI9fkye1QcOm5IO
	 i6vS9FJfhhMnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/14] mfd: remove unused 88pm80x driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-rtc@vger.kernel.org, robh@kernel.org, media-ci@linuxtv.org, linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
In-Reply-To: <20260909132153.1596191-2-arnd@kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-2-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:37:01 +0000
Message-Id: <20260909133702.4D7381F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> This pair of drivers was originally added as companion chips for pxa/mmp
> SoCs, but the corresponding platform code was never merged, so it has
> been unused the entire time.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909132153.1596=
191-1-arnd@kernel.org?part=3D1

