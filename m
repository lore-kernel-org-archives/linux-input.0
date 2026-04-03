Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3C3D3CF2;
	Fri,  3 Apr 2026 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236117; cv=none; b=kKmFM2D2We/61M4bUl+vWYJ2hYITUDBe44qWXi/5X9hvvLf7uFKoyLtWpIhrzHEQic66hqhYMxKFDGjfQqupvatqsvHQgGWTi82UAx7EHP6dnbHzNk6bZ9zAdzzKpJeeh+1ehyggAKreiBQaFhNigyaeI3Jp7OjYj0peMNdrQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236117; c=relaxed/simple;
	bh=Jd5hIGfiPnahT8dkJsoGA3qIVbAw/LNGEyDeatYvUyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIIiPU+oriqn9NCua09AqOEVmydBxxcpS+gizuXva74nGDna6DVdftKlQpRkJHlg4KXAmApV4cxHV3qb4QvsCtzvVQjpDpbWswOuuZcwQpqwq/daooeVcD+dyLMz+djJrNsVyDyRz9ae1RWE+JzbtI/y8Xx/Lp4G9ppsLm3prgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ3mmr3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ3mmr3b"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E321C2BCC6;
	Fri,  3 Apr 2026 17:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775236117;
	bh=Jd5hIGfiPnahT8dkJsoGA3qIVbAw/LNGEyDeatYvUyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fQ3mmr3bbLJlJcAijLaivoz/MvATvzKUtsAtFnIjusgLJZyOKnLexFoTs9f8kyJGd
	 YMJIokW8qZMTjTsF/55TjRSJ9PolPEwpD4TTjqErUBLNkWAMaoCHeYvQHFVGqQGK1H
	 s/QAIMByLVESRSRO7DRgKsvoyCVucP+AdA55cWjhqTOt+reVHCXmrhCOAOn1Eaicvf
	 60f8c4s3ttLwc8aWwZe7OJssvFudNqRMyuiFY4wUKIKq+cc/ALVzbl4788FmVIQ/V8
	 oMzw52YTGHeNFfdTfXF0JnGPhHqYRfssFqYqe/eBLF6ooVw6cRmNyC/aRNgKcA+OtN
	 OQ3qvUejcv6Ng==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866A9E85385;
	Fri,  3 Apr 2026 17:08:37 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Fri, 03 Apr 2026 19:08:34 +0200
Subject: [PATCH WIP v3 05/11] Input: stmfts - disable regulators when power
 on fails
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-stmfts5-v3-5-5da768cfd201@ixit.cz>
References: <20260403-stmfts5-v3-0-5da768cfd201@ixit.cz>
In-Reply-To: <20260403-stmfts5-v3-0-5da768cfd201@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=LIButZg+Qr0VYxOivFVqKi0JBvx+GtP/QaYfETouW78=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBpz/QQDRJtfGA8dK851nFa0dQ2JxBOUNYT4wkCr
 AFhPDC+8smJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCac/0EAAKCRBgAj/E00kg
 chRsD/4viI8uLlIse4j+WjF/Uq1x/n9t9g5nLR1KsGmY0DhwTdIBIuQmw8A9ImwhszZKGdkvp9l
 zmnv838m5M6RJkoPON0r40lybn8gqpnfj5m8ARTc6KPMLWU6TXDOq1TnEyOEe4hw108M8illqoz
 aIHkVowf54KSR1RVielpe2OVGn62cJaUXAYxwukiVR5TWBqJSW//S4vVhl3njlxteMy1/3UuFRB
 LRqQKsp0NsT+gE5e15nz8CT7I/ePTGRWHXAjZGwliX9Q8auG0XK353zzTZdByOc9hlPAHhXflRR
 o6QhQfzv8ZBNmVrqWORV8ylaLzMvgUP35aRQUNLUPwHTPb13v6mIVL1BgyvNYMHdKgpdwylKQTb
 FtVp7BvzWOohL6ZAOnElhUWs/68XwTh/hweYO5oGzDd5vXsm4QulPhMaRNuVec384gHW7hhyIxx
 OnnT/TJ9G/ZDjuZuEixwY3z1nOC+wBR7CxK2ATluQsXJGQtTznACmK5FI97hEtj3pERBAg7se9V
 uPnwfrcPf8PWAI/zKzfM3o6SP8FTv6PeJI+YCPTjjQKXhaRNpfYxhwPJeKWiyME3/ciS8iXt8RP
 JmMSYAVojQxXqBucqLcR7QxjqDqq+Ieoy5tCGWb3B+Fwf7ULEbO3mNg4eeGb7W2uLEk81zO4W+a
 RAOiIQYfrSrDGgg==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

We must power off regulators after failing at power on phase.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/input/touchscreen/stmfts.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 71d9b747ccfc5..a90528b76f52b 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -557,7 +557,7 @@ static int stmfts_power_on(struct stmfts_data *sdata)
 
 	err = stmfts_read_system_info(sdata);
 	if (err)
-		return err;
+		goto power_off;
 
 	enable_irq(sdata->client->irq);
 
@@ -565,11 +565,11 @@ static int stmfts_power_on(struct stmfts_data *sdata)
 
 	err = stmfts_command(sdata, STMFTS_SYSTEM_RESET);
 	if (err)
-		return err;
+		goto power_off;
 
 	err = stmfts_command(sdata, STMFTS_SLEEP_OUT);
 	if (err)
-		return err;
+		goto power_off;
 
 	/* optional tuning */
 	err = stmfts_command(sdata, STMFTS_MS_CX_TUNING);
@@ -585,7 +585,7 @@ static int stmfts_power_on(struct stmfts_data *sdata)
 
 	err = stmfts_command(sdata, STMFTS_FULL_FORCE_CALIBRATION);
 	if (err)
-		return err;
+		goto power_off;
 
 	/*
 	 * At this point no one is using the touchscreen
@@ -594,6 +594,11 @@ static int stmfts_power_on(struct stmfts_data *sdata)
 	(void) i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
 
 	return 0;
+
+power_off:
+	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies),
+			       sdata->supplies);
+	return err;
 }
 
 static void stmfts_power_off(void *data)

-- 
2.53.0


