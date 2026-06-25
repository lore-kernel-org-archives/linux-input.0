Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229EB2253EB;
	Thu, 25 Jun 2026 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375755; cv=none; b=GTeFqXa7Snx0i31B3W3ERKTqg0OyZJMhu4WnkGJqZJ/wP71HfWULcMCJFT8VhrfFfN9nfNxAH68m2U9Y8r49HokWbXydUTsiX+I1HnTyubr594tngYownJe/IyYqSnDt0/RCmjMk4/OzWPygjJJQEnRa6qVHpaUxr0vDpijiLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375755; c=relaxed/simple;
	bh=EWYYWzY5LGNLs9iTL2sOMPGHuaVNyHjvMgXoaG7+ipM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glc5iotsXwmgCTJMRInvTgAdLh8KfQ7g0gyjUrK6kg7tyfsqR5Z4/clC1bFsCmBCWKcYhTODkz98m7zBpWElJrryXOUKM6MNO7XCaw8yLHtO8bEJA8jCB8JzB3ImsK1ldwrtH3t0qMry9r4Ylw2oqV72DG+DoGXu2fLvVOSGEFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA8Bbgzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA8Bbgzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD0E1F000E9;
	Thu, 25 Jun 2026 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782375753;
	bh=EWYYWzY5LGNLs9iTL2sOMPGHuaVNyHjvMgXoaG7+ipM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KA8Bbgzpn+WLeecrEA/sZJzPfMIJdsxJAilb7lfX32UTI4hHNPnnP1Mp33OLkRYhg
	 K1LRtjO0S2+TI2QWI14V1lZSZt87itlVrmUg+trWqOJRxBWFiju3EC97p97d8+HsSc
	 CljiLJncq5EQpEYU2hguuiW3Svmx6OjOoP67o+r0jyZm076h0+sS8JvfQJT1jCbwBA
	 Wi9JsriK8EfkB06N9Pah33JqN1m0rt0YLQhyUhn4UVjoEupuUh2QDlQopUY2H0tS9e
	 7eEkV+ig6NqBmI3rXI3U14Iho1PI7XtP65zh9eIR+4MOvCsM8prddOlB6hqTmJCso8
	 evU/tGrtBx9LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/7] leds: Add driver for ASUS Transformer LEDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260625081529.22447-6-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
 <20260625081529.22447-6-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:22:32 +0000
Message-Id: <20260625082233.4BD0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> ASUS Transformer tablets have a green and an amber LED on both the Pad
> and the Dock. If both LEDs are enabled simultaneously, the emitted light
> will be yellow.
>=20
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081529.2244=
7-1-clamor95@gmail.com?part=3D5

