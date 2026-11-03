Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714514;
	b=rBcPadvR4Pxdip65FQ+E8NKxNJb/budJxTALPMtQ+HVhPfK2htT+SK7pKNdnX1R+tR2h
	 3fEwrT+Kahvn+O+zNA5fGaIjlFJx5CHyIoC5Xmjl6L9GxmYLkcAIIUYYrVc/Tr0vO+Bav
	 fClPI2/aLcjkFiITt+voUQ27MU0wwYCpEq5fliNsdYG9FYIuQxYrL9YJpuXx4Oz6lxIy6
	 JJf7XPyuQaMiYmOuxYYTcJ8WMylm9l7Y2HHYdtjt8Rf0OtfUA36VAkILuhOraiS7/Joe6
	 DP1O1N1ALz3W0kM6CwMDTSVM0nvx7J/zkJIDvdLcUbFJfkb7m9d32Ofkox+hgVm3rfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mGD1UhFryBGIkU8P1W+kRlX6z8gqLCh30+YdQnadjr4=;
	b=qyZDihbZn+gGbuqUaX00eOVy9a3YV+qkzBVMgm6dDUaXaoR9alUQCQjkWa3uVP0XkPUs
	 jELh4ogWRLOi9u66nIs3nB8GAzn1+3oq5BTMalv7iYl0hWkRHiRLoW5cq9q5MjeG4mL26
	 r11d1kOaHkTo9tza0CkAM/kf/2LXi85B2BtwmbkXc/tPL763cH+oOwyeYxtvVQ6huXsq3
	 NmBp4+SXCsjP5q+dd5DZNm6l+A3yyuawU81W6xdavId7HrD59hUXSLAz3y2em1vy4OfSK
	 nJ5gZNZ1DD8pgpTeiOpcV5IVA1ItJfmh6cx+gK6c3bXZ/rhehYKz5KbS4Miw2j7Q/Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EdXSG3fK;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BF6082BE5
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 14:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D46BF6082BE5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EdXSG3fK
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36a1467ca93so389243eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Nov 2026 06:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714513; x=1794319313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mGD1UhFryBGIkU8P1W+kRlX6z8gqLCh30+YdQnadjr4=;
        b=EdXSG3fKhnynSqNwL+5CzOEiseDt8hCYU6zbPYSLOLKhEj+bkjvMxtQhmE5ozUP7pw
         CARz/f6GQL6+s2QIB99+FMLjZIdeKHgr0BnR3lgCUBYYAuJOUXphZoxLRDBYr6ToKG0c
         gAac0KwpeKQiqch8xT01i2BWZK4VjcWvlz4MBlEm5ZjKSw9NGgnMOHRg1cuRi7h3YZ5H
         ys/wXhPLiR42hUxhjN0pjs79Xv3+WH4nZW4XMp0pRMKNjy1gnN6xFHkWZuLL1OdGCwam
         iQAxKaTMyRyg3833Z+FkceLAOVmLRHiQncD/qX2NbGg6L3ezVHGBZ5jhOFpUp9glzOYe
         WFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714513; x=1794319313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mGD1UhFryBGIkU8P1W+kRlX6z8gqLCh30+YdQnadjr4=;
        b=gJAjkqK/YDUnjHNM/YErxbQnGpejXTHPZ5oWbHIJi4bbMS0JWlVm999H3Bh4tlov9s
         Jzl/zvm+j9ObO2it+WCBXmeHLwLUiK5NGTNYg38xjGdsF2i/g9uoxzPpmAw8a27OvkF9
         UkxtLkxZSBJhiiO6EVqlHvEkoGUl0EgKTG1UUgRqkyRCyKbCwMx5tQFp1+Lb6pbbfhtl
         2FKB0mphuwrccBgp5K5mn3GngBCBgonvcAQZlJx5EI6c28fpy9w7IRawtAmO9G1XIZkQ
         XbXZMj9oZskOGurrnz1LrWq5WUw3JGK6yFtlVjiYf9bu0ilFikfV/n2RhdCL1KSlNr6+
         UaXg==
X-Gm-Message-State: APuU4Z+gowOOlkfbUS+BVRVWY/PD1chw/tS1A5VIdviLiqjKzIdeQ8yx
	D7KXgQHEjfIubyAot6v+CJb7Doxz6+WdfxQPeR6xXb4MXY9rpGuXzdry
X-Gm-Gg: AYBFou2FOsVUkb1Z1dqui4XqugBuNM+w/SeccX+KxtIq09+CXRtu74CcRYYeo331UX2
	8L9xJsudcb0xfg1WmRDmELbQsMtZrEhP1PEx2d+kDv1OpBnwo6BD3xIwLtQayWMdpyXuybjIXVi
	yvhoOjq5zQRxqvibNX0gazemk+WjcbnSZO6DVI7xeGY8Xsp8GJtpDlD62mIrdxaZOSlELjvoQ7t
	iqZIzA2HAb9rSZEsY9XqqDkV7Hgwu1h/F1pOi2t+iy1SSrZxxWlpkptAdIakWDKAFwHXqrXrS/m
	FbSKVR6JNdPS+SXUETkrsAV+Rvs9uMV7/ur2dF0Z5q28wqIjMkOgsENb0R7MSWCPuoGYZyQgtYF
	NYj/XF+GKfqhvj/QBzreXwHGbe4QuG/BgFIgI/UJlsjc435r4u41m6eTxQsQQdU2M1RBHjnghb8
	SVBJEddoTcllGbzGGKm95DKhdUuUIHcGdx42z5oqaFEfLwtZL7yCVNqp4M0xbLpADRfUyPjhV2C
	eIKuwb5V0kN/2IDGv77arfhlKJ2Up2CVa7qXqY8xrnRngnQAnBEG7W1xVfKWiXrHty8l02rpwQo
	764yDfIbNv6vuGzwrxjqtG376pJev8OHVRMESA8tbw==
X-Received: by 2002:a05:693c:6304:b0:368:1f8c:5f23 with SMTP id 5a478bee46e88-36a4205b0bfmr29799141eec.0.1793714512436;
        Tue, 03 Nov 2026 06:01:52 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a6f7f9sm56343226eec.25.2026.11.03.06.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:01:52 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v2 0/2] Input: clamp SMBus block reads to the caller's buffer
Date: Tue,  3 Nov 2026 22:00:04 +0800
Message-Id: <20261103140006.1587143-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

i2c_smbus_read_block_data() has no length parameter: it copies the
device-reported byte count (clamped to I2C_SMBUS_BLOCK_MAX by the
core) into the caller's buffer, so callers must pass a full-size
buffer.  An audit of all call sites found two input drivers passing
smaller stack buffers:

 - rmi4: rmi_read_pdt_entry() reads PDT entries into a 6-byte stack
   buffer during PDT scanning at probe time; a device reporting a
   count of 32 overruns it by 26 bytes.

 - cyapa: cyapa_gen3_irq_handler() reads into a 27-byte struct
   cyapa_reg_data on every touch interrupt; a count of 32 overruns it
   by 5 bytes, in interrupt context.

In both cases the contents are controlled by the device.  Bounce the
reads through a full-size buffer and clamp the copy to the requested
length.

Found by static analysis (audit of i2c_smbus_read_block_data()
callers).

---
v2: cyapa: also fail short reads with -EIO (Sashiko AI review of v1):
    the "ret > 0 ? len : ret" convention masked them, so callers'
    full-read checks passed with uninitialized stack contents in the
    unread tail (and leaked it via the product_id sysfs attribute).
    rmi4 is unchanged; its read path pre-zeroes the caller's buffer.
v1: https://lore.kernel.org/linux-input/20261103131127.1585884-1-lui2012qwq@gmail.com/

Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---

Chengyu Liu (2):
  Input: rmi4 - clamp SMBus block reads to the requested length
  Input: cyapa - clamp SMBus block reads to the caller's buffer size

 drivers/input/mouse/cyapa_gen3.c | 22 ++++++++++++++++++++--
 drivers/input/rmi4/rmi_smbus.c   | 17 ++++++++++++++++-
 2 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.25.1
