Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C138381B0F;
	Tue,  2 Jun 2026 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780394118; cv=none; b=cqZThkrdeQCHFsznFhOgZCX7CVdiBvtqpXv9TUhesL9R+WBSxNZliWeC+8uT9H3LNxYOsCgx9JJd4EmuskHLqAPvyu6OeloZAJsdkvga0FaQ7vPIwh5RTKC7QSkF7aqYKF45sX6XIIG3oBqK2wrHq/bUHQ9NPGGnc2WsyUDlLbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780394118; c=relaxed/simple;
	bh=7uYUmkU94eEgaajyLYghCE8VnXJllTmPtKA2eCWA07I=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DUXtqXiuHeNZYHS6UNPUP5VpneWd6+xCVd9B3t45kO0dDMOYicr8iQdN2tGPD67j4LtnMsCkD+x11iFYO5dSllXWCErMrh0aQuBkf5LsqeZnvUKTSXSEnii9fXVwXMEvCvsTGGMMhThorIBrP2erW7nQVXUvJ5MF4SzOoBjXM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com; spf=none smtp.mailfrom=joint-cloud.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TBVVABL3; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joint-cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TBVVABL3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1780394110; bh=D24FkV5/OjCnjuVwe9877rIb+nT9YsHiZuRnl6Qbs8A=;
	h=From:To:Cc:Subject:Date;
	b=TBVVABL3oCJoUazwjRFwSc+CqRSRUPLJBEyB2keVE3iELneC4nFUn9rxdEo+U2UIz
	 IyPN0aEwDVcDHf4D30CPR6w/QfQEi4v0MS5GOT6H9H7y1SKNUp0eCMSs6K5+u/DeZL
	 VcpkhmUMorHgaRVkS2aQxwHjnmm9bFbEYuRFu8mY=
Received: from ASUS.localdomain ([116.21.162.60])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id DC63003A; Tue, 02 Jun 2026 17:55:06 +0800
X-QQ-mid: xmsmtpt1780394106to3zhfyu6
Message-ID: <tencent_5F1FF80489E702360F352F889570656BF608@qq.com>
X-QQ-XMAILINFO: OJn05o3aXTi92Xp6u0FmO5yT55nYI0qT2HrVgxOVd30UbOna/cR316T0iXrd26
	 LkpNG/ezraWI09/gr9EnbTr8BxF/2FzUsIYolmDDH3mfjYoPHCVL8gNg4x6ulwp6l2/9m//dQfw+
	 d1s8WfM72UxrDgavAgIxM65De3qVeKsWU0W1SgNKXNZe+5ahBurRV0oQCedmMV+OfPRt6Fqt0Jyq
	 WILfqWH7DCAodCorEfWcG6dko+vV4U7sDU7owSM+mGwLS1cfRROhgizqu+Dx33JmQnimmDVJwrKI
	 lNouHLWnJxivWeIqOo5Qnync1yhQItQ3bZiNzsUYqSJvMWAe/3sO2aqVmWDuGLsAy31ww0dQCreT
	 leFjYIHHyqhazDfwaMpj2Hc3t1D/vh8EXGGxQuphQ2UQKsfcT8d5kC47Lm+MiqdMolAWIK+ls8Oy
	 kN2OkCfzgrSN+m2bZb08OR8fWaed4LZ/vNBv2nByxX6JfrdoSfoyRXpzyxdDFDzNkCVt9M5IG+vj
	 tIB6G1MU0qi2Kdrg2RvD9XdPWegIeabWbQdMH10EKiWgJ6b10Ul/vdg/T4FUl9qDGyXuOF3N14dk
	 1cD8opuVGnLeWT/vtzviACoZFY89uw77jnD68RSZRy0fi80UL1T2gs2SXMV2p5UaXck92kT2frRr
	 hbFb3IoGdPtaXrN5RQm2br0e7Xhk2+d5WeW9xqdFv0HVdNzISsOvBm1nePMpnDEu851yyP+TXAlu
	 rnwkJdC1lhfrUAjR1dnKHgx6U6dAbAi6suajVtiC6uWvrWmLzxt+rzre7Omcv+6YksKFNcqotFP9
	 b4S6t3oUX0YGzlxyVQq+Jy3MjAKMeRaXWZ7HlOUMbeF7QZyvdt/4bhKSCJDyZMvrUcGgJDPjFmgX
	 ZQxaCrStpcLlsAvop+lphh0BBJvsH22EcFUEBke7dfpCLAMGwsT/opVny9cayWXb5YW/gqJwVIPZ
	 25hrw/0eNLVzyiP3Dv/YoF7Bl6SkwHh8ualQ3YpCFpGp2ys2pil04pZOZhehWlN2/RC+04onAaOB
	 MdvOGFnUCcTUEO+l3ToCIyoithx0e87HHLZRzXDP+VWc+C5h9s
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: steven <steven@joint-cloud.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Feng <steven@joint-cloud.com>
Subject: [PATCH] Input: axp20x-pek - add support for AXP313A variant
Date: Tue,  2 Jun 2026 17:55:02 +0800
X-OQ-MSGID: <20260602095502.538990-1-steven@joint-cloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Feng <steven@joint-cloud.com>

Add power button support for the AXP313A PMIC. The AXP313A uses
the same register layout and timing parameters as the AXP20X,
so we can reuse the existing axp20x_info structure.

Signed-off-by: Steven Feng <steven@joint-cloud.com>
---
 drivers/input/misc/axp20x-pek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index 24f9e9d893de..d4e2fc9a937f 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -393,6 +393,10 @@ static const struct platform_device_id axp_pek_id_match[] = {
 		.name = "axp221-pek",
 		.driver_data = (kernel_ulong_t)&axp221_info,
 	},
+	{
+		.name = "axp313a-pek",
+		.driver_data = (kernel_ulong_t)&axp20x_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, axp_pek_id_match);
-- 
2.43.0

