From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Tue, 15 Dec 2015 11:14:32 -0800
Message-ID: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36861 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbbLOTOc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2015 14:14:32 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

[Apologies for the resend, didn't realize I hadn't changed my GMail settings
to not use HTML.]

I have recently purchased a Lenovo Yoga 900 and most everything is working
with a slightly modified 4.4-rc5 (https://lkml.org/lkml/2015/11/30/441 applied
to enable the touchpad itself), I am seeing two issues:

1) On suspend/resume, the touchpad is non-functional. A `modprobe -r i2c-hid;
 modprobe i2c-hid` "fixes" it.

The kernel emits:

i2c_hid i2c-SYNA2B29:00: failed to reset device.
dpm_run_callback(): i2c_hid_resume+0x0/0xc0 [i2c_hid] returns -61
PM: Device i2c-SYNA2B29:00 failed to resume: error -61

During the resume. So perhaps this is a timing issue (given that once
resumed, the
module reload does work?).

2) During boot, the following is emitted:

i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report size:19 / ret_size:18

I'm not sure if this indicates a hardware or driver bug? With
i2c-hid.debug=1, I see:

i2c_hid i2c-ITE8396:00: report (len=19): 12 00 5a ff ff ff ff ff ff ff
ff ff ff ff ff ff ff ff 06
i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report size:19 / ret_size:18

Any suggestions?

Thanks,
Nish
