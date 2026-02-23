Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4711A37BE67;
	Mon, 23 Feb 2026 22:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771884134; cv=none; b=q8HwVCVey/za1yi5BDOsRYKHXHc05KIN+djcjdU1vXWuwpZpVSzdervnAK3yy3Nzz4AVnNp6tz8SiOZtqfy858l8cfIecCCGlR0+QiQK4sC3RZetNMYtl5cosxlIi6JKtPAea4u9wQpZD72d8kgtfn2yjN7vty6HhF4bX5i2akU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771884134; c=relaxed/simple;
	bh=pw3vyz+acPDy/m2PO3V4cGL2PnXrziFDsmoMLZw8roc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XH8Vddu4dNnlOzwmGEgwCESf8BlJBbOmBY4IuCV/Uz6KPN3GT2E8YY4y9ShTx3bgf2erD+rQ96DFYf/II3HF+beUsUEfQfXpxuAnBvmOpllVmXcpgqUgwwa+a78G9ptcDIIYobPk2MMYEdyMm01HxsU2olOrErgapVLQ5HVhH7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t8kqdRIK; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t8kqdRIK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771884131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmtOctsCvHwnciSaneDI0yWRVyNerg692l2YgGbkbfs=;
	b=t8kqdRIK1PDdLPrhA7CZluePlZqqX4ZJyW7h9rMSUrDQ6dMuIzTSYlBLGguxL2+51Rt8j7
	wUMzAkSLEUaOBECRs60MVXsKD9no9aH86aqxAzswUs/d2Vt9dNabWmcMESbgOkY3OM8gPq
	uNQEGHiMs83zyJj2OzKEYL32XdlIToI=
From: Bart Van Assche <bart.vanassche@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jann Horn <jannh@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Nick Dyer <nick@shmanahar.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 15/62] Input: synaptics-rmi4 - fix a locking bug in an error path
Date: Mon, 23 Feb 2026 14:00:15 -0800
Message-ID: <20260223220102.2158611-16-bart.vanassche@linux.dev>
In-Reply-To: <20260223220102.2158611-1-bart.vanassche@linux.dev>
References: <20260223220102.2158611-1-bart.vanassche@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Bart Van Assche <bvanassche@acm.org>

Lock f54->data_mutex before the first 'goto error' statement since
jumping to the 'error' label causes that mutex to be unlocked.

This bug has been detected by the Clang thread-safety checker.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>
Cc: linux-input@vger.kernel.org
Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/input/rmi4/rmi_f54.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index ac4041a69fcd..fd57ebb1cb50 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -539,6 +539,9 @@ static void rmi_f54_work(struct work_struct *work)
 	int i;
 
 	report_size = rmi_f54_get_report_size(f54);
+
+	mutex_lock(&f54->data_mutex);
+
 	if (report_size == 0) {
 		dev_err(&fn->dev, "Bad report size, report type=%d\n",
 				f54->report_type);
@@ -546,8 +549,6 @@ static void rmi_f54_work(struct work_struct *work)
 		goto error;     /* retry won't help */
 	}
 
-	mutex_lock(&f54->data_mutex);
-
 	/*
 	 * Need to check if command has completed.
 	 * If not try again later.
