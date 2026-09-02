Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7943553D;
	Wed,  2 Sep 2026 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378125; cv=none; b=Fl3Qq3m0GXn7230Wcmk5DLKLiYpXPJ56o11zNV8SSxbwY4a+lrM1WYaGVZTBSmhdbv8YB4uaDTV/Or85TLj41pIY/r6wxd6oucBY4ycNwbUv6oDsvQrtFuocwJlo99ImwWg+fnJT3EFdpIwIaQ7PrU5JaLDzoisd+QPS8umDmvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378125; c=relaxed/simple;
	bh=IMvlN0DW8CvTJmhR++UJE7CIHLQAJuk+oTC9T0u2eIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mZF2oY+3VhA/CUXHVKBQRlpQeCFsXm54dNWlPHda01M5LUYoe+Bt+cnsOfja0yO9TLLjR+yO/1d4a+W+lWrA6W1yxjZTvvtJ9uzeloccF81zIjmWu/I+GhVUjMx6eH8soWLevAMWIrYsyE+YUQrTc74cRogjYwO9GbZA7hnUyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMCvLN/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMCvLN/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48451F000E9;
	Wed,  2 Sep 2026 19:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788378117;
	bh=IMvlN0DW8CvTJmhR++UJE7CIHLQAJuk+oTC9T0u2eIg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMCvLN/rJjemP3OQrbfeGbyIXJAM08BNbnjoivfxXPOzXag9MKmj0iakmjiBh0ryx
	 SZ1ZBFuv4jKP5vAqZE6LT7jVZfvNclNQH+HZJkBNRlJnYy/WIn3mWWGXF54O5GqV1k
	 l0h842RlRJN+fWgmxCilQgbsxW+AgWqD1m2lTNEyATc+aIi2qg/wi1E9K0ZN7Fo2zG
	 yWpEKOzkJbxY55lwJdQ2NZPsc1u5PkIwVLpLr3NrqwEvd6BzjImk5O1x0dHm02fC77
	 FEZFtEN4R50rg2e7A8SS28Kma7kbImD4AMYOZjgeHwtpzbHXxLfRWWln6MRUSB1DnC
	 TUQmNrzGH75lw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: dmitry.torokhov@gmail.com, mfd@lists.linux.dev, conor+dt@kernel.org, lee@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260902193351.185771-2-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
 <20260902193351.185771-2-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 19:41:56 +0000
Message-Id: <20260902194156.C48451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Describe the MT6392 PMIC and its RTC and regulator devices. This device
> is mostly based on MT6323 with some similarities to MT6397 and is usually
> found on boards using the MT8516/MT8167 SoC.
>=20
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902193351.1857=
71-1-l.scorcia@gmail.com?part=3D1

