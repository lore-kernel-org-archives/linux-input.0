Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D73A2E36
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451096; cv=none; b=WUc8fLWN3QTTsQuN4H87wC6XM+Pdceq/T7+rHV+19SUqLpntYvPJ06i8pupBnhtggz7Zx4x5okQNz8ayBbroC0sVk/pR7pEGHMfhhN5iegq+H6C6LfQOoZUfLpydGfA4TI1KV71WgkiL9t7YNZDTahFYX+XlWhCSowJngovNqIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451096; c=relaxed/simple;
	bh=zgJ9AtTdSIkQ90Om/CXas7Dimf0BgqPsiJZ4DNoz7BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6YvnIkh+ah8uefk3ylSv+bMqUy+TRRXu+8mfMlrIm0aFJPmME3Uf4S8RdUzjzO/lHWZE9tAet7SLXKSpk07iWpztoaL9isfHTSf/eJqBNwOezwk1OZjzMRRKY1NCvUacEelBwX/LujeOebuxNpFEQ2K7qjK4FxLS5sYsyHVooM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j14dNrE5; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j14dNrE5"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30bc806fcf8so780970eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451094; x=1783055894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qxi0SvECdeeSU5h+tXAOyWZUcGzGjMbcI09ZL3GmHI=;
        b=j14dNrE55HWrb7y4itIyEIo3viNAlqHSI+3E03wVpdcJkHPu7nB1Inh/E0VdaZFwy8
         EEq3I0Jf4tCgYl9KMRQuzSQI2F2msuAcDfLcXfVCkoYhoXDoQa4vGLZgffFQDnbqmWYf
         n/FK4ZvKFSATRldWJ1H4SUi9dVAYZB3IQFfEuXN3F9lK+LkZbSuIDMFeIBDqsC7Y8BTl
         sHyQ/p+I901qBahedP8l8mVEph5ogNJHLYjeC+4mSmKWeFeZAtq0JADWRlOxQMyszYC9
         DRkiKpJa+8MtxPiPPTjbB9TR9PKB1nd7WwuS37VkQrjgwGwwaENu1Jw49Jp0P2iFgsKH
         uTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451094; x=1783055894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Qxi0SvECdeeSU5h+tXAOyWZUcGzGjMbcI09ZL3GmHI=;
        b=TfaiF8XM0qRjp1TJWJ37/biZK382BvLF8EfHvNzYij7dNOzopXoN9rF0jgEaubNLco
         +BBDLk9bBNEtgQVuGXnyw1cwryzOwvfOvoTqVNlHW0IA1JP9JSZgREoRLal/UV1NInRU
         YxiPx4UTXNK7do3vDsZB0Urpqj3G7IEi5Sd6uK/ohveBcjy0197Nqds3mjRrV8SXVV2i
         8taAJq8cbgZKB4NWRL0IYRgYHZnt+9gqggTQSWtHwM4GDw1GQvtErQ0Cu84h00i3ABr3
         I+O9Fj+NxUq30PCgIo6KcXXSpt3qDWdsF8uSRZzSfj5mWsxn9JYTb+838/M8BbT53VzT
         n/yQ==
X-Gm-Message-State: AOJu0Yy/yJUgcPaBTFESWRP0vJ04wwdZGdmCzlYuxteNAX9OvL9ZmAlA
	HuQb/+XjBVFlQAX9BBxlEmHoc2luwXgyaPsKIp4f0eqaKJVm82u/768t
X-Gm-Gg: AfdE7cm3kW1K3RdLszOhu3DgKaceF8JderDC2tllu/Hi7NKRmoByFA+CPNzybrIUoxi
	336/c4AaJyHXeSA9ILz2N1+6Ce10uanRBMrq++Yef5EIju9BK0uKLWlZmwBjrzKej/auwvGhxJv
	tmusxi5UjZHSQwiY/NbyApwQWaO7XoW/W/ckmdnSI+ZCc7thz17zpr6SzZLeMC2fwO5Yb+wmFh3
	f3tp6rSdtVbtze+83NiymsDnfvi0rVc0hxhM3KasJ1WpW1Xcyy9KrMSjTA1KtZZocl7JupElmQh
	MGC7iOrt30L4nCWyqqlzfhgTkn5+YAhLmT8kVOACtSGRD3qS3zslhJ/98SfwypG31WHRV725ZCU
	SEDmjQbdRTBeLZw3AbI/CWx5rjTDX1pyDEEoAF2gclr7ik59tjyUhv1Ff/npx+NiqIbsobvxI0S
	DhwGhN4uTicyy3HU9eNlfDI/5su00NofbCVi20CWKPIqkAtodCB7MZfv7Vnm0QwKlarraN7MAmG
	RVb
X-Received: by 2002:a05:7300:e6c6:b0:2be:833c:149d with SMTP id 5a478bee46e88-30c84d46fcfmr5444139eec.28.1782451093588;
        Thu, 25 Jun 2026 22:18:13 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:12 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 06/10] Input: synaptics-rmi4 - propagate F54 worker errors to V4L2 queue
Date: Thu, 25 Jun 2026 22:17:55 -0700
Message-ID: <20260626051802.4033172-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, rmi_f54_buffer_queue() waited for the worker thread to
finish but ignored whether it succeeded. If the worker failed (e.g.,
due to a timeout or register read failure), the queue thread would
silently return success, delivering stale or uninitialized memory to
userspace.

Add a 'report_error' field to struct f54_data to store the worker's exit
status. Check this field in rmi_f54_buffer_queue() after the worker
finishes, and mark the buffer as VB2_BUF_STATE_ERROR if an error
occurred.

Fixes: 3a762dbd5347 ("Input: synaptics-rmi4 - add support for F54 diagnostics")
Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index e86dfc9ce7d9..c86bc81845bb 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -106,6 +106,7 @@ struct f54_data {
 	u8 *report_data;
 	size_t max_report_size;
 	int report_size;
+	int report_error;
 
 	bool is_busy;
 	struct mutex status_mutex;
@@ -340,6 +341,12 @@ static void rmi_f54_buffer_queue(struct vb2_buffer *vb)
 		mutex_lock(&f54->data_mutex);
 	}
 
+	if (f54->report_error) {
+		dev_err(&f54->fn->dev, "Error acquiring report: %d\n", f54->report_error);
+		state = VB2_BUF_STATE_ERROR;
+		goto data_done;
+	}
+
 	ptr = vb2_plane_vaddr(vb, 0);
 	if (!ptr) {
 		dev_err(&f54->fn->dev, "Error acquiring frame ptr\n");
@@ -610,6 +617,7 @@ static void rmi_f54_work(struct work_struct *work)
 		report_size = 0;
 
 	f54->report_size = report_size;
+	f54->report_error = error;
 
 	if (report_size == 0 && !error) {
 		queue_delayed_work(f54->workqueue, &f54->work,
-- 
2.55.0.rc0.799.gd6f94ed593-goog

