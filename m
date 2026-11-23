Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439029;
	b=l322WslX9jSblI3Ll6gwCLqYNSLh6JOjN8IGyPRCLkHr9zHNcN2hAuRVe1LZyNZiVQyf
	 7g4o6ICS5pL94mYVN6olDG9m47987mtx2xiQx2Qw/I+3NNq/mGbanOjkJ3M6XTH7tdHSj
	 3xTV6EqOE65dL02n8bZy+2AiIbupnO1Qsci6l6jKVOrD5iRPFysyxGeIejq5AL+m+PHJN
	 KhmP9EOkUZPCwqYy8OiWAWDuUfRGHQSKWilfMvCZNzAOQAg4WpJ5V+qvlgIXOSu+Lh//H
	 2i07UC2U5OOSWZo9YM49RIQ9dee23iNSBm40iKA3PjCAtb1Zrvb12kHwH4ki5Ea6OSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439029;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=ekjuJETxBofgW47xyMti6B4g7UJc0kIjJ8m41jtns8U=;
	b=EmcBkJcxILh7qqJmzbqT93zmacijWvCx4QtawN4vF0xT3vQYpbQbvxIY0+rXEFWWrWFT
	 sJhvO55+NMrW66wKY+4FwmaFuAZZn2Z7ItxKUrax7xXGoZElxv92LGjBSDatZF5oNFxUq
	 upFtUneXuUFRPuscpfpDX1/JFy11rP+XSlIIfg+D3wjnIGbskXMZpCtkXqiqC9W+eBP6i
	 7ineq+Qw7gR/O+dU3iFdqVJCyukOg+1XH+pLf4qvnPH8VOJVhrhatap0QobwuCtPrkmTV
	 QZ+c7DYI542HK84Rs7aoZbQUmYjvulNVr40pky47IqU8eJbEe6M32jTOHxZtikN1Bnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=qyMrZ5x1;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99790606A31A;
	Mon, 23 Nov 2026 13:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99790606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=qyMrZ5x1
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE4521D827A6;
	Mon, 23 Nov 2026 14:03:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795439024; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ekjuJETxBofgW47xyMti6B4g7UJc0kIjJ8m41jtns8U=;
	b=qyMrZ5x1hjNCHT79tEdPMisOuvgjp0hcT10NEZAWbHYqPBp3jgEYsFmvf5+cS8Mre8mIDX
	O1Utv9aj0xUSEo+ueX+5Daz1tdKx+Wg2J8dwJutg5lsKnO+ODk6TuaqngarU703O0m6EE6
	70qaLRqM7LrN0fS2mb40kjZHfsmHo1ZuxK1jBbyM+wauG3a9rUOIsyzmwOsCGR85DSo2Va
	yRxCXzK+xiR74CNeaTW1coXkhXvfK1/r9fRHsiIblCZIVPn216049fiSJ0CiuCbUlXq+2N
	wJKa85fVZKO7n8d/OERy0BRyl7TFxdb2qHdYlMrWs97FE15rC9ubP4fRqcbmvA==
From: Michael Auer <mick@yoxcu.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH v2] Input: pm8941-pwrkey - report wakeup events
Date: Mon, 23 Nov 2026 14:03:36 +0100
Message-ID: <20261123130336.1316006-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The power key (and resin, with "wakeup-source") is a wakeup source, but
the driver never reports a wakeup event. Its wakeup_count in
/sys/class/wakeup stays 0 even after it woke the system, so user space
cannot tell a key press from other wakeups. PowerDevil, for example,
uses the wakeup counts to decide whether to turn the display on after
resume.

Report a wakeup event from the interrupt handler, as other power key
drivers do.

Signed-off-by: Michael Auer <mick@yoxcu.de>
---
Changes in v2:
- Report the wakeup event only after the status register was read
  successfully (Dmitry)
- v1: https://lore.kernel.org/linux-input/20261121204112.847960-1-mick@yoxcu.de/

Tested (v1 and v2) on a OnePlus 6 (sdm845, PM8998) with an
sdm845-mainline 7.1-rc1 based kernel: after a power key wakeup from
suspend the key's wakeup_count is no longer 0, and PowerDevil reports
the wakeup as coming from the power key. On input/next it was only
build tested (W=1, arm64 and x86_64 allmodconfig).

The event is reported for every interrupt, press and release. After
resume the press can be read as a release (the handler then simulates
the press), so reporting only presses could miss the wakeup.

Tool use: the analysis, the code and the commit messages were
written with an LLM coding assistant (Claude Code). I reviewed all
of it and tested it on my phone as described above.

 drivers/input/misc/pm8941-pwrkey.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 34b4afbb1984..034db0ccc9b3 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -165,6 +165,9 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
 	if (err)
 		return IRQ_HANDLED;
 
+	/* Let user space see that the key woke the system */
+	pm_wakeup_event(pwrkey->dev, 0);
+
 	sts &= pwrkey->data->status_bit;
 
 	if (pwrkey->sw_debounce_time_us && !sts)

base-commit: fed36ea16e3e9929a07c7dc285916216dffac7fa
-- 
2.43.0

