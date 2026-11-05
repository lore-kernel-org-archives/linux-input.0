Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900594;
	b=tXoN4QDPd6V80gqE3B6g9KU4XjlbVkkKughKQbg9c8PJf7CgTilwyui3wUcEn7c8cdxj
	 Tdf4OL2pxugVHuUeRElImhLwzH/+zp2zuSU8SZibJIIDANFqayjtirCKo6WmJZM5nmL1f
	 9xv6JdbSgr0pOOEQsG/sQPRWvef9hJLpcSwQM0hKjOswIdZQvDgg+mDVsuPL4aIwYYPS+
	 kIYtNvLte7SxE16MTbQMDveUa8Z0Kv1LExCmRsvF3xYFz/hqhP0nSbzWwuQboj/0BWRAH
	 qEKyhmCvBA2IJJI217bXm+rztT9HNpQGli8SKCYKvTcGYo/89CyFrtg8R4eK/X6TzdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FXWweisIimkht5Pq5NCBqOipAtAwASQ/Tc1CwWiphJw=;
	b=SzrjIdr163gQYDlxV9ddGuMoqsVjNRx4KOL/q8VOQm5InfYE4nhVpr7lqGbShZr7shKH
	 tvhR2vZNhSV9QXW7IIjEBaGgDXvDhReSJoncl/1qcJNdbazysj61AH3v9EQcVY9lgCYcf
	 PrCKSbtyARV3GQpok8MknSeIwJ8FSmcpJm+F+kLr2Rxmc1kapWBsNczaH8szvlNb2+t3M
	 pYR4B4uxTr57tIfQJtGDCHJumA/a395lwW6LcwSmK1SKOv4ncqvZ0nJpyR2XHq6IYfUYi
	 +aUDwzoyEaZ+VKVlMCiL41FdBtJVUD8YEII/d5cot5sKloPJx0kcOqroBOuBHRs1hCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i0NF8kYm;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7323E606D804
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 17:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7323E606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i0NF8kYm
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4923176309dso306708f8f.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 09:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793900593; x=1794505393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXWweisIimkht5Pq5NCBqOipAtAwASQ/Tc1CwWiphJw=;
        b=i0NF8kYmW+NC59nd7JBd2hvyXiK7YUHTymxBhFwVITBVi82siH751HKJQ63B9EMo2a
         Vlufiopi83PN9Y88qA4VYJvwH8xVq+hI+f+gFytpAN+TCVzud5oV/P52bFAOsLf6GEQi
         AcAzAG8DuaoB58/3eFs599caSDacHSgqsi2CVkkb1uqqHcX1TSNPrA0PYMGooaP1clwk
         yUh6ziJpVsus3nTtnfpRYbLISSvS+pmu1YKqR8wniQNRu8wjaLjDiqDGWHuM1BDrqZgH
         rOUeobOLLnOynx4fhLH1kmY1lTg2eWCjK9Awn/izbEaIuzvyFpNA+u36HDZzI+VP2hiP
         gcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793900593; x=1794505393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXWweisIimkht5Pq5NCBqOipAtAwASQ/Tc1CwWiphJw=;
        b=UZGDJomn6MvKIU7t3dOG8jJ6HwB6PcfAef68MtoYFkL7mL/4sRtQ5DWTVjtkSrpVnD
         RbwK0edYcZ4pfIcK3CjOJiDsEDIGtQKth6PsRfv+TLT5qUUSCEqbZMsaqtebmvJh0UNO
         /L2OBIDnQLODuUvM8ot2jzXX01X8gYZEr0Eqw7Xm3Ao2oaU3y+cGynGH2HLgiGPEmiy6
         u/UKalun/u4O+6tbP3OyFQ7c9EJu8QQ2jDQzwcMnNQQTGTOHmAzqWHeGkSrQ5dpROUsX
         BrKA8UQVDHxCF96GsGbnqeeCslXGdXIJoSW65j7TVv5Xi4UqpsnjTjAsCMSmH0OlQMs+
         bN6w==
X-Forwarded-Encrypted: i=1; AKwUvBx1TS4Hd5d73kzUlhFTOWz0bvuNUe8R0s0sF7UgO8QeeBDPZznNYcCkJExmtbhP7Dpbj0VxVUjCKv3Oqw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ATi51A0XKq4ht5G/CT57EGIy5rWZcJn1+5wHDXF+8/mgMn3Cu
	Swr97854JT0Cc6vIWDRzlfL57FYyVL8q1aMNJLKbUpdItfaTvPRgxqGwySh0zggM
X-Gm-Gg: AYBFou10j5AUzr0bHR+SMyzb/K2l4/l1hzsHdJYsXMy57lkvvR8+N5nHjOFc3l/rL6g
	dhGcnBG4rDQX8DEHzMeEI5Ni6VKLtNi4xOEDUS8Btg+gZRvPDFZLZ2/pOA7VA6FIVtsDMLAnIYt
	NDgykf8bJxJwihTAB4TC9EikXGOHDbTFBtOOtv85dV7hfKv7sSNT3Ragz8tc6AwRA4vSyRlJOkn
	SlGUSREHO6pAAP7MKSvEMv72F1rYOMaIhEb+HDtkfXSY0hBpWjHFWUVYrBVWBnqRA2lvjV0Eig8
	EOzgWYpBrONzFMpOfJsLfZPMsun1J8H3zaFpzieKbPJJK2YDNzQeTAZqlwT9Z6I3+FX9KvXX3je
	rXJOqctVLaTFBq+lyfdcpN06FnzD/jXqmZuIYapC9xsxblBYb8RdA6FATkUcosW8mK3E4mDAsCn
	sjg7kJjMbex8KbLas8zL5q1iJfztK1TXcOKGymoZNZA0Xnn3x3Ml5l91k9KLP65VzXArUQjfVtS
	cOZmfVDsGWPySpJzaTSHLbGsIYwp906pqo6uT3aTSiSREc1uznlFm6Fl159fQruxJedQy1UfOei
	ho28/jRafSx26mOuGlM16z9FMyURspLJYqwse8iFLyZc1w==
X-Received: by 2002:a05:6000:22ca:b0:48d:f3a5:4563 with SMTP id ffacd0b85a97d-49274bc839emr695784f8f.20.1793900592571;
        Thu, 05 Nov 2026 09:43:12 -0800 (PST)
Received: from cachyos-x8664.hgw.local ([2a00:1d34:861b:8500:1b0d:8ca0:906:12b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed553441sm10182903f8f.43.2026.11.05.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:43:12 -0800 (PST)
From: Muhammed Sariyildiz <asiyee994@gmail.com>
To: jikos@kernel.org
Cc: bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: multitouch: Preserve class quirks when inverting orientation
Date: Thu,  5 Nov 2026 20:42:52 +0300
Message-ID: <20261105174252.36714-1-asiyee994@gmail.com>
X-Mailer: git-send-email 2.56.0
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

When exactly one coordinate axis is inverted, mt_probe() replaces the
device class quirks with MT_QUIRK_ORIENTATION_INVERT. This drops all
quirks selected for the device class. Applications created later
inherit the truncated quirk mask, which can break device-specific
contact handling.

Add the orientation quirk instead of replacing the existing mask.

Signed-off-by: Muhammed Sariyildiz <asiyee994@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 4e19a0c..94e83fc 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2155,7 +2155,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (hdev->quirks & (HID_QUIRK_X_INVERT | HID_QUIRK_Y_INVERT) &&
 	    !((hdev->quirks & HID_QUIRK_X_INVERT)
 	      && (hdev->quirks & HID_QUIRK_Y_INVERT)))
-		td->mtclass.quirks = MT_QUIRK_ORIENTATION_INVERT;
+		td->mtclass.quirks |= MT_QUIRK_ORIENTATION_INVERT;
 
 	/* This allows the driver to correctly support devices
 	 * that emit events over several HID messages.
-- 
2.47.3

