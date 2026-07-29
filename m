Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAD31E831
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785290353; cv=none; b=ocfcx+2Nwwnx931G/6ZZmwtJAhQWmA2W+qrqk/E5oP8hLoSrX1Ywu2pcHWliev0kgfnxYjLytUuDTux7O84Sjah9ZsuZKGX4emsJ53u7tNHjZMQ2WRhaNCRAe4UfcEznN6gF0AAKQRx8/RY4NDS4cPBnEDYjyxE2Fc3tpDgAaAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785290353; c=relaxed/simple;
	bh=CP5laiHk+bd7zH26K4w/uw0EBvzNCZpSGTE12LokN9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmEOfsxsXXK56543oAz0Oph507b9B9Icrn4+9/BLV9y7WW+4LMzy7zOL3TaAyhoGvJljR+I2HoLOA41zbvXxpQNIJo2ejomcb50J0dVL1+ADpGtQs1nkO3T44ydN+W4Phh3fwYbuyylIIvzCZgqgrzkgoWzcKCJ0cBrdMPJawxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=qdkyNTy/; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="qdkyNTy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1785290045; bh=CP5laiHk+bd7zH26K4w/uw0EBvzNCZpSGTE12LokN9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdkyNTy/A6kQxo6NBw0NuC7H0h9J0A7J+dnniOt3/ny7tG2gG4nDN/IcYTHOW91+T
	 9WfDzycf//UAEknB+R8hR8nMRiC5ILtBcqtYZ1o1BxhXHMojadfxw9LTt7yV1MEdW3
	 tmThnJHrBWShar/vI3LW3l6cotqTg1xnibLnTq+hLjLktDjutO4uC/NEtjna10nl6Z
	 mDyqV7Bn1LuTXN99XBXa6KmLRghNGKiTlpdMj45FrbH5+sxft42bOLqTjyKCo1hqna
	 pT11h+s23YSiE0+urUTukC3BxHCmDsp9j14dZaFgm9AeBFHob7svwIyml+1f6W+ORq
	 JH5WalSECzT/w==
Received: from microtis.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 366E4A0A9;
	Tue, 28 Jul 2026 18:54:05 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH v4 04/11] HID: steam: Zero-initialize reply in serial lookup
Date: Tue, 28 Jul 2026 18:52:26 -0700
Message-ID: <20260729015243.1170573-5-vi@endrift.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729015243.1170573-1-vi@endrift.com>
References: <20260729015243.1170573-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When requesting the serial number from a controller, the function will do
some basic bounds checking to make sure the reply is valid, as well as
capping off the reply with a null byte before copying. However, the error
logging can leak uninitialized memory in some cases. We can simplify and
solve this by just zero-initalizing the reply memory eagerly instead.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 drivers/hid/hid-steam.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 983d18d1de4f..8bad79205b57 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -447,7 +447,7 @@ static int steam_get_serial(struct steam_device *steam)
 	 */
 	int ret = 0;
 	u8 cmd[] = {ID_GET_STRING_ATTRIBUTE, sizeof(steam->serial_no), ATTRIB_STR_UNIT_SERIAL};
-	u8 reply[3 + STEAM_SERIAL_LEN + 1];
+	u8 reply[3 + STEAM_SERIAL_LEN + 1] = {0};
 
 	mutex_lock(&steam->report_mutex);
 	ret = steam_send_report(steam, cmd, sizeof(cmd));
@@ -461,7 +461,6 @@ static int steam_get_serial(struct steam_device *steam)
 		ret = -EIO;
 		goto out;
 	}
-	reply[3 + STEAM_SERIAL_LEN] = 0;
 	strscpy(steam->serial_no, reply + 3, reply[1]);
 out:
 	mutex_unlock(&steam->report_mutex);
-- 
2.54.0

