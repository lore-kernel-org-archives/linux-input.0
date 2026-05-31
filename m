Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E924679C
	for <linux-input@vger.kernel.org>; Sun, 31 May 2026 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780219026; cv=none; b=CK38bZOcoX35g+CBf9hui3QuPq3gx4FFaB7+H7RmciqOFkchOXpAQDF6eQ2oRkRHaDWXTXzsYfPcxq4xYtYC9AVOjx4YAcqJgB5/ivwm4oW6igR/WmoYqaXGGSBzbQqgq9p7nFCmluetoQR/msvKMWQFHyqwrrg0YoQ0jIKnY0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780219026; c=relaxed/simple;
	bh=jHz8CVODyq/bGFHHw1uFbsab5fAepr9pEEGfvssULnA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfD4XiWImYp6wh9il/8TrT+CHFePDGqe2Lc1btpiYt1jWUwZRRBIwhJRQQyuk3b3GPjHstX6S5wek6QGxpLGpy5dSh3PNjfjEwhh7ieg4bmXVbA/LkZ5apl8MnVvZ3iSvWRiRXQZAZr+/bmsHSW6nLbqEyoU1frn4XCcZt6Rt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=kkS0M9o6; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="kkS0M9o6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1780219021; x=1780478221;
	bh=6Mi/KLOUb5arO23rwQT+9y7j1zQmga8RdlBDubg+76U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kkS0M9o65E9vzU0tAQN3sG+1sNy/wqRGMLlBz6rgYzhRrhrKCYAcix10tZSei36Rq
	 A49IY34WBaDVMNn7Zt7eyW4Z3ernS+5S/Vwn2OhMTe3ohROjGNJj1xywXCUJ4X2GiW
	 +ZOD1u1hbuP5jc5AEIZLB702dpCk1xO+PccTCrDCugGA0zfHhMxEhzn8LUt4V2wjP0
	 K4JH90O8bLjt0AUV3k/ykRjl6LzupDieaAVunXpN7Onl7bNyl9FwsCNyJtXZSz8pfq
	 BeGeufQuklPkukCPDtABDmasJ33OVFmaoN44yBoDgl74Qj5o6Ph9Mo9rzcr9nGlM3t
	 dhq+BtB6dMFjg==
Date: Sun, 31 May 2026 09:16:56 +0000
To: y.oudjana@protonmail.com
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Flora Fu <flora.fu@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v2 0/4] MediaTek MT6735+MT6328 SoC/PMIC pair base support
Message-ID: <wQ6oaceRZHkMTNpnvLBdrScK2DqHJ1boThn_3lf03guV83pOD24rG4c-a66ziGBrXPj09-xHK_pJoA1QvsP_wxvGZGT3y8KAhnIXaRERtH0=@protonmail.com>
In-Reply-To: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
References: <20260531-mt6735-pwrap-mt6328-pmic-v2-0-dac37bf92894@protonmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 06f8c2a7c3d9eadd276875d922d56e33b78a84b5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sunday, May 31st, 2026 at 11:10 AM, Yassine Oudjana via B4 Relay <devnul=
l+y.oudjana.protonmail.com@kernel.org> wrote:

> These patches are part of a larger effort to support the MT6735 SoC famil=
y in
> mainline Linux. More patches (unsent or sent and pending review or revisi=
on)
> can be found here[1].
>=20
> This series adds base support for the MediaTek MT6735 SoC and MT6328 PMIC=
 pair.
> This includes PMIC wrapper support on the SoC side and regulators and key=
s on
> the PMIC side. The PMIC has other blocks such as an audio codec and batte=
ry
> charger which can be supported in the future.
>=20
> Changes since v1:
> - Fit regulator definitions in 2 lines and 100 characters whenever possib=
le.
> - Remove get_mode and set_mode ops for regulators that don't support them=
.

Forgot to mention:
- Remove MD register definitions.

>=20
> [1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Yassine Oudjana (4):
>       dt-bindings: mediatek: pwrap: Add MT6735 compatible
>       soc: mediatek: pwrap: Add support for MT6735 and MT6328 SoC/PMIC pa=
ir
>       regulator: Add driver for MediaTek MT6328 PMIC regulators
>       Input: mtk-pmic-keys - Add support for MT6328
>=20
>  .../bindings/soc/mediatek/mediatek,pwrap.yaml      |   1 +
>  drivers/input/keyboard/mtk-pmic-keys.c             |  15 +
>  drivers/regulator/Kconfig                          |   9 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/mt6328-regulator.c               | 500 +++++++++++++++=
++++++
>  drivers/soc/mediatek/mtk-pmic-wrap.c               | 177 +++++++-
>  include/linux/regulator/mt6328-regulator.h         |  49 ++
>  7 files changed, 749 insertions(+), 3 deletions(-)
> ---
> base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
> change-id: 20260531-mt6735-pwrap-mt6328-pmic-de481d5c5e89
>=20
> Best regards,
> --
> Yassine Oudjana <y.oudjana@protonmail.com>
>=20
>=20
> 
