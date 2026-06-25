Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA12D97BA;
	Thu, 25 Jun 2026 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376280; cv=none; b=Z/Z2O6vseNUIuHAMk1UNbFysmkQ4NPq5203zl2CcD1k1676XiICxH0HZ61pAPonzOpxaO4znF+4g1K7HvqczpNoPUznzB0S7fILSBRkL1L4vpaXkLl9xvmQNHMHXiRwfLEk2C3llYYj8ni9jiIJBUoU0rsgLjYJnliYgZblT6Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376280; c=relaxed/simple;
	bh=TTMlmIAYYHhiIV5FH8zWh9b/3lHF/mx58P0IgJj6BhU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hf4U6+wFF0z6idLtsZiTgGdBuA8UKrI622AceDjLyV+CPOoidtKmFi0FKNXGX5y4SDj4toe08693daXlYDk9TJ/kvC82FrKP8Kp1Qrv3xx/tKqEuNyseeVjjHvaLw2p8zylZJNwlbPiFUMaLawanKg4NTvScXVY6ddTKmYaM5Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMigrpl+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMigrpl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF221F000E9;
	Thu, 25 Jun 2026 08:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782376279;
	bh=TTMlmIAYYHhiIV5FH8zWh9b/3lHF/mx58P0IgJj6BhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CMigrpl+3wHZ9sR/9gkDDKDEeaWa3xMVMlLK2Ai3fnxVtRoMRn8NtVsFa2ZnCxqz1
	 jUWXugwpZR3kIf70guW3C7ieW5xlRc+SV8fgstdVAnFTL4Nqu3Vzt0PAZH3NsVOoIF
	 7K3CUSYqi/vA3zv6jCq2mJnSw0EVnnVs08eu14ajagf7TR3Aj1Scfo/m1J3NrppIhZ
	 0QRD5Gi00L/qxATwvizIRTEI1g5ypU7ThrrrPL2QupOFU4IPhfeGY1pnHp9b5oSJAX
	 cZ+d0aF5mzspFpXd+qJGPgeH7C5dXsD+ZhBbPR6tlmZmEdW8heLosUXXxn28yWJ57A
	 fLfH942SfRjaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/7] power: supply: Add driver for ASUS Transformer
 battery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-leds@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260625081529.22447-7-clamor95@gmail.com>
References: <20260625081529.22447-1-clamor95@gmail.com>
 <20260625081529.22447-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 08:31:18 +0000
Message-Id: <20260625083118.DFF221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> Driver implements one battery cell per EC controller and supports reading
> of battery status for ASUS Transformer's pad and mobile dock.
>=20
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625081529.2244=
7-1-clamor95@gmail.com?part=3D6

