Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F01FC8;
	Sat, 18 Jul 2026 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412158; cv=none; b=tQxoRBUNLwQax257/Ad1mVSvPs6pqAzt3PqZQtEwpGi2hLBhT/kz2p8aZQyMgtqPyGNNYrCT9JSDvk9SKOngLOTwFVOpEhBhhpm+vNMZAGAptDKF1a3O0dlXiABinULQt7RBmsx+gHIC+zWkvCpng0uajFXbnmFGeTcIKrcXt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412158; c=relaxed/simple;
	bh=62FrzbCTnCQ/Qpl/5cqJW+MCuQjti1STMy8ocwZ5vYw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRowOdU/t0MBysqiEKlLDky7P8NVUtk8cnxRpaVhBhjaDcrKXK9E9fsStpSysZZAVOAyi5NB+thb8sdevg2oUTVNAkCP/USGk5adyUlsgilH6ptzV1z51ZjDC6g6K0v8VwOi8f588UGoFCQe+EcfZ0pxwfk+GriapeBQ31prcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCOtWQIT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCOtWQIT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1971F000E9;
	Sat, 18 Jul 2026 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784412157;
	bh=62FrzbCTnCQ/Qpl/5cqJW+MCuQjti1STMy8ocwZ5vYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCOtWQITHj6eq2a2uVrkxNxBrn11DgcxZfRRnCLPYA6DynVkr1RWLqNS+a/6s7vqB
	 A7TX3tYx7pUlnhORgwGWq4dpX+7iCUyphS0fAVj6hB3R9kWUw9BoWClUX1DVPPr40R
	 CyX4DsyLERwX3BKE74NyL8DkfcHRPrbyRFAApsp0vEpcN13R5RKoQG2DCYEMzj7DG1
	 r3pea+VDtPsfobNiYm8WYs/ytJfZxyYl5Jz1ILR1XhXWisN79OCFyEIau4QPkM+3Z/
	 nUAxgCMjBCrtUn0Z4xf/cfXO7V72sXwDElUZk262lWP0IGHOXEwHZl3i8izPHLxDes
	 6qhXI3Iot2HKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Bostina" <egbostina@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20260718215632.3295049-3-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 22:02:36 +0000
Message-Id: <20260718220236.CF1971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

> Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> bindings to DT schema.
>=20
> Signed-off-by: Eduard Bostina <egbostina@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718215632.3295=
049-1-egbostina@gmail.com?part=3D2

