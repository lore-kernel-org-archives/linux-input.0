Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF0483BD2;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790338177; cv=none; b=VuKpjdezNpwbR6T06Ejn0EMRub7oH1/PkqC53MkThyThoB12JzE7T6gseyqk+xehosa0U2vsm0sPbZcgexKRBEehsDXJGyp2CG/CTgIOqZWJUbeScBXM1BpcQ9y4PAuA8x+sL5mUAoLXwEWJjirw0a4aPM13tex0HuTsRIYQ9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790338177; c=relaxed/simple;
	bh=fRDe89N3HJeAFyCusP4aAHWCcvsF/BWXyWYiiFspEec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvBCenS8zYHsWbuuH2R+MdQqejfdvfr/v60ddpc4PqoTWAn0CJ+N1DOYBCcpJnvvH3jOMt/Xb8maUHvGFPuQvYQKAAgYTvhsuRvjtprJcdqE1v1tfUtqARCUvM/2pzsrJo8/61kkCaX7q9KS7jrN5Uz9n11yXOfws5Gg+z/1oUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMA2ieNZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMA2ieNZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 947EBC4AF1C;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790338177;
	bh=fRDe89N3HJeAFyCusP4aAHWCcvsF/BWXyWYiiFspEec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KMA2ieNZoO+Y6ct0i63lThyzN3lKH5nFeS4LPk/QxKWfnHMKxTfehzWlnt28kREwu
	 3q5tp65hFj0D1FYszQsp2wJR+mYw2EZ6w6Ouaw9pyo4eeJC/vZ00eiws4xH0W8uEYJ
	 NaD5zggC62OXrcgEgeR7xq0X8C9L2na3ylNLukrtqLTMOj9Iqsm7D+FxOVGYywACE6
	 J9TKCUhHlzntjG3WaA+G5KMBUH3vNPHH6TbN+WCvLgYmCD9Z0n7rsRAY5BxkuJyDPS
	 0uLcK3Xg/BYGXatU7GVxXxHrhNajJQv7LXcRpb5OTSwBI7sKRP9XBIN06YTUg6Gu8Z
	 mulWrqE6xg6tQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C2EC9830D;
	Fri, 25 Sep 2026 12:09:37 +0000 (UTC)
From: Michael Reeves via B4 Relay <devnull+michael.reeves077.gmail.com@kernel.org>
Date: Fri, 25 Sep 2026 22:09:33 +1000
Subject: [PATCH v4 06/10] soc: apple: rtkit: Add tracekit endpoint
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-mtp-keyboard-final-v4-6-304c267518f4@gmail.com>
References: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
In-Reply-To: <20260925-apple-mtp-keyboard-final-v4-0-304c267518f4@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Michael Reeves <michael.reeves077@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-input@vger.kernel.org, 
 Yureka Lilian <yureka@cyberchaos.dev>, Julian Braha <julianbraha@gmail.com>, 
 Sasha Finkelstein <k@chaosmail.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790338174; l=1194;
 i=michael.reeves077@gmail.com; s=fedora-20260918;
 h=from:subject:message-id;
 bh=kS9uTA8Dh/vtajiZu3Qfpn0cuQfrngimukMbAAW4igI=;
 b=vwBDb4M87lheJjoXlU98UzGcI1urbMeCujmsXdvNsu1Std7C/eGctq5MQnUdxSoMIJ/76/KgO
 sXpJq444xsAAEVTf2ofWlnMRnYzTnfgQDd/O++7XjdtpyI8KOppg/s4
X-Developer-Key: i=michael.reeves077@gmail.com; a=ed25519;
 pk=VJ0TvyQ9TvfzYZa908YSE9kpkjFLLD5luv0bERu+boc=
X-Endpoint-Received: by B4 Relay for
 michael.reeves077@gmail.com/fedora-20260918 with auth_id=1035
X-Original-From: Michael Reeves <michael.reeves077@gmail.com>
Reply-To: michael.reeves077@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

The TraceKit endpoint is a system endpoint used by MTP, AOP, and
potentially other Apple RTKit coprocessors.

Start it automatically when it appears in the endpoint map, like the
other known system endpoints, to avoid warnings about an unknown
endpoint.

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
---
 drivers/soc/apple/rtkit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
index a3fdac8f6..1059b4bd8 100644
--- a/drivers/soc/apple/rtkit.c
+++ b/drivers/soc/apple/rtkit.c
@@ -22,6 +22,7 @@ enum {
 	APPLE_RTKIT_EP_DEBUG = 3,
 	APPLE_RTKIT_EP_IOREPORT = 4,
 	APPLE_RTKIT_EP_OSLOG = 8,
+	APPLE_RTKIT_EP_TRACEKIT = 0xa,
 };
 
 #define APPLE_RTKIT_MGMT_TYPE GENMASK_ULL(59, 52)
@@ -191,6 +192,7 @@ static void apple_rtkit_management_rx_epmap(struct apple_rtkit *rtk, u64 msg)
 		case APPLE_RTKIT_EP_DEBUG:
 		case APPLE_RTKIT_EP_IOREPORT:
 		case APPLE_RTKIT_EP_OSLOG:
+		case APPLE_RTKIT_EP_TRACEKIT:
 			dev_dbg(rtk->dev,
 				"RTKit: Starting system endpoint 0x%02x\n", ep);
 			apple_rtkit_start_ep(rtk, ep);

-- 
2.55.0


