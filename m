Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5C337B87;
	Sun,  1 Mar 2026 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772387479; cv=none; b=e12hNSB3P8I230vIxtYMIw4qLCjCJrbFuDpPaY4zlPDx1jy7QPRcjUQKXrbZ9OCnfz9CfnPLd2p+CQuOkqDvCr1+TQ74rd5KoEQG4P6FnCWe0pj6udcW6BbuaCCDY+rZHvI4X/8EBJ16d+3lvNNvpdjSsBTzFD4ZI1QHjqenxE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772387479; c=relaxed/simple;
	bh=nhmogOI+WjaFzj49pGOROXn2gYZ4HvN2zLn5fUjRH3g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPqsjDHptH6TvCmLJC5mIHHPtYXIYuhcY1gWpF0G0t6kzJEDFxRcEts621MZm6qzJFupC1WNl6D9IVE9tAGjD9Jr/kpxm9RkZ0kYvjJmxM20tfFn6mS8HXpNMwAs79+awZPj7K0ocKoUs7t3TMbxuRsVmdu0jcrySiVjyHmOFkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3v8e5qI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3v8e5qI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB7DC2BCB5;
	Sun,  1 Mar 2026 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772387479;
	bh=nhmogOI+WjaFzj49pGOROXn2gYZ4HvN2zLn5fUjRH3g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p3v8e5qIM3sUce+oVO4KGoQXtVISLeKXjoFqFA6Y9jGq4C6c3VmB2OW5JWf/i0hAM
	 bGu0fUSzHB6+kjkul0CbTuf7XQjW3ASdEfG5uwutbFAChCH1aR1KLaA06jvZpzRV+3
	 mdxUBA1e7bYyV+O5krX5P7/TuIxBnb1mpKb+VGm+mKehxKWmIt73loHZ0gLziTfliJ
	 IRWmsvhyJWkI9JIyt5O6nvsI1q/A/Cb5K+FLONjsZc6BKNixlBjE23607WMAB+8Hff
	 /aPkiDh2mOYYP3/IR2uUAHSNqU8eEAIwOwUFdynxN5q6IYu+FiNXOUVxakeFFhsulO
	 UtkyvFlacZI/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649BEFD0073;
	Sun,  1 Mar 2026 17:51:19 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 01 Mar 2026 18:51:17 +0100
Subject: [PATCH 03/10] Input: stmfts - abstract reading information from
 the firmware
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-stmfts5-v1-3-22c458b9ac68@ixit.cz>
References: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
In-Reply-To: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=LcR268CsLFX9IfFbR3m8SNFdiJ3g92w+33Vjc2KTWvw=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBppHyUWy/xfoO2DMWkvnS8Fo3kqaxb091fLqkJs
 yr4BN24YZ+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaaR8lAAKCRBgAj/E00kg
 cg5jD/0b2uRo3rzxQmo5CcalkkF0xubiFdZrbRZAflq92qK4+zrRzzXq42iZ5nMk/BYbtzm100G
 WpYXVpvzJXkhvbkF+fm4L+ZhYeAQ7Lp/FSrDrY0kcwlCDSMMsu5ptrIUTIjE1sL/Jp6oV571J6U
 +Nxio3frQuqOy1QTnq0Cb56/pC8eLFw/kkfxxoCYJ7w5iXU3Azp42xT9FeryOBosVKSUuCzYFZ5
 Y0r+x5SWY5t5UHPnni8piwCaJUqGZNh2kdOrhzC+7UTVp2yCuRWu1LFpr3y6n1kn/wIbnfn66d6
 Fglo+sr6ah9ROWcp1taGKX6OJIyQXOfUU5+do75qwLBlVwsaCRuxwX6f3UEjSo0MhqPhL9NbrHr
 igvOnKr8yBkIbKIXLmJn9nlC/AVE52hWUT3OVEi4tXAOoh08vMgRQWJDTusd/rboo6xv9PmJat5
 zwhTo5GTVGsANu33wnJKGIrw88FDW+/UMtvCRSA2VTbN8RWVpPECA8WkCdAmIWjGfWaf8lhB3fp
 rD9nKKpNJCzSbM6knCg69dXSXwVy8Am/+wNeioc3SJ9+0ZZ3I6De4GceMNKCwdqTxlurcd9DH8q
 enUW0gmPcWmuksR181zBO0HsFFG4vT6l5bE/U9SKeRE7QjEcyNPNRduVz6wk9OO7MIUzQtePR9b
 oWPsh/uRQCEpo7A==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Improves readability and makes splitting power on function in following
commit easier.
---
 drivers/input/touchscreen/stmfts.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 7c0f94ba49464..db2dd0bb59fcc 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -519,22 +519,11 @@ static struct attribute *stmfts_sysfs_attrs[] = {
 };
 ATTRIBUTE_GROUPS(stmfts_sysfs);
 
-static int stmfts_power_on(struct stmfts_data *sdata)
+static int stmfts_read_system_info(struct stmfts_data *sdata)
 {
 	int err;
 	u8 reg[8];
 
-	err = regulator_bulk_enable(ARRAY_SIZE(stmfts_supplies),
-				    sdata->supplies);
-	if (err)
-		return err;
-
-	/*
-	 * The datasheet does not specify the power on time, but considering
-	 * that the reset time is < 10ms, I sleep 20ms to be sure
-	 */
-	msleep(20);
-
 	err = i2c_smbus_read_i2c_block_data(sdata->client, STMFTS_READ_INFO,
 					    sizeof(reg), reg);
 	if (err < 0)
@@ -548,6 +537,29 @@ static int stmfts_power_on(struct stmfts_data *sdata)
 	sdata->config_id = reg[4];
 	sdata->config_ver = reg[5];
 
+	return 0;
+}
+
+static int stmfts_power_on(struct stmfts_data *sdata)
+{
+	int err;
+
+	err = regulator_bulk_enable(ARRAY_SIZE(stmfts_supplies),
+				    sdata->supplies);
+	if (err)
+		return err;
+
+	/*
+	 * The datasheet does not specify the power on time, but considering
+	 * that the reset time is < 10ms, I sleep 20ms to be sure
+	 */
+	msleep(20);
+
+
+	err = stmfts_read_system_info(sdata);
+	if (err)
+		return err;
+
 	enable_irq(sdata->client->irq);
 
 	msleep(50);

-- 
2.51.0


