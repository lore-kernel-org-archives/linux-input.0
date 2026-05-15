Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071B36EA86
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857080; cv=none; b=NuSlQLJq5PVKjiMtx5FaKuDlnQcdggyszWyL8qPs1ldrXMi7kZMRNjVLUw2X6l3e0CjowtfkYGALDtxWem6Kr5dK+x0lRYbHt6Rw4xuCz5tk0Bl7nDHGO+dh+GgFwGGHiYkQJk/ZjUfC3/DRY+2ezIew8zyCEzCvQdmATi2fptg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857080; c=relaxed/simple;
	bh=q1rlFt7jJnHIsxhi6tG1D4vQom1TCpRJxsOOyqH9ziQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wdbf+nIqCjXaxZ5TEW3T47uXXJEAsLAuLdb9MpL0n+QOYZPq3wtne5ax3hnWE2jSsDsFKg3qG3mV6TC3bh8bP1VFkq9GAym4jZRXJUWfobo7SBXH2nBfzhsUhgZryWVgSfruI6R3EoeR6ssT8eEW1GIkGlkSPRKgC0siGrU8DXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcs5oi8K; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcs5oi8K"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891b0786beso60737475e9.1
        for <linux-input@vger.kernel.org>; Fri, 15 May 2026 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778857076; x=1779461876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgTukckjUaag6yoExp0Fh4OX9Oq6SoZIofNpA/0vdMQ=;
        b=jcs5oi8KhrmQ3T2aZEXpqwF73RRZ9Hc7UdiuWYl1+SFAHR+flC7VxRNbpCzzymAH0g
         1m6ZMQJQSCtM4v+Dve0BXsyO9rQ8U/pG77G4CB+yAuEmEvkq7WZTHFhnwEjD3FHyuslJ
         imwXUlyVUc5VjBZ9rHhgeWG4KtDeJV4TqJjfUgU5lfrloiDwPjuCbeEb7RIPeRiGCKkT
         KVgIsAzzqHhbNuM3AZRfzfS2IDt/mdBGbKKDrI0AwMA6acQgQ+hfiKMq3ILX4hlUx9gv
         lIyO2ME2QDeb8x6HqL+9fXIwgtN5WjhZqx3oaHVXKfMCYPnpsOxjSwVOMBVy21+Ewmnk
         N5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778857076; x=1779461876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgTukckjUaag6yoExp0Fh4OX9Oq6SoZIofNpA/0vdMQ=;
        b=TMlieioHb1LeSFXwK0bVmFzLz7Vep5Q7JBOtBuAYawkfU+krqy8xljHpLQSbpaw67b
         ZNxrP9yLTQetRz01Hd8vaaiIe+qlzByC0d9/3cceV7ul7+C8t0N7qJKwEA9J3NNXQEFx
         t0IIpWoIy72FJKRJJolMJS2/OxlSeIrPMjz2oXliJoufWZlpFSz2ktuf8/ut/DADdmKN
         s/EwHVSGqS2PEITgh9FkcxlFlmIcvD0e6peybk9YVzme9KHgNV8aXG47fa0Ft6WN6M+D
         LIgjbG5gh6j+8jvPoqF/UkNfcvYmdQvATJf+B47/94bx3hsgdfgS1mIYWotml7kcJdCF
         q03g==
X-Gm-Message-State: AOJu0YxHHBjrxHtDQdJiBUyU/NbEpYZOvckfBIuDfUIboRm++bqa2501
	3wVP5PlQQV9/SO+ydN8ViE2U7gUxq9GZe8c/Y3aIxrHKJWK2IR1orgEDiK/EbDRBMo4=
X-Gm-Gg: Acq92OEdEfHf1tmOXnUV0d+PG2dcQmT4BQ00Zzrt8cBActw/Hh7oGOQRKBNF+K8Ln0p
	Yf0qe3H5yC1NAp26NVd85dqngp2MOnq1tzLidm/e+bjOdeE0Akjt7gMwaOiwna5w3fNR9PLi20S
	9IWtxe+uGDs86TgDI83yX2elXgzVCbSOCm9NRmV9klN6OPAOwUcya738i5rvtyxo/ZP7wEPmJeW
	3ZEYNPlTx0ZtEV71o5eK0ihcMhCs8iDjvmtx2SWPHMWo3KHFfKCIE6IM+n7Re38tmJgTIff/1Mm
	7CQRyKmjPXD7o55fKZl4a5FAqG31c97+V5RG0n5MmUv5GzGgXLta+ktjN5v0mm3eNtSUHPF8z+f
	R54U8aM9ETinExCSJBIC0ONmQ+GtnvMWtFi9pMo/S10jjJMMzRAdayRi+dQLV7c8CZPYWoUmzZd
	NdWU1U6Fy9LkWEComQR0EnByYjNgM+QivJ9VhWEPMBTdSFmOlMw5kDEwLFoTHun2jXy0thvFwiN
	DwUIDfYrCEMTR28MhurgpdLFZk5VKzZUNJ+Tym30BPFI2zJYzcXOeAcJVY21Lckn6CpNg==
X-Received: by 2002:a05:600c:198d:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48fe60e552cmr68673165e9.9.1778857076250;
        Fri, 15 May 2026 07:57:56 -0700 (PDT)
Received: from my-vps.. (ip212-227-39-93.pbiaas.com. [212.227.39.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5ab527asm76096135e9.11.2026.05.15.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:57:55 -0700 (PDT)
From: Louis Clinckx <clinckx.louis@gmail.com>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] HID: lenovo-go: drop dead NULL check on to_usb_interface()
Date: Fri, 15 May 2026 14:57:40 +0000
Message-Id: <66162775a1a939891fde1a96660825df6f3188ca.1778701376.git.clinckx.louis@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1778701376.git.clinckx.louis@gmail.com>
References: <cover.1778701376.git.clinckx.louis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to_usb_interface() is a container_of_const() macro: it performs
pointer arithmetic and never returns NULL. The if (!intf) and if
(intf) tests in get_endpoint_address() can never fire. Remove them
in both drivers.

No functional change.

Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Louis Clinckx <clinckx.louis@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 8 +++-----
 drivers/hid/hid-lenovo-go.c   | 3 ---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index abf477e68..f44aeb2c1 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -382,11 +382,9 @@ static int get_endpoint_address(struct hid_device *hdev)
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	struct usb_host_endpoint *ep;
 
-	if (intf) {
-		ep = intf->cur_altsetting->endpoint;
-		if (ep)
-			return ep->desc.bEndpointAddress;
-	}
+	ep = intf->cur_altsetting->endpoint;
+	if (ep)
+		return ep->desc.bEndpointAddress;
 
 	return -ENODEV;
 }
diff --git a/drivers/hid/hid-lenovo-go.c b/drivers/hid/hid-lenovo-go.c
index 3fa1fe83f..e0c9d5ec9 100644
--- a/drivers/hid/hid-lenovo-go.c
+++ b/drivers/hid/hid-lenovo-go.c
@@ -641,9 +641,6 @@ static int get_endpoint_address(struct hid_device *hdev)
 	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 	struct usb_host_endpoint *ep;
 
-	if (!intf)
-		return -ENODEV;
-
 	ep = intf->cur_altsetting->endpoint;
 	if (!ep)
 		return -ENODEV;
-- 
2.39.5

