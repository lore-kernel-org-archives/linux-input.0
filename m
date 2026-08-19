Received: from mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACAB3D566B
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169526; cv=none; b=YfDq+49pTdYBu37wy0Jrblkmblt24pZweEfDZfUwvR45WPka9oeAsaRKnmcDwsVrMGiWZ+zf8d6fvKsMwFO1miU2U/tK81qmBU232Q62gUvF++EnHbmUSDNK2qXmXxyUuI7Bg9yIwxFUyt4gTr5XprsdJktAwEVvva62dMvsgHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169526; c=relaxed/simple;
	bh=oeXaUn8Szz+Gd04+pFy8uvhhmYoKKM0fkrOYOXL8LrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtUEXvtpGxiprTItRdexx6ueyRzHyjAYKnLGDhsiqMajhs8Fg8MAFDNKp3vJbpT8Rc8a0nSyS9nK1WT/8gA7eQT+JKSS3sp/aOI6OZZgdfh2K011D0PEQYYWZ0ifZgfdNFHa4maeqIY2yX5fd/5CQdRzFU+zfPDJ+jvhC5/DiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YgIbBwa/; arc=none smtp.client-ip=91.218.175.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YgIbBwa/"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oeXaUn8Szz+Gd04+pFy8uvhhmYoKKM0fkrOYOXL8LrM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787169521; v=1; x=1787774321;
 b=YgIbBwa/GZFdYaN7zMk8dFoVTPgKLeAQrvTc/vxZEkVgYuJMSRg5vau4RjcsASA2Ue06b6WG
 MDSWAg5/7a66ksPRYKAR1MpIBPnreDijZbQXUMUZdvTH6YGUvQppcGr444rYd2gTyrk+f1tPrUM
 fFPZkc9u4bvVPE9XEeGgW4xM=
X-Envelope-To: linux-input@vger.kernel.org
Received: from kernel.denis-pc.lan (151.61.14.130)
	by smtp.migadu.com with ESMTPS id 3212c3d8969eaee6;
	Wed, 19 Aug 2026 19:58:41 +0000
X-Mizu-Trace-ID: 3212c3d8969eaee6
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
Subject: [PATCH v2 00/12] HID: asus: add support for ROG Ally handhelds
Date: Wed, 19 Aug 2026 19:58:23 +0000
Message-ID: <20260819195835.1649657-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds support for ROG Ally handhelds in the HID driver for
ASUS devices.

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
   - Force release all vendor buttons (KEY_F19 and KEY_F20 were missing) to prevent "stuck" ghosting on resume
   - Fix misaligned continuation line in hid_asus_ally_raw_event()
   - Reword the 0x0B report comment to avoid a checkpatch "fallthrough" false positive
   - Normalize kernel-doc comments (function name with "()", parameters, Return sections)
  - HID: asus: add gamepad configuration
   - Normalize kernel-doc comments (ally_check_capability(), ally_get_config(), ally_config_create())
  - HID: asus: add vibration strength configuration
   - Normalize the ally_set_vibration_intensity() kernel-doc comment
  - HID: asus: add joysticks inner and outer range configuration
   - Restructure the ally_set_joystick_thresholds() kernel-doc comment
  - HID: asus: add triggers inner and outer range configuration
   - Restructure the ally_set_trigger_ranges() kernel-doc comment
  - HID: asus: add joysticks anti-deadzone configuration
   - Normalize the ally_set_anti_deadzone() kernel-doc comment
  - HID: asus: add support for response curve
   - Normalize the ally_set_joystick_resp_curve() kernel-doc comment
  - HID: asus: add support to force feedback
   - Add a newline after input_set_capability(input, EV_FF, FF_RUMBLE);
   - Convert the ally_x_send_ff_report() comment to kernel-doc
  - HID: asus: add support for gamepad mode
   - Normalize the ally_set_gamepad_mode() kernel-doc comment and convert ally_apply_gamepad_mode() to kernel-doc
  - HID: asus: add support for turbo buttons
   - Normalize kernel-doc comments (ally_set_turbo_params(), ally_create_button_attributes(), ally_remove_button_attributes())
  - HID: asus: add support for btn remapping
   - Convert the comments to kernel-doc
   - Fix an uninitialized variable warning by returning early when the button mappings allocation fails

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

 drivers/hid/hid-asus.c | 4686 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 4525 insertions(+), 161 deletions(-)

-- 
2.47.3

