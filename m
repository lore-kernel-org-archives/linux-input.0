Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711503;
	b=XXtYjlaMk9g95hIExbJ7lTf0DtxxlSpOcfBIr2NLv05RB1U9ec8Hdwcw/jf7w1/g5b3b
	 oRbdxWZOeMTZvXHUyrjCuw0+N6QxSGKEN7LnEXqTY3g7pX4kq5dlG+jx0Xy9aZe34VOXU
	 InMak37SHht43E2XQpjZ2cGB0vH07ykRSj5AwWACkn6TmELeC0Zb+wB9yWLzrJB7kDQkN
	 Z30fn+tuQwZBKODMXQsZh545R7t8XcpOwBm4X0TPOPXb1dq9alkWeNWaXfIuNeRmYxIju
	 1nBjdmrbN6FTyWFxX59xrre3eonde0BeIC64pbIkn3hH1TDydx1J/a/NlsjN/1AmpHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
	b=0isj0tXVF5/teAVWcAANSZRT/kN9nP/yj0/wxaM0I3pQOqPIfCry1yI+fe5dWv5zYuXy
	 uJAb4PnSmWeheWy3oYq4bmllgCTCzZHIBzKP8/UTeps2rlJK5uG6XoazRA16QYdigvvxO
	 QpTQrLXa2pjtgjMtvTztfJ5qsd1PWwpRsoUB5G4eFJHRtSZiOhICnPie5E9NBRB62+deh
	 jT1PPLPtbSzU0yJwYwftMQ6pm2AKawGHwHagZZZX9S52WxSSWlW0ooC7NDEnH8jNOhXCJ
	 v67PzgwwwT6VjGcIfhSD2+qjglPJvw5QuXb6KnDFJOg/zjMIfY3a5ddCls3LKuGJACA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5d4Z0C4;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06415606D823
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 13:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06415606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5d4Z0C4
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36bd3dd31a6so60951eec.2
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 05:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793711502; x=1794316302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=Y5d4Z0C4VCcS+iRFugDfiTr9QM8oGt20qjhiOAWEwjdXCa6mxNLimTVXGi/67AdjL8
         006SGlBaxB/asTP0YUavB0G9PqD2ANnKOnaA1O6zDD7FgAoAP9W1Qz1cII5okY3Y8LJ7
         ng8G63X94vCGAa6ouj20O1i8fD0kal4DonkkSODCt5erp2LOZbOM5bGxZ7LsRqXAcw0p
         EtMDKg3YTgUWhPhVerzHVKOnD9dHBaJOD507KUcVwVZOrSASYBSIuuJra7w3o+q8Pmc5
         IIkaxWHcmqAgYk9dh/WcJc9+urlz6nWvGGbSh+U87GpOD5tFgldThNqsxefdS/queeur
         yVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793711502; x=1794316302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k+m3TcPajXrwUViGESbrFGTtui5B9hia7NpfsA9IB6Q=;
        b=iglrhNLkPp92ZEhVgkUZrK1WJr2FMnEyTLLJQNznyNp1nNo0V4HgOcUW0vXxCQLGG5
         mkc6mCCitaa7NZ29lQUzFJcpYxwKKAZpSb6aLwKRExnrAkgLMrGWvW76eo6DBWsY4YeM
         20cTZURWZ712u4P1b7PT4dk2rPxakwoMg1EdmfuvfeJXFP9oFsU5uq5w39TLJ2P/93mA
         K3KlMdZ0AjsLbxNqIBXw7EIvbT/ZymniKEht0DE8HyokX0zSMHJ78o1wS3M+Ni5uYrF7
         a50wFASbXXg34jjFQYyPVLzhePHRoxez4JFjet88MWerLzmB42kQQeiQjSDcYeKXbecd
         TSlQ==
X-Gm-Message-State: APuU4Z9ncAdhw1rQRE4sqVZG7aa294ycg/ysOTbggKhMpcxm/LrH5Oaf
	LPIjq+HijSeRvNhoECvQNTaYFyF9oRzRBTLpo2THMSsKl0hKN0Zk24Zl5aZCZjXMnuA=
X-Gm-Gg: AYBFou2ity6ZNfsDSqRcxdBVTRKjeoTdvG11scH5uFoVNQv0J3gFpf5NaK/EnSWkFQx
	zzAplE/dW9Ww3fH+SyX++paeaqszfw2G2hNfoMMxU1foa3IT/4N54BPps5Hotw/BzPm+tVWA83f
	KG5yxo9z6uAidwln4a6v9QNCL4FDuuOD50IbogKTRRe2Fh42q8dhiJdXr+9FmSXEzku3U3eZB6w
	NfAE8LMrvxZntdoMZV9d/QQrPIPmEEIecPv8u8Z2L16SwQiqG1qYWVmK2JII/30uJ4+gF5XZgPO
	WSwmJegohuZuCrdwvtj7wpVQbL9erxxiK8rwGsTacCvn7CT9X3IWb9wBxACVwVWPNWgS+k287XN
	e2thgpA3DYlxQ+JTyL/xOk3CUHA2wJtC84+RD3EAndSFK1vOUOZLk6j//Yk0Yr7EFxMSxAVQfkR
	yvW0+LGHJeiYph9cuZnOSdMkLrGjahPjPzbnHFx1gHpSwvIBOZolEcubk/2EHZSXJvNiI5ZwcVB
	fkag0J+Q3fJ0jkmrTlha43twOOK7DyIB69EQ5wq/WwCZKMznNv7mc9td0WB5xCBzlrMPRcQM1IP
	uYOoDl4xanDJ0lmJwtrULWrBYR0LkiC9wEdwM4R3RA==
X-Received: by 2002:a05:7301:1c9f:b0:368:5521:612f with SMTP id 5a478bee46e88-36a4206296dmr27406108eec.0.1793711500553;
        Tue, 03 Nov 2026 05:11:40 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm40133125eec.4.2026.11.03.05.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:11:40 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] Input: rmi4 - clamp SMBus block reads to the requested length
Date: Tue,  3 Nov 2026 21:11:26 +0800
Message-Id: <20261103131127.1585884-2-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103131127.1585884-1-lui2012qwq@gmail.com>
References: <20261103131127.1585884-1-lui2012qwq@gmail.com>
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

