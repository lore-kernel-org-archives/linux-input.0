Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793186346;
	b=nRzyK+fhr8AUvwNscGI9f+rY+obbqh5rL8pPv/3vDfpYaa/NNJYYp/adiWDZhhWzmcEV
	 9fUVbTUM8j8xqm6tJ2a3sqicZBJf7tRtd65khlQCjbnQ2WExmM8SQju2axmCN5CDFSFWD
	 Bq6bKh/Ovv2JdEJ0cU7aKNriEmYe/pPhTuGghqQ6hDUnx4dIiP+Lmy9tMsaK1pROU0jHA
	 LkJBbmVtJSmHSBaYTTTUlR/D/gSe0PDEkJXXzLWlX/aTn7bEp/m4Ewvrd0O9XM+SJqA2h
	 dfkRK8F27dKLoXO+fxYI8fZC+lRmb5V3aTFFIIf1rbbFy0iJF3YWdr2MuqSoeVzH3Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793186346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KOoA9Umgn4JIoMaxIckP13h2ihpbZ+7K1hns+hD7csA=;
	b=xzMmMpjyVO33pARJVcRtw9xOhQhIr5Tnd1/uyO6vKKnHTmTqvbBAcQC4WEVcXIE3JvUZ
	 W2QYcIsZLxgFfNqTBnpAcPd1DKupQQqzZKToiOzcxQ0g3pQ1tuPSp7/Bxt6QWF+dv/uFX
	 kGiv+kLnS8PJXqsZ7pzenq3H0f3qDJBVb4kbFqFfPzqjUe+9I4tTVpcZF3lEVA5ayjX8n
	 HytaJRpJTlauVwd6b+RfEuHCTzqdiVIMF/u1/MpWXmW8unlYHWNrsArG5wyPtsKXFdRve
	 ovsLTRM67WEZ4X7vmR9C90/1SNeqlSdGkPPo6kzefhn5fFxXsJvzlH8h1D9Xvmj1ZdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0C8rcYX;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771EF606A337
	for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 11:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 771EF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j0C8rcYX
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a215e64962so8987755e9.1
        for <linux-input@vger.kernel.org>; Wed, 28 Oct 2026 04:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793186345; x=1793791145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KOoA9Umgn4JIoMaxIckP13h2ihpbZ+7K1hns+hD7csA=;
        b=j0C8rcYXMoI0cHH6kB7YfdWfZh09kZxhGFC/Ew9pWrhnbWA+VWktWHe6a8uCRv4epn
         QtefVpLGyHDpfRsYKZF7xLnBe9uHEI11jP+GJfl/2r3RNfe3VhPaWByqMgy0h6CNFF+z
         wHPhfYNFXWQ8sImdfsr9VtQUc+ZNeNLON5eflMXAyn3LiR2yHA5CDqzBEGYU92Onmet2
         k8NPKNOqsP/CfjUJE95kaDcLV5vv4kSy5vKFtDMPZqcx7pLJO/Diu87YlcHEZfscH9Ne
         xFT8SitdW+DM8YTFN8BDiMXvNSHkBVnvYhZ3Pa2vrP1nKaPGu8YazCEHu6IqCYfI5hMr
         7XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793186345; x=1793791145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KOoA9Umgn4JIoMaxIckP13h2ihpbZ+7K1hns+hD7csA=;
        b=WMysl6idOcjJVm06j2s55vBeKjFkjg7bGr6BzRLD0loTfsvKXG0XId0LoObE33Ej8p
         IgD+9o3opAuInrmyaSg/+m9z/+tZqcjgJtnmX3oParVvcGtFYL1fnNBeW5DmfC2fbDDu
         cHkn6BZXf5FnpvachIQhuOo8LAGDWGMF2Exn5lM7q+LWazfk4Qo6Yy/hbBQzGMY9Hjgo
         Ynkqtyx//QK2cQMaauN6gT85GWDmtMA3hQH0YbhvZYSeEXStWyCWkFcf1ehG7E6j1aXi
         DsGMp4OI/wOcJ2/bCbLvWPsuVjTsarhnW0qTUYYNdeGoGtsyffgiTOOI47A7QwAZaBAy
         S0oA==
X-Forwarded-Encrypted: i=1; AKwUvBy2fdO1NCNvKXsatAuZUrVdH07AGRJdifYwEdJSIYDEhkmNHmNqe3+CRmz3w+U9AtVF6rRoxCTfbBJ1Hw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJMA+K4yzmtlUirj8pG2EJUa44FKdtqdWQOzvKlDs4a8Q86nb40
	27i8yiqv7qEb8amk9Sy2czP6STbX+3TXIpZ90KDX1PWUN1ewL0P2WRQL
X-Gm-Gg: AYBFou1AlWWSfJv4ua7xDNiMTRS2hWYp2vm10JSqisbC/GOn/t4XLxGSaUvUZnpMxcE
	9iYojaa0JdWwNw57LHJr6fJ9ct28OkJYAv+IA4vjwk4cHJcRfYhW90+xt/8z/BzMhhuQ7I/W++J
	hgPYqYfIrf/RXdNo1aJ0wF6b/XXm6PBpLdueahs2XsWI4etzpRaST5cjiNodRfldwL9DFHbUl+n
	c75ZUB0c0QDo7PGtUrRUQeKQynQIZuUhCxLPAVyxhdkgOj80x/7yDWx5T8+F8NSsweqM9H3g4YM
	K+oYNbqmfk0E0PrU+7N5vKjGyEgdUAMc4eemydpzQHv8ZflE2mBsn4oCZ5oBK9IbbGa6uBk54Ts
	ggQ2QAEoKzaGu7b/vyEM+5Yk43GmSZAixsFpiSlg68xTuOwUWHyAUj56VtOz+gj4HuAyhr2FPWf
	oEmca1wBFyZ07/6KnNUTAFL+mjtF9g55ydJfFpbcpYsWbtJFMB7nPauT5RWpGudBuOiRmRMc4Bp
	WGGqiPJIYYaLPjcDmBqvrngy/gmoWH2Hl5Hg+IP9wJPZbG83+KQCRiF/6L4olEwV2m1Uft6sccU
	/zT5sLxxo8L+bFSIBYnmWZCNEqO/E4ciDUXL1iA=
X-Received: by 2002:a05:600c:c3cf:10b0:4a1:f377:5c75 with SMTP id 5b1f17b1804b1-4a967d96ef6mr29165285e9.33.1793186344800;
        Wed, 28 Oct 2026 04:19:04 -0700 (PDT)
Received: from fedora ([2a02:587:85d1:a500:5135:1deb:a9ab:fb3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978d57b39sm64197635e9.10.2026.10.28.04.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:19:04 -0700 (PDT)
From: George Karagounis <taterraster@gmail.com>
X-Google-Original-From: George Karagounis <mail@taterr.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mail@taterr.org
Subject: [PATCH 2/3] HID: elo: Replace create_singlethread_workqueue with alloc_ordered_workqueue
Date: Wed, 28 Oct 2026 13:18:52 +0200
Message-ID: <20261028111853.22429-3-mail@taterr.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028111853.22429-1-mail@taterr.org>
References: <20261028111853.22429-1-mail@taterr.org>
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

create_singlethread_workqueue() is deprecated. Replace it with

alloc_ordered_workqueue() for the elousb workqueue. WQ_MEM_RECLAIM

is added to ensure hardware events can be processed under memory

pressure.

Signed-off-by: George Karagounis <mail@taterr.org>
---
 drivers/hid/hid-elo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-elo.c b/drivers/hid/hid-elo.c
index 86e8729e1975..72fdc073ae39 100644
--- a/drivers/hid/hid-elo.c
+++ b/drivers/hid/hid-elo.c
@@ -296,7 +296,7 @@ static int __init elo_driver_init(void)
 {
 	int ret;
 
-	wq = create_singlethread_workqueue("elousb");
+	wq = alloc_ordered_workqueue("elousb", WQ_MEM_RECLAIM);
 	if (!wq)
 		return -ENOMEM;
 
-- 
2.56.0

