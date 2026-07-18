Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB512931C6;
	Sat, 18 Jul 2026 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411979; cv=none; b=STYwrx7SMoHubhBunPJeeHoBEc9fjTjGCS4+T2okvNpBXNEoVsSM6QEp00MagyP/iapdJHd2pcRPn48I65uKkDRX+YbQIT9gxky2A30O8f3rvjcuHkylFQPKV2VKWFqRh6gS6iuhsie2XlJ2RtjL7I435KllxCIFamRaTHtKLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411979; c=relaxed/simple;
	bh=AYt4bTL22XRla8JWYxmAo40Jg3WCRJP9kLovVPMZAu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CXtHQxqOej50mENRyzdSJ7gt+WtZshVceIf4TT8OEfX0CBUgL4Y7n5uRq9xf6t6WjovTqoyv2EaU7OwGlTd8PVqtnZlMRIYBtWFOGuOM/isjGuxa0neb4J1HzQfUE3PXetr9u0ebPTZ/W2g/EiSyBmX14fv7xe8IaRYDX2Tz/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbWwWNR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbWwWNR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E651F000E9;
	Sat, 18 Jul 2026 21:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784411977;
	bh=AYt4bTL22XRla8JWYxmAo40Jg3WCRJP9kLovVPMZAu8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbWwWNR+R8+jHi8BxAsEqYZb7O+bSTJ2smF3wRl2c6ju07VxXD/I2ZBNPvCyxsgQ0
	 nOvCrMnbyP39YZ0rSORBhcAozQSM5hl94VPVFneLz/snrARtfCYeut78ilHpz+6xov
	 j9PZh/yKhYnh3dZfBtjJ7QIPCJp+jelx+qNDBZGdtD+3Gm9tS2jSxyghFpvTp9rNb2
	 j4PFklSpzChE1xYZjCDDPoE2BPjpL5F5NNAkbpYW+Ty5tpneRBpnkriOZBZCaBbJ8A
	 vevRrzORbAq+E4c4XuuWDilutav61+s8E7gfjsyKJoJFWYkUEBDHVYZLogN/auOZGu
	 ZdumcKllGdJRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] ARM: dts: ti: am335x-guardian: Drop unused
 isink-en property
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: linux-leds@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260718215632.3295049-2-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-2-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 21:59:36 +0000
Message-Id: <20260718215937.67E651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> The 'isink-en' property is not read by any driver, so remove it from the
> TPS65217 backlight node.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718215632.3295=
049-1-egbostina@gmail.com?part=3D1

