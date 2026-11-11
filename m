Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=173.255.198.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379828;
	b=grBKkvYAoy1ybuYQx0ceGtbZdcRPCwkKI44LsU0O5/0DyxXmCxeZSs4RLALyhnK6J8zC
	 UMDOywr48FaGTXNIjLlwlYuCt+MTYi8XyDBHZa5GLS8ebOYRuf/09I7XJfALdHr74wLDF
	 PuKDTIWNdnrbGNicxEwmYqPKyz3nh8l97EC4OK0Q3sVeLJPERIrT1Ga4ersB2qqKCpSPq
	 7JL3MBwbOUFB/E036VNLBWe7KVWQxYzBvX/7udXgrqFB2IjqGGxYLTPzUE9nALqjCTHxk
	 2M43f2I8ufYa52kwZLjq0F1haX87txIOuvo+ax+1p3nf0Sbvh7dvaR56xEYPEmBvfxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379828;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=EV69DdrAxv76ROulpz65Zo16jPZmMpCOVreqwTdDsuE=;
	b=ODeNj/4BDQf3KF2vyP8L8PRrcaNquzGjiLWpdUdX1CsTYwCchYGrcC6ZreCpP2E0XpFr
	 ij+MXjCmEyfZRiLyCx6LMuZ0xeeKK1z70SwyGR5fUfQU03lo0mhaS9QPyFmxjgjXSdpa/
	 hdGM1qcrjobKQfnAQPvyfgPOeFbWCSSS3foV07v+yZ9LpCBTI6RVtNaW0fyxN/ahb6RnQ
	 vgJ4XZIsVKGd7RQtYw2FMuUdqA849XjwI2zK8LWz+yIFxMvkXGobNzWsVjExCx1utEbgC
	 pZ0VD/9XiWayxnDLS7pT4QmHrb4ggPcX3cNhgNtkV69vWC1ubToeDmNVOjMi6rncnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=endrift.com;
	spf=pass smtp.mailfrom=endrift.com;
	dkim=pass header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=pcj6KfS+;
	arc=none smtp.remote-ip=173.255.198.10
Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2E606A997
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 06:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AD2E606A997
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.a=rsa-sha256 header.s=2020 header.b=pcj6KfS+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1794379827; bh=j9gW0BiYekyoxPmwIDqXqhWTxQzGutVxqPTwCqz3lUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcj6KfS+cHGbmvVvdfGMZG8JVqIDbJOl1n1hxAAgAzGF9MRoloNhdvkQZcZdoau3K
	 e0NlC8YZ89BAGC08Hsr+HS1fvSoSyHBmKnYXRA/W/NsqXY7KL9Gwuoh9t8B752Esij
	 7ZaTkxs1EOp/0uL1hRz1V0Ifx1lfcHw5f1S5fpwMJS1KXZvhuJ3Y49Ydt+IwvFFQCN
	 2O0eyOQZlAwrf63NQeiok+Yi46y+mQPRsvU+Gy7W2nKoM9Ph7rm+P5Yuh9pH/5EmIL
	 JAg9p3mdyNCKor/9ETxK6ZQFLm0s8DfHyZO7kdYxN0h3rrlOPGwQmK/8VINiwdD0n+
	 Ohs0H3LeFDnfA==
Received: from microtis.vulpes.eutheria.net (unknown [97.126.138.172])
	by endrift.com (Postfix) with ESMTPSA id 9E801A10E;
	Tue, 10 Nov 2026 22:50:27 -0800 (PST)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 3/3] HID: nintendo-switch2-usb: Clean up urb in probe error path
Date: Tue, 10 Nov 2026 22:49:56 -0800
Message-ID: <20261111065001.3626071-3-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111065001.3626071-1-vi@endrift.com>
References: <20261111065001.3626071-1-vi@endrift.com>
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

In switch2_usb_probe the error path if the initial urb submission fails
forgets to unanchor the urb. This patch adds that in.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20261111032125.2888320-1-vi%40endrift.com?part=1
Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-nintendo-switch2-usb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nintendo-switch2-usb.c
index f53cbf0a3e15..8524cc68d5a2 100644
--- a/drivers/hid/hid-nintendo-switch2-usb.c
+++ b/drivers/hid/hid-nintendo-switch2-usb.c
@@ -427,6 +427,8 @@ static int switch2_usb_probe(struct usb_interface *intf, const struct usb_device
 	ns2_usb->bulk_in[0].state = NS2_URB_OUT;
 	usb_anchor_urb(ns2_usb->bulk_in[0].urb, &ns2_usb->bulk_in_anchor);
 	ret = usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
+	if (ret < 0)
+		usb_unanchor_urb(ns2_usb->bulk_in[0].urb);
 	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
 
 	if (ret < 0)
-- 
2.54.0

