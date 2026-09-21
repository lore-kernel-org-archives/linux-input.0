Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B04FDA6B
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790016581; cv=none; b=duyJxa7NFIzwB8+nrSCdNK16bbNskR+QZVudiexH0OGgPI8LJIK0912sX3vHN5QUKAnbT7+S9ncZQBCvrJ4MfnMkRKxBUaIBtBgtc4R6hZN91cVb20eQHkcl1prpUlmt/eziJfc0Fv+s0nskrnssCV/FC9v9IjYx2X1ZlLlXAeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790016581; c=relaxed/simple;
	bh=YHvvmOG7XYxGrePjd3RJHsMHV5sxexGE/IHowYzt+FI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=lPEhCTXNvf2GfKQ0no5kIMRNUetEk8IkCUZ9kMVd2u/9AfQBZgG7BVCreWFPrZHMdkOPyRKdpBi9EiPy9E97BkdalxQDlPY59nfarcpkhRPoLZXQ431A14XuRL6AaYWt4TNKWHzd8UwQ9V2wgblqjY1V6mulJTsdpz2PvZhvEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO7iHZxp; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO7iHZxp"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso2195355a12.2
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790016579; x=1790621379; darn=vger.kernel.org;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8uJZEiZCOi7zzVfQoheYkZxBxMAwj8RbqVTaMRlED7o=;
        b=GO7iHZxpYC1yIlPwrSvVC7aNcf2evyOIuLYXMyY6NNmYUNevp45mR/eZY+LfqwxOqA
         AaUDvlqBRRCYhKy6AynF5nuO/kuz5luTXP2Lvo1hMgSPj7HgLzoR2G+XMuKszaoPZHdm
         MVCXbqqlayXF6iPHZF9Kw8GnP/uLPnK8JQyZJhty7SarZidCd0cCb1Zv3W5JQReohbW6
         hm3+bQ85EbBrbVRaaryiAm2atpspDvoi1KXSDaCHq89CN/N4qXlSlqB8YPDpYl1xkEaM
         9sVoVVzCM2BVJSSiulJlf2EnqzeeCD/FWWweQM8WcKdun2XQ/S2RtVgqKOc0FpaqvarV
         MCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790016579; x=1790621379;
        h=message-id:date:content-transfer-encoding:content-type:mime-version
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8uJZEiZCOi7zzVfQoheYkZxBxMAwj8RbqVTaMRlED7o=;
        b=lc8st90E7GQVeodWaqu/7PJYHfragGDggBXVAMJQeUNlQeHYtv3U+uIq22oXAj2F9K
         v9T20qE7PBMB7ttwBOb5aPlyl+oDGNE61ysX6Wdvomzek935AWN/uarmJzlrzWmafEwe
         HOWfDKrR8MQam7rMlXmEYrc8hreU1T9bq9kEQc3oTrGChB58v0ZknMln1SymjUmlZXDW
         ZYiVa9yRQ4e4RgD3TzWIS+287L0twwmMfnHitSv9awwaGyVPFrkd5bkk490KLAELV6Jr
         iX67YDEDY0y87OBZx66OdOfgVw7zUnw59kW6L8ipW/e4lZfIx73YdMmJ0w2qS12nRqzy
         AHKA==
X-Forwarded-Encrypted: i=1; AKwUvBy9ZvCD/TV0QBLvaxuf1dVULwf4OY9aEViDZjgF4Nlgfwy87c2yKVZY65SwXYOkwcJpmROSkg8DRs2IuA==@vger.kernel.org
X-Gm-Message-State: AFuF++nwZkzCwi0/IQamsxcVsHTuZ8FVPRldR6CFScFeN2YOPSiiBDat
	D8uuhA5CI9zyhLr9hHu1mUpQvkghC1XiwYvoaN0c5rzSG0KbWv6flelYll+0tj/a
X-Gm-Gg: AYBFou0rgJJAfB8mraMWTbx1iiHZS739sY5XWIsopHXBWgh8pObnj95HM3BTgdEUbpo
	B3FS3rqekqV8aWGMkmhN/a9chi8Iy811E4KRtG3pUGuILkWcv2EUQiRSMLTJZgx1ZBbNyJu4Rp1
	JqZLbw3BlC1gKQhj/gmiIKYanSAw4is457fWDhB0QftgK9gzy8CHpBJp9FoZqFz6YwNqoRnTf3U
	7UvWMOEx/DcYcBibIu9Xxd0/dqiKUHcPmS1BgzBuHthi9nyAYd5q17iwYNqayIppOdZBqFu3QRV
	wx29UzNRByuWXFJGdUHmZYsQ5l2yyb0F+S6nuS9lLEn3Ni0VK4EfKJamDa9eICzrX8fxDMInYVt
	vWmJuG0844QMStCjY3Wv1kpFVX/hxzgvuwCjYsMRgw1TXISScbvdQW+s06lWFFjJH6XDOcX33ma
	J3zQ4ot7jq1gy6bChpSZMAsNOZc21pJq7RtM/QMcNe98BBJ9jIseYVihmHJscPjwJuj1rNtjZot
	tQvYa+z+dl0nnN5Ehjhwj4=
X-Received: by 2002:a17:90b:1dce:b0:39e:6a80:dda3 with SMTP id 98e67ed59e1d1-39e6a810c76mr11349225a91.42.1790016578958;
        Mon, 21 Sep 2026 11:49:38 -0700 (PDT)
Received: from SANGHOON. ([1.220.132.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e52d5adc1sm8579800a91.0.2026.09.21.11.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:49:35 -0700 (PDT)
From: Sang-Hoon Choi <csh0052@gmail.com>
To: "Daniel J. Ogorchock" <djogorchock@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
    Benjamin Tissoires <bentiss@kernel.org>,
    linux-input@vger.kernel.org,
    Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] HID: nintendo: release the player ID when LED setup fails
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Sep 2026 03:49:28 +0900
Message-ID: <179001656825.91284.1468613120745540918.idr-bug-07@gmail.com>

joycon_leds_create() allocates a player ID before allocating the LED
names and registering the LEDs. If one of those later steps fails,
nintendo_hid_probe() jumps to err_io_stop and skips the ID cleanup.
The failed probe leaves the allocated ID in nintendo_player_id_allocator.

Use err_ida for this failure, as the power supply and input setup error
paths already do. If the ID allocation itself failed, player_id is
U32_MAX and ida_free() leaves the allocator untouched.

Fixes: 5307de63d71d ("HID: nintendo: use ida for LED player id")
Reported-by: Changyul Lee <lcy8047@gmail.com>
Assisted-by: LLM
Signed-off-by: Sang-Hoon Choi <csh0052@gmail.com>
---
Found during source review at mainline
5dd1818b15d98d4a20806cd00b1b40320b06004f. The affected source is unchanged
at f0100363d8c374bd8e9ea7c9ba02744f0b802ca4.

The modified hid-nintendo.o compiled with x86 allmodconfig and W=1.
I have not tested this on a controller or injected LED setup failures.

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 43e0f2aae..bec0e7652 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2784,7 +2784,7 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	ret = joycon_leds_create(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to create leds; ret=%d\n", ret);
-		goto err_io_stop;
+		goto err_ida;
 	}
 
 	/* Initialize the battery power supply */
