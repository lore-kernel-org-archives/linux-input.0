Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254493168EB;
	Tue, 24 Mar 2026 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774381238; cv=none; b=uXis/3B1fxh3s6tafY+sv/sYAEaVItOWMAIzsMRFN7lL7ICJ3Gg6+OP0GC3p2IMQb8U1gbmGe18jJOVs9gq/94rwjJClQlQRC3eFT0C4uN+luLYw3fgGRINVfnAXDOHQUS1SveacFv28vyqeCJ7/T/oyhxs/TTqT6DQCykeehhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774381238; c=relaxed/simple;
	bh=Dg8VJs/6qaDCZA5ZK4yQ/nkLOVVgN9sIgg9C2DqA2gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yas6AqMJGUg4iqr/7n3UipxcI5JOX85DJCEJD+K9D0BCMV92kOrHj419fs+ca+BtCfEeqeu44IQFln3rI4a2Gp7SxQpwVHQn4rQQjMRBY954cJUUFXpaxMpND3RSZaoEap/kTzOiOk3B3dnmWbuga9V52Tbt0B+TZU5Nuodqs2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=licYyHWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="licYyHWh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E900DC19424;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774381238;
	bh=Dg8VJs/6qaDCZA5ZK4yQ/nkLOVVgN9sIgg9C2DqA2gE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=licYyHWh9UGw0Z1DxRbkDvywClKLnTm7S2xE3xihmb5NnlWOA29tiVaCofVmPQjyS
	 NDO+r13LY7gUgItnicOyG+OFY/4vr2Ymk1fCJ8Uqs7KNQ0QnYLdes+4dVTTsY7gxbE
	 CyFatEg28gQ/ioG9+2Epl5ANBj85Se+TIO50cGLZ77ZX8+bB5XOr4OoZknOcNVVBad
	 VicwQW1epPqzuhmE9ajtMFEaPcAP9CsCYTmFtUbBQVWwn0QTA06KGjs6AaR8u46o2S
	 fK2gPXQm6XiM0KsEmU2k+IFAVkTMQJ9u2mQQ09Ug1r7jOGbpvrDerVqTxBAIhQsBJS
	 zaoDzKT2K9idA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC69FEC107;
	Tue, 24 Mar 2026 19:40:37 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 24 Mar 2026 20:40:39 +0100
Subject: [PATCH v8 6/7] Input: synaptics-rmi4 - read product ID on
 aftermarket touch ICs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-synaptics-rmi4-v8-6-2168d2df68f5@ixit.cz>
References: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
In-Reply-To: <20260324-synaptics-rmi4-v8-0-2168d2df68f5@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=CMV2802aTv/oc1MkDukEK0bp3xh70HXQEEwQSB5KFZI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpwuiz73HYFSz4nvYs55kwH2sVPDHjVzycuzdMJ
 9dqxbcxelWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCacLoswAKCRBgAj/E00kg
 cvLgEACW+vsbDps/I+o10IjyH3n1mPzRHIoKgx4RNG0JxQcL0qL1aZh1AoKsl3sJDOxh9BNPhUH
 bN7atpm5IpetbAKYP31CE6MeQAqh1O105msFY3AL7BQAevkKKOMppPkGZ0HPlMMOkyWe4nSs7su
 Z+2L4b22MINxr2j+oIeA76wPCZbpRA8iIirQ6ANwXe6Jx3FXt1iH1DkKPrp1MhuQ3j8Q3p58wmY
 mD604EZfH0aB/MddniNDvTe84RV8IUBewPRDKrS/s/RO92pkz7PuWx5NMON/2UpR4COEXisRfJp
 UxQSIKG9LCYQCtrJZNk28pOU+ka0yUVkQXliv6Rt40NmBneQBAOIzcBbx1RplZjfCB8lEl/Chet
 HJ2E/WMg7LD+o26+sPdrSHPwl7g9mRCWc+PWG75J82Kqm4ceuC+Cg30Vrb6skrNYJgaYpoZzIuB
 OLPdTIMzDrYbEcFX2uPGpi9Tkso5rhzgMwlWyzii5V2xHD7PNfkY1cfsPn7pyPLHlsETrxvtcNU
 BmRQX1rfhQlUei1S3HmwHcwd/dBZTW0JvjLnMPhE3rO3bnFCf8huxM6iDdDekv/zGayaFPX31Vp
 RKrF1NA2FfYK2B17XSwduhDKn0F1TAFqqy5ZZ61w5zWvAmJKeBDDI+nKPX5oqqB8Qy3Xocwa6OQ
 8HLotFs4tz4xwPw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Kaustabh Chakraborty <kauschluss@disroot.org>

Some replacement displays include third-party touch ICs which do not
report the product ID correctly unless we read directly from the
product ID register. Add a check and a fallback read to handle this.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/rmi4/rmi_f01.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f01.c b/drivers/input/rmi4/rmi_f01.c
index 47be64284b25e..2278e9b6a9207 100644
--- a/drivers/input/rmi4/rmi_f01.c
+++ b/drivers/input/rmi4/rmi_f01.c
@@ -250,6 +250,20 @@ static int rmi_f01_read_properties(struct rmi_device *rmi_dev,
 		}
 	}
 
+	/*
+	 * Some aftermarket ICs put garbage into the product id field unless
+	 * we read directly from the product id register.
+	 */
+	if (props->product_id[0] < 0x20) {
+		ret = rmi_read_block(rmi_dev, query_base_addr + 11,
+				       props->product_id, RMI_PRODUCT_ID_LENGTH);
+		if (ret) {
+			dev_err(&rmi_dev->dev,
+				"Failed to read product id: %d\n", ret);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 

-- 
2.53.0


