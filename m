Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227245111A4;
	Wed, 16 Sep 2026 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568877; cv=none; b=Dp1dHKxm/9jO3QzjcNYRSdANn83FaPCB6XG6HAy6CeafWYZQZ1OUiD+Gv+ShnuRUis9uiG5P6VOEWPhLpn4mEWrbhAfyBOpVwdqYTh1oKEdk1kwAmXvwmVZPk209RVGfMgdf0Vna5m0gn5v0RYbGCNM2zHHZC4Mg/5BSkFNB7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568877; c=relaxed/simple;
	bh=gGNMMwwE8I4VtksDzzEPRhztJWxVt6+Rp9K8tUrO2sk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BijpsPUs4ppq+UpFGmWgjAbmy/HqrnUAdKX1xq30pezQMSwBrZwihYZM5Zm9vEbxmlkqPZMgix5wieVVBB43d+JR8FV27dBfontHD8qUlr1EAmuIhxEeb+44sJOQ3SsUKmwzzAp7id/aL6olFBSqb41Zys8yc2P3JgwjNYhsIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTpJSUp2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTpJSUp2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9DF1F000FF;
	Wed, 16 Sep 2026 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789568875;
	bh=gGNMMwwE8I4VtksDzzEPRhztJWxVt6+Rp9K8tUrO2sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JTpJSUp2Z5D5ia+0VWHI+LMPD4v+FCYNgFSLdRozkv/vZMkdbg8Hz07pgQHGDVJ7n
	 kouu6CRv/juYtlZ7J+rRDDcryfq/piCfNurmPMb/RO1+Zmcrooe/VtRXmXLgOkH2Bj
	 wbSTXZTD9AaNoCoMVtq+HKMEMritjbldpJz8C5FpqeoTX7ArADB1/t0FvZ4J1xYPpG
	 gr/RAw4TlflfuzIGe4cdndwamgQ1MO+2+MJ8bgj0zgqJL1I8vdZoF+R6+rgxK1MawR
	 +nV5+gKtDTDugZc8N+AQUpdQADlgaFIgBWxgt+N/QGV75E8jz5vuqAkHdyM1AwpE/Q
	 pzgjSFSSlEPOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/19] dt-bindings: power: rpmpd: Add MSM8952 power
 domains
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, lee@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-4-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-4-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:54 +0000
Message-Id: <20260916142755.2D9DF1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D4

