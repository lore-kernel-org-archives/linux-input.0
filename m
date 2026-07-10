Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FCF29AB02
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650542; cv=none; b=XUUtU56b8ua9C8PiTtLCMrO87u2UPv8Tf9zFL5uxK+AB5Uddl2Cb97xHK1XKjtLMIgpZFnwfBU91ODD04ZCTNHGfq9/Ux6lkCA0XO31xChVhHZYz7ZMzZr7YxjXl+MKj56chxQ2ucDzKgf8g8tr9AvvgaTGbf15kTHwXPlVgHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650542; c=relaxed/simple;
	bh=IJkqPJypQc7GLzpERLUahs7dKBADnN+RxSys4p0uAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njoruulTtHALIuwLxRlS04KKgb/To6dXyT53tNssn430kiuviw0CrUDwZXb26iGRIDJ6eI3JkpOYEiqPTm3xJj4Ux9eYyF1b/bzeZa+3dPJAs1jhDjpqO7tJp8pthX6y4hXodAqnpSwkHqJs0+rCy+LiUPrHW03yts5cDWthlrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp6qZNcy; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp6qZNcy"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so21737985a.3
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650540; x=1784255340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eokHULuHuReut0+2I3ViyzYy6XEeFIbj+NJmSsqM9JY=;
        b=Fp6qZNcysCjj+oR7YU6eK/Kxtf/8NwStFvYDclOODYj3LicZoJ0/QPDC1Ew6D0gWtL
         ZTlrPmUc7UhNVa4DKAfaKjklPqXHOUFCftLJgIbtkdGgdJKqy6bY6qqSW7Xqbcf8LZMC
         UNpafK8KLzIPgEXMgq2xPC/WxrmtrqMU43d3QKJWRrdUfQEgQ4tpDqdvI5EZ3gd06+Dr
         7LvF/B7HJqWYhWKhnvTZS/frP8zVwhXhalppioD8rbO9a2b0N9DTNPzGS4dDxJ/dovi2
         bpigm1dlqcyIBuflepWSp+PDoHeAZ1G96GAvqJCLQ+6HPqWpGGxG1Shw4Qu65twkyTvd
         sEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650540; x=1784255340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eokHULuHuReut0+2I3ViyzYy6XEeFIbj+NJmSsqM9JY=;
        b=jky3ceI1Sd9vYOwm+9xeYdhsJGT04ufS/9lhjmWS/oFMX5dmWlef4iKgd2wa/5V6k2
         1ARFyDQ39Fw19tdexfiaot/o62mdto1tipf/qj5NAl0SR8zk7p8BM6Qc6YKKnN/SPgT/
         DenAXQxarL3xApcBJ1c/2WrDYph4zoW6WP05HcFHGEyMA5gB3R48s6FpKxNnqHpWU0jj
         XGJe2393EDYESWFZwr4oCbAyJLvBqluPZzkAmgvhQqJ13afgqysCcJe1PWZ1fNRLPXsE
         fCHFwF5CQTCQkhAoRkt+Dz5R4/pV/z4FQnCJ/NlKa8N2KRDipxQercCFwto9Cy5KkSTK
         KqdA==
X-Forwarded-Encrypted: i=1; AHgh+RrZVrWeQ/Eo+jPue8yFQwjKLNmtrQTpoV5FNUn1xJcL1mHH6NjFzXoVAcYLKs+Lz3GnR2mpzONrBUjtoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHPCxKYXzSlrIq2FCl0g5jru9zoJgiyP9yf0EpbHd5c/IK6esu
	M/D/iOefBh7JiD+CW6RQaxYn2ZcN0OfPy50ms4eeMGGPYlcv9Vr5Is6U
X-Gm-Gg: AfdE7ckzpPJ44O1Lfr6H3blbq3ccxUtN9bv7ABHclSpiir+D6TPp+Yr/Uuft4aTe82Q
	qrxIcwc/7YA2XTdbhdYAOkIWixUSDbppHXctTqkCvUeC52zPn9EB8Q0XcVdVBMzsZ71pwCvsy9F
	bg4l8h3BnbsyvxRcQk3B6WGcz/0IlBA/OR28B4i/uwj1cjKFNHsZq7ycQ/OYVXE5BbEwweyMLTX
	/Fnu/yG7ohyUXIgsbqRQ6c7G1VNjCrzgsraWMLWhfv95d7ZBet9il6o4bzGXsCv4ed3cbR3eq7C
	owBjJjNJIEJ5YgFsdk9D1/Yu6lF1wKDThnKk+OJ/tWVRHJhp6/esDZbTN3E8HZWaZj6PwTAI7eu
	X5qQHpt6W9vJbjeOeVIOg0ENjuRG8xkCJh8CwRpngnPLWy+7spOYJ6D5cuOnuBAXyHPCNxrJ6WF
	0MQTD7Gyc4+wp56i/rf2FblHvMfNcK9pLUQQKHGS1hn7l1XXpwCCTqk/q1ZLw+ImvXk12LdQ8dt
	jVBHQ5qNf/GVTu//bBIIywfluEgk8MZ
X-Received: by 2002:a05:620a:46a9:b0:92b:67e6:8ac2 with SMTP id af79cd13be357-92ecf6b4bedmr1085970385a.60.1783650539736;
        Thu, 09 Jul 2026 19:28:59 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm90507885a.11.2026.07.09.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:28:59 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	kys@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] HID: hyperv: bound initial device info descriptor
Date: Thu,  9 Jul 2026 22:28:52 -0400
Message-ID: <20260710022854.3739558-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

A malicious Hyper-V host or backend can crash a guest with a short
SYNTH_HID_INITIAL_DEVICE_INFO message. mousevsc_on_receive_device_info()
trusts the HID descriptor bLength and wDescriptorLength without checking
that the received VMBus packet actually contains both byte ranges, so a
truncated packet with an oversized report-descriptor length makes the
guest read past the received packet while copying the descriptor. This
matters most for a confidential guest, where the host is outside the trust
boundary.

Patch 1 passes the received initial-device-info size into the parser and
rejects descriptor lengths that exceed the packet. Patch 2 adds
same-translation-unit KUnit coverage: a well-formed message that must
still parse and the truncated/oversized message that must now be rejected.

Reproduced with the KUnit/KASAN test: stock reads past the packet on the
short message after the benign control passes; patched rejects it and both
cases pass.

Cc: stable@vger.kernel.org

Michael Bommarito (2):
  HID: hyperv: validate initial device info bounds
  HID: hyperv: add KUnit coverage for device info bounds

 drivers/hid/Kconfig      |  10 +++
 drivers/hid/hid-hyperv.c | 144 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 144 insertions(+), 10 deletions(-)

--
2.53.0
