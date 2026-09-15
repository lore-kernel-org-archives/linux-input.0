Received: from mta0.migadu.com (out-71.mta0.migadu.com [91.218.175.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754584570EC
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789503212; cv=none; b=j/nOT4889uv2oZqXSnP6rADakSOaF9NnfV8APV5j3VNqYbf/uuwZ3vP6ncBZjpD3fefxY98FlGWfA+KCoi2+DUme3szIOQW7ZVDh7+gy/ztcT9BaFCoseFzlYuJ+qbAgUMeypIfx7r2nXyLxV3JSA9tFa3H1A3R+HuUHiFtvBF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789503212; c=relaxed/simple;
	bh=UFqJeceWqH5H3QvUGn6lT2CBFLcxM0Y8gkK9PgsoSOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bv0Pw01I0LPnkxArxNjOHzIhwDbkvuARcrjKOWldp4Kvu9yJCgNfrW7wbgKXGNsOnlY2sYmYKS+YveG3QpaCj1lxGfAJWywAo1Nd6q6s0D7cpp7zhxUzFuaQ+ZwB/CStLFHQ/nm+8YlUaOzTmxjMoi1ZABn31Kz4uIsUDOHXzCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j8HW3Sd5; arc=none smtp.client-ip=91.218.175.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j8HW3Sd5"
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UFqJeceWqH5H3QvUGn6lT2CBFLcxM0Y8gkK9PgsoSOg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789503204; v=1; x=1790108004;
 b=j8HW3Sd5gGdwi8ladymMj4FXLVS22IMXUEIGfR29g4oy3cJyA+GNOVLO4EoKF/PRhYcp3nq6
 tgo0qj5S6T7E0gwGdd3YY4UzJZmY6h6oWAauA/+HT3S1qgD+SBqsLD1qb7KsW0Vj5s7kjg5rkdX
 M4verTQiju7/yQ4CQ+Y5bcWE=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 410e2d08d661555f;
	Tue, 15 Sep 2026 20:13:24 +0000
X-Mizu-Trace-ID: 410e2d08d661555f
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
Subject: [PATCH v7 00/12] HID: asus: add support for ROG Ally handhelds
Date: Tue, 15 Sep 2026 20:13:02 +0000
Message-ID: <20260915201314.28279-1-denis.benato@linux.dev>
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
Link v5: https://lore.kernel.org/all/20260904145845.184887-1-denis.benato@linux.dev/
Link v6: https://lore.kernel.org/all/20260908174433.74260-1-denis.benato@linux.dev/

With v7 the series is rebased on top of the asus tree: the first patch of v6
has been applied upstream as 8099f9da59f1 ("HID: asus: do not send keyboard
init reports to touchpads"), so this series is now 12 patches.

The probe paths of the ally interfaces now reserve the interface role while
their initialization is running, the configuration attributes work from the
moment their files exist and a failed initialization rolls the configuration
back instead of leaving the created sysfs groups behind. The response curve
is no longer configured entry by entry: a single attribute per joystick now
takes the whole curve in one validated write, and a companion index file
documents what each value is.

With v5 I returned to the original manual management of memory and sysfs groups
as going devm did not play well with the general "plugin" architecture of the
ally portion of the driver and has caused more bugs than it solved: sashiko-bot
will have to come to terms with hand-managed memory this time.

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

- v6
  - HID: asus: add support for ROG Ally handhelds
    - Add a maximum size check in ally_alloc_cmd()
    - Drop the dead x_hdev snapshot taken in hid_asus_ally_raw_event()
    - Drop the unused hdev parameter of handle_ctrl_alt_del()
    - Drop the unused hdev/report parameters of ally_x_raw_event()
    - Turn the "// F20;" comment into a proper "/* F20 */"
  - HID: asus: add gamepad configuration
    - Publish the configuration (ally->config under ally_data_lock)
      before the sysfs groups are created and withdraw it on the error
      path: attributes could become visible while ally_get_config()
      still returned NULL and the restore path silently did nothing
    - Record the Xbox controller mode in the first-setup defaults and
      apply the recorded value from hid_asus_ally_init()
    - properly rebase ally_alloc_cmd(): make it no change from previous patch
  - HID: asus: add joysticks inner and outer range configuration
    - Drop the unused cfg parameter of ally_set_joystick_thresholds()
  - HID: asus: add triggers inner and outer range configuration
    - Drop the unused cfg parameter of ally_set_trigger_ranges()
    - Fix a commit message typo: "sensitivity"
  - HID: asus: add support for response curve
    - Add ally_resp_curve_is_valid() and use it in the init/resume
      restore path exactly like the apply path does
    - Drop the unused struct device * parameter of the four
      response-curve helpers
  - HID: asus: add support to force feedback
    - Drop the unused pointers from ally_x_send_ff_report() and ally_x_send_ff_off()
  - HID: asus: add support for gamepad mode
    - Apply the mode exactly once from hid_asus_ally_init()
  - HID: asus: add support for turbo buttons
    - Remove the calibration groups created before a sysfs failure
  - HID: asus: add support for btn remapping
    - Do not gate remapping by turbo
    - Reject NULL remap/macro pointers in ally_set_button_mapping()
    - Carry the ally pointer in struct button_remap_attr
    - Fix the "hypen" comment typo

- v7
  - The "HID: asus: do not send keyboard init reports to touchpads" patch
    is not part of this series anymore: it has been applied upstream as
    8099f9da59f1 and the series is rebased on top of it
  - HID: asus: add support for ROG Ally handhelds
    - Reserve the probed interface role for the whole duration of its
      sleeping initialization: a concurrent probe of the same role could
      pass the singleton checks before the first one published its pointer
  - HID: asus: add gamepad configuration
    - Publish drvdata->rog_ally before the configuration attributes are
      created: the callbacks fetched it before asus_probe() published it
      and returned -ENODEV in the meantime
    - Roll the configuration back with ally_config_remove() when
      hid_asus_ally_init() fails, instead of leaking the created sysfs
      groups and the button entries
  - HID: asus: add support for response curve
    - Replace response_curve_pct_1..4, response_curve_move_1..4 and the
      apply attributes with one response_curve attribute per joystick that
      takes the whole curve in a single validated all-or-nothing write:
      staged partial edits reaching the MCU on resume cannot happen anymore
    - Add a read-only response_curve_index attribute documenting the
      meaning of each value
    - Restore both curves unconditionally on init/resume: only validated
      curves are recorded now
  - HID: asus: add support for btn remapping
    - Drop the stale cfg->turbo_support gate in ally_config_create():
      remapping attributes are created for every device with button
      directories, not only turbo-capable ones

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

 drivers/hid/Kconfig    |    1 +
 drivers/hid/hid-asus.c | 5068 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 4906 insertions(+), 163 deletions(-)

-- 
2.47.3

