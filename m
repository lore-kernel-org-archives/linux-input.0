Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164251;
	b=QWYw52Iqgp/MsPGFArOtSTn/Y0+tLR6z4fHKGL2VwLxrWJgCll4XqleXGhjWIdhpir+5
	 Ai8FskhY/I9qXfbt6YsM7UTPvHWPBqyyquTnmAacEnx/QVveHtL8I2tG7d+PAkkPUNwnJ
	 +c0iNEdejlbW0ZA08HHCSzao2nwE4bVog8TtNle4DiHdOZTa7IrCUreV8HViyqfrgiFrN
	 R3RbaFHIhKqdgCF0w0OCwaLjtjwk/WFlprm7p1wL9B9N1w/FLow2cbagKKzjdzNOXw5jS
	 kFvjwgqrw1Hdw7+xJhBD9AfbtlWK3U3B1vby9AT184TE0Ddgqa9f4o4+0D2axQiW3tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164251;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=FZ4gSALVJZEpS42+e2FU1wHNldZm7CixO/Ili3jjYjQ=;
	b=yHn3CJWVMQ6fHSXc8/MDAUkPNRmqfuVKG76UGeJpz2qf6KCrWvpZ2Y7E7YBzGFHEVOcE
	 vJvoRFZD4DShfCQC3+gOcOX2gtLrBpuVqLFsgcBdUCehabQuAHEoQb20TRVg1kzpfvqPB
	 U2DSoyX+L+XAvCpjmLk/K7ql4M2olmTxZq4HT/uEB9xr0gTGtVoRc7jhGOYrKeBFRmIKJ
	 3J7GGpNxAkTWvFiFytxF+lUlw2WM1tAi0AECRZAWc/mKgsIRyuSGniGP87LXAdPjL2S5d
	 +QuLQ7Ix0cuin9GJniuWhoZee7aV0eitrC211Rv5IlnsrQrUl4isj06PxlHwuVVA4Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwWKhL+G;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC3606A335
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02FC3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YwWKhL+G
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-15ea896ddc8so1139171c88.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164250; x=1795769050; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FZ4gSALVJZEpS42+e2FU1wHNldZm7CixO/Ili3jjYjQ=;
        b=YwWKhL+GHrChb5ufz1RyC8GdU7EtVlqown2RYTC6d90gbFuotV5O3fQYGl1Zz/qv5b
         puZ0iEwWjQLq/U4FwXn+Nnu+GzOPLy/DZ+Q6IFxSfFQnEyDYkzsdcdnAzMDqDBXDQ1a1
         G+nytKnNV6H8lYb3oy9Jjc5JpvQLsOt3wPMDZTrNQDMevotrYCWMLE/g7Dnjg8y66zg5
         F/JsugisGZbwIdSQeMFQX1pXy3GrZk4YUN/ZoyY41V+C2XCbR9Det+KYxaVPwL+tQJdy
         wwDNj0EtSSoJNCq7HPEp60MXawu9WJ8c5tUlfyg2g5hyNt0tXHgPNUKS7ulDxPzKqk9i
         wMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164250; x=1795769050;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FZ4gSALVJZEpS42+e2FU1wHNldZm7CixO/Ili3jjYjQ=;
        b=hjYiGbR88e13krAw3qBAtY+JQadOZkVOCtVZluQ12MUP2IiJGQXrNezt1KhvDUxCXl
         LQcWhgwW5iVoYGOQpX/ePmRWtPG3T0WJsnBRTu5nL9kZot4kKrXYImLd9DGNDyipQiFm
         xxunMAfxEXpN6m+4ja7yblqli0H64Ye5co4nuOZ0wjBnZgK5r6dkf3HAtiGbnQrYO/sH
         6hs8dJxpV5RSFUjgMXw06TvFFp71aQQwaVU/bX4N9sSF4mojlh8f8p9UGNq2rOZTTUiY
         si8P58se2jxjDb8LwddUN4si+YTJuw20ObD6DoGFOsC9m372k9Cv76fpO+LQ1w5QWpCN
         YKtQ==
X-Forwarded-Encrypted: i=1; AL+hErHEwUzCJHpICwDEGCGhYjsabnqA6ZmkIHHgXzgnG2ny3eq4PdRBaW1mqMCjbSTVXXPm5EDkX/EPesHVzw==@vger.kernel.org
X-Gm-Message-State: APuU4Z89jCL6wuPX17U+qP3kmuKPmSvwd1YcecYv8YUCMTt2+a+p6npC
	OgSB1OAiFkkkmCzk8JIKuC8zZHqOltth+ltl30laarnoSYn+arQyHoGW
X-Gm-Gg: AYBFou0cyJU4rkUG7A8dgrXsN8tODA++zUfqXwsf/jRKkt9hIN7wL5FVuqZN67mhAy6
	WoQl1Ge4nm1BbGRN9N8Ar1MGZpCLdGfszWac0fTG+59o+Yzi/uHv9a7SbphbJqgEAwbHmKao0s1
	wrnQOqDCv31rtEQ4s7psD2ZxVpQs+5TvY/S/gGud9PKbWLy647e9MIzBcOGHoNRZfRWJ7X1ZCQs
	uaVyf1bVMyPfSSxk9qfF5XgZxQsJZqur8qy2fVLRdRoFvSPOC1W0nvwlciMeqhBrgkAUoJie/dx
	2Is1bx6/bRr5FaKSRwPVRd+TWRvpTVfoXj7yCd84+iRVDOPFcsI/q5Ap6IJdWlk/Ph+sXlG6lYY
	ryyYeG233kLcxkcrnAwBwz7OEeNh9J7LCVPBWzyiTkF/eNwzLX6FFeO5JNDK5Ws0/ph71cClh1V
	NdQ9HDdTDuFz5vBCFYH7dUPcWPcvUJBQz4IugF+Zxq8lBN96P9M0gHrm7QwQj/G3jPaXN5kAPk9
	XB9tm1pfAdQILZPo4+UGcQ559+Y7ilX4VS2cS/zcCWG01gkwqyTKMdmXuj2gtoKDSvxcFE5lbpg
	4Uy5KdjrdykAiRi8xh/6Ajre9tTNXZdCfkrBZo9IBoi3ArIzSEYRXGXzFQenx2HkRJ/lBHamKNk
	n2GUSHj2/PMxKZHLs0SgYutUAAANjvTgXdpRbpYY=
X-Received: by 2002:a05:7022:7f03:b0:1b3:a881:4d9f with SMTP id a92af1059eb24-1b5568a69abmr2133740c88.20.1795164249965;
        Fri, 20 Nov 2026 00:44:09 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm4808244c88.0.2026.11.20.00.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:44:09 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v3 00/18] HID: logitech-hidpp: G920 force-feedback rework
 and driver cleanups
Date: Fri, 20 Nov 2026 00:43:51 -0800
Message-Id: <20261120-hid-logitech-hidpp-next-v3-0-ba39242d4336@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEgIAGsC/22Qy26DMBBFfwV5XSM/wA9W+Y+qCz8GcBswNQQli
 vj3GhJVWWQz0pXunDmaO5ohBZhRU9xRgjXMIY458I8Cud6MHeDgc0aMMEEp1bgPHp9jFxZw/R6
 mCY9wXbDxzte8MtYZhfL2lKAN14P8+fXI88V+g1t23LOR4PeSTy6PGrJmBuziMISlKVRmWV3Xl
 hJaV1IaQ6nRAljLjaNWc2WlbKvj2L9qUzxFyTtRoVRlWysMr1SzcrR79WFeYrodD1jpofFAEE3
 2yUumlBRcYIp9Fku3MvfjTx/XUzeYcC6z8EFa2cv2e4GVYYI5kRUHTb3i9hWxbdsfhnvgg48BA
 AA=
X-Change-ID: 20261119-hid-logitech-hidpp-next-adcd534abca8
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

Per Jiri Kosina's request, this 18-patch series for v7.5 is split out
from v2 and applies on top of:
[PATCH v3 00/14] HID: logitech-hidpp: G920 force-feedback and battery fixes

Note that v2 patch 22/33 ("HID: logitech-hidpp: shut down G920 force
feedback on input unregister") has been dropped in favor of "Input:
destroy force-feedback device on input unregistration" in input core.

The first group of patches improves transport handling and error
propagation: keeping connect work disabled during probe until
hid_connect() completes, preserving transport error codes in
__hidpp_send_report(), and translating HID++ protocol errors into
standard negative Linux error codes in hidpp_send_message_sync().

The G920 force-feedback rework moves capability discovery back into
hidpp_probe() while device I/O is active (excluding generic USB PID
force feedback for validated HID++ devices), separates device-level
wheel settings from the input FF queue lifetime, moves the G920 range
sysfs attribute to driver dev_groups using sysfs_emit(), executes range
stores, effect uploads, and effect erases synchronously, indexes FF
slot arrays directly by effect ID, and cleans up FF helpers.

The final patches modernize the driver by switching multi-byte protocol
fields to unaligned accessors, storing device serials as byte arrays,
using guard(mutex), __free(kfree), alloc_ordered_workqueue(),
devm_mutex_init(), and devm_device_add_group(), and removing unused
kfifo and wtp_data fields and redundant helpers.

Thanks.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v3:
- Split out from v2 as a separate 18-patch series for v7.5 per Jiri
  Kosina, applying on top of the v7.4 fixes series.
- Dropped "HID: logitech-hidpp: shut down G920 force feedback on input
  unregister" (v2 patch 22/33) in favor of "Input: destroy
  force-feedback device on input unregistration" in input core.
- Collected Tested-by tags from Gideon Heinz across all patches in this
  series.
- Link to v2: https://patch.msgid.link/20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com

Changes in v2:
- Rebased the series on top of linux-next.
- Kept connect work disabled during probe until hid_connect() succeeds.
- Switched hidpp_send_message_sync() to translate RAP and FAP protocol
  error codes into negative Linux error codes (-EBUSY, -EIO, -EPROTO)
  instead of returning positive protocol values, and preserved transport
  error codes in __hidpp_send_report().
- Converted G920 range store, effect upload, and effect erase to
  synchronous execution with slot indexing by effect ID.
- Added G920 force-feedback helper cleanups, removed unused kfifo and
  struct wtp_data fields, and cleaned up minor helpers.
- Link to v1: https://patch.msgid.link/20261109061103.2887636-1-dmitry.torokhov@gmail.com

---
Dmitry Torokhov (18):
      HID: logitech-hidpp: keep connect work disabled until hid_connect() completes
      HID: logitech-hidpp: preserve transport error codes in __hidpp_send_report()
      HID: logitech-hidpp: return negative error codes from hidpp_send_message_sync()
      HID: logitech-hidpp: rework G920 force-feedback initialization
      HID: logitech-hidpp: use sysfs_emit() in hidpp_ff_range_show()
      HID: logitech-hidpp: manage G920 range sysfs attribute via dev_groups
      HID: logitech-hidpp: execute G920 range sysfs store synchronously
      HID: logitech-hidpp: index G920 force-feedback slots by effect ID
      HID: logitech-hidpp: execute G920 effect upload and erase synchronously
      HID: logitech-hidpp: clean up G920 force-feedback helpers
      HID: logitech-hidpp: use unaligned accessors for multi-byte values
      HID: logitech-hidpp: store device serial as a byte array
      HID: logitech-hidpp: use guard() for send_mutex
      HID: logitech-hidpp: use __free(kfree) for temporary allocations
      HID: logitech-hidpp: use alloc_ordered_workqueue() for FF queue
      HID: logitech-hidpp: manage send_mutex with devm_mutex_init()
      HID: logitech-hidpp: manage ps_attribute_group with devm_device_add_group()
      HID: logitech-hidpp: remove unused kfifo and clean up minor helpers

 drivers/hid/hid-logitech-hidpp.c | 798 ++++++++++++++++-----------------------
 1 file changed, 323 insertions(+), 475 deletions(-)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20261119-hid-logitech-hidpp-next-adcd534abca8
prerequisite-change-id: 20261110-hid-logitech-hidpp-6884bfb6a348:v3
prerequisite-patch-id: e1416a97b0f876b3ad2c58d961bc858fc894d90d
prerequisite-patch-id: a7c7a0921c6903c5cb52598f422b76593030eefc
prerequisite-patch-id: e250d48e371cf39225c26a2830059e1ef0f84100
prerequisite-patch-id: 19ed5cf936a31bcfb2e6743c64bdbfaf4cd4c497
prerequisite-patch-id: 7d9f088caf73b37fffaa521ab2fa01154bc725d5
prerequisite-patch-id: fd2e52e0c7fb38fbb457f1a133b21cc2e82bad7d
prerequisite-patch-id: 26d251375b09680f430f05d1cfe6f1a7049d7699
prerequisite-patch-id: 452b96def4814eb20770c50cda5ba2cdf934e1e6
prerequisite-patch-id: 99be7ec097ed9b8c9fcae3a1e769c65bd40d0e5e
prerequisite-patch-id: f42ce025d79d5bce980e061ee7bfd79fac6db59f
prerequisite-patch-id: 1f1d98c497c6f72f2468a7b136b38d3b1673a843
prerequisite-patch-id: 1ae006ac01f09e4fab516f0925b69f6683011ca4
prerequisite-patch-id: 1d063d2ee308c2ac3a57dfa9029b2d826b7f2a42
prerequisite-patch-id: 417cd6cae264a8b5dd5714ddeef4e75bbd959b17

Thanks.

-- 
Dmitry

