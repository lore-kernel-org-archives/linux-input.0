Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0B31D362
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 20:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123183; cv=none; b=LqJkxpKC1iV3OAIGeznkpYF8OIVXfr3Na6YclUTJ+TZkWzko/iRtlr4JyK60peN2XDcVteUFfRhuS5xfYJAX8ipO07ofqOvBv8LvtcIqnsGsGUP3dlberat62gz709fOb3hGU+wVyxDLh31t0rXmMZj8dMALau7uXLK6MrsTrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123183; c=relaxed/simple;
	bh=dgRlrPA0xNRpVH6a2orSrjoVD6Nad1aDhCkhQHF7NZc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSzIOB8Wm2Av5QHtjdQHFdY/gXFrwvKO4qPL7jo0K/gFkkE6eR+DNEIAcY8ahKD7OdxlppJ1pRpmMyqrXrvaVf4EaW5RTSD+28gRM0stHK0dPEf67iGyyGh4Fu8QWWW5DsHO7fGiATujwMoSexdFTWoVCuKVZ0ZQs8f8G5HbOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4ulL8SM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4ulL8SM"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so2229716a12.2
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 13:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788123178; x=1788727978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EUPfcFMxDXMk/XqBeY+4XwVjn+mvGP82psS7PbouEZI=;
        b=K4ulL8SMDxQGY9peYtUl96MNzOmlNI+cDtc9p4EoZ2NfPXPLblNsOnlFSu94jxZ9xf
         CwIjBZMSdGrzVsvZ+vg6/nJsXP9PkNXXnkBOX5hLcr5krzFtl9U9hV7ByhKZ5l+iFr+q
         179zMzQ6kX6VRCBUQR6AlSOQWtfMnKS21QPt80xe6ATIY9+4/E4GV1DMcze92KtRigOl
         yHLgf8HKJvT4d24v8y10rTS0vukPHfzqjWiBGB0cr13v6HXNaxdXWgn1s3/xAmy7OQmd
         l3zK6yeP1DBfgwSbl3RcFzPvhFDjcKhKV+qufAsr4BHPruRstaj+1jq05xNJIxkwiJRE
         leJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123178; x=1788727978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUPfcFMxDXMk/XqBeY+4XwVjn+mvGP82psS7PbouEZI=;
        b=qgueij6qwnHVlnLvxonerBfhbAnKylTjrCGsUAdmDl1g6CaDjVWlVxXW3lLc1nUphq
         6Lljj62cyN8YF9KSXKQz1+4AoYGNcV7c8KSVFnS69xbaFy6RO1UYJrsPrjv0AWmX9/0o
         DTQMbFmffvkSVVMWFR7JAW9wN96CVSWvKQ15CrrJy3aFCn/Uoa9Dx/e1PYvjBPCLwn5s
         r7sN24pcgxOnEco6ph25c4iyXzt1UHs30K8ele6V+Xo5YvI0SQgL8XclnNT6EVxNcrjD
         Vx0cdEYTknLLOiMxJ6BAaTDIdkX6bMRGa/IE/AZy7CEP9NgozdEnrMpF9icnWIC45ncH
         J4iA==
X-Forwarded-Encrypted: i=1; AHgh+RpVwn5IaAnImqQlNlfx2v87B+K4AehaosiJ0NcsJU+Ip0mk61xxdUBYKnEg5k+n1tdoWB59YNd6xsvR6Q==@vger.kernel.org
X-Gm-Message-State: AFuF++mkoppnYP/gc35t+Y/8MoKtmcwVs81CDv7Wne0DBMwa/fHBZo7m
	oMsNXfCmt6yT1cLCuHG6ODUCUlEk6nUB3NJ7asLx0U86sIlj/WTG4aJg
X-Gm-Gg: AR+sD12/pRbY5RdMwMzt3tmyyBwrkAz3Nk8CyUPQ9XKaN+5SeIQE0+4ANLZXyFwJxB2
	SORqT4SBfamAjfFjj95V+l/0oENdBnUPnP3ssLsPJjhcb8We9MlhXxdVa+pUMuUfR7p6lAc959D
	tQlQEq6HtKltXOXiPBQlFeVuowWMwdTEeTMmhEmu72amp1Vo08lj1meQQ2L2kxcWdbuAcU/bXI6
	YZUKSPWafE/DTkJ5lgrBUWCyuzBY8xCyR0Jx+wrgn4oNXGf+3/3plqYNu6VkoMubA7oYoS48OSj
	IpeYodrRvPktaavVsmqhNUSxWLumHcVdpKpwTFNzXEua/oePKrE750icaTOhE7SisitJYcgzyD8
	L3JJaYlPLdmdrHfE/RAVVcp8LmijTzYYjRYs+EXbyc7HxQRzAAy4Squ4ovyiaabViZx9i/icx5X
	tiRUHCvWIvBnDmOdpxK7YnovOpAs9X3b8rK24bnozyisCvxmDlFslorN0je+8U+v9HfvXfrua4d
	9BmVal712YPo0xqH1LS60zOk4hRYsObHjLgtcb7qesTe1ubrIM=
X-Received: by 2002:a05:6a20:a108:b0:3cc:f280:ebc6 with SMTP id adf61e73a8af0-3d265c4270cmr33755175637.5.1788123177680;
        Sun, 30 Aug 2026 13:52:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c021:485f:75be:3c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm26849437eec.24.2026.08.30.13.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:52:57 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 30 Aug 2026 13:52:48 -0700
Subject: [PATCH 3/7] Input: gscps2 - protect buffer access in read and
 report helpers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gscps2-v1-3-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
In-Reply-To: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-parisc@vger.kernel.org, sashiko-bot@kernel.org
X-Mailer: b4 0.16-dev-b242f

In gscps2_report_data(), the ring buffer consumer index ps2port->act was
read and updated locklessly. When gscps2_interrupt() was called from
process context (such as during port write or open) concurrently with a
hardware interrupt running on another CPU, two execution contexts could
execute gscps2_report_data() simultaneously for the same port, racing on
ps2port->act and leading to duplicate, skipped, or out-of-order bytes.

Protect buffer access by taking ps2port->lock inside gscps2_read_data()
and gscps2_report_data(). In gscps2_report_data(), acquire ps2port->lock
only when popping entries from the ring buffer and release it before
calling serio_interrupt() to avoid recursive deadlocks if the input
driver synchronously sends a command back via serio_write().

Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/gscps2.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 5b6e311f8a02..fef6fffb6f86 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -238,6 +238,8 @@ static void gscps2_read_data(struct gscps2port *ps2port)
 {
 	u8 status;
 
+	guard(spinlock_irqsave)(&ps2port->lock);
+
 	do {
 		status = gscps2_readb_status(ps2port->addr);
 		if (!(status & GSC_STAT_RBNE))
@@ -255,7 +257,7 @@ static bool gscps2_report_data(struct gscps2port *ps2port)
 	unsigned int rxflags;
 	u8 data, status;
 
-	while (ps2port->act != ps2port->append) {
+	while (true) {
 		/*
 		 * Did new data arrived while we read existing data ?
 		 * If yes, exit now and let the new irq handler start
@@ -264,17 +266,20 @@ static bool gscps2_report_data(struct gscps2port *ps2port)
 		if (gscps2_readb_status(ps2port->addr) & GSC_STAT_CMPINTR)
 			return true;
 
-		status = ps2port->buffer[ps2port->act].str;
-		data   = ps2port->buffer[ps2port->act].data;
+		scoped_guard(spinlock_irqsave, &ps2port->lock) {
+			if (ps2port->act == ps2port->append)
+				return false;
+
+			status = ps2port->buffer[ps2port->act].str;
+			data   = ps2port->buffer[ps2port->act].data;
+			ps2port->act = (ps2port->act + 1) & BUFFER_SIZE;
+		}
 
-		ps2port->act = (ps2port->act + 1) & BUFFER_SIZE;
 		rxflags = ((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0) |
 			  ((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0);
 
 		serio_interrupt(ps2port->port, data, rxflags);
 	}
-
-	return false;
 }
 
 /**
@@ -296,11 +301,8 @@ static irqreturn_t gscps2_interrupt(int irq, void *dev)
 
 	guard(rcu)();
 
-	list_for_each_entry_rcu(ps2port, &ps2port_list, node) {
-		guard(spinlock_irqsave)(&ps2port->lock);
-
+	list_for_each_entry_rcu(ps2port, &ps2port_list, node)
 		gscps2_read_data(ps2port);
-	}
 
 	/* all data was read from the ports - now report the data to upper layer */
 	list_for_each_entry_rcu(ps2port, &ps2port_list, node) {

-- 
2.55.0.897.gb25b4bd76c-goog

