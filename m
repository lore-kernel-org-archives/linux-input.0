Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E436E484;
	Sat, 12 Sep 2026 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202477; cv=none; b=NGPtVmkaN1EEQisthHSK7EkW75XE234SclyyTPE5y2npie7yKmV3PfVJCYtJOEvz5D//ci+F/cVM/7VYRzv6gbhEHOFMlrwBRSvK4vORiG4b4twzX6L14my7/I5EhKhVUFLba5uulb8lCCCkxUyuBXDhu7d5Y2yczlJw8YZzH8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202477; c=relaxed/simple;
	bh=9GJSBK27NdknLZevfr534GsBFcHqjNITB+5Ar8rgZAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DjMGoVqu91SSjtqfK7cfqfHjxzkudUkgM3HRRNa8ElubBRrxE0VnJ63RKW3LwZshBRcvnP0Hgww7bmZ9jHdMuCWWVfIQmCNRExs2but+yr1CeBW65lRGaBcU9MYU1tHOZt2YN0AF0iZI7L4Tu7fj4Ss290VzFT4ji+PdP99WszE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkqtJRlt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkqtJRlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B331F000FF;
	Sat, 12 Sep 2026 08:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202475;
	bh=9GJSBK27NdknLZevfr534GsBFcHqjNITB+5Ar8rgZAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UkqtJRltQg8lfB/pVB1KdiMDE5kzY2N4x9UqDCkci/W1vxrh/xgSBar2h649atsos
	 GYH/ZdjY8wfXlBTlckRkblicAvUzZTgNoHRr/pGGmhCAa1iwiZqUEi2rPvE60X5EGI
	 5ciC+94L0jbge5C/ucDm3JxkMHOwfX0jTgPye0TLaZTjgzjbvsVkkqVqEc9x0C7unY
	 JMGBR3aMysut+Vuhh28Xm/l/8f7riggzA1r+he/64rk0egEubJDSw3/hERhW+Dfbdv
	 kHuxznwB7oihTy9LlKzPUep9CWVGEEhF/CCrp6kbPrFvO1q6e5bmAau7l1+Rgn13OQ
	 90/cEn6da78yQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 06/20] dt-bindings: vendor-prefixes: Add General
 Mobile
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: robh@kernel.org, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-6-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-6-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:41:14 +0000
Message-Id: <20260912084115.05B331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add vendor prefix for General Mobile.
> Link: https://www.generalmobile.com
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D6

