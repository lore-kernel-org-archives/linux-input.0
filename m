Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433AE478E23;
	Fri,  5 Jun 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644445; cv=none; b=K/krOkcPFpUhWHTtF4HgQvCyemDBHg70RzoFYMqqHCM4dI298wfXIFIq0VePdGW+pAlpTjyHFvakXnUIb3WpR/y3tyYSsSgLjKis4Vdhz+v5WKjHNCDGDyUZriq7nlo4xpzel+BRCq2HEOUvZtE0+qVnZvUoqd6wqoq5QokwxpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644445; c=relaxed/simple;
	bh=GWUiIg7q9Err0QhQ40mgTt2t3Sl0KinkLwFX/Ry3g3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rraVfYO6yQjzyPU1Dqc09DAkvGpfZabBOIHGYP55ro3XC0CWT9bt8QB+LeyziNRyp76PwMV7xHQDST/9Mbnv9iJH7EbAT7ZfwkA+YusHhJwlwOjNVaUpswqrvV5TE0rLdwPdjgh8QuwWwNfqnXeJwYZcdnMYTpUqk4QuCinWffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HV2rTHve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HV2rTHve"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 968D4C2BCC6;
	Fri,  5 Jun 2026 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
	t=1780644444; bh=GWUiIg7q9Err0QhQ40mgTt2t3Sl0KinkLwFX/Ry3g3k=;
	h=From:Date:Subject:To:Cc:From;
	b=HV2rTHveY5S/ps87GVmE4OC+aewgshITOTuFMmJ5c3RJeOzPvsuHWyXLwwTJl+rMw
	 yUQPCr6V3Op48S7WJlDY8Ig29oA6Ds+QQzIZfPjt7KNOuZKTAg4ZbTcl/LPD5Hkle+
	 0gdJ1TxZfkSML2Al+zX0FZT1QoVztl9g6DrQ7A+o=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C4CD6E74;
	Fri,  5 Jun 2026 07:27:24 +0000 (UTC)
From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Date: Fri, 05 Jun 2026 15:27:21 +0800
Subject: [PATCH] Input: atkbd - skip deactivate for HONOR BCC-N's internal
 keyboard
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-honor-v1-1-78e05e491193@linux.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNT3Yz8vPwiXdNk45Rkk5Q0C1PjJCWg2oKi1LTMCrA50bEQfnFpUlZ
 qcglIs1JtLQAqqQSLaQAAAA==
X-Change-ID: 20260605-honor-5c3dc4df853b
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Hans de Goede <hansg@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 zhanjun@uniontech.com, niecheng1@uniontech.com, 
 Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 kernel@uniontech.com, Hongfei Ren <lcrhf@outlook.com>, stable@kernel.org, 
 Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780644442; l=1506;
 i=cryolitia.pukngae@linux.dev; s=20260401; h=from:subject:message-id;
 bh=GWUiIg7q9Err0QhQ40mgTt2t3Sl0KinkLwFX/Ry3g3k=;
 b=3OAl+cNxKXdpXzsrO8ofFXw1xxP2uSMpIrDt8MGEXllFFBWRELu6WlslyUCRkHb0lpUhQo8hm
 5bOcE4iV61tAD9Ms2e9tXAeeST76hBwiACVqMoxTvN47Qs4zJBoP4T2
X-Developer-Key: i=cryolitia.pukngae@linux.dev; a=ed25519;
 pk=kF6wBkp7j9167keuk8Q9RvPgMRPuHlJztbLy0vbJ3K0=
X-Endpoint-Received: by B4 Relay for cryolitia.pukngae@linux.dev/20260401
 with auth_id=712

After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
BCC-N, aka HONOR MagicBook 14 2026's internal keyboard stops
working. Adding the atkbd_deactivate_fixup quirk fixes it.

DMI: HONOR BCC-N/BCC-N-PCB, BIOS 1.04 04/07/2026

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Reported-by: Hongfei Ren <lcrhf@outlook.com>
Link: https://github.com/colorcube/Linux-on-Honor-Magicbook-14-Pro/issues/1#issuecomment-4562679891
Tested-by: Hongfei Ren <lcrhf@outlook.com>
Cc: stable@kernel.org
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
---
 drivers/input/keyboard/atkbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index c8ad55f26ea8..de8edab3cb0f 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1923,6 +1923,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 

---
base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
change-id: 20260605-honor-5c3dc4df853b

Best regards,
--  
Cryolitia PukNgae <cryolitia.pukngae@linux.dev>


