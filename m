Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A0446067
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 15:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534083; cv=none; b=Oht+9pkLwgGV2kjsN1afofkLICB3c06w8jgLagaMc4PS1rTYUy0wNREC0z/517lJ/cIj+D8L5YmC3Uhd8Bwue2VsTA6VOwEmbztFB97Kxy6qGqnzud1BK/xxNXU7KWC649cNgzzv89HPuEF5OR8liCqMSyxM6iqBBEO6GlrjYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534083; c=relaxed/simple;
	bh=H0nn9GjKNpyMnda8tNfJxZX5pvuFIPJvfSLrJmBp0E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VBzCUZdSEMbSyMxSA3DntPp/R0VCbwf0cYOxh++c0O0o+Vs8/AhazUXD48fSVjzNYN27fLs5UZal0VIb0Xgcrnabj6rGd4TvyeLIJFF8Gw5u9nrKr3RO4Cq2QrxgkrYAtTRgtV4jcvPCnrwDuEpsG34+VtmBV4rmU03Tj9elDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iBcy/cfN; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iBcy/cfN"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=H0nn9GjKNpyMnda8tNfJxZX5pvuFIPJvfSLrJmBp0E0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788534076; v=1; x=1789138876;
 b=iBcy/cfNeO4nb7JpIlKU8BNOBWmF3qSNN4qJB/sm+jZ7VWfJ/rh0THij0FhWP//VzE5G/c5Q
 SetKsnJpxR/+rZuHJ3IdklzH26Cvg8kA+0mSY9VhhFejeYzzdTvKynbIs2WIDiGTHC+hUwqPFIa
 EOeB2M9ZP8DfzY5adEJUA+cQ=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f361bae1e3b03016;
	Fri, 04 Sep 2026 15:01:06 +0000
X-Mizu-Trace-ID: f361bae1e3b03016
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
Subject: [PATCH v5 00/13] HID: asus: add support for ROG Ally handhelds
Date: Fri,  4 Sep 2026 14:58:31 +0000
Message-ID: <20260904145845.184887-1-denis.benato@linux.dev>
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

Link v1: https://lore.kernel.org/all/20260813144736.2477941-1-denis.benato@linux.dev/
Link v2: https://lore.kernel.org/all/20260819195835.1649657-1-denis.benato@linux.dev/
Link v3: https://lore.kernel.org/all/20260823185849.2478673-2-denis.benato@linux.dev/
Link v4: https://lore.kernel.org/all/20260830234320.114356-1-denis.benato@linux.dev/

With v5 I returned to the original manual management of memory and sysfs groups
as going devm did not play well with the general "plugin" architecture of the
ally portion of the driver and has caused more bugs than it solved: sashiko-bot
will have to make itself like hand-managed memory this time.

Changelog:

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

- v5
  - HID: asus: add support for ROG Ally handhelds
    - Fix UAF due to inverted input device ownership in hid_asus_ally_remove()
    - Reject probes claiming an interface role that is already owned
  - HID: asus: add gamepad configuration
    - Keep the configuration allocated until module removal instead of
      devm-managing it: the sysfs callbacks must be able to outlive probe
    - Undo sysfs group creation manually on the error path and in
      ally_config_remove(): creation and removal are now symmetric
    - Add payloads size check in ally_alloc_cmd()
  - HID: asus: add vibration strength configuration
    - Restore the cached vibration intensity after an MCU reset
  - HID: asus: add joysticks inner and outer range configuration
    - Restore the cached joystick thresholds after an MCU reset
    - Remove the calibration sysfs groups manually like the other ones
  - HID: asus: add triggers inner and outer range configuration
    - Restore the cached trigger ranges after an MCU reset
  - HID: asus: add joysticks anti-deadzone configuration
    - Restore the cached anti-deadzone values after an MCU reset
  - HID: asus: add support for response curve
    - Restore the cached response curves after an MCU reset
    - Keep holding config_mutex until the curve packet has been sent
  - HID: asus: add support to force feedback
    - Serialize the cross-interface force-feedback sends with the gamepad
      interface removal by holding intf_mutex in the callers
  - HID: asus: add support for gamepad mode
    - Restore the recorded gamepad mode after an MCU reset
  - HID: asus: add support for turbo buttons
    - Fix UAF allocating the turbo button entries with kcalloc
    - Restore the cached turbo parameters after an MCU reset
  - HID: asus: add support for btn remapping
    - Keep the button mappings outside of the controller lifetime, so
      that the recorded configuration survives a re-probe
    - Re-apply the recorded mappings after an MCU reset
    - Fetch the configuration through ally_get_config()

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
 drivers/hid/hid-asus.c | 5197 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 5039 insertions(+), 159 deletions(-)

-- 
2.47.3

