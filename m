Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BB836CDF8
	for <linux-input@vger.kernel.org>; Mon, 23 Feb 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883425; cv=none; b=LCD8iNsNdYCVcsvEJxtuR4bh4s8XC67mVIhpaN69wRJwd5Lj/nrZZ4BQ+yTn2eEQ/1+JjsHBqR+qxecO8uR7YFmIbKS/tQzy4rV2CTBmK4C0IBv7h9d+uY3eFQho99xV3hghMrNZr0k9YNfmn7exB1/lWs3j9E94l2pfv6GyP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883425; c=relaxed/simple;
	bh=5Pqf61yeeHkieyN/SC6tXgMl060963XQtuofQGXp+Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kAgDdHzJU0g59yOEacA6c5BF8zsghj1fxGKVRTkCCp/aor4UjfdERXGIfraVQS8yGJomYK8mqvIKO1Wtzz0wGXV2zrx2XnXJ0FPdc0ARDYMhEIFjI7inQYXOuuHWNbuOlpZiABhYOkt+ChxDYE7WSV0CGm/wmQ/IuAYLvepEB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=H7YRt+pA; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="H7YRt+pA"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fKZKD32P9zlh1Wf;
	Mon, 23 Feb 2026 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1771883423; x=1774475424; bh=9nw1Y
	hBDny49VjVzPhX78+AD35KoxHopUr7OaiUTYNk=; b=H7YRt+pAkiPKXK0istdF6
	oBtT33kNPLoabY6BgpLJ2vKH1DF0zFT+ByL272024W0l94byoZl51eyUWc/a4vOC
	yzeL8I8fKvGUbFPUxshMfW4qJgwevs3b7fNfOAOyjhM4FN0vsDMzZMbzmL2bD8Tf
	CEUGcJ36bSlEa1O5KSEy8PMrkwQaICx9I1DcxlUmuDXZLRPj1/0byFRLgw1nP/2E
	FScEFUsxSgJvTJLiGxDvosJAX0P8o8Ala2GEkEUI9+69gdNEFbMZe+AIzw7gHcDo
	TBLRtaw7wpdeJTUdeDqENnx5/ehfogNIIPPDYJ+cuTJO9Xuxvbf39SdUOcx0SYXV
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fBI0H-hAk8OY; Mon, 23 Feb 2026 21:50:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fKZKB3rpfzlfgPY;
	Mon, 23 Feb 2026 21:50:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Nick Dyer <nick@shmanahar.org>,
	linux-input@vger.kernel.org
Subject: [PATCH 15/62] Input: synaptics-rmi4 - fix a locking bug in an error path
Date: Mon, 23 Feb 2026 13:49:03 -0800
Message-ID: <20260223214950.2153735-16-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
In-Reply-To: <20260223214950.2153735-1-bvanassche@acm.org>
References: <20260223214950.2153735-1-bvanassche@acm.org>
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
