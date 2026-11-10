Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276075;
	b=jigSDnjoQjUR0UIw5EpfjWTuR77sIjgQlanq0ECGthcdudJrfSQPkFgsxKk/R1NVUmWT
	 M/NX177KKxB5QRbXMML8oK615bmN5Mcs4b7TT9pFTftEdKohB1cy11TygYAF9m0cTiNZz
	 oXzVSHvsPwmpIHBmt9S3QJSjDKT2nbIPhfjOwt5xUsLM8YNj6IA6UrNGqpEif81CgXsUH
	 KD9nv5/RGtcmVfnzab0vi6ipzd/jgjNBZ10BG80fWS7OI/nJe/VW+SAatZO0wcCAs9lHX
	 pKbbu8AoQVN5wxziI2XYVcOqLG3HvNt+8wIYSffGVMQwUiRMT5iu5Y+rcqhoj4ttNMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276075;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gxc1O/IrSzA0ZBAxGSkHNev7+DO88ESpjBA/745lot8=;
	b=PUIkVY0Zc1pIp3jF8//kNwkOOf7Vnszx//78BO7KzsT+LTLWrQGZ7gcWTBIOLur8DqY/
	 KkjAewmTjVIEI6YTKE81Ks52UZmfxj9E55GF30FONqQubWPUrFoAShX/DxLNpi4XcYfol
	 /908NnPSXgGbvUwUZauL4Z5Z4WvnbPhNHaJ4pPtKr7JOJ4ejnbo1D3di2p2qQNCkIn9FQ
	 hNM2x/14ffCmngZkvrb8HRVrtLY4AdOm33fxeNayCi8xjitzqA4NOA4zAo+HnCm6zjA9o
	 zDFxyYWpE8gaHf1umUNKY6haaeM4LjLVAHeiyCwQ8+8yeWsA8A77RrXjPZKAfx7zCaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bHTatz0B;
	arc=none smtp.remote-ip=95.215.58.197
Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F460A6F70
	for <linux-input@vger.kernel.org>; Tue, 10 Nov 2026 02:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D3F460A6F70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bHTatz0B
X-Envelope-To: linux-input@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xjYeWvN0yA9r0bljBcsMh+pq7nf1KQ/syQfV3aKQR3o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794276072; v=1; x=1794880872;
 b=bHTatz0BD9qtYlJHhIU0bEceTotF544g00hDmOCmCrvX13s4PMnhYHaCBnPnfMR2JeogUfSN
 3+O2ylsw/1DriZiOdky6E9b1wFCkMM1JBOe5IO/1SwS32pMTkmH0QOSsFpqstVkoz1bfFtGopVK
 mXrLrH3dZtdUhfUFsaGXy0oM=
X-Envelope-To: linux-input@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1a7a0e4bacf429e8;
	Tue, 10 Nov 2026 02:01:12 +0000
X-Mizu-Trace-ID: 1a7a0e4bacf429e8
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
Subject: [PATCH v15 16/18] HID: asus: document ROG Ally sysfs attributes
Date: Tue, 10 Nov 2026 02:00:34 +0000
Message-ID: <20261110020036.112884-17-denis.benato@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110020036.112884-1-denis.benato@linux.dev>
References: <20261110020036.112884-1-denis.benato@linux.dev>
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

The driver publishes the gamepad configuration of the ROG Ally
handhelds through sysfs: the controller emulation and the
operating mode, the per-motor vibration strength, the per-axis
joystick calibration (dead zone, outer threshold, anti-dead
zone and response curve), the trigger activation ranges, and
the per-button mapping, macro and turbo settings.

Document each file: where it is created, what a read returns,
which values a write accepts, and the error returned when the
controller lacks the capability.

Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 .../ABI/testing/sysfs-driver-hid-asus         | 396 ++++++++++++++++++
 1 file changed, 396 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-asus b/Documentation/ABI/testing/sysfs-driver-hid-asus
index 30e0d17d4cec..8a11a4b1944a 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-asus
+++ b/Documentation/ABI/testing/sysfs-driver-hid-asus
@@ -93,3 +93,399 @@ Description:
 
 		Access: Read only
 		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/xbox_controller
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Enable or disable the Xbox controller emulation of the
+		gamepad.
+
+		The file is created on the configuration interface of a
+		bound ASUS ROG Ally or ROG Ally X controller. A read
+		returns 1 when the emulation is enabled and 0 when it
+		is disabled; the emulation is enabled by default.
+
+		Reading and writing return -EOPNOTSUPP when the
+		controller does not report the capability.
+
+		Access: Read/Write
+		Valid values: 0, 1
+
+What:		/sys/bus/hid/drivers/asus/<dev>/gamepad_mode
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Operating mode of the gamepad. In "gamepad" mode the
+		buttons report gamepad codes, in "desktop" mode they
+		report keyboard, mouse and media codes. The default
+		mode is gamepad.
+
+		The file is created on the configuration interface of a
+		bound ASUS ROG Ally or ROG Ally X controller. A switch
+		asks the controller to change mode and resets the
+		recorded button mappings to the firmware defaults of
+		the new mode, so the remap, macro and remap_available
+		files report those defaults afterwards.
+
+		Access: Read/Write
+		Valid values: "gamepad", "desktop"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/gamepad_mode_index
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		List of the operating modes the gamepad_mode file
+		accepts, space separated.
+
+		The file is created on the configuration interface of a
+		bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: "gamepad desktop"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_vibration/intensity
+		/sys/bus/hid/drivers/asus/<dev>/right_vibration/intensity
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Strength of the left or the right rumble motor, in
+		percent of the maximum intensity. The controller does
+		not keep the strength across a reset: the driver sends
+		the recorded values again when it re-initializes the
+		controller.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller. Both
+		motors default to 100 and a write is rejected when the
+		value is above 100.
+
+		Access: Read/Write
+		Valid values: an unsigned number 0..100
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_vibration/intensity_range
+		/sys/bus/hid/drivers/asus/<dev>/right_vibration/intensity_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling intensity file accepts.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: "0 100"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/inner_threshold
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/inner_threshold
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Size of the inner dead zone of the joystick, in percent
+		of the axis range. The default is 10.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller. Reading
+		and writing return -EOPNOTSUPP when the controller does
+		not report user calibration support.
+
+		Access: Read/Write
+		Valid values: an unsigned number 0..50
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/outer_threshold
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/outer_threshold
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Outer threshold of the joystick, in percent of the axis
+		range: at and beyond this deflection the joystick
+		reports full deflection. The default is 90.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller. Reading
+		and writing return -EOPNOTSUPP when the controller does
+		not report user calibration support.
+
+		Access: Read/Write
+		Valid values: an unsigned number 70..100
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/inner_threshold_range
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/inner_threshold_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling inner_threshold file
+		accepts.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: "0 50"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/outer_threshold_range
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/outer_threshold_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling outer_threshold file
+		accepts.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: "70 100"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/anti_deadzone
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/anti_deadzone
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Anti-dead zone of the joystick, in percent of the axis
+		range: the deflection the controller applies to
+		counteract the inner dead zone. The default is 0.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller. Reading
+		and writing return -EOPNOTSUPP when the controller does
+		not report anti-dead zone support.
+
+		Access: Read/Write
+		Valid values: an unsigned number 0..100
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/anti_deadzone_range
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/anti_deadzone_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling anti_deadzone file
+		accepts.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: "0 100"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/response_curve
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/response_curve
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Response curve of the joystick, as four points. Each
+		point is a pair: a move percentage, the deflection at
+		which the point is placed, and a response percentage,
+		applied from that point on.
+
+		The values are ordered "move_1 resp_1 move_2 resp_2
+		move_3 resp_3 move_4 resp_4". move_N is the joystick
+		deflection percentage at which curve point N is placed
+		(0-100, each move_N must be greater than the previous
+		one). resp_N is the response percentage applied from
+		point N on (0-100).
+
+		The write is all-or-nothing: it is rejected when any
+		value is out of range or the move percentages are not
+		strictly increasing, and the recorded curve is left
+		untouched. The default is the linear curve
+		"0 0 33 33 66 66 100 100".
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller. Reading
+		and writing return -EOPNOTSUPP when the controller does
+		not report response curve support.
+
+		Access: Read/Write
+		Valid values: eight unsigned numbers 0..100, the move
+		ones strictly increasing
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_joystick_axis/response_curve_index
+		/sys/bus/hid/drivers/asus/<dev>/right_joystick_axis/response_curve_index
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Explanation of the format of the sibling response_curve
+		file.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_trigger/range_lower_limit
+		/sys/bus/hid/drivers/asus/<dev>/right_trigger/range_lower_limit
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Lower limit of the analog trigger activation range, in
+		percent of the trigger travel: below this deflection
+		the trigger reports zero. The default is 0.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller. Reading
+		and writing return -EOPNOTSUPP when the controller does
+		not report user calibration support.
+
+		Access: Read/Write
+		Valid values: an unsigned number 0..50
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_trigger/range_upper_limit
+		/sys/bus/hid/drivers/asus/<dev>/right_trigger/range_upper_limit
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Upper limit of the analog trigger activation range, in
+		percent of the trigger travel: at and beyond this
+		deflection the trigger reports full deflection. The
+		default is 100.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller. Reading
+		and writing return -EOPNOTSUPP when the controller does
+		not report user calibration support.
+
+		Access: Read/Write
+		Valid values: an unsigned number 70..100
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_trigger/range_lower_limit_range
+		/sys/bus/hid/drivers/asus/<dev>/right_trigger/range_lower_limit_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling range_lower_limit file
+		accepts.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: "0 50"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/left_trigger/range_upper_limit_range
+		/sys/bus/hid/drivers/asus/<dev>/right_trigger/range_upper_limit_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling range_upper_limit file
+		accepts.
+
+		The files are created on the configuration interface of
+		a bound ASUS ROG Ally or ROG Ally X controller.
+
+		Access: Read only
+		Valid values: "70 100"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/remap
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Target the button is remapped to, by name. A write
+		sends the mapping to the controller and is rejected
+		when the name is unknown or not valid for the button
+		in the current mode; the recorded mapping is restored
+		when the controller rejects it.
+
+		"NONE" is always valid. In "gamepad" mode only gamepad
+		codes are valid, in "desktop" mode only keyboard,
+		mouse and media codes are; btn_m1 and btn_m2 accept
+		every code.
+
+		The file is created in one directory per button of the
+		configuration interface of a bound ASUS ROG Ally or
+		ROG Ally X controller. <btn> is one of: btn_a, btn_b,
+		btn_x, btn_y, btn_lb, btn_rb, dpad_up, dpad_down,
+		dpad_left, dpad_right, btn_l3, btn_r3, btn_menu,
+		btn_view, btn_m1 and btn_m2.
+
+		Access: Read/Write
+		Valid values: one name from the sibling
+		remap_available file
+
+What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/macro
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Macro target of the button, by name. The macro target
+		is not restricted by the controller mode: every name
+		the controller knows is valid for every button.
+
+		The file is created in the <btn> directories listed
+		for the remap file.
+
+		Access: Read/Write
+		Valid values: one name; the btn_m1 and btn_m2
+		remap_available files list them all
+
+What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/remap_available
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Names the remap file of this button accepts in the
+		current mode, space separated. The btn_m1 and btn_m2
+		files list every known name in every mode.
+
+		The file is created in the <btn> directories listed
+		for the remap file.
+
+		Access: Read only
+		Valid values: a single line of text
+
+What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/turbo_period
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Repeat period of the turbo function of the button, in
+		firmware units: while turbo is on, the button is
+		automatically pressed again at this period. The period
+		0, the default, disables the function.
+
+		The file is created in the <btn> directories listed
+		for the remap file, only when the controller reports
+		turbo support.
+
+		Access: Read/Write
+		Valid values: an unsigned number 0..20
+
+What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/toggle_period
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Toggle period of the turbo function of the button, in
+		firmware units.
+
+		The file is created in the <btn> directories listed
+		for the remap file, only when the controller reports
+		turbo support.
+
+		Access: Read/Write
+		Valid values: an unsigned number 0..255
+
+What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/turbo_period_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling turbo_period file
+		accepts.
+
+		The file is created in the <btn> directories listed
+		for the remap file, only when the controller reports
+		turbo support.
+
+		Access: Read only
+		Valid values: "0 20"
+
+What:		/sys/bus/hid/drivers/asus/<dev>/<btn>/toggle_period_range
+Date:		October 2026
+Contact:	linux-input@vger.kernel.org
+Description:
+		Range of the values the sibling toggle_period file
+		accepts.
+
+		The file is created in the <btn> directories listed
+		for the remap file, only when the controller reports
+		turbo support.
+
+		Access: Read only
+		Valid values: "0 255"
-- 
2.47.3

