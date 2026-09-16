Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C351FCBC;
	Wed, 16 Sep 2026 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569045; cv=none; b=cW71sFnHd1kiX3sPcURRCsheKqHZ9OWXmyn7kjeGsy6Gh6vgYoG643GgFA1VGnZkAh+UoOvB+t6cebmvISG2S3XO7HAOxt+DE7Id63Bzs/XewNyTT4rbZ+KWX1wMM9faZPaE/yj/XrAWm1kQONskk2CToq1zGDBwPFZ+QsGTpJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569045; c=relaxed/simple;
	bh=kLwMCAGXyJiEdodJAl6IBtwsslfPPzuY7jdwCWLAbzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VQaYjhuU6osqjW/l+E5KH1i4mQVepHHX8St3KknD82WMGG7BZnZaymzCUEQIXacjPOoa9FgfCTVTd0DQxoYYxijJwkp0O/KecXfP6K9s4Nt1NmbnXmYR6ibonku3ItXjrMYAQTl0rsXjRGKhvE1P4ZhaATBARE1/rs7tRTChNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz/ljGC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz/ljGC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB101F00899;
	Wed, 16 Sep 2026 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569042;
	bh=kLwMCAGXyJiEdodJAl6IBtwsslfPPzuY7jdwCWLAbzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bz/ljGC0/B5Zw5OuR5QucGStoy40aiU8jMlEoQCvpC2pDhYZNf+o/ragcos1Y6f/5
	 mE3ZVuA94M/YtxQGp9iBDheFyDf23MT1RWg+XfVlq8c8jovVv1KHvIkN6reW1p5++j
	 ZPHmP4o1jjRoyITK7L+ZojEU/X98uhPFeV6jcP1PTpFtEhEaD6AdBqQatml9G9o/0g
	 hnVMKnNWL2HKN9PBi9UFq78lND+VOsQKqZR7eiOdV+zPxYkE2+XyHvJTr/gaGFFMU2
	 dPpUBNe+ApPWqfLNMtVMVYzHsQKeJ3firvfWArMp41R/ki97s69QYpgDNgzjZhxsVA
	 dPtN4EinnTb+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/19] dt-bindings: display/msm: qcom, mdp5: Add
 MSM8952 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, conor+dt@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, mfd@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-msm8952-initial-support-v2-10-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-10-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:30:41 +0000
Message-Id: <20260916143042.5DB101F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add the compatible for the MDP5 found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D10

