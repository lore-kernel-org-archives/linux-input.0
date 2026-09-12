Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B4F41D648;
	Sat, 12 Sep 2026 08:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202656; cv=none; b=UuXII5RBDQp4AgtwTjjy8P7so18/bjr8aHUV+mGR5/Oc9FmKaO9vB2LtFCyKwkEdkKZNAizVybJfPwV+G3lsTsk98sOWm5k19pRpyXrV09cGu5s4nxlYNn1ieC1mnYOUxP7ZvPfnw1gxBXmPELFF60cMXQun9LDp710mtDAYgUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202656; c=relaxed/simple;
	bh=+ABGxwCNM5sZ8CTJo3fIHMUsTnJTARAjJDSqtXXGjIM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=no9k3iQ2FJzzfoPyV8FxweHCJ6ReeSrDQpDxYN4+GqYBuCzZWrTaNDG6VppFuw1KaB0VKbIIP4WA27sUUIijGSjuZQWYzq8lqTnZ/p33681KYXLYyZVb6Acjx+6GzgGcsLqs1YZexkIeF7C2SEr/vrhNoyjerSnoaWrYdE48UXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTjUWmyM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTjUWmyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64911F000FF;
	Sat, 12 Sep 2026 08:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202654;
	bh=+ABGxwCNM5sZ8CTJo3fIHMUsTnJTARAjJDSqtXXGjIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XTjUWmyMyMnXKzpKCYieoaZ2P0gcDT4cJQQ6fsOd754YUlLaxFSktLThXImKILyXN
	 dcxcVi92ARbi8/Fh//qaodskNgMWbVsLTpuds68dx73zbnHjiYLSDo8WFcjlN6FhWn
	 1XqYs7U+tMiYcPmbQql7O1nyZSDwdhUhvynu12I3Vk2xyhHKKtuxBjSd0zHoSuexad
	 UJ+CWZRMQo7ss3MSrw3F5MaaWkLIEpsSswI7oG3ewprlGCXDSUzd8nzEI6u0RePyIl
	 JcftA01Ahk6WARhYuJXGVLcQLRvGN555Xm5r/c0XPzioP36ZC6lHwkmt0lV/aqom6k
	 UOVA36lt98IpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/20] dt-bindings: firmware: qcom,scm: Document
 MSM8952 SCM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, mfd@lists.linux.dev, linux-input@vger.kernel.org, lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-11-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-11-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:44:13 +0000
Message-Id: <20260912084413.C64911F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the scm compatible for msm8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D11

