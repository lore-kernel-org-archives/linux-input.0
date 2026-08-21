Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7381B3B52F8
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348898; cv=none; b=rEcq87tqc6zgJCaA0m8qMd2m3/XMfhd4DRISK1IDsMWIKS6aQob73Tp10QIjaqzT/DH3TecBOMRlzSd/P+F250jjQsWqk/UlVG0LdKP9o8iQhcOxarbhohl5ntFAGFlydRDRRJMiMf/0YcUzqO8SWMyD5KYjbYmzPti4kB2dpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348898; c=relaxed/simple;
	bh=Kd1S0iEAC3asoP4TJrOJa8X2s36lLpYSD6MHtXaVNWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OO/PpKHbkMd1ZO+5KXEoNwx0IZ9vq3HxfojLJqJNHYcxD0Au+IG0DsygnJg/U5+uhBvihsn5n31OCYH4QwIP/K8s8N/NRxFRUO4iJV+ZQoiy3jCxMTt3jTaoWtHl67yY7VvKP0SbzWddAkks89scLOq1+/0SNLExO/q42gFIS9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YueCJg65; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YueCJg65"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso16923155ad.1
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787348897; x=1787953697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2UYb5252MjGPVUXcTSSbD8h/yNodsVxGPCa1hZxNaaE=;
        b=YueCJg65wbJmvUzJMqzUHA2Y+IAEg9pzed1XvBq/ZrwhTMk82Pw49REuwEAFNTjN87
         s/jUqFvwvjXhVRC4wkVoySmBzfrUKLqm/raSFCr/Q/h0D3WoPBU1b1KUWBrI4hP2LA+l
         7kvOHWHx+NTMmPx9IABKvpwlhcn4fBgB5XSBacbHL/RTMRE0WSyqbsDrDYdkUJ7L7OtJ
         070flUvzGn6k9zQtR5Nc61M72svue+GSqz5Vc+cYLAoftfYuXdU8g/LqbUNUzK2OlzOh
         YKNlLcjtlQJnN3xARwEt2yMTwf3b5ZeNsA/I3kUgIbANqoGf75VBQknD2aMLNYQpmlfh
         sLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787348897; x=1787953697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UYb5252MjGPVUXcTSSbD8h/yNodsVxGPCa1hZxNaaE=;
        b=XOsIj0I0P5znvOfbkR3z+HTkEv2erod25iI5WhaeIO0LZGfiIJzln6jLypUSVpJ2kr
         hTW9dbP0nGCdoB1kQXWqUmqyOmq8OEwMVX9L7mIhJp1nhjCt0w/dECBHnVrx+oDHAeb9
         lQz32rnon9nvxexJv3NpbNk0PWN3OowJzJADx5JCl98zug173Cmp1XJvBxpZQ16wwsPK
         4S15U2PPmQ/Yuk4MDfoACHy9e9+tAE3j8ULT1Go1mo9fbvSe+PK+s9B2q1kHpbvND+Zw
         NDLekiCMIkLJExyZHHKZ9Gdc2xwU5qw2TJjFNA41Rvy2bcMWACfzx3AoZsA+SlvNx2Ya
         iQsQ==
X-Gm-Message-State: AFuF++maAyKuoaE/Lhm7E70wNulpdG/0kHkuLfXv26p4OCD+a33/xy7x
	8qlpqpCnp4PCAqnLRYjiI0A0r8k963mkgXdgy5ih9BCha3sae5UPryxR
X-Gm-Gg: AR+sD10viW0yV+UbcK1HOtOQoutLeYTFpGzCAdS6aNZuPNyccNrQE656jW4z5yxGPx9
	LGlNlPlBJGApKhOkjOF+XTS2hIbIXulo+0XqO0uirJpDj8lv8q+L9+UohfVhAA9FezkniV1yqZ4
	9HIxjTrrKTh5E9EzWS0R5ESWosEzdgqP/pXTThj3WnvmQiYiRfzjdkIAI4inaN0JnBvWJkQS22+
	SFGQktYbfVS3PYB3n6ZlwQ2Wd+TBxexcD28DsZVsD/W8A0FZrGWhiK1Gmeove0F9NaN3Xzf4qgJ
	eSIbDhWxJjALXmJmP1H5hLAj1A8oEfQLbCZTSCZ0wi3OBjcBMN6qfOs6xXSEDI3wlNiiek6Pjh8
	HhUpV0aHr/XpbJXewfXb14BETKhZShhRKCwGKkKMQKaujg59xl/eqvcMpmDnjFvVPoWPG2PIQcH
	1PDe1ZjCR2bON6Q0BmYDxiibDWaWWXQZ7g53HkmO+Rqw7ycJlcdoTanZlSFATKXkuANkiIT/ofN
	i3+8YxQ5LZbk3tBMxM=
X-Received: by 2002:a17:903:2bcb:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2d64adaa1a2mr186499115ad.3.1787348896741;
        Fri, 21 Aug 2026 14:48:16 -0700 (PDT)
Received: from localhost.localdomain ([103.16.69.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb46sm27276942eec.3.2026.08.21.14.48.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Aug 2026 14:48:14 -0700 (PDT)
From: Aditya Dash <mradityadash@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] HID: hid-lenovo-go: fix controller configuration
Date: Sat, 22 Aug 2026 03:18:05 +0530
Message-ID: <20260821214810.87826-1-mradityadash@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hid-lenovo-go driver exposes controller configuration attributes, but
several requests use incorrect fields or report the wrong result. Calibration
uses reversed command fields, FPS mode DPI includes an extra device byte,
firmware calibration failure appears as unknown, and two right-controller
attributes use the wrong selectors.

The first four patches correct those declarations and request layouts. The
last patch fixes the shared synchronous request path so that only the matching
reply completes a request and transport, firmware, interruption, and timeout
errors reach the caller. It uses the corrected calibration command pairs from
the first patch.

Calibration completion is asynchronous. The driver now submits those commands
without waiting for an immediate reply and continues to receive final state
through the existing completion report. Firmware does not provide a sequence
number, so a late reply with the same complete command tuple remains
indistinguishable from a newer reply.

Aditya Dash (5):
  HID: hid-lenovo-go: use the correct calibration commands
  HID: hid-lenovo-go: fix the FPS mode DPI request
  HID: hid-lenovo-go: record calibration completion state
  HID: hid-lenovo-go: use the right controller selectors
  HID: hid-lenovo-go: return configuration request errors

 drivers/hid/hid-lenovo-go.c | 165 +++++++++++++++++++++++++++---------
 1 file changed, 127 insertions(+), 38 deletions(-)


base-commit: 1292bca0f8d835d2ad96d309595b2e97f3106d3d
-- 
2.55.0

