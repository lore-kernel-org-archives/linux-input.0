Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48574C9001
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361039; cv=none; b=tRF6u5SVC8C54Ly/4rkRvNB447HUrtz0MPy36D3sl5dpcLFN/eIPljlsC2CivBB2RD1cWWtM8jSa3aKLpbYP+2aDhGpixUovkU8fUhplQLYJCA3N21l16gI7yrJ9hGRlg1p5Iz4hP5J9zn3Lj/9VTeZLa6nTHpCNz02K6a/colI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361039; c=relaxed/simple;
	bh=8bHmYASogem4UkImv9USP3WHnLyATHC1Hy5IMe6WNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/GnPpYc/gm7zo7+V+30ATAIdv1jRFh8PHH8joOITmXtIkRiKC6WRRV91mJ/hKItOWc/BXuxDGGePpKhqXq9e8ipgIQdZnaOs3Y9MoJrD8/kuyPNbFimLZI0IKKbnHStTDsJ2aRRmZ3NAMGscezyLxZlGdRmiFJXIup8Y3wSQR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUgK/eC7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUgK/eC7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1e1dade31so4247125e9.3
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361036; x=1792965836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbJN8CvA2HEjblO9LmvSpdf6N0XOweTOQoH+n7JOTxI=;
        b=WUgK/eC7u70BKGzluYiFXMKcsiXpqaC0dKDn+8RE+3SzQ+IA87C5pAKltt5rZwisEa
         7Ldzza1tPYVjqVsR9ItmF/neqwOJ2xf2Ilu9MbjTDhycZo8lzSZKLxEDT0ztMA1/T9Ok
         7olgxht60OFn27URmGEN4ayCGa9RRJusN+9uMbP6m6Il6lZcDg1q+Oj+5KdDQtqCLGg3
         /5HbzsibrCwLplkWSGiBiOAbOBDElqsdcrndPyPzlXL006eM2X63JlhNXQ2VGR9SuHDy
         Ow5Fogp0tSZQjCYCR7++KBAW+pEjjCyJfnDxiZygU8zyiE3NOtEcneQUnvMAZYGVdMww
         HKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361036; x=1792965836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbJN8CvA2HEjblO9LmvSpdf6N0XOweTOQoH+n7JOTxI=;
        b=IWLHHDgHx7cQusF8qrrUT7in141l2ZtAAWhgn1vZCv+d1eGu5t18R3YQXRXOkpMkVJ
         Q/RnuqKuJ5vG4wKL6GZ5Wbgd89z6EgjweS5gtE9ZPsWVg9qVNhWdl0x0H+U8D6reBeW/
         MoXbL9vinHyGOxsCDSwOAKCmscAUKdIs8eZgyB2DriYV6GOyDFmGp9WSCvirMQqQb7S2
         KgqRefDJ0i9SeHh/pkM7acaJQZdEyMSmJu7etU7RzIf6xkXuV7IqhO62s8pux1wowL4G
         YSUr1zQ/QPi3+Gdtn/RZu4DAl/BsBrNrcFiFuCGRVX01j+5uUk5cgWKlZ2batL6dwAP5
         j04Q==
X-Gm-Message-State: AFq9FYKlkotyk24h2467683SiPzsJ06Nei54uhZkjdPdt57P4jyaoKaD
	06qlSo7y21cJctPT7v94s5Gkzb+DBGaDDpIyVzvyXH2yVvZcsyXizDg=
X-Gm-Gg: AYBFou3Krp/5PNUTnNrG2reA30yviKf1BhOLDL4BPO3STz2pX6rb+AB3m5AFtWnMWNU
	DCDyju7dnwyGue+gVERUI76UwVo0+dAoZ86D8s5cyGrmPUv39cqONA2ATOng9cxzl8Szo5gHWz2
	aw2ATWESQgR2dERUfAzxWdfEVVJwINdbZWs4b6w7KVECJtAnfur6xXzHLeWpC+Ofg6BopMlJh48
	AxnvGi49oyGbUVpQ1g8iYrJmPnFVTYbs3C+D2LL7AKQ5Jlk0+w3dN1M89luHjpXnnb2qwppKB1M
	azcz96rCLQT0f3U4z5nMC3zaXW6cjcQVsZKzk0bDMmcMHlmk33BEi+yEeoAE3cs+ZGRm76SGA+z
	3RYNj0kHFPcCRwIxh1rMW/kRUSeJmcA8w8zAPJWAoNnlMHfsX3ew8lz2Tg5GuM2Rh+Xnle80SIo
	GsbTg3in0nuOMjWUVBqvNCDUym657CV+zkibtm552j
X-Received: by 2002:a05:600c:628e:b0:4a1:df70:b4a5 with SMTP id 5b1f17b1804b1-4a1df70b5c0mr94000825e9.7.1792361035900;
        Sun, 18 Oct 2026 15:03:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:55 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 8/8] HID: prodikeys: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:44 +0000
Message-ID: <20261018220344.1987142-9-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018220344.1987142-1-tristmd@gmail.com>
References: <20261018220344.1987142-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

pcmidi_handle_report1() and pcmidi_handle_report4() read a 24-bit
bitmask from data[1..3] without verifying the report buffer is large
enough. Since hid-core invokes raw_event before validating the report
length in hid_report_raw_event(), the driver must check the buffer size
itself.

Add minimum size checks before calling pcmidi_handle_report1() and
pcmidi_handle_report4(). pcmidi_handle_report3() already handles
variable-length reports via its own size parameter and needs no
additional guard.

Fixes: 3a370ca1dcf8c ("HID: Prodikeys PC-MIDI HID Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-prodikeys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index fba01e4fcab1c..925ca70f9cd4a 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -491,12 +491,16 @@ static int pcmidi_handle_report(
 
 	switch (report_id) {
 	case 0x01: /* midi keys (qwerty)*/
+		if (size < 4)
+			break;
 		ret = pcmidi_handle_report1(pm, data);
 		break;
 	case 0x03: /* midi keyboard (musical)*/
 		ret = pcmidi_handle_report3(pm, data, size);
 		break;
 	case 0x04: /* multimedia/midi keys (qwerty)*/
+		if (size < 4)
+			break;
 		ret = pcmidi_handle_report4(pm, data);
 		break;
 	}
-- 
2.47.3

