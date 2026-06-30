Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7455410D26;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824086; cv=none; b=oMrKHZ/05EjTCuXhIZZf8Bjdc3NU5Hr80hJdcgxeuUzsk4ZRx46HclZxGa8nD7iF0q5fT13CcpfFTpuF1Ys7ZiwpGQmcEqK55nzeAYMa8nshq45u46lli0ZAZjr0cmAA/01z8LT8h4Y4klytmXb/JTBRZh+iCuD1ludnyaqK6pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824086; c=relaxed/simple;
	bh=v5K8YIOQSM4pcHUmb0+gBEqEMmgttu3NrEpZewiOH7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kItaATnKOQvjeFKZlfj3RoIfPQ8wxT9xu/IpmgNjZihLnm1mvje8hEEkiGlxEoC+Cab5/nDyHMb3jwxl2l1cDsuxoK39ciGeHZm+wyJFfhwaT2CLeMkBRgW8iljDEqJX4Kp/78zASqfdcXPyBGGK6JpgzdUZsVhKwhrTT2eub+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMJtJWsL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMJtJWsL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C51CC2BCC7;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782824086;
	bh=v5K8YIOQSM4pcHUmb0+gBEqEMmgttu3NrEpZewiOH7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lMJtJWsLzUcDLEVPamBva2P15vIXr6oDES9ANs6QAxxnrglPRE2MTsajK/KUDz9sc
	 2W0LVUg2HbDas259NOZ/62IRFtHNZYklGQA3yN6nbVAUpDbUpST8UNz5s6yznc3JPA
	 aCNpEQD5vwRPPOCTabYh0qhtVNMHr74zu5b6Yo5PP1B55rUKJJqPke/gl/wfwflCvQ
	 q3SRkBcegYykpsxvj+xt4ZIdRqcBey/54tjcMO1ptXILozzFfcoqdLqfhS6M+MigKk
	 3cnCfPrTCcZ+VxP1fqdkuGDCJX8rKL3tqIWdonhzRbYWw+sthpwuM2z/CrcHVgWP6U
	 qcgsrjlswmiYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47405C43602;
	Tue, 30 Jun 2026 12:54:46 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Tue, 30 Jun 2026 22:54:29 +1000
Subject: [PATCH 01/10] dt-bindings: mailbox: Add Apple t8122 ASC mailbox
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-apple-mtp-keyboard-final-v1-1-506d936a1707@gmail.com>
References: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
In-Reply-To: <20260630-apple-mtp-keyboard-final-v1-0-506d936a1707@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782824083; l=1027;
 i=michael.reeves077@gmail.com; s=20260105; h=from:subject:message-id;
 bh=NwNyyVWwfMGwXyyxkslAk52mQZkXJnBNHg2CHXQEQ4E=;
 b=CK7aMG4Z4oGnQhA3PjnKecoI+wEIKEftwtDJ0ZlWJ5B07dBzEvYZDDfqij4ju+7c5A6BbCZQt
 9KrMNVXDe0YAL4cotqDbFqmlvSNrK6wuclH5S/Qy5TS1RuJLKDGYP5o
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=QIrgWBGCm3LG0YYc6MLCDkwuVXLTGGooVBdWX/KhSiU=
X-Endpoint-Received: by B4 Relay for michael.reeves077@gmail.com/20260105
 with auth_id=591
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Michael Reeves <michael.reeves077@gmail.com>

The ASC mailbox on t8122 is compatible with the v4 mailbox block used
by other Apple Silicon SoCs.

Document the t8122 compatible in the v4 mailbox section so M3 device
trees can describe their coprocessor mailboxes.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 28985cc62c25..946c909c6922 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -30,6 +30,7 @@ properties:
           - enum:
               - apple,t8103-asc-mailbox
               - apple,t8112-asc-mailbox
+              - apple,t8122-asc-mailbox
               - apple,t6000-asc-mailbox
               - apple,t6020-asc-mailbox
           - const: apple,asc-mailbox-v4

-- 
2.51.2


