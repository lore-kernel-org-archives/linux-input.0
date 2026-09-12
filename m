Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9B418355;
	Sat, 12 Sep 2026 08:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202576; cv=none; b=YeeHwBJWpPVA1wV8toQg0Bp656dNn9nShEK82Gn82nmwlSwIVfFZO8etXmA2mEpXro63iTvYWjzCIwPePVJm8nDF4/C8m4iG5m1h5Q8vi+hemED/7XVM6PlABAXoTyHs16COC/2U/ygJj8Qgcg28+RnnHYeHj1T2atVZ568GuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202576; c=relaxed/simple;
	bh=CHm8qz07+DxjMB5pPp6QEU4lM4MrohOHBKzrpQgl4AI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CT/OUyey45VG0fuGz2U3DOslMf1JtZmeqC27SyVYXaVRu94Qsmvc9WwlmvCwl61YbzOBn2kzRPxmCnBX8q8g5ByrNnHc52x7ctsTOpwakrd8mDgJGsXsdSxtRTX8BhzV5X3hAhShOI28ufmjSSWCvN85rpJ6iVLb6U8JEQISRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjOPC+AS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjOPC+AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640631F000FF;
	Sat, 12 Sep 2026 08:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202575;
	bh=CHm8qz07+DxjMB5pPp6QEU4lM4MrohOHBKzrpQgl4AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CjOPC+ASfYekTjBBKt3frqgMC75gG3RJ/sWLATF5nX89iZw4CRnN7Piu3Ef7ZbkPS
	 K7Qbczgn+JIRSWAu39r3XpoTgJshzNmwmg53/cWASc3igjRpy3kY3DEQPAlxanJuIO
	 3O5H608MIfT9hdEER7dE9J1o3Q/CYID8G8Syzy9sEr4t4/uvd5vDxsa8bePmVZCpqF
	 M6iMTGl4LKReLrdxtwyMztnArAq+2Y1Um8U8RZIxBKLalEmt7RYSACTFhV7ysnLJ7g
	 4et6vX65fzVqXFx4e4R1UOM5BQAXSCfLX83mDiblSeLvPBpkVZs6Bk+v5B+VAePcH+
	 qakTTQydwqXqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/20] dt-bindings: mfd: qcom,tcsr: Add compatible
 for MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, lee@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-9-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-9-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:42:53 +0000
Message-Id: <20260912084254.640631F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the qcom,tcsr-msm8952 compatible.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D9

