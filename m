Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5A51355F;
	Wed, 16 Sep 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568987; cv=none; b=hA1H/oCF+Dorf2B3Ux45nOQW5KrPpLmGWEY9Kg/+W9xPg3Gah79sKmC7sstfUfh79FVE5o4Wkw3GcVZFFdHi17ZAMJwHETBUhYu3wvgCiNqd+oyQvVcCUoNMFsOQaqHHgjUtZKpksdmISPYgQ3yWiSTRmqFACz99adJnKHvgMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568987; c=relaxed/simple;
	bh=ZNo4I4BwfpUdfZF/eYBVmz+/Ycx+iBQCfdxGUZQNIyE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G0CDNGlAjXVpjbJoUc+Xx3rpmn0TyOjVookIOEKVI8EiWh25ohP4rOA5U3fTfsY8FfsAQvnj9MdF4GTXdWgcJZ174QxZY51ng9JBj3EijqOgG4mUlZNWUlw8wwBRtHk19DIws7d/toYltt42v8jSwtJm0J9VU0MgUfuP2x+wNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUpUb+6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUpUb+6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D741F000FF;
	Wed, 16 Sep 2026 14:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568986;
	bh=ZNo4I4BwfpUdfZF/eYBVmz+/Ycx+iBQCfdxGUZQNIyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUpUb+6YUYEPa+BcFxqmN4Yqxrc3C/r79+nDmE3xlXlgPcjHpF64Nyw8bMv11fAag
	 3DcclRd5DxXXNsTfSKStzi6i8RDId2LyzyqEZwMqoWb9aj1bXvdS/Pli5T9GfrCwXk
	 bNYAq7P8MU6AaxJbcl8OmHQYOoB4RpgVZzsNNPjusUqMlMm7nyB2nQ0uD6JxhSAmUR
	 73Mbapsb5WOI7cASvjhGrGLQjkUc9H0JfbKSy54KvdrWZiBbyWW+DlBvmYctjytuvZ
	 ribLKUoqj3uguuLJcm8Nk3Vm+qD/gOm1+fNteNUuuOchJKO5qeie5h2QhXRZzA4MpY
	 Qjzjp/Fn8oN6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/19] dt-bindings: arm: qcom: Document MSM8952 SoC
 binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, linux-clk@vger.kernel.org, lee@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-7-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:29:44 +0000
Message-Id: <20260916142945.67D741F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the MSM8952 and add General Mobile shamrock to it.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D7

