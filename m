From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH] HID: elecom: fix the descriptor of the EX-G trackball
Date: Sun, 19 Nov 2017 01:04:16 +0000
Message-ID: <20171119010416.GB15931@gaia.local>
References: <CAGqt0zzPC56sU5=GDS=FkwpTcnjoHotwhOZQ8bEf01=ePObk_A@mail.gmail.com>
 <20171118222726.GA14579@gaia.local>
 <20171119002353.GA15931@gaia.local>
 <CAHcsgXR0_q9tFodLYMddBa1Qc2SMqsN02ncY0WKYQ72SRq2oAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:46266 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938004AbdKSBEW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 20:04:22 -0500
Content-Disposition: inline
In-Reply-To: <CAHcsgXR0_q9tFodLYMddBa1Qc2SMqsN02ncY0WKYQ72SRq2oAQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>
Cc: Yuxuan Shui <yshuiv7@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Alex Manoussakis <amanou@gnu.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Nov 19, 2017 at 12:31:45AM +0000, Diego Elio Pettenò wrote:
> Please do not drop the explicit documentation of the diff. Looking at what
> a driver does in three years is not going to be obvious, whether you know
> HID or not.

I'm sure there are situations where this is true but I've just gone
through the first six HID drivers in the order that grep found them in
when I searched for "report_fixup" and in all but one I was either
informed of the issue and the fix using a short and concise comment,
annotations on the replacement descriptor or the commit message. The one
report_fixup which was unclear had been moved out of hid-input-quirks.c
(when it was a thing) and I didn't actually feel like finding its
original commit message, it could probably have been clarified by a
rather simple comment.

Even the existing report_fixup of the BM084 has a one line comment which
entirely explains what the problem is.

I really don't think a big diagram showing the difference between two
report descriptors, which may or may not completely overlap with the
report descriptors of other devices exhibiting a similar issue, is
necessary.

Please also note that the documentation is not gone, it's just
shortened and generalised, there is still more than enough information
to work out exactly what the report change is.

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/
