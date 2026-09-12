Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7042429008;
	Sat, 12 Sep 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202538; cv=none; b=b58k0QEVeBXwYuSdaYVCdwD7eLCUjNETcgLLBNPICDqPsm/gulWrk+efSuPbpqO7MxWTCxQl35+aIwcC2Zmp7GVhWc83tYv67huKRZNSg/j+mi3WHiLJ6N4NygWerXi6rd8ff31tkQceq90U7JZl71MQTGYWZPeKjNUElIkbRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202538; c=relaxed/simple;
	bh=EfFVvKa9lCxxEncl+3DaEHvYlcWwtW87kg9k12mJ3tk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lXKqxh1FjS+kA/xyiGyLDeGAw3Xvp7LWPcyJZ3Ndsl8hhoVxW++ai6JH+CAADkXia7BdkEP506A5iQpKcpEhveByS6cCcqDZPgkpy+ndoan2E1Yq3MxwdN5PE+MyVLdlphEbYm93EQvZWGX7lGmvxX+IsbtO8ZuR3Tyi9glhPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVUUaaqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVUUaaqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0279B1F00893;
	Sat, 12 Sep 2026 08:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202536;
	bh=EfFVvKa9lCxxEncl+3DaEHvYlcWwtW87kg9k12mJ3tk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LVUUaaqdtqEfmwhTcV1VpvzG+qZWuJnpA8fWDYs9NGqEuGR5m3Y4rS5XKzcAtzQJB
	 b7oJoRFqe9xPIPnWmAk2M+G7A+ENqYm3/F7CkjSpQ1N15fbjEzj/JQag1UW7Jr7mQV
	 U78RgQ2TMpw9IXOymCUFplD7tGGEdvE6CY84PYK74yb2xyoz14jBJV6ILf4Wemynz0
	 +EsuW7VWlbKjS4y5bq50DaZ3W0+MfAdQ1R+5EV5u/9J2cz7FG7GdVvvcNBjXSidVGP
	 hNRWoeOyw7R+0c0AfUCtWWASjUZntn64tSbiDlM9C4aiYm6/JspGyVP8oi4W+IdjWR
	 cHBrKjl2ztEKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 04/20] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, mfd@lists.linux.dev, dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-4-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-4-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:42:15 +0000
Message-Id: <20260912084216.0279B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the compatible for the rpmpd found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D4

