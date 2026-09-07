Received: from e234-57.smtp-out.ap-northeast-1.amazonses.com (e234-57.smtp-out.ap-northeast-1.amazonses.com [23.251.234.57])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4FB3876CD;
	Mon,  7 Sep 2026 05:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788759841; cv=none; b=XN+NfNCOa+Oo75s2E34fEQIw6IPbhGCnlLIU41xCM39KIDM1NmCyfArjN35+M1NMyKBoNPCdiJ2wRajEbyXZ9s6OjVelQJQi8i0yYjE7VITO7d4CXXbG58utM4K9LD62/TzhQHUAGjigd/fB73qAGs4v3mUdEYJBaRc+1UyyWIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788759841; c=relaxed/simple;
	bh=XlzQ+wI6abraHAFKz6h14He5rDm5lEAEryUIOcSDo5k=;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=HqDKbQVIpX0deQpZPDnWe6z8eBwstGgGHqk+vjvnZSbxDfJGe3AExi37eSgY4HStPk7+fK2XM7mO4bDD6n8BlCIqvne7HbsS+1CNjKG5ofWz4Mt0nnUl8jDPhu5W2BItJGJEW1dEsqkN8kSbM2s3uKigjerNw4FFHcPJG0BqNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz; spf=pass smtp.mailfrom=send.fqwqf.xyz; dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b=NQJb5k4r; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=DdRlxEPK; arc=none smtp.client-ip=23.251.234.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.fqwqf.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fqwqf.xyz header.i=@fqwqf.xyz header.b="NQJb5k4r";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DdRlxEPK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=fqwqf.xyz; t=1788759839;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=XlzQ+wI6abraHAFKz6h14He5rDm5lEAEryUIOcSDo5k=;
	b=NQJb5k4r5nOXW/c5qxMGNpb5hQAQDoRPoCKD0Y8Kt80rYWE554Pb/ulTIpAOTM/u
	hAaUAAkamyUxHeGbh6xbd+FNFFo7JXXKxfp7gZfNrpyGlb87DwZ8+7zP3zMXQJ0DshY
	qYAM1qAEvkVCF6FuV8W5mF/RpNz+eh346Y/JxKjs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1788759839;
	h=In-Reply-To:References:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=XlzQ+wI6abraHAFKz6h14He5rDm5lEAEryUIOcSDo5k=;
	b=DdRlxEPKiD5uvcW5I4bjyp8ss1z6eaOhA/WSI+ut24uPgvc0tuoS+ClRAtCx7gc9
	k+t7i42xkoAi9QB5V3Jfq6r55pyzS64KOPxmu0HNK/8VYI+kwpldh+jtmG2YZqTDE5u
	u5JSOVrwEqMo02aTRHAPKWoDFMlt6UNuY8NMTqNw=
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907054339.12409-1-fqwqf@fqwqf.xyz>
References: <20260907054339.12409-1-fqwqf@fqwqf.xyz>
From: fQwQf <fqwqf@fqwqf.xyz>
To: devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	bentiss@kernel.org, jikos@kernel.org
Subject: [PATCH 1/2] dt-bindings: input: hid-over-i2c: allow reset GPIO
Message-ID: <010601a07a651064-bff1bd5c-5d9a-40b8-b504-a0ce7b41669d-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 7 Sep 2026 05:43:58 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.6BGMgStFQE7EJYq5syaCRzdneEHVt/+DAaGDrqUmDs9QLO4/SllUBZ3fHvnZ8rcAX/3IjUyTRgi5JFZsWrikFHwlPJqCkqEMlxDFM4JXh+ycxH/J5Tudg5bGdz6h4331g1L1EFsGR8kuYNfGLsrxz4Nym4YXoPcZxeVkrHry4Zx21n8vEVLEjc7s+OCM8PU9:1.ap-northeast-1.DTXDV/V9GPBWozcllKo8innbNB2qs2O/3F8XZSzd9ZM=:AmazonSES
X-SES-Outgoing: 2026.09.07-23.251.234.57

The OF implementation of the HID-over-I2C driver already obtains an
optional reset GPIO and asserts it around power sequencing. Document the
property so device trees can describe that existing capability.

Signed-off-by: fQwQf <fqwqf@fqwqf.xyz>
---
 Documentation/devicetree/bindin=
gs/input/hid-over-i2c.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.yaml =
b/Documentation/devicetree/bindings/input/hid-over-i2c.yaml
index 138caad96..bff43f6b7 100644
--- a/Documentation/devicetree/bindings/i=
nput/hid-over-i2c.yaml
+++ b/Documentation/devicetree/bindings/input/hid-ov=
er-i2c.yaml
@@ -44,6 +44,10 @@ properties:
     description: HID descriptor=
 address
     $ref: /schemas/types.yaml#/definitions/uint32
=20
+  reset-gpios:
+    description: GPIO used to reset the HID device
+    maxItems: 1
+
   panel: true
=20
   post-power-on-delay-ms:
--=20
2.53.0

