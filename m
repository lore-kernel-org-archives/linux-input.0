Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BEE3BBFA1
	for <linux-input@vger.kernel.org>; Wed,  5 Aug 2026 05:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785906540; cv=none; b=krXAccdSq7RS99NGGu/wpuYvV+wGMAO1/kjWnf2Ug5Q1SWu73GKs+k5eRRGnto0B04gIMBc/KfWbOzyX9Ky0IVCDsfOEtfBAtwyixEVglBz/pQPStRGLjyPzwwoS6hFmcvbTtkZCEDmqMooQebiy/ZfYH8eQeKr1GP4mmVuRGII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785906540; c=relaxed/simple;
	bh=XjGnkKbz8Rb9EuBzDyxeRzqNwncAPrVTYrZRPB8Vz2E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lfpZlHV/27Il+7bHN4kXzgk9yqh/l4ibO4V+S4BFVAoTD1hE11mWff45eYjcBMerGtTniAmP+cLPtEqbISRYGKStN2+cTybe+hfMOpqNL1Vtp2xbcEAMtu84+3R2e23dd7zDPjM/tSpE8oO9bz/VMsbxs5gmekuB0kH80lnrZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qg0MoPax; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg0MoPax"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca957432c7fso518716a12.1
        for <linux-input@vger.kernel.org>; Tue, 04 Aug 2026 22:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785906538; x=1786511338; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kT2AjLary7mMQwGAhHHhXdSYn8k6stuUNJfnGqWcbZY=;
        b=qg0MoPaxTMA0y6zfXNM6ThqxtU2+5vGP8qp0dL15p4YwQZRbQLGQNTMN9hUAQtgZmQ
         +OWI0IBO7MDmn4wipOlJgk9p+euv/OaIB5YBypbnVDU+9MewjIAdAbln8EbriCcPReE/
         IYXfuem040qJjKy6OdE91j7i4F7tnXArZO+wpJyW28toDW/5bgnIlrYaOnLhyo5bZy/J
         Bq6J/dF20o82YYbVBST+L+TQ7ORX9cGLxqMtXdg93Y0oZTZ8cBJF7B+kmLPkZKq2FgAr
         wRQvXb6WYnq4X9dC6aROrLbZbYT+F8QuUX9lrSztHCbK4xqBPC6RxQvAq2L3d9xob9Be
         xdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785906538; x=1786511338;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kT2AjLary7mMQwGAhHHhXdSYn8k6stuUNJfnGqWcbZY=;
        b=CeEwvpCdw3wHWEpPitxAbZfjVXwWa9J61/QU6+qcU8xtxD3EaaurHVdyjyBzeGn2Yl
         /CZrsO5I0+ITVyBRD5cvqEe5rKgdvKlVisoe3qoFEXcRy8F6OrOhq0n+vz8TpHlLUkJ/
         UAWjKm6rHekth/eV1Y+d3R6DVP3Xh4ky6cvkqvvV8Uvd3treUDkqyEdGAsgSjUYbCyZG
         FkUrtBJIZKJxGXlijhlHq1/6bCvY3vFx4Nhl3SvljXor6wJVi/jYY+pIqthwXsWcdlfw
         GAWVYD0yDMQ0JelWiR4TrosXgfouSBM6AlaW7VoCq4KthooPYmRB21anYhHxSwV76agH
         K2jQ==
X-Gm-Message-State: AOJu0YyD5PWJAOgJek4pHzKzKRcxMZcvDYxqwsztx+OFQZ79pm6su1GO
	AldP1BuJg5hIZxcFHEEm+9OsX3RaM4wGNzDBSRCGkO3VzfLCNY2I+PJvXhOHjw==
X-Gm-Gg: AR+sD11sePFKQ3Nr5Tf1T+xwmB4nBFJrrELW04yMcg1XB2qmloXbh6sUrT2QwOLVy6R
	q8misrMUZjk2Ju/lcx28JYBYAuq0sG9DhlZ73qdYzcvN2KwScDrDjJ41ESR83VZlPkG9femst5j
	GowF8phnW2VEu3aOvC8RInL3Rxl64kzYUA1UPGjpIYqWhYt/JpIt8KuEZhqPzEfc4eBnu3DM3/i
	1LyhwcqiC4NGZH5FbxSVP9QdPKMsUaasyQhZdG5RkhcT52HmTQzEgWvBXhNjKdmrnaWnjZM/zde
	VZ2NgPLCzIEVo4OvQmddQdJoKjWG5gN6mYiHInEUpyKCDHuBezDMmCoTmsE/SNvHJ44yUqJWDQ/
	qcyHaLqg+JcZjh2LQVYfkg6BMJLqwdKCq9T/kBfNXfhGjua4CPsPuQigianjpQWtzkrxVN4vxo9
	EQQzT+6busjDoRRTfJ3Y25sNU6W281vK87ffOv9t+lCT+0oncMp5/nWHmP5LZqIbkTOYAbIVomZ
	NSOZLxX4Z5P6yjXmxw8vkbE80rohQDcD5gRxqFy
X-Received: by 2002:a05:6a20:d48f:b0:3bf:d487:4b42 with SMTP id adf61e73a8af0-3cb86027257mr4815520637.35.1785906537980;
        Tue, 04 Aug 2026 22:08:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b0c54sm12695769eec.5.2026.08.04.22.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 22:08:57 -0700 (PDT)
Date: Tue, 4 Aug 2026 22:08:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <bentiss@kernel.org>, 
	Andrew Duggan <aduggan@synaptics.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: rmi_smbus - fix out-of-bounds read in
 rmi_smb_write_block()
Message-ID: <anLFSMKSoKyyZ272@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When chunking writes into SMBus blocks in rmi_smb_write_block(), the
loop calculates block_len using the original total length (len) instead
of the remaining length (cur_len).

If len is greater than 32 bytes (SMB_MAX_COUNT), block_len remains 32
for every iteration, even on the final partial chunk where fewer than 32
bytes remain. This causes smb_block_write() to read 32 bytes from the
advanced data buffer pointer, reading past the end of the input buffer.

Fix this by calculating block_len using cur_len and advancing the buffer
and address pointers by block_len.

Fixes: 82264d0cf7aef ("Input: synaptics-rmi4 - add SMBus support")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 6de68c602558..d799405fbd33 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -140,7 +140,7 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 	u8 commandcode;
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
-	int cur_len = (int)len;
+	size_t cur_len = len;
 
 	mutex_lock(&rmi_smb->page_mutex);
 
@@ -148,7 +148,7 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 		/*
 		 * break into 32 bytes chunks to write get command code
 		 */
-		int block_len = min_t(int, len, SMB_MAX_COUNT);
+		int block_len = min_t(size_t, cur_len, SMB_MAX_COUNT);
 
 		retval = rmi_smb_get_command_code(xport, rmiaddr, block_len,
 						  false, &commandcode);
@@ -161,9 +161,9 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 			goto exit;
 
 		/* prepare to write next block of bytes */
-		cur_len -= SMB_MAX_COUNT;
-		databuff += SMB_MAX_COUNT;
-		rmiaddr += SMB_MAX_COUNT;
+		cur_len -= block_len;
+		databuff += block_len;
+		rmiaddr += block_len;
 	}
 exit:
 	mutex_unlock(&rmi_smb->page_mutex);
-- 
2.55.0.571.g244d577d93-goog


-- 
Dmitry
