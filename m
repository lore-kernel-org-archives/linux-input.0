Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.89.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794605261;
	b=bd0j5ppgdRR5R0GLXhCXsE7jKA+JRG5hraAxVBjv/PwvjZdYW9a5GnpMbtR47Xr+felc
	 t3XRv3AhnLpAgv4LaAYQxhhjuQPaYkWhCb6OiDrnkQUPf+oeU+U4SXOWTYNA7aa9szW16
	 8HNEOb5DMs2TUygs/TmZsjfk9mJw8ap7BKJVF/7gmX3GMrLPM1bA+VzVzAgcl0KdNzdks
	 2+Sf2FB0cTK4zedTSr8HAh94HRJgdObYwCcw/eAaUdf9fbpeVDfATTIcfRdJUMEIuB09s
	 R5VkLuMniuW7XYFVtmn7O/O8MOUq7ILhV8E2kpNxBcVXniugtdLt/q5oaDX3h1PIeQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605261;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Info-Out:X-Proofpoint-GUID:X-JNJ;
	bh=yZ/hWIGLND9FMTKFMneZHVy430UM5dMtdGEsn0B2xes=;
	b=iIn9FFXvTBYeL+HsW2vedzdEpdJEQrwa0FuIJ4Jv1fNNHkl3hLyq59WmBXPaBGM03vNj
	 lFQZ4T0c5vVQd1I11pnQtMSMj6rmaW8FnbNEhp8n3LKif/7jCasyjSBYZE5L2sE0K2x6g
	 h69UE4l5XIov4oqsBQTUyl0DKzEoFKVzhpdhM4FfNGGqxHKcW3p10mb4Fo3V0mGSDgLE6
	 M0cw3gSF/NJNFMCqQGf2lQt8yG6TQv3k9bBMPPsESbBJNkv+47OztTPywb/VXKWobycfN
	 ZWMS1iy7ostN991nBIaI4T59uCKXcF6zfdisn61PziajC7EOvXDGQLnhOmh6uHKIBtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=matias.me;
	spf=pass smtp.mailfrom=matias.me;
	dkim=pass header.d=matias.me header.i=@matias.me header.a=rsa-sha256 header.s=sig1 header.b=G0urU3of;
	arc=none smtp.remote-ip=57.103.89.231
Received: from outbound.ci.icloud.com (ci-2005j-snip4-11.eps.apple.com [57.103.89.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49818606A334
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 21:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49818606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=matias.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matias.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=matias.me header.i=@matias.me header.a=rsa-sha256 header.s=sig1 header.b=G0urU3of
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id 9B4A218001F4;
	Fri, 13 Nov 2026 21:27:35 +0000 (UTC)
X-ICL-RepId: 01a1d6cf-0b62-782e-b2b7-9d70681f2ef8
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=matias.me; s=sig1; t=1794605258; x=1826141258; bh=yZ/hWIGLND9FMTKFMneZHVy430UM5dMtdGEsn0B2xes=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=G0urU3ofYrpk6K4DtiVl37L5Otx/97reUnN09enda3ePJTT2JVdzxSt0PMo5QBsE+C1U8b6Aw08HI6LRBOm0QLHTeHrThuOr6OpzdWXhxMEJUT5QCvhZ6WEcteFq+kc/t14tzZSHCOu8iScgOk5MRxjPIVcA3Gn63q5frJ+jwF2NQZuSC08XprFNaisMw1dBYVgt8GwPrxpsQAPuowI19JHSQKO4pAEeLgORcrTPTeb5qetYj6zgsxitSB6xVu6R0phRSHIrJsCJAg7MqT26G7IGoLPQf8hUJzFxgEI3i46w4bv5TTBjUD8HzNkGnP809cbG8Zfl0/36vs22ahBkBQ==
mail-alias-created-date: 1705102286191
Received: from localhost.localdomain (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id 94F8018001E7;
	Fri, 13 Nov 2026 21:27:32 +0000 (UTC)
From: =?UTF-8?q?Mat=C3=ADas=20Mart=C3=ADnez?= <hello@matias.me>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Denis Benato <denis.benato@linux.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Subject: [PATCH v5] HID: ayaneo: Add AYANEO 3 detachable controller driver
Date: Fri, 13 Nov 2026 18:27:29 -0300
Message-ID: <20261113212729.15925-1-hello@matias.me>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA4NSBTYWx0ZWRfX22JQnt0CasNu
 D9wpGrikDLPMbmWQYaz6M9pJk4Oilr/FdowCfqNMdJ9JijpRk/p/p78lkYZjBiwR2PjNqT0Qwj+
 BFgpkePKhP5kERQsm25UkTkSHC5ZGLRnKjiFdG+YElwHvS6WQfE/xg4N/hYTcQ1NDBy9IFQV7G5
 K8v6AFVwknSVmrfTy3rsIK2wwQPl/7gkLc3Legzd7PVd+5PbYIdSuAOJwnbTc8vEFURDgdeitTX
 Cw8PFAM84QHCI7Kb9YxM+o6IJhZYGzgVnU83vrfIxu/hIyiIVVGqmVBSJI4UEWgGMn/I0EHXAaA
 HNUNiRIsj8Xu3t1k4k5fLSz73pWBdHcf1A3IGtbN63kxHYAtaFRUjo4qZfDfPg=
X-Proofpoint-ORIG-GUID: w5Q4hxBv2PKfdqf4lAb5rpMqBQ6_p_yP
X-Authority-Info-Out: v=2.4 cv=MsFfKmae c=1 sm=1 tr=0 ts=6af780c8
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=ls_17pB39MoPrPG6SVgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w5Q4hxBv2PKfdqf4lAb5rpMqBQ6_p_yP
X-JNJ: AAAAAAABJvC69ne2OWLx3TfBGul9grpZ9lbHpNCHhpSI35c8rSqfPqQ3ppciqtdxBqyx54
 W6IR9UOZBSvdb0OE9UL592vBIE75NYwFDMKoYkOFABradF1VgfqyIOHVHlCCyWgrEmDoUD
 DgV80UDGqvxFscmd0iWL4pQ5p557YKyzJ+cbGWZ7IiUnu+0S8hucfTD4A7PjKD8VWeJ9hZ
 0DnUw7pCHRuyb0OCkQzj8y6zY21t71ZVBF6LVvW2pnRn5d4nmeoaOQA9qJpkOATs8K0dvW
 IYiU7BKNBt+61ds+91BvHkxd1hwXt8mKkqffpwxF/Uv5ryo4mHBph6LF9VjRLJj7bPAorD
 +wWsdOJO0hRo3CLRLMNxKdDUbyGyXRj+CC2YYFbjWHiW56Oe28wOakypnTDINtSp3INmIN
 LBqpqXbTZoA7fFJ0TPUWF46YUJXq5frq1eMESU6qam6jXVrqPKm+A13MW+xdZHN8dsonjb
 q7FgjlYmc931MA3zjPwjNMS/P9TU/IifsX7Qq4gRbJSXzvP8lRsOF9FBKw0b/cK9nNDiGM
 6ujKEs9Ii9fkUhUMEEHq2lEiWf8vquE9YyCyIqq+9fPil1aAUR5shR00egpo/XsoH3t3vv
 aChjEC90fMbx8HCzvV/YD8UfvXGqIroVlq6Z1uLqGAzg6GHGjLl0afvJUB6A8PoX6OKT2/
 xNf6SpMUOHbpYomXiTCavJtOP3pv7ESlUROiwCiRCjtt3vEZSw5E29d5Kpyws3/29/4OLh
 oqHFvhoajv77bs6ScZZuIYBUVwDmx0jSfBElfjyxy57Z/+KT93OfhAWw619HjimQmByJ6i
 Q9OEbup0kxTmWCRa2itizf9YL8In1kpVJu6GtnefbjSh2Qi8FM/7Lgslwmcodol3cOzrC2
 2vWeH9FMCeUgmExspuyxctHq/zOVHCI81RP2ryufuTZG+M0Ik0EKeiVyh1iuyXWQ3rNAlD
 UuEtMzf8AnfyhessA+LjQKcNm+MGX6mN02rQTncLwuCI5thC9diU35gA4oyZbmHvUSOxx4
 DSXhyii1CAkinalwrbb1/VtCtRqsnqFsWQ5ndQTr7IKHRJDQAwHy1+cNuAgR6KDg4hnoKy
 bdZCUvrDHP474KEo3qEC3celFxtkfAOKfOsbfsEFmbm6LPgT66+Pio1YAPepG2Z2eOfuZb
 /mLEEn9TMLrR47W0WmviA5BCcmknjeoK57VT6ImE77FqMod6zbU5uG9aGISXbx1IwcU+0s
 yeG5Gr2U8+SLjZ01l6oqF4UZ0PI3DrS+WwGZyHvQLBO6EFUxS9Cpu26A8jN+zv2M0Rato8
 1utHtbM7kOxxaD9YAq9uR9bzG7vGMwcjew/aOZmo6p9wgHwDzcMMZbhutKBVIa

The AYANEO 3 handheld has a detachable controller with swappable
modules ("Magic Modules"). The controller exposes three USB HID
interfaces behind 1c4f:0002 (a generic SigmaMicro VID/PID): a gamepad,
a keyboard for the extra buttons, and a vendor interface accepting
65-byte commands.

Add a driver claiming every interface of the shared ID. Interfaces
other than the AYANEO 3 vendor interface are started as transparent
generic devices, with reset_resume mirrored from hid-generic:
hid-generic yields any device that another driver's id table matches,
so refusing those probes would leave the input interfaces driverless
when the driver is present at boot.

On the vendor interface the driver provides module identification
(module_left/module_right sysfs attributes), software eject of the
modules (eject sysfs attribute, blocking until the firmware confirms
the release handshake and a minimum settle time has passed), a
configuration reset (reset), rumble strength selection
(rumble_intensity), and RGB control of the joystick rings as a
multicolor LED class device ("<device name>:rgb:joystick_rings";
userspace such as InputPlumber matches the function suffix). The
firmware's fixed-tempo effects are exposed through the LED effect
attribute (monocolor, breathe, rainbow), matching the attribute names
established by hid-lenovo-go.

This complements the ayaneo-ec platform driver, which exposes module
attach state and controller power. A full physical eject is performed
by writing to eject and then cutting power through ayaneo-ec's
controller_power attribute; that orchestration is deliberately left
to userspace.

The protocol was reverse engineered in the Handheld Daemon project by
Antheas Kapenekakis. Tested on an AYANEO 3: module identification,
RGB solid, breathing and rainbow at several brightness levels, rumble
level selection, gamepad and keyboard input through the transparent
interfaces, a full eject/reinsert/repower cycle with the re-enumerated
interfaces binding cleanly, and repeated driver unbinds under a
concurrent brightness-write load.

Signed-off-by: Matías Martínez <hello@matias.me>
---
Changes in v5:
- Trim the code comments per review: drop the observations that
  restate the adjacent code and the aside about a separate led-class
  core fix, and keep the ordering, locking and wire-protocol
  rationale. No functional change. [Antheas Kapenekakis]

Notes
-----
reset_resume is the post-reset path, not a plain resume hook. It runs
only when the device was reset while suspended, where the controller's
firmware state is lost regardless of how normal resume behaves;
ordinary resume works and the driver does not hook it. The transparent
interfaces defer to hidinput_reset_resume exactly as hid-generic does,
and the vendor interface reapplies the cached config only if userspace
had configured it.

Default intensity (answering the v4 question): the multicolor LED class
computes each channel as brightness * intensity / max. The subled
intensities start at zero, so with the defaults a brightness write
would show the LED "on" while emitting no light. Defaulting them to
full makes a brightness-only write produce white, the least surprising
behaviour on a device with no config read-back.

effect/effect_index are documented in this driver's own ABI file, as
sysfs-driver-hid-lenovo-go and -go-s already document the same
per-device LED attributes. Consolidating the three into one shared
description would be better; I can send that as a follow-up (a generic
doc plus removal of the duplicates from all three files), but it
crosses into the hid-lenovo-go maintainers' files, so I kept it out of
this patch rather than block the driver on it.

eject scope: a write-only eject attribute that drives a firmware
release handshake follows existing practice. greybus exposes the same
on its detachable modules (drivers/greybus/module.c, DEVICE_ATTR_WO),
and ACPI uses an eject attribute for ejectable hardware
(drivers/acpi/device_sysfs.c). This driver is more conservative than
greybus, which commands the physical eject itself: here only the
firmware handshake is in the kernel, and the power cut is left to
userspace through ayaneo-ec. If the HID maintainers would prefer eject
left entirely to userspace, the module-identification and LED parts
stand on their own and I can resend without it.

The id_table matches the generic SigmaMicro 1c4f:0002, shared with
unrelated keyboards (see hid-quirks.c). This is deliberate: the AYANEO 3
controller presents under that ID, and claiming it lets the non-vendor
interfaces start transparently instead of being stranded (hid-generic
yields any id-table match). On hardware that is not an AYANEO 3 the
driver still binds and starts the device transparently, and sets
HID_QUIRK_INPUT_PER_APP on that path, which hid-generic does not. I can
gate that quirk on the DMI match so foreign devices get plain
hid-generic behaviour if you prefer.

checkpatch flags the -ENOSYS check in ayaneo_send() as a misuse; it is
the standard hid_hw_output_report() fallback (the transport returns
-ENOSYS when it has no output report path).

v3: https://lore.kernel.org/linux-input/20260917160722.89391-1-hello@matias.me/
v4: https://lore.kernel.org/linux-input/20260925061941.75121-1-hello@matias.me/

 .../ABI/testing/sysfs-driver-hid-ayaneo       |  75 ++
 MAINTAINERS                                   |   7 +
 drivers/hid/Kconfig                           |  17 +
 drivers/hid/Makefile                          |   1 +
 drivers/hid/hid-ayaneo.c                      | 856 ++++++++++++++++++
 5 files changed, 956 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ayaneo
 create mode 100644 drivers/hid/hid-ayaneo.c

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ayaneo b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
new file mode 100644
index 000000000..525b08277
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
@@ -0,0 +1,75 @@
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/module_left
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/module_right
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Reports the type of the module currently inserted in the
+		left/right slot of the AYANEO 3 detachable controller, as
+		the raw identifier reported by the controller firmware in
+		hexadecimal (e.g. "0x04"). Bits 0-5 encode the module
+		type, bit 6 indicates the module is inserted rotated.
+
+		Reading these attributes queries the controller and can
+		take up to a second.
+
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/eject
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Write-only. Writing "left", "right" or "both" asks the
+		controller firmware to release the corresponding
+		module(s). The write blocks until the firmware confirms
+		the release handshake (typically a few seconds). The
+		module is physically released once controller power is
+		subsequently cut through the ayaneo-ec platform driver's
+		controller_power attribute. That final step is left to
+		userspace.
+
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/reset
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Write-only. Writing "1" asks the controller firmware to
+		perform a quick reset of the controller configuration.
+
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/rumble_intensity
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Controls the vibration strength of the AYANEO 3 controller
+		rumble motors. Reading returns the selected level. Supported
+		writes are the values listed by rumble_intensity_index.
+		Defaults to "medium", matching the firmware default.
+
+What:		/sys/bus/hid/drivers/hid-ayaneo/<dev>/rumble_intensity_index
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Read-only. Space-separated list of the supported
+		rumble_intensity values: "off low medium high".
+
+What:		/sys/class/leds/<dev>:rgb:joystick_rings/effect
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Controls the firmware LED effect of the joystick rings.
+
+		Values are "monocolor", "breathe" or "rainbow", as listed
+		by the effect_index attribute. "rainbow" is a
+		firmware-timed colour cycle whose hue and tempo are fixed
+		by the firmware: brightness scales its amplitude and the
+		multi_intensity values are ignored while it is selected.
+
+What:		/sys/class/leds/<dev>:rgb:joystick_rings/effect_index
+Date:		September 2026
+KernelVersion:	7.4
+Contact:	Matías Martínez <hello@matias.me>
+Description:
+		Read-only. Space-separated list of the supported effect
+		values: "monocolor breathe rainbow".
diff --git a/MAINTAINERS b/MAINTAINERS
index 4a69da715..7be0ff5b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4535,6 +4535,13 @@ F:	Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
 F:	drivers/spi/spi-axiado.c
 F:	drivers/spi/spi-axiado.h
 
+AYANEO 3 CONTROLLER HID DRIVER
+M:	Matías Martínez <hello@matias.me>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-hid-ayaneo
+F:	drivers/hid/hid-ayaneo.c
+
 AYANEO PLATFORM EC DRIVER
 M:	Antheas Kapenekakis <lkml@antheas.dev>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 2481bc01c..1babbee85 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -205,6 +205,23 @@ config HID_AUREAL
 	help
 	Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
 
+config HID_AYANEO
+	tristate "AYANEO 3 detachable controller support"
+	depends on USB_HID
+	depends on DMI
+	depends on LEDS_CLASS_MULTICOLOR
+	help
+	  Provides support for the detachable controller ("Magic Modules")
+	  of the AYANEO 3 handheld: module identification, software eject
+	  and RGB control of the joystick rings. Complements the ayaneo-ec
+	  platform driver, which handles module attach state and controller
+	  power.
+
+	  Say Y or M here if you have an AYANEO 3.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-ayaneo.
+
 config HID_BELKIN
 	tristate "Belkin Flip KVM and Wireless keyboard"
 	help
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 43a8eb0f3..116dafb2d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD)	+= hid-appletb-kbd.o
 obj-$(CONFIG_HID_CREATIVE_SB0540)	+= hid-creative-sb0540.o
 obj-$(CONFIG_HID_ASUS)		+= hid-asus.o
 obj-$(CONFIG_HID_AUREAL)	+= hid-aureal.o
+obj-$(CONFIG_HID_AYANEO)	+= hid-ayaneo.o
 obj-$(CONFIG_HID_BELKIN)	+= hid-belkin.o
 obj-$(CONFIG_HID_BETOP_FF)	+= hid-betopff.o
 obj-$(CONFIG_HID_BIGBEN_FF)	+= hid-bigbenff.o
diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
new file mode 100644
index 000000000..a6c2dee79
--- /dev/null
+++ b/drivers/hid/hid-ayaneo.c
@@ -0,0 +1,856 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * HID driver for the AYANEO 3 detachable controller ("Magic Modules").
+ *
+ * The AYANEO 3 controller exposes three USB HID interfaces behind
+ * VID 0x1c4f PID 0x0002 (a generic SigmaMicro ID): a gamepad, a
+ * keyboard for the extra buttons, and a vendor interface (application
+ * usage 0xff000001) accepting 65-byte commands.
+ *
+ * On the vendor interface the driver provides module identification,
+ * software eject, RGB control of the joystick rings (as a multicolor
+ * LED class device), rumble intensity and configuration reset. Other
+ * interfaces are started as transparent generic devices.
+ *
+ * It complements the ayaneo-ec platform driver, which exposes module
+ * attach state and controller power. A full eject is: write to this
+ * driver's "eject" attribute, then power the controller off through
+ * ayaneo-ec's controller_power once the eject completes.
+ *
+ * The protocol was reverse engineered in the Handheld Daemon project by
+ * Antheas Kapenekakis.
+ *
+ * Command format (65 bytes, unnumbered report):
+ *   [0]   report id (0)
+ *   [1:3] little-endian sum of bytes 7..64
+ *   [3]   command
+ *   [4]   subcommand
+ *   [5:]  payload
+ * The device replies with a 64-byte report echoing the subcommand at
+ * byte 3.
+ *
+ * Copyright (C) 2026 Matías Martínez <hello@matias.me>
+ */
+
+#include <linux/build_bug.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/hid.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/unaligned.h>
+#include <linux/workqueue.h>
+
+#include "hid-ids.h"
+
+#define AYA3_REPORT_SIZE	65
+#define AYA3_RESP_SIZE		64
+
+/*
+ * Empirical timings, inherited from Handheld Daemon's implementation of
+ * this protocol and validated on hardware: the device answers within
+ * 300ms or not at all, needs about half a second to settle after a
+ * reset before accepting new configuration, and completes an eject
+ * handshake within a few seconds. A minimum settle also separates the
+ * eject command from the power cut (AYA_MIN_EJECT in Handheld Daemon).
+ */
+#define AYA3_CMD_TIMEOUT_MS	300
+#define AYA3_CMD_ATTEMPTS	3
+#define AYA3_RESET_SETTLE_MS	500
+#define AYA3_EJECT_POLL_MS	400
+#define AYA3_EJECT_POLLS	20
+#define AYA3_EJECT_MIN_MS	3000
+
+/* Subcommands (byte 4). Byte 3 is 0x00 except for the config command. */
+#define AYA3_SUBCMD_CHECK	0x08
+#define AYA3_CMD_CONFIG		0x21
+#define AYA3_SUBCMD_CONFIG	0x09
+
+/* Bits that stay set in the eject status byte after an eject completes */
+#define AYA3_EJECT_DONE_MASK	0x11
+
+/* Application usage of the vendor interface's first collection */
+#define AYA3_APP_USAGE		(HID_UP_MSVENDOR | 0x0001)
+
+/* Config command eject/reset field */
+#define AYA3_EJECT_LEFT		0x07
+#define AYA3_EJECT_RIGHT	0x70
+#define AYA3_RESET		0x88
+
+/* Config command RGB modes */
+#define AYA3_RGB_SOLID		0x01
+#define AYA3_RGB_PULSE		0x02
+#define AYA3_RGB_RAINBOW	0x03
+#define AYA3_RGB_OFF		0xff
+
+/* Config command vibration levels, stored in the high nibble */
+enum aya3_vibration {
+	AYA3_VIBRATION_LOW	= 0x1,
+	AYA3_VIBRATION_MEDIUM	= 0x2,
+	AYA3_VIBRATION_HIGH	= 0x3,
+	AYA3_VIBRATION_OFF	= 0x4,
+};
+
+/* Firmware LED effects selectable through the LED "effect" attribute */
+enum aya3_effect {
+	AYA3_EFFECT_MONOCOLOR,
+	AYA3_EFFECT_BREATHE,
+	AYA3_EFFECT_RAINBOW,
+};
+
+static const char * const ayaneo_effect_names[] = {
+	[AYA3_EFFECT_MONOCOLOR]	= "monocolor",
+	[AYA3_EFFECT_BREATHE]	= "breathe",
+	[AYA3_EFFECT_RAINBOW]	= "rainbow",
+};
+
+struct aya3_rgb {
+	u8 mode;
+	u8 r;
+	u8 g;
+	u8 b;
+} __packed;
+
+/* csum is the little-endian sum of bytes 7..64; unk* fields are zero. */
+struct aya3_config {
+	u8 report_id;
+	__le16 csum;
+	u8 cmd;
+	u8 subcmd;
+	u8 unk5[3];
+	struct aya3_rgb right;
+	struct aya3_rgb left;
+	u8 unk16[4];
+	u8 eject;
+	u8 unk21;
+	u8 sensitivity[2];
+	u8 vibration;
+	u8 unk25[7];
+	u8 magic;
+	u8 unk33[32];
+} __packed;
+static_assert(sizeof(struct aya3_config) == AYA3_REPORT_SIZE);
+
+/* Replies echo the subcommand they answer at byte 3 */
+struct aya3_resp {
+	u8 unk0[3];
+	u8 subcmd;
+	u8 unk4[15];
+	u8 eject_status;
+	u8 unk20[12];
+	u8 module_left;
+	u8 module_right;
+	u8 unk34[30];
+} __packed;
+static_assert(sizeof(struct aya3_resp) == AYA3_RESP_SIZE);
+
+struct ayaneo {
+	struct hid_device *hdev;
+	/* DMA-safe command buffer; guarded by lock */
+	u8 *xfer;
+	/* Serializes commands and cached-config access */
+	struct mutex lock;
+	/* Protects the reply-matching state shared with raw_event */
+	spinlock_t resp_lock;
+	struct completion resp_done;
+	struct aya3_resp resp;
+	u8 resp_expect;
+	bool resp_pending;
+
+	/* No traffic is sent unless userspace asks; persists across resets. */
+	bool configured;
+
+	u8 rgb[3];
+	u8 brightness;
+	u8 effect;
+	u8 vibration;
+
+	struct led_classdev_mc mcled;
+	struct mc_subled subleds[3];
+};
+
+static int ayaneo_send(struct ayaneo *aya)
+{
+	int ret;
+
+	ret = hid_hw_output_report(aya->hdev, aya->xfer, AYA3_REPORT_SIZE);
+	if (ret == -ENOSYS)
+		ret = hid_hw_raw_request(aya->hdev, aya->xfer[0], aya->xfer,
+					 AYA3_REPORT_SIZE, HID_OUTPUT_REPORT,
+					 HID_REQ_SET_REPORT);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+/**
+ * ayaneo_cmd() - send the command in aya->xfer and wait for the reply
+ * @aya: driver data with the fully built 65-byte command in @aya->xfer
+ * @resp: destination for the reply, or NULL to discard it
+ * @attempts: how many times to send before giving up
+ *
+ * The device echoes the subcommand byte of the command it is answering,
+ * which ayaneo_raw_event() uses to match replies. Unanswered commands are
+ * retried up to @attempts times.
+ *
+ * Context: process context. The caller must hold @aya->lock, which
+ *          protects @aya->xfer and the reply state.
+ * Return: 0 on success, -ETIMEDOUT if every attempt went unanswered, or
+ *         a negative errno if sending failed.
+ */
+static int ayaneo_cmd(struct ayaneo *aya, struct aya3_resp *resp, int attempts)
+{
+	int attempt, ret;
+
+	lockdep_assert_held(&aya->lock);
+
+	for (attempt = 0; attempt < attempts; attempt++) {
+		scoped_guard(spinlock_irqsave, &aya->resp_lock) {
+			reinit_completion(&aya->resp_done);
+			aya->resp_expect = aya->xfer[4];
+			aya->resp_pending = true;
+		}
+
+		ret = ayaneo_send(aya);
+		if (ret) {
+			scoped_guard(spinlock_irqsave, &aya->resp_lock)
+				aya->resp_pending = false;
+			return ret;
+		}
+
+		if (wait_for_completion_timeout(&aya->resp_done,
+						msecs_to_jiffies(AYA3_CMD_TIMEOUT_MS))) {
+			/*
+			 * raw_event clears resp_pending before completing, so
+			 * nothing else writes aya->resp: the copy is safe unlocked.
+			 */
+			if (resp)
+				memcpy(resp, &aya->resp, sizeof(*resp));
+			return 0;
+		}
+	}
+	scoped_guard(spinlock_irqsave, &aya->resp_lock)
+		aya->resp_pending = false;
+	return -ETIMEDOUT;
+}
+
+static void ayaneo_checksum(u8 *buf)
+{
+	u16 sum = 0;
+	int i;
+
+	for (i = 7; i < AYA3_REPORT_SIZE; i++)
+		sum += buf[i];
+	put_unaligned_le16(sum, buf + 1);
+}
+
+static int ayaneo_check(struct ayaneo *aya, struct aya3_resp *resp,
+			int attempts)
+{
+	memset(aya->xfer, 0, AYA3_REPORT_SIZE);
+	aya->xfer[4] = AYA3_SUBCMD_CHECK;
+	return ayaneo_cmd(aya, resp, attempts);
+}
+
+/*
+ * The config command sets RGB, vibration and the eject/reset field at
+ * once. It can also carry joystick sensitivity; those bytes are left
+ * zero so the firmware setting is not clobbered on every RGB update.
+ */
+static int ayaneo_send_config(struct ayaneo *aya, u8 eject)
+{
+	static const struct aya3_config template = {
+		.cmd = AYA3_CMD_CONFIG,
+		.subcmd = AYA3_SUBCMD_CONFIG,
+		.magic = 0x01,
+	};
+	struct aya3_config *cfg = (struct aya3_config *)aya->xfer;
+	u8 mode = AYA3_RGB_OFF;
+	int ret;
+
+	if (aya->effect == AYA3_EFFECT_RAINBOW) {
+		if (aya->brightness)
+			mode = AYA3_RGB_RAINBOW;
+	} else if (aya->rgb[0] || aya->rgb[1] || aya->rgb[2]) {
+		mode = aya->effect == AYA3_EFFECT_BREATHE ?
+			AYA3_RGB_PULSE : AYA3_RGB_SOLID;
+	}
+
+	*cfg = template;
+	cfg->right.mode = mode;
+	if (mode == AYA3_RGB_RAINBOW) {
+		/*
+		 * The firmware generates hue and tempo itself. The RGB
+		 * payload only scales the amplitude. Handheld Daemon
+		 * derives it as HSV(275, 100, brightness), which is
+		 * (7/12 * v, 0, v) in RGB.
+		 */
+		cfg->right.r = aya->brightness * 7 / 12;
+		cfg->right.g = 0;
+		cfg->right.b = aya->brightness;
+	} else {
+		cfg->right.r = aya->rgb[0];
+		cfg->right.g = aya->rgb[1];
+		cfg->right.b = aya->rgb[2];
+	}
+	cfg->left = cfg->right;
+	cfg->eject = eject;
+	cfg->vibration = aya->vibration << 4;
+	ayaneo_checksum(aya->xfer);
+
+	ret = ayaneo_cmd(aya, NULL, AYA3_CMD_ATTEMPTS);
+	if (!ret)
+		aya->configured = true;
+	return ret;
+}
+
+static int ayaneo_raw_event(struct hid_device *hdev, struct hid_report *report,
+			    u8 *data, int size)
+{
+	struct ayaneo *aya = hid_get_drvdata(hdev);
+	const struct aya3_resp *resp = (const struct aya3_resp *)data;
+
+	/* Transparent interfaces have no driver data */
+	if (!aya)
+		return 0;
+
+	guard(spinlock_irqsave)(&aya->resp_lock);
+
+	if (!aya->resp_pending || size < AYA3_RESP_SIZE)
+		return 0;
+	/*
+	 * Replies carry no sequence number, only the subcommand echo. A
+	 * late reply to a timed-out command can thus complete a newer
+	 * command with the same subcommand. Such replies are snapshots
+	 * of the same query milliseconds apart, so this is harmless.
+	 * Replies to a different subcommand are dropped here.
+	 */
+	if (resp->subcmd != aya->resp_expect)
+		return 0;
+
+	memcpy(&aya->resp, data, sizeof(aya->resp));
+	aya->resp_pending = false;
+	complete(&aya->resp_done);
+	return 0;
+}
+
+static ssize_t ayaneo_module_show(struct device *dev, char *buf, bool right)
+{
+	struct ayaneo *aya = dev_get_drvdata(dev);
+	struct aya3_resp resp;
+	int ret = 0;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock)
+		ret = ayaneo_check(aya, &resp, AYA3_CMD_ATTEMPTS);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%02x\n",
+			  right ? resp.module_right : resp.module_left);
+}
+
+static ssize_t module_left_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return ayaneo_module_show(dev, buf, false);
+}
+static DEVICE_ATTR_RO(module_left);
+
+static ssize_t module_right_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	return ayaneo_module_show(dev, buf, true);
+}
+static DEVICE_ATTR_RO(module_right);
+
+static ssize_t eject_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct ayaneo *aya = dev_get_drvdata(dev);
+	struct aya3_resp resp;
+	u8 eject;
+	int ret = 0, err, i;
+
+	if (sysfs_streq(buf, "left"))
+		eject = AYA3_EJECT_LEFT;
+	else if (sysfs_streq(buf, "right"))
+		eject = AYA3_EJECT_RIGHT;
+	else if (sysfs_streq(buf, "both"))
+		eject = AYA3_EJECT_LEFT | AYA3_EJECT_RIGHT;
+	else
+		return -EINVAL;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
+		unsigned long deadline = jiffies +
+					 msecs_to_jiffies(AYA3_EJECT_MIN_MS);
+
+		ret = ayaneo_send_config(aya, eject);
+		if (ret)
+			break;
+
+		/*
+		 * Wait for the firmware to report the eject as done: no
+		 * bits outside AYA3_EJECT_DONE_MASK set, matching
+		 * Handheld Daemon's verification. The in-progress state
+		 * is reported from the first poll, and the minimum-time
+		 * floor below guards the power-cut step regardless.
+		 */
+		ret = -ETIMEDOUT;
+		for (i = 0; i < AYA3_EJECT_POLLS; i++) {
+			if (msleep_interruptible(AYA3_EJECT_POLL_MS)) {
+				ret = -EINTR;
+				break;
+			}
+			err = ayaneo_check(aya, &resp, 1);
+			if (err == -ETIMEDOUT)
+				continue;	/* busy mid-eject, keep polling */
+			if (err) {
+				ret = err;
+				break;
+			}
+			if (!(resp.eject_status & ~AYA3_EJECT_DONE_MASK)) {
+				ret = 0;
+				break;
+			}
+		}
+
+		/*
+		 * The firmware wants a minimum time between the eject
+		 * command and the power cut that follows this write.
+		 */
+		if (!ret && time_before(jiffies, deadline)) {
+			if (msleep_interruptible(jiffies_to_msecs(deadline -
+								  jiffies)))
+				ret = -EINTR;
+		}
+	}
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(eject);
+
+static ssize_t reset_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t count)
+{
+	struct ayaneo *aya = dev_get_drvdata(dev);
+	bool value;
+	int ret;
+
+	ret = kstrtobool(buf, &value);
+	if (ret)
+		return ret;
+	if (!value)
+		return count;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
+		ret = ayaneo_send_config(aya, AYA3_RESET);
+		if (!ret) {
+			msleep(AYA3_RESET_SETTLE_MS);
+			ret = ayaneo_send_config(aya, 0);
+		}
+	}
+	return ret ? ret : count;
+}
+static DEVICE_ATTR_WO(reset);
+
+/*
+ * Rumble intensity names, index-aligned with the wire values through
+ * ayaneo_rumble_levels below.
+ */
+static const char * const ayaneo_rumble_names[] = {
+	"off", "low", "medium", "high",
+};
+
+static const u8 ayaneo_rumble_levels[] = {
+	AYA3_VIBRATION_OFF,
+	AYA3_VIBRATION_LOW,
+	AYA3_VIBRATION_MEDIUM,
+	AYA3_VIBRATION_HIGH,
+};
+
+static ssize_t rumble_intensity_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct ayaneo *aya = dev_get_drvdata(dev);
+	u8 level;
+	int i;
+
+	/*
+	 * Single-byte snapshot; writers serialize on aya->lock, and a
+	 * racing update is harmless, while taking the mutex here would
+	 * block trivial reads behind a multi-second eject.
+	 */
+	level = READ_ONCE(aya->vibration);
+
+	for (i = 0; i < ARRAY_SIZE(ayaneo_rumble_levels); i++) {
+		if (ayaneo_rumble_levels[i] == level)
+			return sysfs_emit(buf, "%s\n", ayaneo_rumble_names[i]);
+	}
+	return -EINVAL;
+}
+
+static ssize_t rumble_intensity_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct ayaneo *aya = dev_get_drvdata(dev);
+	u8 previous;
+	int ret;
+
+	ret = sysfs_match_string(ayaneo_rumble_names, buf);
+	if (ret < 0)
+		return ret;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
+		previous = aya->vibration;
+		aya->vibration = ayaneo_rumble_levels[ret];
+		ret = ayaneo_send_config(aya, 0);
+		if (ret) {
+			aya->vibration = previous;
+			return ret;
+		}
+	}
+	return count;
+}
+static DEVICE_ATTR_RW(rumble_intensity);
+
+static ssize_t rumble_intensity_index_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	ssize_t count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ayaneo_rumble_names); i++)
+		count += sysfs_emit_at(buf, count, "%s ",
+				       ayaneo_rumble_names[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(rumble_intensity_index);
+
+static struct attribute *ayaneo_attrs[] = {
+	&dev_attr_module_left.attr,
+	&dev_attr_module_right.attr,
+	&dev_attr_eject.attr,
+	&dev_attr_reset.attr,
+	&dev_attr_rumble_intensity.attr,
+	&dev_attr_rumble_intensity_index.attr,
+	NULL
+};
+
+static const struct attribute_group ayaneo_group = {
+	.attrs = ayaneo_attrs,
+};
+
+static int ayaneo_led_set(struct led_classdev *cdev, enum led_brightness value)
+{
+	struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
+	struct ayaneo *aya = container_of(mc, struct ayaneo, mcled);
+	int ret = 0, i;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
+		led_mc_calc_color_components(mc, value);
+		aya->brightness = min_t(unsigned int, value, 255);
+		for (i = 0; i < 3; i++)
+			aya->rgb[i] = min_t(unsigned int,
+					    aya->subleds[i].brightness, 255);
+
+		ret = ayaneo_send_config(aya, 0);
+		if (ret)
+			hid_err(aya->hdev,
+				"failed to update RGB config: %d\n", ret);
+	}
+	return ret;
+}
+
+static ssize_t effect_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct ayaneo *aya = container_of(lcdev_to_mccdev(cdev),
+					  struct ayaneo, mcled);
+	u8 effect;
+
+	/*
+	 * Single-byte snapshot; writers serialize on aya->lock, and a
+	 * racing update is harmless, while taking the mutex here would
+	 * block trivial reads behind a multi-second eject.
+	 */
+	effect = READ_ONCE(aya->effect);
+
+	return sysfs_emit(buf, "%s\n", ayaneo_effect_names[effect]);
+}
+
+static ssize_t effect_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct led_classdev *cdev = dev_get_drvdata(dev);
+	struct ayaneo *aya = container_of(lcdev_to_mccdev(cdev),
+					  struct ayaneo, mcled);
+	u8 previous;
+	int ret;
+
+	ret = sysfs_match_string(ayaneo_effect_names, buf);
+	if (ret < 0)
+		return ret;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
+		previous = aya->effect;
+		if (previous == ret)
+			return count;
+		aya->effect = ret;
+		ret = ayaneo_send_config(aya, 0);
+		if (ret) {
+			aya->effect = previous;
+			return ret;
+		}
+	}
+	return count;
+}
+static DEVICE_ATTR_RW(effect);
+
+static ssize_t effect_index_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	ssize_t count = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ayaneo_effect_names); i++)
+		count += sysfs_emit_at(buf, count, "%s ",
+				       ayaneo_effect_names[i]);
+
+	if (count)
+		buf[count - 1] = '\n';
+
+	return count;
+}
+static DEVICE_ATTR_RO(effect_index);
+
+static struct attribute *ayaneo_led_attrs[] = {
+	&dev_attr_effect.attr,
+	&dev_attr_effect_index.attr,
+	NULL
+};
+
+static const struct attribute_group ayaneo_led_group = {
+	.attrs = ayaneo_led_attrs,
+};
+
+/*
+ * The final LED write issued by the unregister needs its reply; callers
+ * keep IO working (probe leaves it started, remove re-enables it).
+ */
+static void ayaneo_unregister_led(struct ayaneo *aya)
+{
+	led_classdev_multicolor_unregister(&aya->mcled);
+	flush_work(&aya->mcled.led_cdev.set_brightness_work);
+}
+
+static int ayaneo_register_led(struct ayaneo *aya)
+{
+	struct led_classdev *cdev = &aya->mcled.led_cdev;
+	int ret, i;
+
+	aya->subleds[0].color_index = LED_COLOR_ID_RED;
+	aya->subleds[1].color_index = LED_COLOR_ID_GREEN;
+	aya->subleds[2].color_index = LED_COLOR_ID_BLUE;
+	/*
+	 * Full intensity by default so brightness writes produce light
+	 * before userspace sets multi_intensity (querying the firmware
+	 * for its value would break the no-probe-traffic policy).
+	 */
+	for (i = 0; i < 3; i++)
+		aya->subleds[i].intensity = 255;
+	aya->mcled.subled_info = aya->subleds;
+	aya->mcled.num_colors = 3;
+
+	cdev->name = devm_kasprintf(&aya->hdev->dev, GFP_KERNEL,
+				    "%s:rgb:joystick_rings",
+				    dev_name(&aya->hdev->dev));
+	if (!cdev->name)
+		return -ENOMEM;
+	cdev->color = LED_COLOR_ID_RGB;
+	cdev->brightness = 0;
+	cdev->max_brightness = 255;
+	cdev->brightness_set_blocking = ayaneo_led_set;
+
+	/*
+	 * Not devm: the LED must be unregistered before hid_hw_stop(), or a
+	 * racing brightness write could reach a torn-down transport.
+	 */
+	ret = led_classdev_multicolor_register(&aya->hdev->dev, &aya->mcled);
+	if (ret)
+		return ret;
+
+	/*
+	 * The multicolor class adds its own groups at registration, so the
+	 * effect attributes are added after and tied to the LED device.
+	 */
+	ret = devm_device_add_group(cdev->dev, &ayaneo_led_group);
+	if (ret)
+		ayaneo_unregister_led(aya);
+	return ret;
+}
+
+static const struct dmi_system_id ayaneo_dmi_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
+			DMI_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
+		},
+	},
+	{}
+};
+
+static int ayaneo_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct ayaneo *aya;
+	int ret;
+
+	ret = hid_parse(hdev);
+	if (ret)
+		return ret;
+
+	/*
+	 * The VID/PID is a generic SigmaMicro ID shared by the gamepad,
+	 * keyboard and vendor interfaces, and by unrelated devices on
+	 * other machines. Refusing those probes would strand them, as
+	 * hid-generic yields any device that another driver's id table
+	 * matches. Everything that is not the AYANEO 3 vendor interface
+	 * is therefore started as a transparent generic device, exactly
+	 * as hid-generic would have started it.
+	 */
+	if (!dmi_check_system(ayaneo_dmi_table) || !hid_is_usb(hdev) ||
+	    !hdev->maxcollection ||
+	    hdev->collection->type != HID_COLLECTION_APPLICATION ||
+	    hdev->collection->usage != AYA3_APP_USAGE) {
+		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	}
+
+	aya = devm_kzalloc(&hdev->dev, sizeof(*aya), GFP_KERNEL);
+	if (!aya)
+		return -ENOMEM;
+
+	aya->xfer = devm_kzalloc(&hdev->dev, AYA3_REPORT_SIZE, GFP_KERNEL);
+	if (!aya->xfer)
+		return -ENOMEM;
+
+	aya->hdev = hdev;
+	aya->vibration = AYA3_VIBRATION_MEDIUM;
+	init_completion(&aya->resp_done);
+	spin_lock_init(&aya->resp_lock);
+	ret = devm_mutex_init(&hdev->dev, &aya->lock);
+	if (ret)
+		return ret;
+	hid_set_drvdata(hdev, aya);
+
+	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
+	if (ret)
+		return ret;
+
+	ret = hid_hw_open(hdev);
+	if (ret)
+		goto err_stop;
+
+	/*
+	 * Report delivery is off during probe by default, but the LED and
+	 * attributes go live below and their first commands need replies, so
+	 * leave IO started.
+	 */
+	hid_device_io_start(hdev);
+
+	ret = ayaneo_register_led(aya);
+	if (ret)
+		goto err_close;
+
+	ret = sysfs_create_group(&hdev->dev.kobj, &ayaneo_group);
+	if (ret)
+		goto err_led;
+
+	return 0;
+
+err_led:
+	ayaneo_unregister_led(aya);
+err_close:
+	hid_hw_close(hdev);
+err_stop:
+	hid_hw_stop(hdev);
+	return ret;
+}
+
+static void ayaneo_remove(struct hid_device *hdev)
+{
+	struct ayaneo *aya = hid_get_drvdata(hdev);
+
+	if (!aya) {
+		hid_hw_stop(hdev);
+		return;
+	}
+
+	/*
+	 * The HID core stops report delivery before remove, but the final
+	 * LED write and the group removal's in-flight attribute callers
+	 * still need replies. Re-enable IO for the teardown writes.
+	 */
+	hid_device_io_start(hdev);
+	sysfs_remove_group(&hdev->dev.kobj, &ayaneo_group);
+	led_classdev_multicolor_unregister(&aya->mcled);
+	/*
+	 * A brightness store racing the unregister can requeue
+	 * set_brightness_work after led_classdev_unregister()'s flush, so
+	 * flush it again before stopping IO, while the transport is up.
+	 */
+	flush_work(&aya->mcled.led_cdev.set_brightness_work);
+	hid_device_io_stop(hdev);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+}
+
+static int ayaneo_reset_resume(struct hid_device *hdev)
+{
+	struct ayaneo *aya = hid_get_drvdata(hdev);
+	int ret = 0;
+
+	/* Transparent interfaces: mirror hid-generic's reset_resume */
+	if (!aya) {
+		if (hdev->claimed & HID_CLAIMED_INPUT)
+			hidinput_reset_resume(hdev);
+		return 0;
+	}
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
+		if (aya->configured)
+			ret = ayaneo_send_config(aya, 0);
+	}
+	return ret;
+}
+
+static const struct hid_device_id ayaneo_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO,
+			 USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD) },
+	{}
+};
+MODULE_DEVICE_TABLE(hid, ayaneo_devices);
+
+static struct hid_driver ayaneo_driver = {
+	.name = "hid-ayaneo",
+	.id_table = ayaneo_devices,
+	.probe = ayaneo_probe,
+	.remove = ayaneo_remove,
+	.raw_event = ayaneo_raw_event,
+	.reset_resume = ayaneo_reset_resume,
+};
+module_hid_driver(ayaneo_driver);
+
+MODULE_AUTHOR("Matías Martínez <hello@matias.me>");
+MODULE_DESCRIPTION("AYANEO 3 detachable controller driver");
+MODULE_LICENSE("GPL");

base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
-- 
2.54.0 (Apple Git-157)

