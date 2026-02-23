Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF5371056;
	Mon, 23 Feb 2026 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883570; cv=none; b=oR0hEsoZxy/T4BMPd4GOi3i3tzjgtVCK+7qYBQy2l7ZmQnXrYVc4IlYJ6N4sX/M5nOdKhEnmlXiG/mWobovY8tolM2JyeljDMXqFxAG5TnM56/InzLp8m/Jr9jbp1us7Kha3uA8FnE890J737BemikJOKCW3txPAGQB0osquiHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883570; c=relaxed/simple;
	bh=5Pqf61yeeHkieyN/SC6tXgMl060963XQtuofQGXp+Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsoYh1JSvk9BKDBc5sXJn/HSL3yj+JSyhAmTrv8kee6evSqGanPl94+MrgelQT8BZn4MfHiSDSrOTFTff7CSdqwSCIMtzQfX+CEbsc4eVvAybA1lA5tUQK1/lp5GDlj7vEQ3hwVh94TRClvd80Ix8IH6xV5XwZ8GHBNeql2F/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=aO1YnJzZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="aO1YnJzZ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZN066zXzlh2fN;
	Mon, 23 Feb 2026 21:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883566; x=1774475567; bh=9nw1Y
	hBDny49VjVzPhX78+AD35KoxHopUr7OaiUTYNk=; b=aO1YnJzZggkSb590gLgKN
	MXdrwcY4lncxbvkGFgroxeHpoZjCTVU3nO9GfqYEVi69cdj7Hb0WVS26ttAAkTWi
	UiRcMuhYyV6YK+ozitXwbJrzcp3ublfrHo/w1abkMlVOUkxi2MygHQ/bURUYkS75
	NcntEBtb+eFlPd4rD39DLHA50zVZQGlMA4YhhjWw+2GrjMZyXTnbyZz5pVvTiqyv
	epTlViPSLfJWxi2PFr8AJL1Q3BsoNBCU4/hLohy8dn5c0JArp6pVxE7WDygffmv0
	EkkxGPj0OKN1N6FcxUTh08TJiPbE5to4oBB4L7mbubgw558LZPpAujOEPvxhMoBM
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 30s_d2wxSNTK; Mon, 23 Feb 2026 21:52:46 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZMs272nzlh1Wk;
	Mon, 23 Feb 2026 21:52:40 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
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
Date: Mon, 23 Feb 2026 13:50:30 -0800
Message-ID: <20260223215118.2154194-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223215118.2154194-1-bvanassche@acm.org>
References: <20260223215118.2154194-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lock f54->data_mutex before the first 'goto error' statement since
jumping to the 'error' label causes that mutex to be unlocked.

This bug has been detected by the Clang thread-safety checker.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>
Cc: linux-input@vger.kernel.org
Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54=
 diagnostics")
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
=20
 	report_size =3D rmi_f54_get_report_size(f54);
+
+	mutex_lock(&f54->data_mutex);
+
 	if (report_size =3D=3D 0) {
 		dev_err(&fn->dev, "Bad report size, report type=3D%d\n",
 				f54->report_type);
@@ -546,8 +549,6 @@ static void rmi_f54_work(struct work_struct *work)
 		goto error;     /* retry won't help */
 	}
=20
-	mutex_lock(&f54->data_mutex);
-
 	/*
 	 * Need to check if command has completed.
 	 * If not try again later.
