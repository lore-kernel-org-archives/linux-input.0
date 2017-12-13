From: Tomasz Kramkowski <tk@the-tk.com>
Subject: Re: [PATCH] HID: elecom: rewrite report fixup for EX-G and future
 mice
Date: Wed, 13 Dec 2017 21:47:46 +0000
Message-ID: <20171213214746.GA23615@gaia.local>
References: <20171204205550.2621-1-tk@the-tk.com>
 <20171205201307.GA13831@gaia.local>
 <nycvar.YFH.7.76.1712071103120.3572@cbobk.fhfr.pm>
 <20171209172311.GA5570@gaia.local>
 <nycvar.YFH.7.76.1712111128080.3572@cbobk.fhfr.pm>
 <20171211173116.GA9941@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from erebus.the-tk.com ([109.74.205.187]:40600 "EHLO
        erebus.the-tk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbdLMVr4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Dec 2017 16:47:56 -0500
Content-Disposition: inline
In-Reply-To: <20171211173116.GA9941@gnu.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Manoussakis <amanou@gnu.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>, Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.eu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Dec 11, 2017 at 12:31:16PM -0500, Alex Manoussakis wrote:
> Tomasz please add the wireless version in your next patch, a web search
> shows it's called M-XT3DRBK and the USB ID is 0x00fc.

M-XT3DRBK is the full model number for the wireless EX-G but since the
HUGE and DEFT both use their short names in the hid-ids macros then I'll
call this one EX_G_WIRELESS so that it matches the naming style of
everything else.

However, I'm a bit apprehensive about sending in a patch for a device I
can't test. Even if it's most likely going to work. Do you know of
anyone who can test this wireless EX-G variant?

I guess Jiri can chip in if he thinks this is not necessary. Technically
this patch should sit in linux-next for a while (but reportedly few
people actually run on that iirc) and the worst that could happen is
that the checks in the report fixup function don't match the expected
report and don't apply the fix, or (unlikely) some padding bits get
exposed as buttons with no function.

Either way, I've made this change locally and will be submitting v2 when
I have a bit more time later this week.

> Thanks,
> Alex

-- 
Tomasz Kramkowski | GPG: 40B037BA0A5B8680 | Web: https://the-tk.com/
