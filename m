Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.251.234.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795278254;
	b=u/fu9DV2/wUWYAlyIkW2HjCZNGxGEeLC5P3CZStb5JOT8WG1I8YS6ym3+vahrmGIiBRa
	 2mv7KwnleMcrI3cjzNl+tJ4pfwy4kwWkxphhd1kHFj5Zmxrr8kds8fV7+Ujir0+AwW+Tu
	 J6A26Ej4IffhCZTK0uSPpEO8VSoLNE/3DgEac0dhxjp93kZcSOf0t6y1h7cP5Ij/e/qZi
	 Q6gIDe1B/Ok6CBps15666ICx5qX4wPU2cPcbxbl610HdL92ij9QMMytsW/gGfZze4B0uk
	 dqdVgRexX1tScG2jnfSUpIeOMrrh3dfAuX9JpGtKaH7ggCw9TxuVPvAWMA6yWHL0s6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278254;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:In-Reply-To:References:
	 X-Mailer:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:
	 MIME-Version:Content-Type:Feedback-ID:X-SES-Outgoing;
	bh=471W5chLXn50gR/+buvj/gyEydSS5vORYAWz/ynvgxQ=;
	b=QbYTd1Lp+RQM6U7xa66w4fjQyqOgUiPOMUx0G+TaIHJEirll/4ETOgU5vFacFlb4oZLs
	 nrSneyws8w0WJ+SAJOkCLX15Y4fLlcauhkXmciUAw31w3DGFujEhJBi+zc74WxRRJ//Qg
	 vbUNeyZE+IafxPqB+WqAxxiwFH338sr+7dPPIQ72PrXlEV1Rylc02jcDMGecGD/JLz+Gf
	 SP2Jo3NrFpB/pX6bKg13s8brVx7zQwc+oWqHLar/y1RjhHScptAENX/NSsMuhZAta22ax
	 xsgUkGtF+rPaqCMahiPsab2jHqf15gXHSoNdqvkOoAWGg9DpKpH1alBnu79qdRWl7eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fqwqf.xyz;
	spf=pass smtp.mailfrom=send.fqwqf.xyz;
	dkim=pass header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b="kfw/5V2H";
	dkim=pass header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=RmoFgy+L;
	arc=none smtp.remote-ip=23.251.234.52
Received: from e234-52.smtp-out.ap-northeast-1.amazonses.com (e234-52.smtp-out.ap-northeast-1.amazonses.com [23.251.234.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1632606A320;
	Sat, 21 Nov 2026 16:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1632606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.a=rsa-sha256 header.s=resend header.b=kfw/5V2H;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=zh4gjftm6etwoq6afzugpky45synznly header.b=RmoFgy+L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1795278252;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=471W5chLXn50gR/+buvj/gyEydSS5vORYAWz/ynvgxQ=;
	b=kfw/5V2HUSv3CJTPnxjWRBtdPQQ83tRMU6dp++CVBiPcehN2KhAaHXQn+JsmiHBd
	2Jm5mn6vleQdgQ/v84zGhkmJkvim1bUoHXlv6E7Tn1zYmLDYxkhDfkiwQX3QgLY974R
	58tbUQm1q5//Z0ZZxwsVnlPytduYbXyiNEH8cFLo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1795278252;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=471W5chLXn50gR/+buvj/gyEydSS5vORYAWz/ynvgxQ=;
	b=RmoFgy+LHfrPwlTP+SZwVnqZUl5bRGYoCONFZzjJrdoEczSDmgLMznlkTW4lS0V8
	rjwXYnhSHAwNOngJVVsm6d7FBkj1jA/Y2mW1UD8uS8Pqc1Ozotx36u5nvMjtbmtI3PV
	3yqlv3hTjfNomzbNcCZVMiu2KRqiivXcAmtVgf2A=
In-Reply-To: <20261106-provoke-capably-b7de457b9710@spud>
References: <20261106-provoke-capably-b7de457b9710@spud>
X-Mailer: git-send-email 2.53.0
From: Jizhou Tong <fqwqf@fqwqf.xyz>
To: Conor Dooley <conor@kernel.org>
Cc: jingyliang@chromium.org, broonie@kernel.org, robh@kernel.org, 
	linux-input@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 4/5] dt-bindings: input: hid-over-spi: add the
 Surface Laptop 7 touchpad
Message-ID: <010601a1feec27d4-7cd024a3-e91a-4d7f-8205-2f94096554ac-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 16:24:12 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.11.21-23.251.234.52

Hi Conor,

I rechecked this: spi-peripheral-props.yaml defines both =
bus-width
properties as uint32-array, including in current mainline [1]. =
With
dt-schema 2026.6, changing these constraints to plain "const: 4" makes
the valid example fail with "spi-rx-bus-width: 4 was expected" (and
likewise for TX).

The one-element items form passes the examples and =
rejects missing,
incorrect and multiple widths. I have kept it for now; is =
there a
preferred form for this array constraint?

[1] https://git.kernel.=
org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetr=
ee/bindings/spi/spi-peripheral-props.yaml

Thanks,
Jizhou
