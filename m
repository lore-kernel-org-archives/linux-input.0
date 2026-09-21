Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FE4AFE32;
	Mon, 21 Sep 2026 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015169; cv=none; b=kpf54vkr7bVvJ1jbXuK/rDj13bw4F8Z3PcftkLjB5i7TC5zvHujuT5hEbUNbDe1pPnyY19XCi48Jq04f0wkD+aoV4Tr8KnAKBPtOCoeQEY4Jxfc0Ybys4z9o+xN+AAh+8AEkAWkKVFp6Lh68LGMcZXi/liWzi5v1RGJxL9qjGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015169; c=relaxed/simple;
	bh=Dy4ks4r1jC0danVqhDaLYNAadxSRMpv51HmmJl36a8c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fF1og3si4jMsPmQ0j+qmAr3mKnPVHlKwEwGPN15mPIPDfMxMtvf4VxtgYsa9jHesMQ4PAd/ztv3yR6RCHHtrspNQed+HROrg7qJhHUUOk6+1gF9dUY7zwAdPX79mv/LIS4qqqwRco+n7wHssLzsYYClwrfjoblmXQ7XbsG6L99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg2iPt+j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg2iPt+j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997891F000FF;
	Mon, 21 Sep 2026 18:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790015168;
	bh=Dy4ks4r1jC0danVqhDaLYNAadxSRMpv51HmmJl36a8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eg2iPt+jnMaeBP0QILs3RC/4CVk0iEOgjXZmkTP9kJQCYct6i7zqg8tFw7p8YV8vB
	 yI5/EObchHGnlasU1cite1ksx2gy4K5GKAFUgcAPcg7znOdvYyS8EVYOqbQy3HR5EY
	 ZqL6eCKH59smT/FhAFn4K85TOlMdSQEKh0c8UPXOwj0geQbzGWv94K1Db1pb2JmnpG
	 AcBDyKLMMX9ZbWj9DgzXkqGsLN7V5YQqbOjQMSXvwu2axP1OClIEh/ETev9h28POX4
	 XHJ/v0YMY0AiW9sNhJL0SRLLecCvxaXp3U6b1CKz5nRn+jpY6Le8YNBMMidAecrwt7
	 CYGkG2iMD40Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/19] dt-bindings: thermal: tsens: Add MSM8952
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, lee@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-15-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-15-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:26:06 +0000
Message-Id: <20260921182606.997891F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Add compatible string for tsens block found in MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D15

