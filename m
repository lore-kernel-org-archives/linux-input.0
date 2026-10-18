Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82987449EB8
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 22:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361029; cv=none; b=EQfMoB5PiDE4Zg+TpyNCXkaxtWpStataJFRia84dCSQzRXrorvMtZAmezvPA4KxyoE4AmxjLE+AUuG7Ry2ToscW8t5J3U80AkrGPNVrys+riEv4fyBJPpdWe8vUCkd79ACnRiAkyNe7nWVFMRn7YO1hWw2az9dN6o2MWhg/oVCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361029; c=relaxed/simple;
	bh=cZQzGnGM2K5FEwXkqLo5PAEqWV6s+2ZySdx5UMTRlg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSbIfdNKOWS24cORG0X5Pvc1BqqrXJM5I5gLLG7xe6d0IGtx+4zfsznQHTCcieaAja2tXP89n+FLKlKhP2ILfI02tgybqd72H2bRnaNJt7BhdoZXZG25ODyhAZtZH3lsNd1jxIqEE09/4LkKHHAxOXNfSMoWvWvycHvqsqu5urE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSrSZPkV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSrSZPkV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso15708095e9.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361026; x=1792965826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FES/fYwB941CbOu1dXV2jAnah2WUGhQCqEHv1acGyKQ=;
        b=TSrSZPkVQ+nmKB/1N1jGTaWIkORg7XNm5pSVz+/jnXvpwOzO1gb6i+oIUvR+K7VV6k
         /vnTnbvUyKxmfpu0LjIeQfbot9OUbXwkwHa9iXliL22d3U5NABpKh1wKcbrggHaH/+4A
         en0OWGpsFaM5zns2rtpXunFGGfEjXBdXQX5G2e9I/bK+uzzMGooUg5LGiTC3zIsEc1Sy
         5FLhMYvRAVFQPwhgoFzGF+Thf9mZkk4mD0BSuZdNqw3hiHwkMLi/bsfUKbiSx6GZYm8J
         CeV9N39U0sPCfIvQh+JxZWRHTr/dK4hkfubzf6pYwodhLLTdmdmOEF2DEpm49kGy6iYN
         6B3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361026; x=1792965826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FES/fYwB941CbOu1dXV2jAnah2WUGhQCqEHv1acGyKQ=;
        b=L4BP4oI/W45bIv9JT8+RbeYPK7DZ7JtS+TQUoM9WwA6mSXVY2i5s2SprS1YPtOXZ/C
         wa/RTlmnwK1cQ2USicDqi1i5OniTDJRAXhFQtAEjlK/KH3Qhpl6UBVpwRFfr8iSLrxPj
         cANMrfdE6m0/SwpQvsmZohYtkJw/7NkBqjceLMADZfpRtf4NHP72OM6I1zqQ/75BLNSm
         GOjKRjiseIzPWw7CI6BV/0nmd1eygVA8SimFFvOgpfR4GeqsZBAlXSC6CKjo9pXQnwSM
         eOqmK97pF2w1g8qkcOWLWohOyff/zgn1fNXA9aGU7U3DQrQ6i0aRfanZXNIuLhuzk+lY
         DPDg==
X-Gm-Message-State: AFq9FYI0TlJvrZ9ojeczcwKUUYXajZ2Rs4NFys/rAxXQ4lZO2MU92fFo
	WsT1e5dJdpF4D8XxNCkvutNcf5SNYuM6c2Iap2MEY4a1b1pHXQIaOeY=
X-Gm-Gg: AYBFou0MPueeQscV460iDG1rMZ9mY8545aSIzj9Z4WRzX1+ZPrgz5cDJPDCY9Xs0LZQ
	FOYdrLve9PClWxJGHvTn9Rs5yDup7r87JnQKE1Bv/5C0LQnxsh2E1yAI6Qc9PiKSi8/bBAVt41O
	2DzZB9rWojNPCq8BzvQHb8b5noJYVqDxRPbc927Avcp+nYVwcJQQwrCKytWnFVqU53gmYhz9uLh
	kov8Q+eNBj6A1LBQHN1nmKkBPCdYdhRb1L6cLX/spps4AukX3WmB3LFrYibAZFqnDWKfaHGtsIM
	kVqX1qKSHZkuMiG7NI336rUyAivzXAZLPsRCW0EuuBly1HeU+8xkH33VMl0bJhwE/EetJI+BG3m
	HAkqQ9WokYheD+fGgxN9KJDBnFwBtEfWMLfQ7w2hhiJ2ItqwZ/pXJGI6F+6EbbnGKJeLexU2Qfc
	wQ9usDI4/kV8lhnRAoQgLaxUA71jyjqTe9JiA/q08=
X-Received: by 2002:a05:600d:6413:20b0:4a1:d899:b62f with SMTP id 5b1f17b1804b1-4a1d899b7f0mr76244705e9.0.1792361025664;
        Sun, 18 Oct 2026 15:03:45 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 0/8] HID: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 22:03:36 +0000
Message-ID: <20261018220344.1987142-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Several HID drivers access report data in their raw_event callbacks
without first verifying the buffer length. Since hid-core invokes each
driver's raw_event callback before it validates the report length in
hid_report_raw_event(), these drivers must perform their own bounds
checking to handle short reports safely.

This series adds report size validation to eight drivers whose
raw_event handlers read beyond the first byte before any length check.

Tristan Madani (8):
  HID: pxrc: validate report size in raw_event callback
  HID: alps: validate report size in raw_event callbacks
  HID: mcp2200: validate report size in raw_event callback
  HID: cougar: validate report size in raw_event callback
  HID: zydacron: validate report size in raw_event callback
  HID: oxp: validate report size in raw_event callbacks
  HID: cp2112: validate report size in raw_event callback
  HID: prodikeys: validate report size in raw_event callback

 drivers/hid/hid-alps.c      | 12 ++++++++++++
 drivers/hid/hid-cougar.c    |  3 +++
 drivers/hid/hid-cp2112.c    | 10 ++++++++++
 drivers/hid/hid-mcp2200.c   |  3 +++
 drivers/hid/hid-oxp.c       |  6 ++++++
 drivers/hid/hid-prodikeys.c |  4 ++++
 drivers/hid/hid-pxrc.c      |  3 +++
 drivers/hid/hid-zydacron.c  |  3 +++
 8 files changed, 44 insertions(+)

---
Changes v1 -> v2:
- Patch 2/8 (alps): Fixed U1_ABSOLUTE report bound from
  max_fingers * 5 + 5 to max_fingers * 5 + 3. The last byte accessed
  in the finger loop is contact[7] at data[max_fingers * 5 + 2],
  so the previous bound was two bytes too strict (reported by sashiko-bot).
- Patch 8/8 (prodikeys): Moved size checks into pcmidi_handle_report()
  with per-report-ID guards instead of a blanket size < 4 in
  pk_raw_event(). Report 0x03 (MIDI keyboard) passes size to
  pcmidi_handle_report3() which already handles variable-length
  reports; the blanket check dropped valid 3-byte single-note events
  (reported by sashiko-bot).

-- 
2.47.3

