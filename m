Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCA41D650;
	Thu, 23 Jul 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802165; cv=none; b=nZMLphYjr9W4bpQiXj6YyQiHVBCHFqB/kuci2r3qraKCpPZM7pBlpVByIrvO86TYdtSQiQt6C/LNzMx4gfcv7OhjOlHdMEHTCEj9aAWok3d4ZAP+Ge8xCMMpnNnLuLFi6dn+y3ZZLvteNR7FbJhYrZ3ZhopKLcjTEV1WxI9rLhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802165; c=relaxed/simple;
	bh=SVE0WBK1ETYot1oQG4Aeb/YUZ11+jFDmTVNkmlwJaRc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kdVbAsw2hQBfT/ghSn/GnkNEG4j1iNTTP43ZE72MWZQjFIBJ1s/BTJrRvkIZ1NOOoQ4FsHQKedUUIN3Yof0gYH9TsHJv2l/j8xq5PDwe05MC7V5rk04dRL9kWF+sU5N6dOPtPgP0PbeyeIF+hQjqQBhtcbqDnCRsQecSOVrgLqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPGaGmLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPGaGmLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9091F000E9;
	Thu, 23 Jul 2026 10:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784802164;
	bh=SVE0WBK1ETYot1oQG4Aeb/YUZ11+jFDmTVNkmlwJaRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JPGaGmLvtgpo8MI8V2qY9XdBriY5hKyR1v9aX6q5FRJpFukXxeTh/8iFwN6SHDxtv
	 nToG6lJ+KcJvwAseD/0jMczKie7v7ohQgM0HbxBtOHLbdQSxpJbSmvSqf8mT3jYkqC
	 WSTWqjqseuVLYxo+2S602wQMAQFExj4+xdLx42M0ImtSel2COkyq7rRt7IjglT8GdM
	 qLtD1uw8EkkxtQmTMY2hAGd7f3KaByiA3kOpCbUOujtW5T8JBE8l/LiVzrecjxusoB
	 CO/LgiOtNSZOdNG2Osz4EsiSrl3PjxHmz9EnLtZM84gSrFAjEVnpNtc0tDPKJ8j1vH
	 Bgvy5oopDm2IQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260723100605.628882-4-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
 <20260723100605.628882-4-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:22:43 +0000
Message-Id: <20260723102243.BC9091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100605.6288=
82-1-egbostina@gmail.com?part=3D3

