Received: from e234-51.smtp-out.ap-northeast-1.amazonses.com (e234-51.smtp-out.ap-northeast-1.amazonses.com [23.251.234.51])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D1A3859C3;
	Mon,  7 Sep 2026 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759846; cv=none; b=U/ny2N9XVfVjvfT2LGCCh+sTM6iKqIIuYNKurZfCR+StRskGrEGnWsrx4zFVNkjmXYB2iVR/YkLF60zfVbow7z4OmUPYOTnPnQ5NX994auOfO3MZmf3yPsHzifAQfEpvF2iWcnplAMasBfTjObT3qQE97DqzPYXPe9Rw1AlDIeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759846; c=relaxed/simple;
	bh=YFLTYkpMiuMdIxB0n7Vn5+y+Fe4rF3hmPAxf5YUS2/o=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=K5pXlbVHGWUtsdg9fQy7toC1qcxEzA6rpGd3TpcwjHAMmk7mtVJ++yyDizNFOEK0TN6dpgqEeXurkO8Q76R34ImgOFyR2wE1/C3SVq/09gRUDlEvFI756nCHBpL6v6E29+2CoMbb3aaRQIs5KW8iRmyphpvKbFpsO750K8cL+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=Kn1eaz8Q; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=gPlvdSVr; arc=none smtp.client-ip=23.251.234.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="Kn1eaz8Q";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="gPlvdSVr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1788759844;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=YFLTYkpMiuMdIxB0n7Vn5+y+Fe4rF3hmPAxf5YUS2/o=;
	b=Kn1eaz8QVaIvotpu5FYm4ZDskPlZL1Qj1pfTBGh56GNqXUQbd5a2ZTBO0xlP/PEm
	9yXm0CilFJ0/c09AfqnQUuLVIwKlMMqhIj4I5ACHwRq8tsuOnx/U5UXcRhPwvk6uGQC
	F81U+brIQsiXj9y+io1Fi7uTrLitO7aFQCmMOAig=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1788759844;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=YFLTYkpMiuMdIxB0n7Vn5+y+Fe4rF3hmPAxf5YUS2/o=;
	b=gPlvdSVrNtcB7IDovzAJao8VeXerF8IiNfdzyCSYvq08X/0Ka3g+Ti012iCsYz0C
	HUcA5P0FYhRWPLQcQPt/52tavJq8ewodPrVBHGwTVe3Ha7EIuF/cnEjxkz6yMPrPd17
	ZIYypiQPUU88HVVAK8bpn56+HqNEY3gbvcYtxnsk=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907054339.12409-1-fqwqf@fqwqf.xyz>
References: <20260907054339.12409-1-fqwqf@fqwqf.xyz>
From: fQwQf <fqwqf@fqwqf.xyz>
To: devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	bentiss@kernel.org, jikos@kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: microsoft-romulus13: enable
 touchscreen
Message-ID: <010601a07a6524b4-0bac871e-cea3-4cbe-9a33-111003dd4808-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 7 Sep 2026 05:44:04 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.09.07-23.251.234.51

The 13.8-inch Surface Laptop 7 has an ITCH MSHW0468 touchscreen
connected to QUP1 SE0 at I2C address 0x34. Describe the controller,
interrupt, reset GPIO, and HID descriptor register so i2c-hid can
enumerate the touchscreen.

The HID descriptor is located at register =
0x0000 rather than the default
0x0020.

Tested-by: fQwQf <fqwqf@fqwqf.xyz>
Signed-off-by: fQwQf <fqwqf@fqwqf.xyz>
---
 .../dts/qcom/x1e80100-microsoft=
-romulus13.dts     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dts =
b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus13.dts
index eb7580dd9..76d143943 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-m=
icrosoft-romulus13.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-ro=
mulus13.dts
@@ -11,3 +11,18 @@ / {
 	model =3D "Microsoft Surface Laptop 7 =
(13.8 inch)";
 	compatible =3D "microsoft,romulus13", "qcom,x1e80100";
 };
+
+&i2c8 {
+	clock-frequency =3D <400000>;
+
+	status =3D "okay";
+
+	touchscreen@34 {
+		compatible =3D "hid-over-i2c";
+		reg =3D <0x34>;
+		hid-descr-addr =3D <0x0000>;
+
+		interrupts-extended =3D <&tlmm 38 =
IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios =3D <&tlmm 31 GPIO_ACTIVE_LOW>;
+	};
+};
--=20
2.53.0

