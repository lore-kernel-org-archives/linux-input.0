Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9042EEE60
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788133409; cv=none; b=Zf4PYeAFNU1RLzqx+7hsEFInmytty5qBopYbWp0Omz/+RIMYqpO9tt20LRAUPNep4oA8rH9Afz2DBT6onAxSL6xWmEBL+5Dya4FGKBgXnV9A5/ktlNhZjhBZEWFdeYW/k+Bi1hYXzX2NRGWSluFuOeonM2xeVis2itC75ZzDoqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788133409; c=relaxed/simple;
	bh=Q0L86DQgdKGZxnvz2LuexXaV2DU+Sx66oeqQVgrhoFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UtGT46reQG9ISLOxNug++bzJVWSbVaMv93iRtNapO0l9P2cR/Wq3wJrT8v/4a1QPncKKFfqfE+1rUuHQXNiPug39vBAbohNciZGz2SK5TGLMYu49zdl9JsKuUupa/In92m6HWo9f3MvB+hXONh+oq1hA2mtX+Vf/0J+mvFajmck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qGDQczUm; arc=none smtp.client-ip=95.215.58.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qGDQczUm"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Q0L86DQgdKGZxnvz2LuexXaV2DU+Sx66oeqQVgrhoFE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788133403; v=1; x=1788738203;
 b=qGDQczUmXe1VkOT5ZWrEVris4Ab3bhoNED17DyrDC8AMS9Oa0uB8kHk9f/N14LdJIvwH3glC
 luXt/UlrPSmaDap55/ujdx6sJS6J37QfaWqTEC/+8lpMqBl4w0MLqy3QxqnzCnIVPzeYfZFwT1m
 zebAM3lOb+lhxFNj9gW2iz0g=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dff9053847b265dd;
	Sun, 30 Aug 2026 23:43:23 +0000
X-Mizu-Trace-ID: dff9053847b265dd
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v4 00/13] HID: asus: add support for ROG Ally handhelds
Date: Sun, 30 Aug 2026 23:43:07 +0000
Message-ID: <20260830234320.114356-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds support for ROG Ally handhelds in the HID driver for ASUS devices.

The changes include reinitialization of the device after exiting a sleep state,
gamepad configuration, vibration strength configuration, joysticks and triggers
range configuration, anti-deadzone configuration, response curve support,
force feedback support, gamepad mode support, turbo buttons support,
and button remapping support.

This driver is based on the original Luke's work, which was a great starting point
and I have reworked it to be upstreamable, while keeping the original functionality
intact and extending hid-asus to avoid regressions in functionality such as the
backlight control.

The ally support has been a surprisingly long task, spanning multiple years and
being used in Steam OS and well as other distributions for quite a while,
and I am happy to finally be submitting it.

At this time LEDs are not part of the patch series as I have work in progress to
unify LEDs handling across all ASUS devices, and I will submit that in a separate
patch series when the userspace interface will be ready to express capabilities
of these devices, but that will take some more time.

This driver is the culmination of a lot of work, from many different people,
and I want to thank Luke for his original work, as well as the many people that have
helped me test and provide feedback on the driver: Khamunetri, Jonathan, Derek,
Matthew and others that have helped during these years.

Best regards,
Denis Benato

-v2
  - HID: asus: add support for ROG Ally handhelds
   - release all vendor buttons on resume
   - align arguments of hid_asus_ally_raw_event()
  - HID: asus: add gamepad configuration
   - clean up comments and kernel-doc
  - HID: asus: add vibration strength configuration
   - clean up comments and kernel-doc
  - HID: asus: add joysticks inner and outer range configuration
   - clean up comments and kernel-doc
  - HID: asus: add triggers inner and outer range configuration
   - clean up comments and kernel-doc
  - HID: asus: add joysticks anti-deadzone configuration
   - clean up comments and kernel-doc
  - HID: asus: add support for response curve
   - normalize kernel-doc comment
  - HID: asus: add support to force feedback
   - remove a stale comment
  - HID: asus: add support for gamepad mode
   - remove a stale comment, normalize kernel-doc
  - HID: asus: add support for turbo buttons
   - remove stale comments, normalize kernel-doc
  - HID: asus: add support for btn remapping
   - convert function comments to kernel-doc

-v3
  - HID: asus: add support for ROG Ally handhelds
   - take references on input devices to avoid use-after-free on unbind
   - reject probes from USB devices other than the recorded controller
   - add open/close callbacks to the gamepad input device
   - keyboard_input is populated after hid_hw_start(): issue does not apply
  - HID: asus: add gamepad configuration
   - restore cached Xbox controller mode after an MCU reset
   - convert remaining scoped_guard() users to guard()
   - avoid printing "(null)" for unnamed sysfs groups
  - HID: asus: add vibration strength configuration
   - send MCU commands through ally_gamepad_send_packet()
  - HID: asus: add joysticks inner and outer range configuration
   - send MCU commands through ally_gamepad_send_packet()
   - gate sysfs groups and callbacks on capabilities
  - HID: asus: add triggers inner and outer range configuration
   - send MCU commands through ally_gamepad_send_packet()
   - gate sysfs groups and callbacks on capabilities
  - HID: asus: add joysticks anti-deadzone configuration
   - send MCU commands through ally_gamepad_send_packet()
   - gate sysfs groups and callbacks on capabilities
  - HID: asus: add support for response curve
   - send MCU commands through ally_gamepad_send_packet()
   - check resp_curve_support in show callbacks too
  - HID: asus: add support to force feedback
   - read ally_x_hdev under ally_data_lock and take a reference on it
   - publish ally_x_hdev before registering the input device
  - HID: asus: add support for gamepad mode
   - convert remaining scoped_guard() users to guard()
  - HID: asus: add support for turbo buttons
   - pass the config pointer directly to ally_config_remove()
   - run ally_config_remove() outside ally_data_lock
   - restore cached values when the hardware rejects an update
   - check turbo_support in show callbacks too
   - reported scoped_guard warning verified as false positive
  - HID: asus: add support for btn remapping
   - look up default mappings by name instead of array index
   - resend the old mapping when a sequential update fails midway
   - allow macros regardless of the gamepad mode
   - rename PAD_* codes to proper input event names
   - convert remaining scoped_guard() users to guard()

- v4
  - HID: asus: do not send keyboard init reports to touchpads
    - Added to avoid regressting touchpads and as guidance for maintainers
  - HID: asus: reinitialize the device after exiting a sleep state
    - Follow the modified logic of the previous patch
  - Addressed issues of sashiko-bot albeit one was a false positive
  - Rework patches: I made some disasters rebasing in v3

Denis Benato (12):
  HID: asus: reinitialize the device after exiting a sleep state
  HID: asus: add support for ROG Ally handhelds
  HID: asus: add gamepad configuration
  HID: asus: add vibration strength configuration
  HID: asus: add joysticks inner and outer range configuration
  HID: asus: add triggers inner and outer range configuration
  HID: asus: add joysticks anti-deadzone configuration
  HID: asus: add support for response curve
  HID: asus: add support to force feedback
  HID: asus: add support for gamepad mode
  HID: asus: add support for turbo buttons
  HID: asus: add support for btn remapping

Panz Dev (1):
  HID: asus: do not send keyboard init reports to touchpads

 drivers/hid/Kconfig    |    1 +
 drivers/hid/hid-asus.c | 5007 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 4848 insertions(+), 160 deletions(-)

-- 
2.47.3

