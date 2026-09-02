Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D338737E;
	Wed,  2 Sep 2026 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788382212; cv=none; b=sfGpOS5oaeVu4+Ga2yJWSyskIvEE5DQPLT9y8fjnMpMrBw4RW0rP4GCklJjH+J0KCXSaj3Dw6Y3uRphlWCcEze9TP1ERfNo2r8addzrgmEx36S1QRGndCucWl//Y1XQacmG4PCccwP09Brm44dEkDwpwPakiB5+4LZdgyKniwLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788382212; c=relaxed/simple;
	bh=ZOdsf65sLhrD1clpZ2NrZTAGuthpLE9qonvpvHPravY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJ6+7v3zbKkcXk7RJJFlQdlO5a8yF4JZ3wi3vQ1YXBldxbSxeV0SumKEvrgrVPjgpjtKf7fZ9o8crfCTiWQZ79HgnNmhQdyJ9qqbLemOwIHoZTuJdJ2R5PqSZrBR4PePk5OmmvLZxrCXDbf4xjysfQzcOqW/pm3NW1M+ujvZqsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVtbiabX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVtbiabX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5C41F000E9;
	Wed,  2 Sep 2026 20:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788382210;
	bh=ZOdsf65sLhrD1clpZ2NrZTAGuthpLE9qonvpvHPravY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DVtbiabXNbylfD2vMONRVKGMZJcbXh4ZJ4J12P4J3IroA5blJQjT9av8ipKzcJYRS
	 D460E6SAUr/bVsCVHglTlY+gVceUC4+41kTPlXCQi41JXlba0xzhVZ10DtyuSMcEUB
	 V2XEZ+yqnIRDmYwmkdxT2+rhGuf0rpS532XwbZaUG6q4+zWf4A+UUQbJbDiy/eNEtb
	 XJHJUHhCOlrmLYr+bW3b4/Ed+jiqNhmA7D39qKFzA8ktnLT4kHeOfuCCFUbxyN719y
	 rRLgVr/QauoOWTDkkjpJdIAQWplqJTkqy+IY9pwa3xyPLMdr+IF21dkW1CV/TQFqY6
	 0jrp6dRoLUGtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org, lee@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260902193351.185771-8-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-8-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 20:50:09 +0000
Message-Id: <20260902205010.1C5C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Add support for the MT6392 pinctrl device, which is very similar to
> MT6397 with a handful of different property values and its own pins
> definition.
>=20
> Update the MT6397 driver to retrieve device data from the match table and
> use it for driver init.
>=20
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D7

