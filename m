Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7CF517BC5;
	Wed, 16 Sep 2026 14:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568955; cv=none; b=tX7j7GW0H7UyfiruHhw7qPkdEPuzfoxjMMR9ZmAGF6ar4VQC0pgeaN9L+RMoadn02y5RAvRk4Z2/2vuh6jObPFR3SvQCS9odF3MYKTYdXOULdK6jbeDfHYHqj635bXcq2yBLoh0jjGkRiL/mo+aAx/7LcsvTvNKlXak8lOdeVks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568955; c=relaxed/simple;
	bh=l6OLpuiTCzyGtg21re1Q4j7YWZJh8rW4+8RjR2l/7hY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tU7TuoMeSLO1tynnq1RITk969Yg9mh5Z46r0zFCTnNIYQYiQrTgv7/BXrC4jgNLthqZziuKQpv1bg0rTHql1xpqZ6gBlceSrusFxD4ICA3gePHRVYFqBWlnFLOnaMcxdXf+RUL8jL1iXNzHKGanU9paamLa3IaP3w3F7wryVUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ua7f+cgD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ua7f+cgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A631F00898;
	Wed, 16 Sep 2026 14:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568954;
	bh=l6OLpuiTCzyGtg21re1Q4j7YWZJh8rW4+8RjR2l/7hY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ua7f+cgD932uIjdXchyObhMtJdVOu336cmZ1Il7f+mW3QYZkj/LM4YXeKf39Seae+
	 zMituMn2/0Pu+HF9eYfn7+nFcicxyLw+5V8egbD7ti9T1rpUfsS8PoaIXxI/AtkM2x
	 BaBBEyCnw6Bat6MZkBA1jCX1DVvv69MdMFAbqfGaXU9XnqC2xOF8HGRqlgJOrWzFDN
	 VQbWSwRfeQA0BTsYwFgf0fNzb4V/6ZixBtotrBHU8Gid6s14wSj3Jh/APS6UBp2mXy
	 bltQvKoCUkWp3LwUFsosCS9ym2TEVVbmESlhA2FbsRXepbcrtMURGEwSa8qjGyTEew
	 CzO80JOquxegA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/19] dt-bindings: input: touchscreen: goodix: Add
 binding for GT970
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260916-msm8952-initial-support-v2-18-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-18-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:29:13 +0000
Message-Id: <20260916142913.D7A631F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> GT970 works with GT911 driver, document it to be
> used with GT911 compatible.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D18

