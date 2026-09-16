Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A151A736;
	Wed, 16 Sep 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568740; cv=none; b=euemhd2ftZ/rkmYUf403lhNfMHXGtOFAa7hIEIVIquVn4A982futaT3NGi9Q/2mp2kNNRfx7J2BOKpTfyRwGUcpwBTGytR65yke/M4QpVHovfWATTqnG2jophroLw0YwiECihWmiz6aQUEdL4SMrWWG6kIb8eln4mjnLGLwoqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568740; c=relaxed/simple;
	bh=IpdiSSGwSt1aQj4eb/hpjw2YAEYJmBmtbJNJ7SSVmMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pz6jkT5oYolMlnIoIs/rWApdi3HU7tNA3ABR/kbPZcbnH3G0+auYCXKkEymgCzsoLgn5qz3Kd9HEVudDH64RYMtdwOnrPbRuk1ewo99307KRD5POADIysSDKk+uPh5siD+pjTRcDtl510bvuJLJUOZdwX1daS1izwQJuOAn4+v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aILRVYGC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aILRVYGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CB41F0089A;
	Wed, 16 Sep 2026 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568738;
	bh=IpdiSSGwSt1aQj4eb/hpjw2YAEYJmBmtbJNJ7SSVmMI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aILRVYGCytaC4RBLhqxzhs5YzZd4p9KqvjFD1Yvd6CczrfBQqV7cGsKUfGHkI6eMk
	 XZkobmT0GNIwxNEaQCN4xH9KQ5ius1nZccFuWZ3pVtGv1myOgGBNHKVBJwB00WNTzf
	 vCeFAB1g9Z72to4piG4LGfU/CGt3DQ09iEfJtjPV3SUCahcDCFfPYupdLBsvd96MyP
	 3W8T1XWBlpzNPioJIeM4Hrq93fQQDnfuz8jbESImKiC6q+OrruaumvX9d2tAQWK8rW
	 qGi2nyH4LNXoRBF0ESLtEzp152865MecfHHIMrsrNS+FQlfOoDFY6/F6TkG/weRbCk
	 RXRCHCH5NFiqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/19] dt-bindings: vendor-prefixes: Add General
 Mobile
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-6-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-6-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:25:37 +0000
Message-Id: <20260916142538.87CB41F0089A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D6

