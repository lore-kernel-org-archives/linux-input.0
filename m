Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640843D2FF5;
	Fri, 20 Mar 2026 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025085; cv=none; b=jWo0cbKwK2cMJeonKrTNr3/OnX/aZF5Bd+P06fPg4TAIOdQe+v3+ybqvv4emxJxbrDrUkbXT4VDX/RQDhk/qrpevQKBhdskjCIGobzZe6L9j4z6B189PZ9i0emcTYBumQXRxpF4PT/ABostzvbtMBTWpjKllQiv3dkjR1d8QzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025085; c=relaxed/simple;
	bh=Dg8VJs/6qaDCZA5ZK4yQ/nkLOVVgN9sIgg9C2DqA2gE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cefx0vgnd82vOJXB3lmf23NsH7N5o/x+cDmHvwVJReGg7J/WYzcqjXEfny0of0V2u1XcfRMdaVg/8I9NvGF9Q9vmdARerxtthXtWo4tdkeIct5QrE8vAU6sYS5/QgsimnMASSY5DKcNtxt4CSPgZbsfPVXcTR9d6uoYMyO5MKjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6KQvHT0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6KQvHT0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17679C2BCB6;
	Fri, 20 Mar 2026 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774025085;
	bh=Dg8VJs/6qaDCZA5ZK4yQ/nkLOVVgN9sIgg9C2DqA2gE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k6KQvHT0EsuSQMuNGZN/SnSMTNe6p/vy+WFfOII2NdGyOUlAGeZleHlk7NKGRqGeY
	 7+kBrATovWBMmXeqHhY6FX73IcDA+ah5qGkjTyMGy24/S2GDVyUjOU10YvEPM+xjxJ
	 7eVumEpOVrkrQalGlkH32bU77+Q3j/p6lbB2NuqsSx8J6ha/m7GRH0NX0sC1+Pa8IM
	 T1n48jx0NjQ0cDYggXNnZWJC2w2/ls3lENUo0weXpzxKtIE462KThrfYQUOVSHIgkR
	 5v868kPBYBPRWMf+f3+JEvcgUBl85ihqUkLEDvmIvoBIrrZce1avdHcdEELNb7km/j
	 6tyJd96ow/R9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F89B10987B6;
	Fri, 20 Mar 2026 16:44:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 20 Mar 2026 17:44:47 +0100
Subject: [PATCH v7 6/7] Input: synaptics-rmi4 - read product ID on
 aftermarket touch ICs
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-synaptics-rmi4-v7-6-379360de18d0@ixit.cz>
References: <20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz>
In-Reply-To: <20260320-synaptics-rmi4-v7-0-379360de18d0@ixit.cz>
To: Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vincent Huang <vincent.huang@tw.synaptics.com>
Cc: David Heidelberg <david@ixit.cz>, linux-input@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Casey Connolly <casey.connolly@linaro.org>, phone-devel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1203; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=CMV2802aTv/oc1MkDukEK0bp3xh70HXQEEwQSB5KFZI=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpvXl7NLLzGO8qCVp/Q9HhBBv4aiAiHF48BHyI6
 XFzx0U5EImJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCab15ewAKCRBgAj/E00kg
 crVED/9nvywg8EHTH0qMFq+ZYfPb5cTMzoUrzinCajuPGSe9/dDIWh/s2c+nhD9EF99z+WBL7GL
 5n6EFxb4XF4zPC8FBkAho4p6YrrZOqi4PywJ1jTb4mBAQSHl+rL4AdnwZc9kaiG9oHEdrNxC/in
 XSlVRGpTox2FF5Su9vBFX8ENxCI142httbHKSWcjQwkStLt/dyEQFHmOCZb1JplN0G25qTV34v9
 eW8qQwXHsGeV2zL7MZmlq3SSOIpOEADx+mcphGzgsL1iWxJPWGCBw/fDh2wMaw5KiXdokyQib9b
 NQT6/fpzWahYClWvPWpd+QOczCSm0qwCjUaFQEqzYldReB+Jv0lPCkMgrb4e3rr615NFcsrhP9B
 baJchCHkXLQPs0nTIRwTFKkKuGg8mCBFRmEYEIVisE27YSJtNlMipqRWs3mxtEIWa2gM8Rt6NvI
 ofnqa0Y9AWXr0AqVSGvA1Kc+/Wj25r3KuDlms5Woxxf6QuXe3hO4Sg9WhrJJcKud93vpKr0ZO1K
 SUIB70rjPbaGEd0X5Ocox61BNHlW4Rpa3LfQ74Sehw8pbwIUWT/4ry6xnIuT06c6qScz+izk3HP
 HfvT+AOckCm/+yAJfLl1M5vg+vx2ea9WtIpYfDo9zLXb0zaxxm6uby4GZ2nGhYB+qgCVzyBWh6L
 wh+uhsITDRE+xkQ==
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


