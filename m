From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [RESEND] Lenovo Yoga 900 touchpad issues
Date: Wed, 16 Dec 2015 14:58:11 -0800
Message-ID: <CAOhV88Mv+RUADPHT5AwD=dR-VdPn7Cmf4TkJoaBjNA4Q6zL6WQ@mail.gmail.com>
References: <CAOhV88MGoJdUzty=DDTLOkd7me5uoRWwTTrR8aD=zf5ga0_Hew@mail.gmail.com>
	<20151216092858.GP1762@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33376 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbLPW6M (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Dec 2015 17:58:12 -0500
In-Reply-To: <20151216092858.GP1762@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Duggan <aduggan@synaptics.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Seth Forshee <seth.forshee@canonical.com>, Dan Carpenter <dan.carpenter@oracle.com>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 16, 2015 at 1:28 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Tue, Dec 15, 2015 at 11:14:32AM -0800, Nish Aravamudan wrote:
>> [Apologies for the resend, didn't realize I hadn't changed my GMail settings
>> to not use HTML.]
>>
>> I have recently purchased a Lenovo Yoga 900 and most everything is working
>> with a slightly modified 4.4-rc5 (https://lkml.org/lkml/2015/11/30/441 applied
>> to enable the touchpad itself), I am seeing two issues:
>>
>> 1) On suspend/resume, the touchpad is non-functional. A `modprobe -r i2c-hid;
>>  modprobe i2c-hid` "fixes" it.
>>
>> The kernel emits:
>>
>> i2c_hid i2c-SYNA2B29:00: failed to reset device.
>> dpm_run_callback(): i2c_hid_resume+0x0/0xc0 [i2c_hid] returns -61
>> PM: Device i2c-SYNA2B29:00 failed to resume: error -61
>>
>> During the resume. So perhaps this is a timing issue (given that once
>> resumed, the
>> module reload does work?).
>
> Linus noticed this as well and Jiri suggested the below patch which
> seemed to fix the issue (although it increased resume time a bit).
>
> I was supposed to get one Lenovo Yoga 900 here to debug this issue but
> I'm still waiting for it (sloow big corporation bureaucracy takes some
> time to get things purchased outside).

With the patch applied to my patched 4.4-rc5, things seem to be
working now. I do get one "failed to reset device" message in the
logs, but then I'm guessing the second one succeeds and I don't see
the "failed to resume" message.

-Nish
