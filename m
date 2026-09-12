Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BA42AF9C;
	Sat, 12 Sep 2026 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202553; cv=none; b=ojS/TEq8NNOMTRuwwbBUx/VzHUEnnmC7VXSSmTZGOyatZ+5+dDF3sTlESQoNl7j+ZZeAtFq9c0QfhONvqJjPbqiUOd66LKv4f8D4czKAurlt0V3E+TpbvSqv0SuNXXP0/hGCn7BYb2ZPdza3ARtBzHOL4E9TtCKEHQ+bqwhUE7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202553; c=relaxed/simple;
	bh=i8QwjHgF8l/gFvh8nvLa7/xrYHU0QQ7sieur/d3zdp4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GAZJOSpYByiIQYVT0aq88NdyU1vwerYmnoP/N+lA71MmPxrh0YdV4EFTM1eoxhGsM+2CoXQwNJPE2UKT6ae2XmvfUZL7yyAyniri0eKhGeL1aei8z0arB73EokKktydVOxR8nQOMyalNfNaxatKYj73ymbmRQd043EwWjP2BxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKjDTjJQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKjDTjJQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178DB1F000FF;
	Sat, 12 Sep 2026 08:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202552;
	bh=i8QwjHgF8l/gFvh8nvLa7/xrYHU0QQ7sieur/d3zdp4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JKjDTjJQoefKF2IYBAV0V+WBSEV9Z3cpmYrUO8TbT5c0t6whV/CneYPVLU/0Q/zdc
	 ky9XwuEU56dxprIR4WoXjkPn/+rCOCBzh5HTtAQPm0f5OUvDF8ArpYoPaiiC8rbse5
	 sS6e1vevKG8dFqS3NiQqtbBrqO02E/GI79/HqZ4ZThXrpe42TNbvXpzIj/dBK5UndU
	 QsYbzUtc6QU+WLDPpUOcO6KajYOa3U0KbqzM9/PacPMW5ERPeDolfQco9f/dLHqEOd
	 e1Xc2+QJjWhRjn9spko+S3n4Xkc/fwItDPEGgzE29sVUNKRyTtWfm+M36Mzd1Db2lh
	 OgcVJgjAP/c/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/20] dt-bindings: nvmem: Add compatible for
 MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-3-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-3-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:42:31 +0000
Message-Id: <20260912084232.178DB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the QFPROM block found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D3

