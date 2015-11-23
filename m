From: Tuomas =?iso-8859-1?Q?R=E4s=E4nen?= <tuomasjjrasanen@opinsys.fi>
Subject: Synaptics touchpad reset issue
Date: Mon, 23 Nov 2015 11:43:37 +0200
Message-ID: <20151123094336.GC11291@toimisto-tuomas-07.toimisto.opinsys.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34137 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbbKWJnl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2015 04:43:41 -0500
Received: by wmvv187 with SMTP id v187so151645439wmv.1
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2015 01:43:40 -0800 (PST)
Received: from toimisto-tuomas-07.toimisto.opinsys.fi (59ec6c11.adsl.tnnet.fi. [89.236.108.17])
        by smtp.gmail.com with ESMTPSA id m185sm2300425wmf.0.2015.11.23.01.43.39
        for <linux-input@vger.kernel.org>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Nov 2015 01:43:39 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi

We've noticed a quite bizarre touchpad behavior on one specific laptop
model, namely Acer TravelMate B115-M: occasionally the touchpad gets
really confused under normal usage and begins to emit events
autonomously, i.e. without any object touching the surface, which
results in a totally uncontrollable jumpy pointer. On some occasions,
the end result is a completely unresponsive, stationary pointer.

Disabling and enabling the touchpad via Fn+F7 (the touchpad toggle
function) or suspend+resume resets the condition back to normal.

The touchpad is handled by psmouse driver. Removing and re-adding
psmouse module does not fix the issue.

Reproducing the symptoms under normal usage is quite difficult, but
fortunately we (or to be more precise, Petri Toivola) found out that
sliding a moist paper (a cleaning wipe) on the touchpad to make a full
circle triggers the exactly same behavior (to be really precise, it does
not trigger when the surface gets moist, but when it dries up, around
1-2 seconds). We call it The Wet Circle of Death.

Similar behavior can be observed also on Windows 7:
https://www.youtube.com/watch?v=nDLIVuBmTOY

To me it seems like the touchpad somehow recalibrates itself and becomes
highly sensitive and begins to emits touch events even when there's no
one touching it. The sensitiveness can be observed by looking at MT_ABS
values: in normal conditions maximum values are around 120, but in
confused state they are around 190.

Now, I wonder if there's anything I can do to fix this
"programmatically"?

I ftraced during Fn+F7 and it seemed to make just several ACPI reads and
writes, the driver was not involved, and on the other hand, quite
obviously, no ACPI calls were involved when modprobing, which explains
why modprobing did not fix issue.

Are those ACPI spells something the driver could be expanded to make?

Is there anything the driver could do more to make the touchpad reset
"properly"?

On `modprobe psmouse`, dmesg says:

  [87072.953080] psmouse serio2: synaptics: queried max coordinates: x [..5662], y [..4728]
  [87072.982742] psmouse serio2: synaptics: queried min coordinates: x [1322..], y [1190..]
  [87073.040285] psmouse serio2: synaptics: Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd40123/0x840300/0x126800, board id: 2991, fw id: 1626681
  [87073.077169] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio2/input/input88

I've tested on different kernel versions, 4.2.5 and 4.0.6 (and also on
Ubuntu 3.13.0-55.94-generic), all behave the same.

-- 
Tuomas
