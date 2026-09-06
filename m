Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274E27A462
	for <linux-input@vger.kernel.org>; Sun,  6 Sep 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788728555; cv=pass; b=d+4zB/t40AphNnV6o2jXoBlJP4d0Lawj+d2nQRmFOGyydhrHNPsjYOiTYH7+AK7RXsVUHhzCGRdgDQ7E4BRJjgurQiLY2FlQgK5N0p3hLk/qPSmaFcdHk2CgKA2lsomeUT8Pkjq48p+Ck/gSAvW5gV7qY4nmedbU6j6j0W4L2ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788728555; c=relaxed/simple;
	bh=CoxAm35rfRpfTTlbiTQKG4M3TEoTTICoTkDlb+byG2I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pme1gQ+q9K/2tO80STpjQ36iQPdL6M+Q18wEbvepe5mqN0tMQKy+tVcdrGIRmfAngprnyJhzaVryp3MQJKwn+Lz0Z/ukDcw9b8K/onEjMxtNGCkYvOF0qlcY7ncIrAQGHehi52VuL8W7e1Ap53A0q1Z/E9HZkK+LWp+3yVGrK5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmnnTMIr; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmnnTMIr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-878ed0f17bfso2115347b3.1
        for <linux-input@vger.kernel.org>; Sun, 06 Sep 2026 14:02:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788728553; cv=none;
        d=google.com; s=arc-20260327;
        b=bUYrf5mSUfY4t71WKQkQKOo1vPfwVbQP7k/1dDC4fEGs4J3TF2Y6xuavrfOI9r6mVs
         d4tQNGXStOCcMngWiSSiyi0PzUxn+00/Xx/3YDXqEE091J/ZN+ELfIoVQXBM7KIKgS5U
         ch9t4LHhLezSlX5WYohCf9LJHGBzwoKKzdl6xkmmUJFjplUpvlouC0ok0msHPTwzN8+4
         Q74sVrsKsdgGDWcr9Z69qh0sdExp42maQiX5fIjYLwW5qaLKr1ZAirh6HEyMq3kRwZ+W
         Rm5div5Yso46jKPLlaZx7k6+qynTi4W8hysk9rrlEU9DkUD2dgYpEyNNA5hhJ4BbDNkA
         NzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=CoxAm35rfRpfTTlbiTQKG4M3TEoTTICoTkDlb+byG2I=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=JpbRNbhhEBOLtUQJmUlhpkfzNJyqqIk+Q2epENINxlxAdfFl1+KnIA9XD3/v5y2h6R
         49/0cLCAZmt61mwzUlxfiPJxPbNLs5AIFVSvxS7wUs8SDnZAS/W488AvzwURxc2CFlMO
         dRUGvzNwwePG968llUMtzbvw2tQlbUWW22PslO0+FWzeSel791EVv4MGObcGMRrnhj2J
         cvPfsJ13xdTNzztDyNPFaljTJyKVeEoQ4qRaAar9vt4AfqyVfz3d48/wqN1oNZlhHbjq
         hSVHzPfcI1rikC/vKTIo+DlcOKzfB9of9sqUbIF2oJCFNJG7ZaBqDPa9RiBR75BbSC/t
         7pag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788728553; x=1789333353; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CoxAm35rfRpfTTlbiTQKG4M3TEoTTICoTkDlb+byG2I=;
        b=ZmnnTMIrFtwVB59IE7V2AV+rk4H7BjTLcMFjKt7kCdrseeaC6Z3WmW5bFwFnDsNcjj
         8E0FWSWsOy9oJpyZTgnTAWk3BwpHiFVMMVw85f7UNN8hrLC58RkumoIkJ/qL6tKTduZT
         cyCJJOanEhkP0xHPffH2zgeY9oTV/td+L60dJqGaJpkmv0Z6r24OutURVoVYASYsXhMA
         7ES2TRUZHCQbZxHDw6aZZs77UMYJFhfeSEXQiUVOnTW+/PzjvaF0MSe+YUAkc5QPwHtq
         fOl1csd7q5NmdZkBNBvIHukuVFQoobDiW6Gke4xaLGDQL3LAflrr6Q5ROeqGy1ba3C9H
         GTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788728553; x=1789333353;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CoxAm35rfRpfTTlbiTQKG4M3TEoTTICoTkDlb+byG2I=;
        b=e/LeFD7r6ear88D448SwHtjMugJo72zwkOEEV3+8WOM8nT3vX3uNr3dVfFVnQ0NkLI
         9W9ejw+oPwEcledUvl/reRmYz8VSLLTBhKS7gooGxqul0x1uzU74Rf+WRv517abJq26u
         JYceeX+wCPJOjZ2bSk0XTW+IFbmS83RoAQklMAciElfSd+jGqHT1DN5QkUD4RJ+OUGJg
         sinfY1kvPMMKowjlZdbuMkJqlJFuX6Dct4jOJWfxNY1HQRQuN1It1yTrntYNDZXPvk52
         dSGyoQY4lvU+lpLhiq2zgcyxx9PamnsVNk5ld3/wDPDHwoHluCfo9Kj5oy0PaEW8LCZQ
         4l1g==
X-Gm-Message-State: AFuF++nbIYLoD4DpesICbiels5w5mkNLU+PU+nAWejogwU+v9tDHjszi
	/vN2vHk6C7rFTS4vwO4th27EpQ6uYrK5f/ec/uUptLgRIS5Izh5FGoy84CYLSXIqnjs5KQ4YZsI
	sqsN9bg+amz1uSIWRTn6RG7B5rmwRYw4OpX+68+os5xhf
X-Gm-Gg: AYBFou2s7mNa928dnCyd4dlWLuF+LbR0NvYUXlKlMH+SE7pm0BaVOQEu0C0wUiyTaa0
	th3Nx2xVnY2xOQDfurdKc5Cb4mxopWgZjhqIILWYtSCMx8NzRNfZH0MHYnL2REO4E/RpleVN1ep
	vn3ehflZqExVegQer4iohivO2OyED3hNAYKfTYthXSwhltSHNjc6L3B8CreptXN2QpkywDY15yJ
	pN7lm3MQG/iZ3mdbuJwofOCU+mqn44I89BJB+Zg071/LIaZv9EF4zTq0WDPu5uohIt6XJ8e2hFd
	LbRDUa5fHAW5hUa4cWvQnw9cGwDwFA==
X-Received: by 2002:a05:690c:e3c4:b0:873:5ddf:d863 with SMTP id
 00721157ae682-8735ddfd9ddmr38402017b3.46.1788728552926; Sun, 06 Sep 2026
 14:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Typer <retype030@gmail.com>
Date: Mon, 7 Sep 2026 00:02:21 +0300
X-Gm-Features: AcwNN1UxCCSG6pqeKYvcoOF5sbNdm7WdcdGTIis2lapBPh3m9q7j-ndd1J1vRhU
Message-ID: <CALtkK2CKHVneQzeJMvSZDq7m-4S8NqKQRqWbiM=oLqHpuhhy+w@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_FocalTech_FTCS0038_=28I2C_2808=3A0106=29_touchpad_re?=
	=?UTF-8?Q?ports_contacts_as_repeating_=7E100ms_touch=2Frelease_cycles=E2=81=A0?=
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Link to Bugzilla:
[https://bugzilla.kernel.org/show_bug.cgi?id=3D221973](https://bugzilla.ker=
nel.org/show_bug.cgi?id=3D221973)=E2=81=A0

# Bug report: FocalTech FTCS0038 (I2C 2808:0106) touchpad reports
contacts as repeating ~100ms touch/release cycles instead of
continuous tracking

## Summary

The touchpad is correctly enumerated by the kernel and exposes a
fully-capable evdev "Touchpad" node (correct size, resolution,
tap/scroll/gesture capabilities). However, in normal use it never
reports a continuous, sustained contact. Instead, every touch is
broken into a rapid, near-metronomic sequence of discrete touch-down /
touch-up events (roughly every 100-160ms), each carrying a single,
often significantly different, coordinate. There is no sequence of
continuous ABS_MT_POSITION_X/Y updates under one stable
ABS_MT_TRACKING_ID / held BTN_TOUCH=3D1.

Because of this, `libinput` (correctly, given the data it receives)
interprets the input as a repeating `GESTURE_HOLD_BEGIN` /
`GESTURE_HOLD_END` cycle rather than `POINTER_MOTION`. The cursor
never moves via the touchpad. This is reproducible at the raw kernel
evdev level (via `evtest`), i.e. upstream of libinput and of any
compositor =E2=80=94 this is not a libinput, Hyprland, or distro-specific
issue.

## Environment

- Laptop: Lenovo IdeaPad Slim 5 16IRL8, model **82XF**
- CPU: Intel Core i7-13620H (13th Gen, Raptor Lake), integrated Intel
UHD Graphics
- Touchpad: **FocalTech FTCS0038**, I2C HID, `VID:PID 2808:0106`, bus i2c
- Device path: `/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c=
-FTCS0038:00/0018:2808:0106.0003`
- IRQ: GPIO 135 (`intel-gpio`, line 160 in `/proc/interrupts`)
- Kernel: `7.1.9-arch1-2` (Arch Linux; specifically the Omarchy
distribution, though this appears to be a pure kernel/firmware issue =E2=80=
=94
reproducible below the compositor/libinput layer, see diagnostics)
- Compositor: Hyprland (Wayland) =E2=80=94 included for context only, not
believed to be relevant

## Kernel enumerates two nodes for the same physical device

```
input: FTCS0038:00 2808:0106 Mouse as .../input/input25
input: FTCS0038:00 2808:0106 Touchpad as .../input/input26
```

- The "Mouse" node fails libinput's touchpad sanity check and is
disabled entirely:
`kernel bug: device failed touchpad sanity checks` (event19). This
appears to be a harmless legacy/duplicate node and is not believed to
be the root cause, but is mentioned for completeness.
- The "Touchpad" node (event20) is the real device and is what all
diagnostics below concern.

## Diagnostic 1 =E2=80=94 `libinput debug-events`

```
-event20 DEVICE_ADDED FTCS0038:00 2808:0106 Touchpad seat0 default group2 c=
ap:pg
size 114x70mm tap (dl off) left scroll-nat scroll-2fg-edge
click-buttonareas-clickfinger dwt-on dwtp-on
event20 GESTURE_HOLD_BEGIN +0.040s 1
event20 GESTURE_HOLD_END +0.104s 1
event20 GESTURE_HOLD_BEGIN +0.248s 1
event20 GESTURE_HOLD_END +0.312s 1
... (repeats indefinitely while touching the pad; never transitions to
POINTER_MOTION)
```

Device is recognized with full, correct capabilities =E2=80=94 this is not =
a
"device not detected" issue.

## Diagnostic 2 =E2=80=94 raw `evtest` on event20 (below libinput entirely)

Capabilities include `ABS_X/Y`, `ABS_MT_SLOT`, `ABS_MT_POSITION_X/Y`,
`ABS_MT_TOOL_TYPE`, `ABS_MT_TRACKING_ID` (resolution 13, ranges 0-1481
/ 0-911), `INPUT_PROP_POINTER`, `INPUT_PROP_BUTTONPAD`.

Sample of the actual event stream while continuously moving one finger:

```
Event: ... ABS_MT_TRACKING_ID value 47
Event: ... ABS_MT_POSITION_X value 824
Event: ... ABS_MT_POSITION_Y value 494
Event: ... BTN_TOUCH value 1
Event: ... BTN_TOOL_FINGER value 1
--------- SYN_REPORT ---------
Event: ... ABS_MT_TRACKING_ID value -1 <- contact ends, ~104ms later
Event: ... BTN_TOUCH value 0
Event: ... BTN_TOOL_FINGER value 0
--------- SYN_REPORT ---------
Event: ... ABS_MT_TRACKING_ID value 48 <- brand new contact, new ID,
new coordinate
Event: ... BTN_TOUCH value 1
...
```

This pattern (new tracking ID + single coordinate + immediate release,
repeating every ~100-160ms) is consistent for the entire duration of a
continuous finger motion. There is never more than one
`ABS_MT_POSITION_X/Y` pair reported per contact =E2=80=94 i.e. the
firmware/driver never reports an in-progress position update for an
ongoing touch, only discrete "touch happened here" samples.

Multi-finger touches (2 and 3 fingers,
`BTN_TOOL_DOUBLETAP`/`BTN_TOOL_TRIPLETAP`) show the identical discrete
on/off pattern across multiple slots simultaneously.

## Diagnostic 3 =E2=80=94 `/proc/interrupts`, sampled repeatedly while
actively touching the pad

```
160: ... 109 ... intel-gpio 135 FTCS0038:00
160: ... 124 ... intel-gpio 135 FTCS0038:00 (a few seconds later,
actively touching)
160: ... 147 ... intel-gpio 135 FTCS0038:00
160: ... 166 ... intel-gpio 135 FTCS0038:00
```

The interrupt counter increases steadily while touching the pad,
roughly consistent with the ~100-160ms cycle seen in the event stream
=E2=80=94 i.e. real hardware interrupts are firing, this does not look like=
 a
dead/stuck polling loop. (Caveat: no idle/not-touching baseline was
captured in the same test run, so this is suggestive rather than
conclusive.)

## Fix attempted and ruled out: hid-multitouch Confidence-bit /
palm-rejection quirk

Hypothesis: FocalTech firmware is known to have an unreliable
"Confidence" HID field that some FocalTech chips (e.g. a related
product, `2808:0231`, on a different laptop) misreport during normal
touch, which `hid-multitouch`'s default `MT_CLS_WIN_8` handling can
misinterpret as `MT_TOOL_PALM`, causing touches to be dropped. A known
community fix for that sibling device is a dedicated `mt_class` that
skips `MT_QUIRK_CONFIDENCE` application (`hid-multitouch.c`, around
the `HID_DG_CONFIDENCE` case, ~line 872 in the `v7.1` source, which
whitelists only `MT_CLS_WIN_8` and four related class names for that
quirk).

**What was done:** Built `hid-multitouch.c` (from `v7.1` kernel
source, matched against the running `7.1.9-arch1-2` headers)
out-of-tree, adding:
- `I2C_VENDOR_ID_FOCALTECH 0x2808`, `I2C_PRODUCT_ID_FOCALTECH_FTCS0038
0x0106` in `hid-ids.h`
- A new `mt_class` entry (deliberately given a class name outside the
`HID_DG_CONFIDENCE` whitelist, so `MT_QUIRK_CONFIDENCE` is never
applied to this device) with otherwise-standard
`MT_CLS_WIN_8`-equivalent quirks
- A matching `HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
I2C_VENDOR_ID_FOCALTECH, I2C_PRODUCT_ID_FOCALTECH_FTCS0038)` entry in
`mt_devices[]`

Module built cleanly and loaded successfully =E2=80=94 confirmed via dmesg
that the device rebound from `hid-generic` to the patched
`hid-multitouch` module.

**Result: no change in behavior.** Identical `GESTURE_HOLD` cycling,
no `POINTER_MOTION`, identical ~100ms discrete touch/release pattern
in raw evtest output.

**Conclusion:** This rules out hid-multitouch's
Confidence-bit/palm-rejection logic as the cause for this specific
product ID (0x0106) =E2=80=94 unlike the sibling device (0x0231) where this
class of fix is documented to help.

## Other things ruled out

- `libinput` quirks override (`/etc/libinput/local-overrides.quirks`,
`AttrPalmSizeThreshold`) =E2=80=94 no effect. (Another user with the identi=
cal
VID:PID reported the same non-result independently on the Arch Linux
forums.)
- udev/hwdb property overrides (`ID_INPUT_TOUCHPAD=3D1` etc.) =E2=80=94 no
effect on the underlying event stream.
- `modprobe -r i2c_hid_acpi && modprobe i2c_hid_acpi` =E2=80=94 produces on=
ly
a brief, incomplete, temporary change, not a fix.

## Open question for maintainers

Since the discrete touch/release cycling is present already in raw
evdev events =E2=80=94 i.e. upstream of both libinput's gesture logic and
hid-multitouch's contact-validity/quirk logic =E2=80=94 is this more likely=
:

(a) a firmware defect in the FTCS0038 controller itself (i.e., not
something fixable in the kernel), or
(b) an issue at the I2C-HID transport layer (`i2c_hid_acpi` /
`i2c_designware`) =E2=80=94 e.g. report cadence, IRQ coalescing, or an ACPI
power-state interaction =E2=80=94 that is independent of hid-multitouch's
higher-level contact/quirk handling?

Any guidance on further diagnosis (e.g. a specific
`hid-tools`/`hid-replay` capture of the raw HID reports, or a debug
patch to trace report bytes below the input-mapping layer) would be
very welcome. Happy to test patches or provide additional captures =E2=80=
=94 I
have full, reproducible access to the affected hardware.

## Where this is being reported

- bugzilla.kernel.org, component: Drivers/HID
- Cc: linux-input mailing list (linux-input@vger.kernel.org)

## Reporter's software environment (for context, not believed to be
relevant to root cause)

- Distribution: Omarchy Linux (Arch-based), Hyprland 0.56.2
compositor, Wayland session
- This is reproducible independent of the compositor/session =E2=80=94 the
behavior is already present in raw evdev events read directly via
`evtest`, without any compositor or libinput involvement.
