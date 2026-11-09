Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204696;
	b=sAzLe+Whezz9+cuhk526wZ75jbY2kqJa1fhBDASuVTBDhVc/yM6vGCDnVx2QepGcvxVo
	 0AvKKUfLen32xZs+rQQlhQ+4jzGMC+RmrGLTzb2u/AmBpUycsWkOncTW9txUXI5B3Rvw/
	 0wFU9IRCqxA8rWsFZPzd6SK7LQiyqo7enPPa9bFAx9Kd0rlkHP707O8zfUX12tsa3VKZ9
	 MRLNw5/iAbPhD/60+52fHNQ48d7i67LXSnhpLBbCHV7s8+N5HoZbQNohe8tHK5TmrBEkT
	 bDpiMy6CG6JW2SfL/XQ7/TzPoHV9QWg8G3tofbhS27JxboLJKu/pc6qsXOIHR/l9tJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204696;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MVofIXRExu5WXM840EB3nQvSdANY3ZBB2XNgoi+7ewY=;
	b=F606hDQj03diimmjA7kgn/Kk4hZuBPvWC9NXjkYNltdE7bNZbn5S8umOmKhzy46f/RGy
	 Xo3L1YmXfXVHZb4GB4Zd/4Ckh7sQge8HnWU3zmW+OcGXipKZAw5tcSKRvlcr01+wrpf14
	 Rmy+keoEBibkhXY/7dlY0xbmNIQ6jsgmflpNIgY31dlvFXJ6YTUiaUrwAbr1+P0PBEECp
	 qI5BLqFFO3hahq4Xtme3T35z+JEmkY/JC4Zvw7ym59hZO0AXvqNYg3NDJZIPP5d0yFDzW
	 iDllUrzCZohKYVY7/gwUmmK0i6w/yb5SUHtonbneah4U1GbuZ43WamQBBtk5DA0PZXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVFv7XEw;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E096082BEF
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 06:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8E096082BEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hVFv7XEw
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-37198ed3727so750567eec.0
        for <linux-input@vger.kernel.org>; Sun, 08 Nov 2026 22:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204695; x=1794809495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVofIXRExu5WXM840EB3nQvSdANY3ZBB2XNgoi+7ewY=;
        b=hVFv7XEw98NrbNshaja9Osj4W1Sr7vtDcJmy6W06uOPwuz1RQS8BygFJArhFsmvkI6
         Q2zbCoOuNw9wKzdaZ9SQ9jgs2Z7UisUuB4EaMk/E+nTqlMrdVDFCO0wQrVxshTfHi/Y8
         zC3Zkdkp3i28n0KzEkt0d5Cv5b/zWE1JV2VSYyoLBKBuHgNoy7cb8PGuC+e7IhcocRpI
         UgWw2wHpqT1aHeA34MR43OCG5Jt1p9e1DdX4ukfYtHMPK3UexlMhFiiu+kIC+5Cq3UdG
         JxFoda5KqLVHMaXnBm8eG7osbjXy1lB5msL+KqzJPXdpkNc2SQpengx82gIa2TQHm7tI
         kKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204695; x=1794809495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MVofIXRExu5WXM840EB3nQvSdANY3ZBB2XNgoi+7ewY=;
        b=0bXJcsWOwFoHwlUV1en22mqckNt/Aj/jUTFi0AQbpgfNCZhZ9PrXnlsF/TBp1oJ4f6
         Oajxlftcgsp0rnpV/FS6EeTWrzLsWf/2FfVWWupjGNOguVOsmeCCDl4CVH3/5qFXJfKZ
         1ISmll7HZ4U4LmPTRwbtCBvApJB6eIL9O9RNrSR62ntpavuS9Vv2dUJAUmzoeXrSVvJB
         /xKAatd5LtvSKg0/U0ridoHOBWZPlhZQAaDaEWjiZKwUcmmoShx4dga4gzIl870J6+qt
         qg5TmLKNjCqhEqOb3/1Y1ysAQwPPyeKf9YUTsq1G5jU2AEWZRRbbFsrBZrGtuxhcQrnO
         830Q==
X-Forwarded-Encrypted: i=1; AL+hErG3zdzSVF5Rjqz1j95XwLjsj8sv4vUQq+yTQCEo/1acgMlyd6HiwqA9gzdyMQnVN28GOKvcNNAvjBdy4g==@vger.kernel.org
X-Gm-Message-State: APuU4Z+dDTgzq2WfP/4RJveX7+NYOUb/UYx56S6K32XG8/Um6VCiffEn
	wcWeJWrMo4z6P6JADoGt7DiN7mKE4q7TxN2hkOlPZDQbxHvBsuWivdf5
X-Gm-Gg: AYBFou36U8uJlVBlltpiUiNIbppApgYdXQ00HONY67vk07QRbizEX7HPtJX1kGEKZrv
	aKaZGCPvFRuJ5Vi8hOnDIzVswq9Tum7b/h/wl5ABtfQOZWUA735YQluOGMCnqMLquGCs2OzzXXQ
	U2YX9ufbCspBsMDDVuiaYLfHlwL2kOzo22lomd0t7QoLWTP0WQhkfVLuylBkJRY3A7OcbX15Z2z
	daCDhA89alBJxWb16k4xlufRONcm/0ijvVUpmwtdolhWxx0c/tQzrtjZSGcWrHg5fTWhWoVzISS
	HxLyDpCmqbGneFq1znq7+o5CrSUxmfcfHtaMQhRmoPDjoYMmjck3Q/8sK3ljUFiCj8bTY3JdU9w
	fqEYiewWghEbBJwVfHQt5GS5xa8Li5XmnIjdOVn/5Tnqg0nuRuaw1foDftKpc1Xw72hhHvlGN1v
	BoYXB5cIp+iofvJroOrZjFmbJBdtBE6rvrTVTU0YXILJJex/bRVM05Yq55zXqs6WqoV6LbAQoL2
	7PGwfbojodJjEsOiI4jdL+ZVn2h68v09nnotEA1yimOH9njyDrnaCh4IZetcga4oRHu6oqQVy+t
	AGDD0KdjmlnISKq+b9UAaciKarvBZEnbVrb8/Vsh0bL7f4HDTuab35yGTFDpQsIfOAMh0/1jh8Y
	rPxrj/pOPr8RjbRcVHLzad/BCH1dD8l9Foc8J6w==
X-Received: by 2002:a05:701b:455a:10b0:184:ae11:51c8 with SMTP id a92af1059eb24-1b269b37232mr8648978c88.23.1794204694674;
        Sun, 08 Nov 2026 22:11:34 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:33 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 16/18] HID: logitech-hidpp: use alloc_ordered_workqueue() for FF queue
Date: Sun,  8 Nov 2026 22:11:00 -0800
Message-ID: <20261109061103.2887636-17-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

create_singlethread_workqueue() is a deprecated wrapper around
alloc_ordered_workqueue() that unconditionally enables WQ_MEM_RECLAIM,
allocating a rescuer thread. Force-feedback packet submission does not
run on a memory-reclaim path, so allocate the send queue with
alloc_ordered_workqueue() and zero flags to preserve strict in-order
execution without unnecessary rescuer overhead.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7f5de4caf118..d0ec973a4b49 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2870,7 +2870,7 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, struct input_dev *dev)
 	/* init the hardware command queue */
 	atomic_set(&data->workqueue_size, 0);
 
-	data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
+	data->wq = alloc_ordered_workqueue("hidpp-ff-sendqueue", 0);
 	if (!data->wq)
 		return -ENOMEM;
 
-- 
2.56.0.506.g506a7eabc5-goog

