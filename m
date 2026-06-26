Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742203BFE31
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 21:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782510198; cv=none; b=RjppR/d+VHugCT1y7G1noBaEkM/LS/6hMsIrgMfhVOmuNEZI+/UbJQfjekL2ijSZjKTd3sBN+Jii9QmmqFGmLjmVir8eWgBqnJo/WYBhcewDF0f8reWm8h9zcUEnuj9CgXt6Rgd/QWKU6gdxRwqbavwXXLmWtgL0lMT6Y1/aSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782510198; c=relaxed/simple;
	bh=WCK5RAk1zCdP4c1gcbjSWj0Nfx6JIBiJNNlUouygubM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Grf6yg05WvvwbPs/QCQdQAXwfCDIqOAbgXJ6MeU4A0ikb+qS8OEAflXBzqEx0lHT3sS60vxMyayznlXKcWjDTqUml9azGYnJLmbnbXQiJ5xgargR07q5KS7fx2GD/UW63TBg+mJ3vNjqgQW3f8C3C9qEOb7Wb4r3948IjufXzm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=W1YUXR8S; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="W1YUXR8S"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-695f6438518so2079357a12.0
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 14:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1782510196; x=1783114996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVS51nQcnzfBBjuOddkxlKtX7yJkhFrdX5YZEJPsN3g=;
        b=W1YUXR8SNgCVMGHfP4XNyQDUa5/hdMuwcIJTiKjpSimTEt8Z4rWXX+EO5eV3mtl/Of
         DdDG2og6E92B8nWi1VNoHBDmfhn64GwDeXsscfysFzhHe2+280PHTcnAFwHV7St17QoI
         tIJaY36vLQ6UCMRXJ7R5Y/O5cRjyXv05slLgPpXCmotk4LZtnZrN8VJ8TNquGaBlZwK0
         BV9RtHSG2UGnRECCbzRKNmwqVQ1vW0hJuksnvU6CgTnspZxcQfcPnDkDxba3DZomDoLW
         AdJKBt4Z34kQKwZefeeo5rP+rY92hIXRWWhEKIGu3VSGI3jbYDJ47s7flPWllPbcFUdq
         g2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782510196; x=1783114996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVS51nQcnzfBBjuOddkxlKtX7yJkhFrdX5YZEJPsN3g=;
        b=dczvLkhDURxUKvZ1uYfXdPMtIO9FibWDCiWXT/rkOGeIW4zmv80exeu2F7lT1fCb8X
         T4vrc0u5CXI4k8M2THXklcX6CSemzfsk/oSZYbY5ctvQ0dCnMVxeIVF85gcuJM/6/Bg9
         ILeQiCF3YajQlnMRpGUGp0xt/8OL/WzuegEJrHMLzYhLhEzfOhQ0TtvzL3NRyCZ2JfP1
         YZk3W4K54jgjPfky+WvGssgrB4hRL/i7X96F/n0qAPDK3u38UZ24X+gQgRuH5icx931q
         1shNbqpHUp6LQq1NGvSWrm2kB2hx9sHP/ue+4tDb7Wwh/BVZGrGsPR5FTjqs0FCY04eI
         aQhA==
X-Gm-Message-State: AOJu0Yyhz976nrXkqI93e7WKYom5OZ9NBGsLJPJzMi0KMxvCcv8cgDzO
	eKXqhnkx0LmWfKpXumx5qxlrRip4dvMXB2Bvtkspjno4Rep6TDSOoRguWNUGwe2b6GUVF8brues
	C1g9KCg==
X-Gm-Gg: AfdE7ckaTs8mBJNqKuxD0Era07qAwHKuF5zuoVyN/Xr2veQAWRb2RWDTa/kF7qjDnnh
	tb4orHY5yjLuxImNhFKg6GZLfobfsSf1NWUEHoyO2NnATX7qAJYXM+AjclwJJ/DLreIV+zHnN+o
	dzZRie37Vs3KD9GB5qm/jHyCiBuDzZ4tr9xxJ0ogas2b8vyriCNzNfS3sz5Gaqciz950ClRM6+J
	+eMrHBeHwW5LhRCZOJ3PFXRAmeKKMOdqsKST3Fp7meTlcurWag4vJMQz3HLWp1y3zfKkCJybHjl
	Ql8dYb1gjbrMntdfI4J8se9J9Nz89+7Z66VKQxv11pYAV9L/gsJRs6quvhDzGq5lEpUaJ4kv1fK
	TGipsVZbl82xPSMc4WAM8zCz02d2M/Dp3R2UI26tMI+NPIzc+e2yVPPqHAYVbTByRpP9tWmiunS
	tVwuzpxRaRi7gJLxu4lnLV2is45u2EZdnFgaRneeKuX0pjcdTBHI7mEj4VlNX8btBbX0Sek9/VG
	CfKKd5dQzH4kdk=
X-Received: by 2002:a05:6402:e98:b0:698:3b7b:e492 with SMTP id 4fb4d7f45d1cf-6983b7beca9mr745983a12.40.1782510195338;
        Fri, 26 Jun 2026 14:43:15 -0700 (PDT)
Received: from localhost.localdomain (78-31-252-186.static.kviknet.net. [78.31.252.186])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-697f3aece6dsm3385821a12.12.2026.06.26.14.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:43:13 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH 0/2] Input: ilitek_ts: add stylus support for 0x0c reports
Date: Fri, 26 Jun 2026 23:42:46 +0200
Message-ID: <20260626214248.5563-1-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I bought a CHUWI Hi10 Max and was annoyed to find that the built-in
stylus was not usable with the upstream ilitek_ts driver.

This small series adds support for the pen report format emitted by the
device, exposing the stylus as a separate input device with hover,
pressure, and side-button support. The pen device is created lazily on
first pen report so touchscreen-only hardware does not advertise stylus
capabilities up front.

The packet format was reverse engineered on this device. In particular,
report ID 0x0c appears to carry pen events, pressure comes from
buf[6..7] shifted right by one, and the side buttons map to two bits in
buf[1].

The second patch is unrelated to the pen support itself, but keeps the
existing wrong-report logging from flooding dmesg when unexpected packets
repeat quickly.

On the tested CHUWI Hi10 Max this makes the pen usable in GNOME/Krita,
including pressure and side buttons.

Thanks,
Kristian

Kristian Mide (2):
  Input: ilitek_ts: add stylus input support
  Input: ilitek_ts: ratelimit unexpected report logging

 drivers/input/touchscreen/ilitek_ts_i2c.c | 134 +++++++++++++++++++++-
 1 file changed, 133 insertions(+), 1 deletion(-)

-- 
2.54.0
