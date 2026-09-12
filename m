Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1873443A89;
	Sat, 12 Sep 2026 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789202764; cv=none; b=GcujCxgUYv5q6XZxCmvzIRel5BMW9haA8bJh7X9ItTGe4Lvn3Vq37Nj7LzXPxKOL5b1KPDh0ZIWFsBpOWWw3OS8tZJovCX6X+tDUYVjxAO7O7IcB8HO40SserXhGODh/UxQOak+9C77rCT8XuDrsSKHGkaJC/MC+PcIj2kfSY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789202764; c=relaxed/simple;
	bh=EbiN6qcb6ib4gQxuJkV891vWo2M9sNzIViJKt9b1nFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ikC083E85In92PHSZYJwx0bgq+DwMrqJFD5aYUqADi8/9kK1Qu78pMr/ts7PKaV/pw5lcUdFFVpbH6zMSJw+M29UpPaAvit9xmn3m/WChRAyzkMMPAqvJSM1D7GChzksdaHC8IXRzTDr4mE2bm+sKSXxuZ8aV2hdmcF+NyTfvrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9AHh0hI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9AHh0hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE1C1F00893;
	Sat, 12 Sep 2026 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789202762;
	bh=EbiN6qcb6ib4gQxuJkV891vWo2M9sNzIViJKt9b1nFA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h9AHh0hIPP/5b/7gvKpwVoFTeI9vgNsCc+w4pMTZ6MMLw+V3B9DdEI8e1L0c7sf6R
	 Nel/6GR+ZHASpbJU6rknu4cex2x3E0svKQTXsuPi5UVMJXyP+ac36SzFrQtCuEIs5m
	 16Da46wy0tyAkU6ZTez1uvtA4v9Z5legavgGxtRdxKj8F1BjmMiVzC5/hM6pAC27J0
	 AlxDcDUz7Y3b9xBoq52rkWtFRYoS9c3dMnEeZoyILmhCu+FPSKKupCRKrCjF5/1MlT
	 jkhPRVheMDti+Ck8L7tfi3j4iY2bVnQ4YRxNwfGcP0c3pjVgullsemX4S1U8KG7WRg
	 19XYS5TPWUU4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/20] dt-bindings: clock: qcom,rpmcc: Add MSM8952
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, lee@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, conor+dt@kernel.org, linux-clk@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-12-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-12-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:46:01 +0000
Message-Id: <20260912084602.3BE1C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the rpmcc found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D12

