Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=88.99.165.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331193;
	b=gi0gj+NnMN6SCOEZaadun7ju7qryPgbc4NBuq4C9TZXFiNpmfL6hPi+MKhhh/yo244/g
	 0L9ThO/1DeaMji+S1AenAg3nBKeMmlXW2VmQmWHC+wzx5irwaUFttO/QFi3d1S3TkXQPl
	 GYuubnfaw1aQVZRE4V3wI83+ehUMwxBELjcaHT7j9yMgB1t3Shh17gzJvb3pXTaZBaARO
	 h3U/acecDcdDrja8nT0ZfC+jPuFP5npxQoKAHkZmpFJ8DDSppDpSR4Eos8h+5f4Gqcqib
	 3ajQGqFPNRLplSwTt/OOPGcH36A+vuHdu7TLrjbCrZePzr8NKpY1qKD3D7p1sl9uSig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331193;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=p/zlLp2/5CvVaOiuLTK2bSnJUqlCd8S9f8F1xwWFe60=;
	b=eaB3KYsMyWi/3SFBF3xJ7Yzk6wzqoxNvhdy2b41J34TniCKnjX/iCqThCtpay2N19t6W
	 XLkUfas1FuloiL6QIFE+Kopa2kkCoLGxCFXDx/U5EfiDa4ueKPIj/LOHLLTROpYW9xwUA
	 rqG45uZgXpO/1dQhelbyasaVBD2BB4Rygupl/TyzM6zmtti22WuG3e8fqKwBK+g3YlbQT
	 ByW9kXAY10fMMZuVGABWjUCn1VtlGZ7yIkrg9mLUsiRXEF/JGDyadO6fVTUWPdEUaXoqD
	 wRrzRJN4bPxKj2dx7AYyFaaLWA7vNYTQmTWvBPA3e14Zvqe8E5h4S467xxPHxddT85A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octaplex.net;
	spf=pass smtp.mailfrom=octaplex.net;
	arc=none smtp.remote-ip=88.99.165.17
Received: from cloud.octaplex.net (cloud.octaplex.net [88.99.165.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAABA60A2612;
	Tue, 10 Nov 2026 17:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAABA60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=octaplex.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octaplex.net
Received: from localhost (ip-178-027-246-237.vkd86.pools.vodafone-ip.de [178.27.246.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloud.octaplex.net (Postfix) with ESMTPSA id E4E13A0071;
	Tue, 10 Nov 2026 18:19:49 +0100 (CET)
Date: Tue, 10 Nov 2026 18:19:49 +0100
From: Tobias Dyckerhoff <tobias.dyckerhoff@octaplex.net>
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: i2c-hid: Synaptics 06CB:CD97 (Dell Latitude 7300) - touchpad
 failure modes: post-resume/mid-session IRQ storm, silent idle stall,
 coordinate jumps discarded by libinput; wedge captured at the raw-HID level
 (2026-11-10)
Message-ID: <avNR8dKtLhw7g5f4@ferret>
References: <avNI9_rElXTp48Mn@ferret>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avNI9_rElXTp48Mn@ferret>

All evidence referenced above (raw hid-recorder + evemu traces of both
wedge captures, environment and recurrence data) is attached to:

https://bugzilla.kernel.org/show_bug.cgi?id=222255

On Tue, Nov 10, 2026 at 05:43:22PM +0100, Tobias Dyckerhoff wrote:
> Hello,
> 
> recurring touchpad failures on a Dell Latitude 7300, Synaptics I2C-HID pad,
> HID v1.00:
> 
>     vendor 06cb product cd97  ("DELL08E0:00 06CB:CD97 Touchpad")
>     bus: i2c_designware.1, IRQ 17 (shared idma64.1 + i2c_designware.1)
>     Dell BIOS 1.43.0 (newest LVFS release; Dell's Synaptics touchpad
>         firmware utility does not list the Latitude 7300)
>     userspace: xf86-input-libinput, libinput 1.25 (Ubuntu noble)
> 
> The behaviour is identical on 6.8.0-147 (Ubuntu noble base),
> 7.0.0-42 (noble HWE) and 7.3.1 mainline (currently running, 6.5
> days up).  There is no 06CB:CD97 entry in any i2c-hid quirk table through
> v7.4-rc1 (RESET_ON_RESUME currently covers only the ALPS_JP
> any-product and SYNA2393 cases).  This is not a regression - it
> behaves the same on every kernel I have run on this machine.
> 
> 
> Three distinct failure modes
> 
> (1) IRQ storm.  IRQ17 fires at hundreds to thousands per second with
>     no usable input events.  First seen after a partially-failed
>     suspend + resume; later occurrences mid-session with no power
>     transition involved (measured via /proc/interrupts deltas:
>     ~480/s on one occasion, ~900/s, and ~3400/s on others).
>     Driver state looks healthy otherwise.  Recovery: unbind/bind of
>     i2c_hid_acpi (i.e. a HID RESET) restores the device within
>     seconds.  One occurrence was rebind-resistant (the rebind ran,
>     the pad re-probed, but the storm intensified); a full
>     suspend/resume cycle recovered that one.
> 
> (2) Silent idle stall.  After some minutes of idle, the pad stops
>     responding; IRQ17 goes completely silent while touching (zero
>     interrupts over seconds of finger contact) while the driver
>     still considers the device healthy (X-level props normal).  No
>     kernel log message at all.  Recovery: unbind/bind as above.
>     This matches in shape the 2026-04 report for 06CB:CE65
>     (Latitude 7420, unsolicited 0x0c sleep-notify report suspected;
>     I have no hidraw trace of my device doing the same - analog,
>     not confirmed for CD97).
> 
> (3) Coordinate-jump discard state.  IRQ17 fires at normal touch
>     report rates, the kernel delivers events, but libinput discards
>     every motion event:
> 
>       (EE) event5 - DELL08E0:00 06CB:CD97 Touchpad: kernel bug:
>       Touch jump detected and discarded.
> 
>     (84 occurrences in the current Xorg.0.log as of 2026-11-10, up
>     from 71 on Nov 8 and 31 the day before; libinput rate-limits the
>     message to 5/24h, but every user-space recovery re-opens the
>     evdev stream and re-arms the limit, so the true frequency is
>     higher).
> 
>     The pad is functionally dead.  Recovery:
>     `xinput disable <id>; xinput enable <id>` - i.e. merely
>     reopening the evdev stream - restores motion in ~1 s, no kernel
>     rebind needed.
> 
> Recurrence is multiple times per day. The local recovery log counts
> 53 user-side resets since the mitigation was installed on Nov 2
> (7/6/0/6/6/15/11/1/1 per day, Nov 2 through Nov 10), eight of them
> within one hour on Nov 8 - roughly one wedge every seven minutes.
> (Full log in the evidence bundle; a one-day follow-up snapshot with
> re-measured counters, evidence/03-persistence-20261108.txt, is part
> of the bundle; the Nov-10 episode below was captured end-to-end.)
> 
> 
> An odd baseline observation
> 
> On the current boot (6.5 days, mostly idle desk work) /proc/interrupts
> shows 97.2 million interrupts on IRQ17 - a sustained ~173/s average -
> while the sibling i2c_designware controllers sit at 0-2 interrupts
> each, and the pad works normally meanwhile.  An early re-measurement
> (89.2M at 4.9 days, then ~430/s over the previous 31 h) first read as
> an accelerating baseline; a further 39-hour follow-up on the same boot
> disproved that: the counter only rose to 97.2M, ~56/s across those 39
> hours despite one wedged episode inside them.  The background rate is
> episode-coupled: near zero while the pad sits untouched and healthy,
> and erupting during wedge states (captured at ~1.2 kHz wedged but
> idle, see below).  dmesg for this boot contains ZERO i2c-hid errors
> (no "incomplete report" lines at all) - including during the captured
> storm.  So even in its "working" state the device keeps the IRQ line
> far busier than its siblings do.
> 
> 
> Instrumented episode (2026-11-10; all traces in the bundle)
> 
> After an unremarkable s2idle suspend 09:24 -> resume 10:18 (no
> i2c-hid messages at all) the pad wedged again within ~20 minutes.
> Captured BEFORE recovery, twice, six minutes apart:
> 
>   * IRQ17 while touching the dead pad: 2421/s then 1598/s
>     (capture I), 3142/s then 3606/s (capture II); wedged but not
>     being touched it sustained ~1.2 kHz - that is roughly 20-30
>     interrupts per delivered report.
>   * hid-recorder on the wedged device ran flawlessly: the full
>     669-byte report descriptor plus 3,812 raw input reports (16 s
>     + 18 s captures).  Every single one is a standard 48-byte
>     ReportID 3 touch report: smooth coordinates (max step 57 of
>     1196 x-units = ~5 mm per 7.2 ms report), monotonic device
>     scan-time.  No truncated reports, no error reports, no
>     vendor report 0x0c.
>   * evemu-record shows the kernel delivering that same stream
>     (~80-140 reports/s) as perfectly normal MT events.
>   * Yet Xorg logged three fresh "Touch jump detected and
>     discarded" lines in those same minutes, and the cursor stayed
>     dead for the user throughout.
>   * Recovery was, once more, the evdev reopen alone (xinput
>     disable/enable).  Minutes later, idle, IRQ17 read literally
>     0 interrupts per 10 s.
> 
> So during this wedge the I2C transport, the HID layer and evdev all
> look healthy and quiet - zero kernel errors - while IRQ17 storms at
> ~25x the report rate and userspace discards every motion event.
> 
> 
> What works / what I could not fix
> 
>   * unbind/bind (HID RESET): reliable for (1) and (2), except the
>     one rebind-resistant case described above
>   * evdev reopen (xinput disable/enable): reliable instant fix for (3)
>   * BIOS 1.15.1 -> 1.43.0 upgrade: did not change anything
>   * no Dell touchpad firmware update exists for this device
> 
> 
> Questions
> 
>   1. Would an
>         { I2C_VENDOR_ID_SYNAPTICS, 0xCD97, I2C_HID_QUIRK_RESET_ON_RESUME }
>      entry be the right direction (cf. the Sep 2026 SYNA32A4 06CB:CE17
>      post-resume IRQ-storm discussion, where that quirk was proposed)?
>      The Nov-10 episode struck ~20 min after a clean resume, which
>      would fit that trigger.  I'm happy to build and test such a
>      patch for a week of real use.
>   2. The bundle now contains hid-recorder and evemu traces of a live
>      wedge (Nov 10, see above).  Is a deeper capture worth adding at
>      the next occurrence - i2cdump of the designware controller, an
>      i2c trace via ftrace, or something else?  Failures recur daily
>      here, so follow-ups are cheap.
>   3. The interrupts-per-report mismatch during a wedge (~25x, all
>      reports well-formed) - where would you want that looked at:
>      driver, controller, or firmware?  I can measure in whatever
>      form is useful (ftrace, i2c trace points, counters).
> 
> References to threads with the same signature family (other
> Synaptics 06CB devices):
> 
>   * Sep 2026, linux-input: "i2c-hid: IRQ storm from Synaptics
>     SYNA32A4 (06CB:CE17) after resume"
>   * Apr 2026, linux-i2c: 06CB:CE65 (Latitude 7420) - touchpad dies
>     after ~6 min idle, unsolicited report 0x0c suspected, driver
>     never answers, firmware locks up; rebind recovers
> 
> Evidence bundle (happy to send inline or as attachments, tell me
> what you prefer):
> 
>   environment       DMI, kernel config of the running 7.3.1, device
>                     stanzas, IRQ snapshot + counter math
>   recurrence        local reset log (53 resets over 9 days), plus a
>                     one-day persistence follow-up snapshot (IRQ17
>                     re-measured; episode-coupled, see above)
>   libinput-jumps   all "Touch jump" lines of the current boot
>   journal-samples   dmesg excerpts of the probe + one storm night
>   wedge-traces      the full Nov-10 instrumented episode: report
>                     descriptor + 3,812 raw reports + 2,812 evdev
>                     records + IRQ deltas + clean kernel logs
>                     (evidence/wedges/20261110-*/)
> 
> Best regards,
> Tobias
> 
