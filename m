Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2A2521205;
	Tue, 13 Oct 2026 22:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931513; cv=none; b=I/JmlWSCTeakdUwwJxNrREFlE8TRs8EAgkXxmC7b2BL0I3fhie7n2EZxNZBUvkDiDCzNFXS4Pfpr+qkP20yP5n/RiVR5qW+TUjPNaNXq5iTTG5i9eHJzbpiL+lWBMymdJG3iMy0LAEDhxxdO2R4p9L0OOPdyMSfc1mWWWs00g4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931513; c=relaxed/simple;
	bh=95jmBUeEvqwl8jKxcueMp6GKKeIMhHWpgeD8WJp4hfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qmpNsvNtEtENO91gfbzyEigVAjV1PMRYEtcSfwduC3809CNkhHLm4EAWrscrYnjN81V1wfqc2uY9l6FkxsbXgMMegT+9l8XXCRZyQ4hV1FvwfPLoCOih3GpTEwcQ7xepxhUy/HHqHFCNEo1BLnwqxCsll4elJi+YugCGEZB5r6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsUL8r3B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsUL8r3B"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D08BDC2BCFA;
	Tue, 13 Oct 2026 22:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791931512;
	bh=95jmBUeEvqwl8jKxcueMp6GKKeIMhHWpgeD8WJp4hfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lsUL8r3BjYY89Dwu0lnSmiC+/wA4tTsAtl4SaBrHE4CdhhwaUcRp/L1Z6nvD5Qu3Q
	 7SoH/Grzv1oEVxsM7FtAB+Dn9rUpPYOWeZg20oUlvbUOYhSa/xku1d8MGaO1SGJ+9z
	 VleWmWCO+gsco2DtaG4E52LdATfyywctOc8B7zwECdqTUWlGR/JRwdWlBVZrUDQYxk
	 FwJhHWOf3cYkJmLC+Oda8b6KiAhRhLdmqKNXKZJHnJivnTvRWF8ZyUngEsrG0npsdU
	 8X8lOuOOar1ZnKpZvKcKQ8H1f8hcLAYixoZX/vFYi7QMTNx0/u7fzqZI8B1Q0Lb2zv
	 Bc8sMddeSkOdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA58CC6B0F;
	Tue, 13 Oct 2026 22:45:12 +0000 (UTC)
From: Mizuno Miotsuki via B4 Relay <devnull+founder.crepuse.com@kernel.org>
Date: Wed, 14 Oct 2026 06:45:09 +0800
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: add Nsiway
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-review-self-ns2009-v4-20261013-v5-1-0851740cd939@crepuse.com>
References: <20261014-review-self-ns2009-v4-20261013-v5-0-0851740cd939@crepuse.com>
In-Reply-To: <20261014-review-self-ns2009-v4-20261013-v5-0-0851740cd939@crepuse.com>
To: dmitry.torokhov@gmail.com
Cc: krzk+dt@kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, icenowy@aosc.io, conor+dt@kernel.org, 
 robh@kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=founder@crepuse.com;
 s=20261012; h=from:subject:message-id;
 bh=WXZF/+u+SPxCj0mvhT/nD0fF7Smil0RflWNMJKJzf6A=;
 b=owGbwMvMwCUmds2G2fVJ/hLG02pJDFnntpRdmvg+7J367zwvy2V3ttRZzvLW2D1bf3HhlMnfd
 7K2Hjou2zGRhUGMi8FSTJFltih7+aHmFdfmTmiyg5nDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10DHSMGbg4BWCq91YxMnyWeytvNk9vJ0f2pIfZwU2rPjxawfLo7K/P7nf8pobMtnvGyNDBeVK
 iik/DfN7ElNWMHHGZcx+WzmGf+upHJcOjzuur5zECAA==
X-Developer-Key: i=founder@crepuse.com; a=openpgp;
 fpr=9B150777C283A8D69D90823E16D63C0345E46FA4
X-Endpoint-Received: by B4 Relay for founder@crepuse.com/20261012 with
 auth_id=1166
X-Original-From: Mizuno Miotsuki <founder@crepuse.com>
Reply-To: founder@crepuse.com

From: Mizuno Miotsuki <founder@crepuse.com>

Nsiway manufactures the NS2009 I2C resistive touchscreen controller.
Add its vendor prefix for the touchscreen binding.

Signed-off-by: Mizuno Miotsuki <founder@crepuse.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..a180012054c9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1214,6 +1214,8 @@ patternProperties:
     description: Novatek
   "^novtech,.*":
     description: NovTech, Inc.
+  "^nsiway,.*":
+    description: Shenzhen Nsiway Technology Co., Ltd.
   "^nuclei,.*":
     description: Nuclei System Technology
   "^numonyx,.*":

-- 
2.56.0


