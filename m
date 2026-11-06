Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793966667;
	b=1zSbNZkusdkhGGjwq5xnX1X4k/K8J9Id41n68XmLuUPv3MuXPF6ExFaNFOhdyRXJeJ4z
	 u3NSLsMS/Tp5Gh3eiu3Jf5CTubc8mESkSgDHTMWWFLtOfPACLOj326+ux0h1hu9fYogWy
	 YaibqMeatSIRWYlDLbWDqxpBmGRxAqeQY99R9jJ/FL3NJMx75UJ9z9+tfcxILAHh4byAA
	 21Ixpr4YvAT27MfaskSHBnvq7F3ow+AjGIJMHe7qEmmtzd8y8X8bu6yHiR8wDvnahCd1r
	 681LEvehpcd8L/NcGK4S14xGKpcH1zyuw3rUiMCZkATrahIcBF7uw7icPLkKVQUVI1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793966667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P1OMG/B1lVqgZxM1GZjWM6eenEu+BEzraRxEM+z0u2A=;
	b=sx2OJrrNVSg4HihyNN22RYF+ofMHLb7SMA7fQDe207DV6syKVz+iG+AS8HrJ5grJTHss
	 roZE5gvpT0FrMddRFa9ei7WBb2tvysQRJmK9wNWeNc0MxJUjDsZSRyRUjx8kgHizLCMs7
	 IBNcd7PsOHZfdCRLaXPfiRzC/mIoVcR1Z1XyUlLmRZ4/cUT1imp6yN6fD2ZvGtrCaTNUi
	 sMZOT1ivUZrXW9QQ0wZHpXKTUhLJybWsnPRG1dzjFaYdHuwA/uSAYMlprUj263Xv9i7c3
	 PiE0fgESskH4bnaXzE88W73Cu4V6InsI41stj4fBVqfjMc0Q7n2AT+fEGSIVkrtHFiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJ5DVKWL;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76B5606A32E
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 12:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76B5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xJ5DVKWL
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so78977566b.2
        for <linux-input@vger.kernel.org>; Fri, 06 Nov 2026 04:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793966665; x=1794571465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P1OMG/B1lVqgZxM1GZjWM6eenEu+BEzraRxEM+z0u2A=;
        b=xJ5DVKWLdsqGYUj4mBLEzYwT4ZfyRw80Pr3dR6mVmfZ2qrKdrEj0P2Ev+90MvMbeyR
         fr/CR0GbJCTMdBd3vdDH5q84uNemVDCluDEoiWRoEis2P/deHkOkn3Xd8xY7DFovRntM
         EjQYE5OSOVZ8hi1kDghiMRg3bri/s/FPFcvFY9Cn7gfYgwc0C0TwCi5K2mUdPzhImMJ2
         43eqptqFyRwStcXDo55PV9iOzDWloW4mR9WNbayt031LkXwlpBZ1VjCZTVLgoijV6EK3
         sHNmhiwDZfezljtn3m4HEwXEEytX8/P7CU3r77pvcuBj3OMp76NJQu+R0VmOR1Q2QXAF
         7ycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793966665; x=1794571465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P1OMG/B1lVqgZxM1GZjWM6eenEu+BEzraRxEM+z0u2A=;
        b=cByxH7CatDxFBAHRv5UBew3tR9l07GGsr1uwRk7sFLN+I2x9lep84rMrhaVaJNUr7k
         4V1dmFXyA9rf1cDETqATlUK0Cp7j6UVPryHz11smv34zGX9wrP8Ww1b062YljIBhFzKf
         5GaTv4uN72FI8krwm/1ELWhLOzdZnSVlmLOFYtbIkjy9LuoNTeJDktGmMXBcW1shLH7Q
         At0NxcPAFdCXw+KMM9NsMP9qzPtfkVgJ88EBZHBfsNiBH+sIbRqJSmh3NtVoPUWUqSO2
         Tu/tR3NkqpErS+nvnow2omJLdNgyjwhbKMiPtwUvNeM2QNNNsYKNv3cMrPga5HeZgYHE
         lpRw==
X-Forwarded-Encrypted: i=1; AKwUvByBQUE2LG/8OgrfBpDG7/bOFiCttG+R93k6auJCHIoOQm5kY9Gwu7GkmN+QYe2xdfEHpjNP22sYRevZLQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/vrXnFKlOAdSWpHyqp9TY9rz7wDm4Yu/iFCu/22dxaw+OmwqHp
	4DLtDMyiowedCNFufvgXrqXqxdva4XU53Ytiv83nIpNNBrRFmIT3rW1V
X-Gm-Gg: AYBFou2NyhYLOxyv6oBY7i6YbJJNceRgnRyFAdpoa64CK695Zsna71AprR6/ykx5qXj
	4ZmeQF0iCJAj+uRXV+gcdJIRiLzaoexgg6aOjY+otiB3bVH2RgmUKLT8oN46J/zyrMo9P3zwNZF
	2v6HiRTXNy1dAyzbVlFzbZmQhkZnZladGab54P+o6GGvSUoBctIiHex9WIh9U83aaQTh1wcfb25
	FA2f0FYZFxFxmr6nPj7PUniTgeL79nxH7lSGAbg36OyL9VHZCTPyZUZ+kA893Z5kmmxo9ODgO8o
	Z6a8U5ajwTEYG+eeYEv99RCEJjtre8HebbmsbrxcG8vO51fjqyCP6DMT86YnKsAzvfjqR7v9i0P
	0smGZMcZSBspHWFbD6qDFu+5wCxZlTqt/e03+ywdeppbhhj/nIuz++Jl68GY2B5far0EJHmGokY
	t7xBGAcPRY/BzcODJNhFKDZUCEC0pPbfmBkTHY8/Bjb7Hn6CXwaBxA9dgA+gT7KsEVgJ9inEH+Q
	/HBAxHW9Zv3V9wmy/CsEuj61H+aeqV1Q5PcU47VkZcWNx5sIyN0CeMmi43wDxSa/bFRE+0EdNt2
	6MqGTlnh/65qzkeGkHgWIw==
X-Received: by 2002:a17:906:dc8a:b0:c29:f5d8:9c6c with SMTP id a640c23a62f3a-c4d3530b51amr205452766b.27.1793966665069;
        Fri, 06 Nov 2026 04:04:25 -0800 (PST)
Received: from beelink ([186.247.163.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c60b0sm73922866b.69.2026.11.06.04.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 04:04:24 -0800 (PST)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] HID: wacom: avoid divide exception in dropped-packet calculation
Date: Fri,  6 Nov 2026 09:04:05 -0300
Message-ID: <20261106120405.169399-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
References: <CANRwn3RYhEu0g9Lx+Vg=Uy8V7BWWz-jWV9d7UVuyRK-MGdbHOA@mail.gmail.com>
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

The dropped-packet calculation uses a modulo against sequence_size
(logical_maximum - logical_minimum + 1).  When a HID descriptor
declares a sequence field whose logical range spans all 32-bit
values, sequence_size wraps to zero and the modulo triggers a
divide exception.

Replace the division-based calculation with a branch that computes
the forward distance through the sequence range directly, as
suggested by Jason Gerecke.  This keeps the existing int types and
avoids the divide-by-zero without any 64-bit arithmetic.

Fixes: 359673ea3a20 ("HID: wacom: Support sequence numbers smaller than 16-bit")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---

Changes in v4:
- Replace s64 arithmetic with a branch-based helper that computes
  the forward wrapped distance directly, as suggested by Jason Gerecke.
  Keeps sequence_number as int; no type changes needed.

Changes in v3:
- Replace raw s64 modulo with div64_s64()-based remainder to avoid
  __moddi3 link failure on 32-bit architectures (i386, arm32).

Changes in v2:
- Normalize logical_maximum/value as unsigned when logical_minimum >= 0,
  matching HID parser signedness. Store sequence state as s64.

 drivers/hid/wacom_wac.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 361738b..1d3ae94 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2426,6 +2426,13 @@ static void wacom_wac_pen_usage_mapping(struct hid_device *hdev,
 	}
 }
 
+static int wacom_hid_wrapped_dist(int after, int before, int min, int max)
+{
+	if (after >= before)
+		return after - before;
+	return (max - before) + (after - min) + 1;
+}
+
 static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -2551,8 +2558,11 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 	case WACOM_HID_WD_SEQUENCENUMBER:
 		if (wacom_wac->hid_data.sequence_number != value &&
 		    wacom_wac->hid_data.sequence_number >= 0) {
-			int sequence_size = field->logical_maximum - field->logical_minimum + 1;
-			int drop_count = (value - wacom_wac->hid_data.sequence_number) % sequence_size;
+			int drop_count = wacom_hid_wrapped_dist(
+				value,
+				wacom_wac->hid_data.sequence_number,
+				field->logical_minimum,
+				field->logical_maximum);
 			hid_warn(hdev, "Dropped %d packets", drop_count);
 		}
 		wacom_wac->hid_data.sequence_number = value + 1;
-- 
2.53.0

