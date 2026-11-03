Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714523;
	b=wWomRRyJulfhBfeD0xm5CnkJL1eykGcDVwekr+Nrfj5zP5qFQR6L8s/p+Y1o5l0A4F0F
	 tnQAc+t8xsswNWHJ9bqH80sUNRsyMVpBEaezvOzQL8YiiTDtF9IVqeqe4Wts5fnJlaaxg
	 3w9MiuNGOcm6AuZzUbzi4PtinMEOBD4fVE5hxEwriKMJ805nrqE1sjc1xa8a8P75SrbP+
	 sIaL91MCqN69fEPhMr7UM9DGVCESUugocMr4msBz+9MKngPUrXaIld8Ve2YxF0CSH4fdt
	 jLqmrkm+4g1/4+f+5GzBcg36gIj4UpHgb3p+j+wQZCh4TJe9rBMec9axqNx1EQkcrzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
	b=QCkQTYLUUJYdwCKnzrA26mP0B+Hd5nZkj51fLxqQF0RMzebodGvEPbWcb8/GyTCGOUA6
	 RBfp4p8H3/laOeN7n8Fzl7gPVQ79o/AbtZYH6le7vlLenHers4jY430qYpEXhL9/DiWYZ
	 hlQZV/CZZk+pEcHAexbb7JJIlcOIeYl4ubZe56wmRrZph1DvcF7Mr4YccFbxdahugug+o
	 xbEmCrkUBtvhErg154GdX28F9KIerEy9s3oc1CWS2dBCUTiOe92wGd72wsEpYgzYqTSdi
	 oZOKjIw/256M6K7bVD3Z1KyUuqOZW8/TGp/RJiOqOyS1G0tmPtRD0OUvZLJ/zijfRUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EAihM5PS;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F51606D826
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 14:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85F51606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EAihM5PS
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36bd3dd31a6so69157eec.2
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 06:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714523; x=1794319323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=EAihM5PSl+n+KoiV3sOtuy9ZGYiMqMrNlO+oXWxSs42M+ri2MqFh+WAt/Ldf5xsoYC
         11/XBB/e1vLFGIr2aecvU0FQFvQCq3zPITYhqRS7vNYNBbrxxr82Q5gumqMO/cf4DFGl
         o3Tll68iPcgqLHUUTQ/eGpEGWzTlq3a9DUCShVTs0vDMku7FIq5QfzsfAZMsEFFRRMcd
         z6BQuTerzg9pl8n2NeziFlD5zVY7CKg8mbBG/LTuCib54N2Fmgz8PfSzNR8agOEqPtnW
         CNsauLZGKEHttecdIG+QGW+O6oCSPDkPLhzTk2ezBqgqfG8YzzyAR2rZttIT4KQ7wNDs
         q1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714523; x=1794319323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=zp466J1KmYAJuTNxC5fJHOKzBV98aMZYF6bv/iIwh/dZEwEBNonE8tjaqfqGYFv+F8
         TixBlUX9iq1ZQJvi15iCeqdy9SXQ5i/NQzbndOcIRKACGZkKkGRxV/b/b48z8B1xBSsc
         hDdTcKn7BcaqD+sgI1GLIlnjrHxeWK3EGxaLPDzlENRNcho8Yt4owX0G/DQ/D15PXOry
         0qRzuDP34IDKhWnhlUlEmffkJWhfcVVSHUat6cZTesUrt7lT6wqlKrPRHjbHA8YxndcN
         wlAV0xIRlTFyXjRPwcuxAjWiPOHPp4fIm/YDviFIBLfgHhT+XXlunbflez/wOtqQO1qt
         1Ojw==
X-Gm-Message-State: APuU4Z8LCivOhjmZ1Mge46O/2ionpBcfu/IhTQm6QvDW42BgTPeWOEeP
	TkgGOjb5h/jh+q2S+KMk3GoHfIdvKJARkUvNH4kMWO4EFjyAKAFtUYnyutAMMTFz3XA=
X-Gm-Gg: AYBFou2iLQaWG6MR/dQSha5oIS1ptj5aEuBfyLZRbsQLb2S12tPTGg+n8OX+3W8kSy8
	sBO/rkdTNpd/wIYMifeWeuAr9XzP21x8bYYpyja4N67IWA3bXItrEL9irGrZXwLhGtvcHh5PB8j
	AgqFItPX3S30XoqVIXwcHzpdACzjTE4k4xfDnd2w9nE2au2t+WcRLQIJHJkLxQhlZSe8Ttt+ikn
	eBk40t6XuACgiDl7TYwpFzDFOfvOKXjnkns47vOYtpgH8An4PSf5M7Sj0nPOGS7rOesFsboZA/M
	/G+/llfzCwCK3p933egF3KQFvK96Kx/odB1D0fv0VV8kuCB4/Sy4GUoUnazr3WRnHkRAwpk5BJV
	yuhXYGMBQV4mkljzq8dlrBT+4Wd32c4eYVuTech5j++sZ1e43NxDhOG++QfB9GfYQN1qWa2aTTH
	ejgM1dfUUonlI/x7itCB6w3N9lkWLgV9cVjZU8l9t9YgSWW8W8RFW1/Zsgu4b82atFBl/y2Fr1l
	6pLAfHXqHoXXQ2wZn6j28dRoWJea3XU7CBxLwPmicKCfzUk73vlcG/+ZtSmPYWVc9gaeYUh1tGg
	rE2stZ9YaohNPpHnhQo4fga/7//8+Sv/XcPeXZCD0Q==
X-Received: by 2002:a05:7300:d090:b0:36a:e7a:e89 with SMTP id 5a478bee46e88-36a4239cc86mr29709377eec.2.1793714522144;
        Tue, 03 Nov 2026 06:02:02 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm56343226eec.25.2026.11.03.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:02:01 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] Input: rmi4 - clamp SMBus block reads to the requested length
Date: Tue,  3 Nov 2026 22:00:05 +0800
Message-Id: <20261103140006.1587143-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103140006.1587143-1-lui2012qwq@gmail.com>
References: <20261103140006.1587143-1-lui2012qwq@gmail.com>
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

smb_block_read() drops its len argument and calls
i2c_smbus_read_block_data(), which copies the device-reported byte
count into the caller's buffer.  The core clamps the count to
I2C_SMBUS_BLOCK_MAX (32), but nothing bounds it to the caller's buffer.

rmi_read_pdt_entry() passes a 6-byte stack buffer during PDT scanning
at probe time: a device reporting a count of 32 overruns it by 26
bytes, with contents controlled by the device.  rmi_read() with len=1
and all register reads with len < 32 have the same problem.

Bounce the read through a full-size I2C_SMBUS_BLOCK_MAX buffer and
clamp the copy to the requested length.

Found by static analysis (audit of i2c_smbus_read_block_data()
callers).

Fixes: 82264d0cf7ae ("Input: synaptics-rmi4 - add SMBus support")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
 drivers/input/rmi4/rmi_smbus.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index 8b61c23822..e4d77d1f80 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -177,8 +177,23 @@ static int smb_block_read(struct rmi_transport_dev *xport,
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
 	struct i2c_client *client = rmi_smb->client;
+	u8 tmp[I2C_SMBUS_BLOCK_MAX];
+	int retval;
+
+	/*
+	 * i2c_smbus_read_block_data() copies the device-reported count
+	 * (up to I2C_SMBUS_BLOCK_MAX bytes) without knowing the caller's
+	 * buffer size; bounce through a full-size buffer to bound the copy.
+	 */
+	retval = i2c_smbus_read_block_data(client, commandcode, tmp);
+	if (retval < 0)
+		return retval;
 
-	return i2c_smbus_read_block_data(client, commandcode, buf);
+	if ((size_t)retval > len)
+		retval = len;
+	memcpy(buf, tmp, retval);
+
+	return retval;
 }
 
 static int rmi_smb_read_block(struct rmi_transport_dev *xport, u16 rmiaddr,
-- 
2.25.1

