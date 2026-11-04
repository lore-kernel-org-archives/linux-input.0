Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756407;
	b=3fr+pAuWePRt156hJo7jBDFyBsDtJqrOd64RwVp671En8vq2KhGnroo/gqPFags4IwTV
	 eZlMRXdtN6ZiJAaMvgIUKJaJgzXKvZfMrWULGM8TFdFsfr5BSfQx3XZ0G9cRL3MvxIbMO
	 4cN+BkfZAzFGYtohVhLrhHJfaqUvxAZZBxOh+6TlWD90zQw/Cvq3ITU8lB5YJ16kB6dw4
	 y3j3681gaKclPb2rs3oNhgJASor2iWLg5U5B+pUwxyAwtBCxe+ONdSf+8EAfuTfc9c+GJ
	 ngHuiqe8JpfBL3NoIBu6ZmL3SLR01eOwob+uSoKutNNPHnk1EMibNwN60tkolHKuE6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756407;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RORM8kitLofg01k12wqkIGrs1V61gF56XFbPYnqpa3E=;
	b=tVC56/ksiqJpQDQmfkka59W5BzpHNrSkBcDWL2/91wAC9GaGz9Xq5ogoWDnHTAaAxNC0
	 ehIqfbHvDLX5vcW9TBQGCyZBsXPaxMa/rMsc6IfWuuJGNKAjGEMbNYM1h3FDDz8oX6wr7
	 JhduNXIjBCeIvp+1/oIWbS4Q1Ok/aJPAEeZ3P5WBORX+gx62OHZ7oAymYf9p0QWAc4sL5
	 +fCX8ewjITfq9d/L1RV+S3wgbfEht07g0FkRHwyWVg5h/ue9voLIpu+2X5JrAEQdD55eB
	 qaIVFWosgSfQdWutq2zPUQ8Hl2AKWaMp8BC9ixQ36gSzu5eAzd9wz9koe93ByUCoohQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qoQK8iFD;
	arc=none smtp.remote-ip=91.218.175.184
Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAE606A326
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 01:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FEAE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qoQK8iFD
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fHfJ0zG6oH+Tem/NqDOSouwdN1igvqWseUgBfW6Z0Hc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793756402; v=1; x=1794361202;
 b=qoQK8iFDuAkAkZBwueAnxWdKsPt41Kf6tsLBrXf5Jjqazlqou50lfbiz42goPz1ujFcJaLj3
 lJqNLYsgzB0arELX9nngXpR3iNX7Wq7IMNz6p8NqpYjNNLQVfyqqmBxXZkwlP4yHGSrulodJ5KN
 LuFQLEtCBcLdEa+iIVEx6344=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6cafe6a859b21be9;
	Wed, 04 Nov 2026 01:40:02 +0000
X-Mizu-Trace-ID: 6cafe6a859b21be9
X-Migadu-Flow: FLOW_OUT
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-input@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schwartz" <matthew.schwartz@linux.dev>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Jonathan LoBue" <jlobue10@gmail.com>,
	"Khamunetri Clark" <khamunetriclark@gmail.com>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	"Joshua Leivenzon" <hacker1024@users.sourceforge.net>,
	"Nathan Chancellor" <nathan@kernel.org>,
	=?UTF-8?q?Rebecca=20Mara=20M=C3=BCller?= <rebecca.mara@posteo.de>,
	"Ivan Levchenko" <me@livan.pro>,
	"Corentin Chary" <corentin.chary@gmail.com>,
	"Hans de Goede" <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Denis Benato <denis.benato@linux.dev>
Subject: [PATCH v13 00/18] HID: asus: add support for ROG Ally handhelds
Date: Wed,  4 Nov 2026 01:39:17 +0000
Message-ID: <20261104013935.512713-1-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Link v7: https://lore.kernel.org/all/20260915201314.28279-1-denis.benato@linux.dev/
Link v8: https://lore.kernel.org/all/20260922230205.6847-1-denis.benato@linux.dev/
Link v9: https://lore.kernel.org/all/20261009122820.7603-1-denis.benato@linux.dev/
Link v10: https://lore.kernel.org/all/20261017181520.70206-1-denis.benato@linux.dev/
Link v11: https://lore.kernel.org/all/20261025235232.129945-1-denis.benato@linux.dev/
Link v12: https://lore.kernel.org/all/20261031174130.208240-1-denis.benato@linux.dev/

------------------------------------------------------------------------------------------------

The 13th version is mostly structural work based on the v12 comments, plus one
new patch: the ROG Ally sysfs attributes are now documented in
Documentation/ABI/testing, placed right after the commit that creates them and
before MAINTAINERS... I had it by v12 but forgot to send it... I even answered
the bot pointing to it.

Limited structural changes: mainly ctrl+alt+del handling and AC/CC presses
going to hid core to make things easier to follow and spare some lines.

With usage of macros to compress duplicate code I managed to reduce lines of
code by more than a thousand while also increasing the number of (hopefully)
useful comments and kernel-doc.

The rest is some [Low] feedbacks from sashiko I decided was worth doing.

When I sent v12 I had changed gamepad_mode_index to gamepad_mode_available
to follow bot suggestion: it was a mistake that broke the simmetry with
other handhelds so I switched back to _index.

Also from my local review I was stupid enough to convert a bunch of
scoped_guard to a guard and I introduced a possible deadlock... So
I have reworked that and now sashiko should (hopefully) be happy
and not find other synchronization issues.

This time I used glm-5.3 with sashiko and it is flagging the cross-ally
talk of ally_prefs as Medium, but it is actually intended to be that
way and is explained in the code why it is made the way it is.

The previous sashiko-bot on 01/18 run flagged a feature report misalignment,
I said I wouldn't have changed that, but I did because I misunderstood what
it was telling me: it is now that will flag an issue about query the length
of report 0x5a and sending something else: attempting to fix that will break
the driver.

Hopefully this is the last revision.. I hope I haven't missed anything
else and there are no more weird issues with the mutex.

------------------------------------------------------------------------------------------------

The 12th version is aimed at cleaning up all the weird locking/unlocking machinery
and compressing the code wherever it was natural to do so while also addressing
all comments and suggestions.

I thank all the reviewers for their feedback and suggestions, along with Luytan that
borrowed me an API key for sashiko-bot as I could ensure no medium/high/critical issues
were left unaddressed and low ones are benign.

Given I have made quite a bit of changes I would ask for a second test by at least
Rebecca and Paolo to ensure I hadn't screwed up what was working before:
this is also the reason why I left out Tested-by tags.

------------------------------------------------------------------------------------------------

Version v11 has been more involved and I focused on two main things: extending the
xg mobile (which the ROG ally is one of the few models that supports it) and
properly handling hid packet sizes because it has been a constant source of issues
and fight in the past and I want to put an end to both of those.

I kindly ask Rebecca and Paolo to try using the new asus_report_len() to see if its
also suitable for theirs Zenbook Duo devices and if so to adopt it in theirs patches
as well.

Link of a relevant patchset: https://lore.kernel.org/all/20261020092423.36380-1-p.pisati@gmail.com/

------------------------------------------------------------------------------------------------

Version v10 drops a patch already merged as part of XG mobile and applies the
patchset on top of for-next/7.4.

------------------------------------------------------------------------------------------------

With v8 the driver does sysfs_notify after successfully changing configuration
attributes so that userspace can be notified of the changes immediately.

------------------------------------------------------------------------------------------------

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

------------------------------------------------------------------------------------------------

With v5 I returned to the original manual management of memory and sysfs groups
as going devm did not play well with the general "plugin" architecture of the
ally portion of the driver and has caused more bugs than it solved: sashiko-bot
will have to come to terms with hand-managed memory this time.

------------------------------------------------------------------------------------------------

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

- v8
  - HID: asus: add support for ROG Ally handhelds
    - Release the probe reservation when the interface pointer is
      published: the flags were only cleared on failure, leaving them
      stuck set after the first bind and rejecting every later probe
      of that role
    - Reserve the keyboard interface role too: its check and its
      publication were two separate locked sections, so concurrent
      probes of the same role could both publish
    - Keep the recorded USB device while any probe is still in flight
  - HID: asus: add gamepad configuration
    - Report the missing Xbox controller capability with -EOPNOTSUPP
  - HID: asus: add vibration strength configuration
    - Wake pollers with sysfs_notify() after a successful write
  - HID: asus: add joysticks inner and outer range configuration
    - Wake pollers with sysfs_notify() after a successful write
  - HID: asus: add triggers inner and outer range configuration
    - Wake pollers with sysfs_notify() after a successful write
  - HID: asus: add joysticks anti-deadzone configuration
    - Wake pollers with sysfs_notify() after a successful write
  - HID: asus: add support for response curve
    - Wake pollers with sysfs_notify() after a successful curve write
  - HID: asus: add support to force feedback
    - Clear the rumble update latch on setup so a fresh interface
      cannot inherit one left over from a teardown race
  - HID: asus: add support for gamepad mode
    - Return -EIO for invalid gamepad modes stored in the device
    - Wake pollers with sysfs_notify() after a successful write
  - HID: asus: add support for turbo buttons
    - Wake pollers with sysfs_notify() after a successful write
  - HID: asus: add support for btn remapping
    - Return -EIO if a mapping is ever found unset instead of
      dereferencing it
    - Wake pollers with sysfs_notify() after remap and macro writes,
      and after a mode switch re-defaults the mappings

- v9
  - HID: asus: add support to force feedback
    - Hold intf_mutex while unpublishing the gamepad interface in the
      setup error path, like hid_asus_ally_remove() does
    - Improve gamepad interface device lock around the initialization
      force-feedback send
  - HID: asus: add support for btn remapping
    - Unpublish button_entries under config_mutex before removing the
      attributes and freeing the array

- v10
  - HID: asus: reinitialize the device after exiting a sleep state
    - Dropped as already merged in XG Mobile patchset

- v11
  - HID: asus: add support for ROG Ally handhelds
    - Split the chained data[1] = data[3] = 0x00 assignment into two
      statements
    - Align the hid_asus_ally_raw_event() continuation line with the
      opening parenthesis
  - HID: asus: add gamepad configuration
    - Add the missing blank line between struct hid_driver and
      asus_init()
  - HID: asus: add joysticks inner and outer range configuration
    - Align the sysfs_remove_group() and hid_warn() continuation lines
      with the opening parenthesis
  - HID: asus: add triggers inner and outer range configuration
    - Align the hid_warn() continuation lines with the opening
      parenthesis
  - HID: asus: add joysticks anti-deadzone configuration
    - Align the hid_warn() continuation lines with the opening
      parenthesis
  - HID: asus: add support for response curve
    - Drop the duplicate blank line before ally_config_attrs[]
  - HID: asus: add support to force feedback
    - Add the missing blank line before the static_assert
    - Align the hid_warn() continuation line with the opening
      parenthesis
  - HID: asus: add support for btn remapping
    - Align the hid_warn() and ally_set_button_mapping() continuation
      lines with the opening parenthesis
  - HID: asus: size feature reports from the HID report descriptor
    - New patch
  - HID: asus: identify XG Mobile stations and bind the LED to the
    reported model
    - New patch
  - HID: asus: expose XG Mobile identity and firmware information
    - New patch
  - HID: asus: size ally gamepad commands from the HID report descriptor
    - New patch
  - platform/x86: asus-armoury: pick the eGPU activation from the
    reported GPU
    - New patch
  - HID: asus: report the XG Mobile GPU vendor to asus-wmi
    - New patch
  - MAINTAINERS: add maintainer for the ASUS HID driver
    - New patch

- v12
  - HID: asus: size feature reports from the HID report descriptor
    - First commit in the series. v11 had it after the Ally driver
    - Look reports up in report_id_hash. asus_find_report() is that
      lookup, and asus_has_report_id() is three calls to it after
      rejecting an id of HID_MAX_IDS or more
    - asus_kbd_get_functions() returns -EINVAL when the 0x5A report is
      shorter than 7 bytes, before it reads the flags byte
    - mcu_request_version() sizes the 0x0D response from the descriptor
      and names the request FEATURE_KBD_REPORT_ID
    - Remove ROG_ALLY_REPORT_SIZE as not needed anymore
    - Include linux/container_of.h as asus_xgm_led_set() already calls
      container_of()
  - HID: asus: add support for ROG Ally handhelds
    - One ally_intf per interface. Vendor keys are reported on the
      input device of the interface that received the report
    - The private gamepad input is registered and unregistered by that
      interface.
    - Remove BTN_TRIGGER_HAPPY as it was unused
    - The rumble-off packet is the array ally_force_feedback_off (lowercase)
    - Include linux/compiler_attributes.h for the packed report structs
    - hid_asus_ally_probe() frees the interface with __free(kfree) and
      returns no_free_ptr()
    - Commands are allocated from the FEATURE_KBD_REPORT_ID length.
      ally_dev_set_report() calls asus_kbd_set_report(), so a short
      payload is padded to the descriptor length. The init rumble-off
      packet starts with 0x0D and is padded to the length of report
      0x0D. ally_dev_get_report() reads HID_ALLY_GET_REPORT_ID through
      asus_kbd_get_report()
    - ally_gamepad_check_ready() sleeps after a failed transfer as well
    - HID_ALLY_X_INPUT_REPORT_SIZE is not defined.
      hid_asus_ally_raw_event() does not take the unused struct
      hid_report. The kernel-doc @ally lines are gone
    - handle_ctrl_alt_del() names the boot-protocol offsets
      (HID_INPUT_REPORT_ID_OFFSET, HID_INPUT_MODIFIER_OFFSET,
      HID_INPUT_RESERVED_OFFSET, HID_INPUT_KEY_OFFSET) and the modifier
      and key bytes. Its kernel-doc says true means the buffer was
      rewritten and ally processing of that report stops
    - KEY_PROG1 and KEY_F16-F19 are set in asus_input_mapping(), before
      input_register_device(). KEY_F19 is the second event of usage
      0x38
  - HID: asus: add gamepad configuration
    - The cache is the static ally_prefs. A comment on it says one set
      is by design: the controller is part of the PC, and a second HID
      device only appears when one is emulated with uhid
    - Payloads passed to ally_alloc_cmd() are const
    - hid_asus_ally_init() holds ally_prefs.lock with one guard().
      ally_prefs_setup() does the same from the capability stores
      through sysfs_live
    - ally_sysfs_remove() is its own call and runs before hid_hw_stop
    - The message names xbox_controller and says hid_asus_ally_reset_resume()
      can fail with -ENODEV. The comment in that function about
      initialization already having been performed is gone
  - HID: asus: add vibration strength configuration
    - The intensity fields, the attributes, and the restore path are
      born on ally_prefs
    - ally_set_vibration_intensity() has a kernel-doc comment. The lock
      requirement is in the Context section
  - HID: asus: add joysticks inner and outer range configuration
    - The threshold fields, the attributes, and the restore path are
      born on ally_prefs. The calibration groups are created only when
      user_cal_support is set
    - ally_sysfs_remove() takes ally_prefs.lock with guard() and holds
      it until the function returns, so the calibration-group removal
      reads the capability flags under the mutex
  - HID: asus: add triggers inner and outer range configuration
    - The trigger fields, the attributes, and the restore path are born
      on ally_prefs, under the same calibration-group gate
  - HID: asus: add joysticks anti-deadzone configuration
    - The attributes are born on the joystick groups. The calibration
      gate includes anti_deadzone_support
    - The command buffer is declared with __free(kfree) on the
      ally_alloc_cmd() line. The capability test stays above that
      declaration
  - HID: asus: add support for response curve
    - The curves, the attributes, and the restore path are born on
      ally_prefs. The calibration gate includes resp_curve_support
    - response_curve_store() parses eight values with
      ally_parse_u8_token(), which copies each token out of the write,
      bounds it by count, and parses it with kstrtou8(). After the
      eighth value every remaining byte is checked, and a non-space
      byte, including an embedded NUL, is rejected
    - ally_set_joystick_resp_curve() has a kernel-doc comment, with the
      lock requirement in the Context section
  - HID: asus: add support to force feedback
    - Rumble state, the work, and rumble-off live on the gamepad
      interface. The off packet is sent on that interface's own hdev.
      There is no snapshotted ally_x_hdev
    - ally_ff_quiesce() runs before hid_hw_stop
    - select INPUT_FF_MEMLESS in config HID_ASUS is indented with a tab
  - HID: asus: add support for gamepad mode
    - Changed gamepad_mode_index to gamepad_mode_available to follow conventions
    - The mode byte and the attribute are born on ally_prefs.
      ally_prefs_setup() stores ALLY_GAMEPAD_MODE_GAMEPAD as the
      initial mode
    - The command buffer is declared with __free(kfree) on the
      ally_alloc_cmd() line
    - gamepad_mode_store() returns the sysfs_match_string() error for
      an unknown mode and does not log it
    - ally_set_gamepad_mode() has a kernel-doc comment, with the lock
      requirement in the Context section
  - HID: asus: add support for turbo buttons
    - The turbo parameters and attributes are born on ally_prefs. The
      button attributes do not carry an Ally back-pointer
  - HID: asus: add support for btn remapping
    - Changed btn_remap_index to btn_remap_available to follow conventions
    - The mapping cache and the attributes are born on ally_prefs. The
      button attributes do not carry an Ally back-pointer. Mappings are
      applied on the configuration interface under ally_prefs.lock
    - ally_encode_button_code() writes one code into a slot of
      ASUS_ALLY_BTN_FUNCTIONS_LEN (11) bytes. ally_set_button_mapping()
      calls it at offsets 5, 16, 27 and 38. A type of 0 writes only the
      type byte
    - ally_apply_button_mappings() says the caller holds
      ally_prefs.lock
    - gamepad_mode_store() takes that mutex once, with guard(), and
      holds it until the function returns. The mode update, the
      default-mapping refresh, and the notifies all run under that
      lock. The store notifies remap_index together with remap and
      macro
    - button_remap_store() restores the previous code through
      err_restore. On a first-generation device, a pair that already
      reached the hardware is pushed back through err_restore_hw
  - HID: asus: identify XG Mobile stations and bind the LED to the
    reported model
    - Identity fields are copied by tag (MB, SN, PRO, PNUM)
    - The LED name is asus:xgm-<model>-<uniq>:led. The second field is
      hdev->uniq when that string is non-empty, and dev_name(&hdev->dev)
      otherwise
    - ASUS_XGM_QUERY_VERSION is not defined in this commit
    - asus_xgm_get_identity() is tried three times, with ssleep(1)
      between attempts. The LED stays unregistered only when all three
      fail. An unsupported model is not retried
  - HID: asus: expose XG Mobile identity and firmware information
    - ASUS_XGM_QUERY_VERSION is defined next to the identity query
    - A version field is a 3-character tag, a length byte, and the data
  - HID: asus: document ROG XG Mobile sysfs attributes
    - New patch. Documents xgm_model, xgm_serial, xgm_mainboard,
      xgm_part_number, xgm_firmware_version and xgm_generation
  - platform/x86: asus-armoury: pick the eGPU activation from the
    reported GPU
    - This commit also reports the GPU vendor. v11 had that report in
      the following commit
    - The version payload's four PCI IDs are stored high byte first.
      asus_wmi_egpu_set_vendor() receives the 16-bit vendor
    - The message records that the WMI method returned 1 for every
      activation value, that 0x0001, 0x0101 and 0x0201 are NVIDIA, AMD
      and Intel, and that known tools only write 1
    - Removing the station stores 0, and the next activation uses the
      default
    - egpu_vendor_lock covers that one word. The armoury store reads
      the vendor inside egpu_mutex. The getter takes egpu_vendor_lock
      and drops it before returning
  - MAINTAINERS: add maintainer for the ASUS HID driver
    - The entry also lists Documentation/ABI/testing/sysfs-driver-hid-asus
  HID: asus: size ally gamepad commands from the HID report descriptor
    - Dropped. The descriptor-length commit sizes mcu_request_version(),
      and the Ally commits allocate their commands from
      FEATURE_KBD_REPORT_ID
  HID: asus: report the XG Mobile GPU vendor to asus-wmi
    - Dropped as its own commit. Joined into the armoury commit

- v13
  - HID: asus: size feature reports from the HID report descriptor
    - mcu_request_version() names the keyboard report FEATURE_KBD_REPORT_ID
    - Tested-by added in commit message
  - HID: asus: add support for ROG Ally handhelds
    - Drop the linux/types.h include added in v12
    - KEY_F19 dropped: it was a leftover that went unnoticed
    - ally_vendor_keys() consumes only the vendor codes (0x38, 0xA6, 0xA7
      and 0xA8): the 0x00 report that releases the keys reaches hid-core,
      which can only release the usages it saw pressed.
    - Updated the kernel-doc for the AC and CC short and long press codes
    - handle_ctrl_alt_del() requires the four bytes it reads
    - ally_quiesce() disables the resume work instead of only cancelling
      it, so a concurrent asus_resume() cannot re-queue after the cancel
    - New hid_asus_ally_terminate(): code compression
    - asus_raw_event() declares the intf pointer once at the top instead
      of inside the size check
  - HID: asus: add gamepad configuration
    - ally_check_capability() returns int and ally_detect_capabilities()
      propagates failures through an error label
    - ally_set_xbox_controller() has a kernel-doc comment and tests
      xbox_controller_support before allocating the command buffer
    - ally_prefs_setup() takes the ally_intf: sysfs_live is
      intf->sysfs_live now, and ally_sysfs_remove() takes the interface
      and returns early without one
    - The sysfs groups are created and removed without ally_prefs.lock:
      this prevents a deadlock
  - HID: asus: add vibration strength configuration
    - The store is bounded by ASUS_ALLY_VIBRATION_INTENSITY_MIN/MAX
      instead of a hard-coded 100, and the range files print those macros
      instead of "0 100"
    - The four per-side callbacks collapse into
      ally_vibration_intensity_show() and ally_vibration_intensity_store()
      over an enum ally_vibration and the ALLY_VIBRATION_FUNCS generator:
      the store snapshots both values under the lock and sends them
      together
  - HID: asus: add joysticks inner and outer range configuration
    - ally_set_joystick_thresholds() has a kernel-doc comment
    - The four threshold callbacks collapse into ally_threshold_show()
      and ally_threshold_store() and the ALLY_THRESHOLD_FUNCS generator,
      bounded by the new ASUS_ALLY_INNER_THRESHOLD_MIN/MAX and the
      existing outer macros, which the range files print too
    - The calibration groups are created when any of user_cal_support,
      anti_deadzone_support or resp_curve_support is set, read under the
      mutex: v12 grew that gate one capability at a time in the following
      commits
    - A failure while creating them unwinds through the new
      err_cal_groups label, and intf->cal_sysfs_live records whether they
      exist
    - ally_sysfs_remove() removes the calibration groups based on
      intf->cal_sysfs_live instead of re-reading the capability flags
  - HID: asus: add triggers inner and outer range configuration
    - ally_set_trigger_ranges() has a kernel-doc comment
    - The generated block does not carry trailing spaces on its blank
      lines anymore
  - HID: asus: add joysticks anti-deadzone configuration
    - The store is bounded by ASUS_ALLY_ANTI_DEADZONE_MIN/MAX instead of
      a hard-coded 100, and the range file prints those macros instead of
      "0 100"
    - The calibration gate for this commit is gone: the joystick commit
      already covers anti_deadzone_support
  - HID: asus: add support for response curve
    - The curve structs are defined before struct ally_prefs, and the
      "one set by design" comment moved onto ally_prefs: it now also says
      the settings survive the controller powering off and coming back,
      that no device or input pointers live there, and that a second
      device emulated with uhid would be rejected by the driver
    - The calibration gate for this commit is gone for the same reason
  - HID: asus: add support to force feedback
    - ally_ff_quiesce() runs from hid_asus_ally_terminate() instead of
      from the asus_probe() error path and asus_remove()
  - HID: asus: add support for gamepad mode
    - gamepad_mode_available is renamed back to gamepad_mode_index to
      align with other handheld drivers, and the commit message says so
  - HID: asus: add support for turbo buttons
    - button_entries lives in struct ally_intf instead of ally_prefs
    - ally_create_button_attributes() reads turbo_support under
      ally_prefs.lock instead of unlocked
    - ally_set_turbo_params() sends the ally_turbo_config struct itself
      as the payload instead of a hand-built initializer list, and its
      kernel-doc gained the @hdev and Context sections
    - The turbo and toggle period callbacks collapse into
      ally_btn_period_show() and ally_btn_period_store() over an enum
      ally_btn_period and the ALLY_BTN_PERIOD_FUNCS generator, and the
      range files print the real bounds instead of a hard-coded "0 255"
    - The button attributes are created without the turbo_support gate:
      the next commit decides where the turbo attributes go, and
      intf->button_entries is published under the mutex together with
      cal_sysfs_live and sysfs_live
    - ally_sysfs_remove() unpublishes intf->button_entries under the
      mutex and removes the groups outside of it, so a mode-store notify
      holding the lock sees either the live array or NULL
  - HID: asus: add support for btn remapping
    - The attribute listing the valid remap targets is named
      remap_available: v12 called it remap_index, and the commit message
      follows
    - ally_create_button_attributes() no longer returns NULL when turbo
      is unsupported: entries_attr_index is computed under the lock and
      the turbo attributes are appended only when supported
    - gamepad_mode_store() notifies remap, macro and remap_available
      outside ally_prefs.lock over the static ally_button_names[] instead
      of iterating the button entries under the lock: the mode update and
      the default-mapping refresh stay under it
    - ally_prefs_setup() applies the recorded mappings whenever
      initialized: the button_entries test is gone since the entries
      always exist
  - HID: asus: document ROG Ally sysfs attributes
    - New patch

Denis Benato (17):
  HID: asus: size feature reports from the HID report descriptor
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
  HID: asus: identify XG Mobile stations and bind the LED to the
    reported model
  HID: asus: expose XG Mobile identity and firmware information
  HID: asus: document ROG XG Mobile sysfs attributes
  platform/x86: asus-armoury: pick the eGPU activation from the reported
    GPU
  MAINTAINERS: add maintainer for the ASUS HID driver

Denis Benato (18):
  HID: asus: size feature reports from the HID report descriptor
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
  HID: asus: identify XG Mobile stations and bind the LED to the
    reported model
  HID: asus: expose XG Mobile identity and firmware information
  HID: asus: document ROG XG Mobile sysfs attributes
  HID: asus: document ROG Ally sysfs attributes
  platform/x86: asus-armoury: pick the eGPU activation from the reported
    GPU
  MAINTAINERS: add maintainer for the ASUS HID driver

 .../ABI/testing/sysfs-driver-hid-asus         |  484 ++
 MAINTAINERS                                   |    7 +
 drivers/hid/Kconfig                           |    1 +
 drivers/hid/hid-asus.c                        | 4373 ++++++++++++++++-
 drivers/platform/x86/asus-armoury.c           |   57 +-
 drivers/platform/x86/asus-wmi.c               |   43 +
 include/linux/platform_data/x86/asus-wmi.h    |   11 +
 7 files changed, 4862 insertions(+), 114 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-asus

-- 
2.47.3

