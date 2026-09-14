Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094083B14A2
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429074; cv=none; b=fL/2lM9TFLBv6XCRtuY5+umogO4ykhE6B6ULDaxXAKdjaG4HAUQyrNLLAkUl7ZVc7JWa1UaX14tUxZWo0osplEWmYdUjjC0tuClJnTVoP9UhI5wjNkD4O7SYGyzaWCm0ufqJakhlceVwoCSEX8BDDUnemW8Dwo47Z+GPZmMZYAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429074; c=relaxed/simple;
	bh=QAUxjGI5TxT/Xrun8/+iXgykTgc7YxBk6r5VOLa/my8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmUdQ6GFPWqKaHCasVMMrULM+WTG4Ou43haCczL3CU4j4FsWoFga/HLr6PSLVQbHJDaZfWz2Su7dqzSYJXMbBaUDh64OYPvQIgJbJsyIS5NpHHE3NUq3mGViCTy577nSnOoFUZGl0y2umiDxZ63mhAOCUxo4M3XMmMT/j/erl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc; spf=pass smtp.mailfrom=vasily.cc; dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b=aGzQ055d; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=vasily.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vasily.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vasily.cc header.i=@vasily.cc header.b="aGzQ055d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vasily.cc;
	s=protonmail2; t=1789429067; x=1789688267;
	bh=YSVnX4Jvacy6T1gV7Hqcr9WgSmXcyvrQmUksEOriBYA=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=aGzQ055d3xo0qaK483INjdPOl690K6aRZ6asItwSQI0sRNc//sFyclt0hFuPvxrc3
	 82jcVeV3YNoAgdlSH/XPnfs6ozuoTtD6fEaEzci2pOJv3Tr9ecUjKEWqT4dizVC70I
	 VMEkkSp7MI/fKbBUtgEerv/fW2aoVxjRGq14nsWsAQskMqknounYrFE3NZajb3qMCx
	 TPqsO6L9/MVNfhMoiJZIeqBGODYpbNk1HrZmL+imNy/zMpaiQMwYx3juVt/5CyeFmn
	 MdlQ41U4fLAQIZ/1ndSqNkTfnZowLDO22CMpqSfbYFH6dXvp88fPnriLjtZODDUBHe
	 VAvu1o5QOIF/A==
X-Pm-Submission-Id: 4hkM5P3V9yz1DDKv
From: Vas Zayarskiy <contact@vasily.cc>
To: linux@roeck-us.net,
	Aleksa Savic <savicaleksa83@gmail.com>,
	Jack Doan <me@jackdoan.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 0/4] hwmon: AMPINEL support and shared fixes
Date: Tue, 15 Sep 2026 02:37:24 +0300
Message-ID: <20260914233728.22725-1-contact@vasily.cc>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision addresses Guenter's review by separating shared fixes from
AMPINEL support and leaving the keyboard interface with hid-generic.

Changes since v2:
- Add a HID prerequisite: hid-generic must consult a specialized driver's
  match callback before yielding. ID-table matching alone makes it yield
  the keyboard even if the hwmon driver rejects that interface. The AMPINEL
  match callback accepts only USB interface 1 and retains the transport
  check before accessing the parent. HID maintainers are copied for review.
- Widen the shared power/current caches, clamp overflowing power to
  LONG_MAX, handle unavailable power, and prevent negative Aquastream XT
  calibration results from wrapping into the unsigned current cache.
- Expire the initial cache for every device in a separate patch.
- Use the existing raw-event path for serial numbers, temperatures and
  timestamps. Store AMPINEL values in hwmon units during decoding.
- Omit current deviation until its semantics are established; remove
  AMPINEL keyboard callbacks and the unrelated expiry documentation.

Validation:
- Both modules build and link against Linux 7.2.5. Both changed objects
  build on this 7.3-rc3 base for x86_64 and i386 with W=1 and Sparse.
- All 995 captured AMPINEL reports pass the C replay harness with ASan/UBSan.
  Shared regression cases cover High Flow Next power and unavailable data,
  existing fan/pump power paths, Aquastream XT current, and initial expiry.
  The tests reproduce failures with the previous conversion/cache code.
- A userspace harness extracts the actual core/generic/AMPINEL match
  functions and tests both driver registration orders, keyboard fallback,
  non-USB rejection and special-driver overrides. The original hid-generic
  fails the fallback test. Probe descriptor validation is also covered.
- All seven Python tests pass. Strict checkpatch passes for all four
  signed patches. The changed RST renders without warnings.

Both revised modules are now installed on Hearth, Linux 7.2.5. Their loaded
ELF build IDs match the packaged binaries. All 60 raw USB/hwmon comparisons
matched across initial loading, telemetry-driver reload, persistent
activation, deep suspend/resume and reboot. The AMPINEL keyboard stays bound
to hid-generic, with its input registration unchanged through the reload
and resume. HID input names and capabilities were preserved across reboot.
The reboot selected both revised binaries without manual intervention.
The installation journal had no warnings or faults. Resume reinitialized
the USB controller and reset several devices including AMPINEL; the same
warning pattern is present in logs from 2026-08-29, before v3. Both interfaces
recovered without intervention. No Oops, BUG or call trace was found during
resume or reboot. Boot had no AMPINEL failure or USB-controller reset warning;
it retained the expected out-of-tree module notice and existing system
warnings. Live loading used generic-first order; the opposite order is
covered only by the userspace harness. Power-off cold boot and alarm-generated
keys remain untested. Shared-device numeric tests are synthetic. The HID
prerequisite needs review with the AMPINEL patch.

Telemetry units were checked against the device display at idle and under
load. Channel labels are report order. Alarms, protection configuration,
negative hotspot temperatures and other firmware remain unverified.

AI assistance: Codex assisted with the implementation, tests and submission
text; Sparse was used for static analysis.

V2: https://lore.kernel.org/linux-hwmon/20260914220128.287145-1-contact@vasily.cc/

Vas Zayarskiy (4):
  HID: generic: Respect specialized drivers match callbacks
  hwmon: (aquacomputer_d5next) Avoid truncating scaled sensor readings
  hwmon: (aquacomputer_d5next) Expire the initial sensor cache
  hwmon: (aquacomputer_d5next) Add AMPINEL support

 Documentation/hwmon/aquacomputer_d5next.rst |  11 ++
 drivers/hid/hid-generic.c                   |   8 +-
 drivers/hwmon/Kconfig                       |   4 +-
 drivers/hwmon/aquacomputer_d5next.c         | 121 ++++++++++++++++++--
 4 files changed, 132 insertions(+), 12 deletions(-)


base-commit: 46fde107b4e881f179bf02bca69d8a0020561b3c
