Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300E5013AF;
	Tue, 13 Oct 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903863; cv=none; b=cXmu+FIj3eIlJKjqPFj20u7UJdSdoGU/PfYHT/xhzpesRAgpRSa7Ix1OqLaUvZmK8ddQud3b9ac520gF83bvQWo5ypZK3cVxlI8UjVvMNktWbTf4bq6qUjfPsGHAdWc7FXenFHurnofCitEWuPnT1rV5QrxpxvyYfmJHvucQEpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903863; c=relaxed/simple;
	bh=95jmBUeEvqwl8jKxcueMp6GKKeIMhHWpgeD8WJp4hfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6R/2Gm0M5WJxm9XdeNP9fhr/WJZbPVHR53mKowhN67vEQSOAj33IZAYOJS5txZuXT/UAYgI8KD76WHFW0VZCMi7Y+k5P6BKk3cHFUokcEJxrAmgMwpYBMBJYtNM/TtrNfAPd+PFa1fNFD9Noo0fBTk/Yxl4/BFmajLxRnKy4f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZRVL+Ng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZRVL+Ng"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABCC5C2BCF4;
	Tue, 13 Oct 2026 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791903862;
	bh=95jmBUeEvqwl8jKxcueMp6GKKeIMhHWpgeD8WJp4hfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kZRVL+NgJtj131dKT4FSwfYu8NdgXIO91mL9p7RhDEYUlX/aGEezuqcqGpmIedjeI
	 1GI505+ucaYuChGbStcdOkXU1QLd4fSfJSF60N8D5Hl0f7/hIcWXMqmeT1fdF8Xu4I
	 mBFPUSU+r+R4+Pz7wW5UYdoUtqOaCSIH6k4tyBiDqQ3J7BMSCFq9s1TKDCfEQ8Wg0H
	 mL7z/bilDVxKUe4YQPZAIDwu5JrNoTCrjwtZJG602zedla5Le6HKuX7KO3v9p9kyIq
	 NrbEhXFnuKN4R4CPuHcmzBalC2ibrOSig4ZLgH97z3OfetL3rc2lu/YtxZboOx+eH5
	 GvKYZtbKiLB5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABE3CC6B12;
	Tue, 13 Oct 2026 15:04:22 +0000 (UTC)
From: Mizuno Miotsuki via B4 Relay <devnull+founder.crepuse.com@kernel.org>
Date: Tue, 13 Oct 2026 23:04:20 +0800
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add Nsiway
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-review-self-ns2009-v4-20261013-v4-1-98bb21712282@crepuse.com>
References: <20261013-review-self-ns2009-v4-20261013-v4-0-98bb21712282@crepuse.com>
In-Reply-To: <20261013-review-self-ns2009-v4-20261013-v4-0-98bb21712282@crepuse.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, icenowy@aosc.io, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 robh@kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=918; i=founder@crepuse.com;
 s=20261012; h=from:subject:message-id;
 bh=WXZF/+u+SPxCj0mvhT/nD0fF7Smil0RflWNMJKJzf6A=;
 b=owGbwMvMwCUmds2G2fVJ/hLG02pJDFnnPEqmZPht1crXz/zcLGRUfPxi2eNngWsTvSITlxptl
 jC58/5ux0QWBjEuBksxRZbZouzlh5pXXJs7ockOZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx0DFm4OIUgKkOFmBk+P56juGjN0q/sj4EmzIfOZC8+ULI1ptKolMa2Nda+iQp1TL8L1jsV5Z
 0W3nOvEK+3uYAja8uYq+3qFdnFbvdiefMsS7gBwA=
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


