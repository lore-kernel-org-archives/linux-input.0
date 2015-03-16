From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 16 Mar 2015 15:50:51 -0500
Message-ID: <5507422B.5000805@dell.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>	<201502202141.16017@pali>	<54EE1917.4020805@dell.com>	<201502252145.22577@pali>	<CAN+gG=EY-gyNKyEyfXw8hTDL8L4TR8OQLM2g+uLUUv_HM3mHWA@mail.gmail.com>	<5506E8D2.60207@dell.com>	<CAOFGe97na_mw-_AHJn6zyxVb-kDAxntjEgvXRcy6eg7uPfhQ8A@mail.gmail.com>	<550725D9.20805@dell.com> <CAOFGe95VzKhvrFES9DHD4TB08XVd+pEMbDGVZ=fdAiDFLT9gVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from AUSXIPPC110.us.dell.com ([143.166.85.200]:50411 "EHLO
	ausxippc110.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933146AbbCPUvD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 16:51:03 -0400
In-Reply-To: <CAOFGe95VzKhvrFES9DHD4TB08XVd+pEMbDGVZ=fdAiDFLT9gVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Ekstrand <jason@jlekstrand.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, =?UTF-8?B?UGFsaSBS?= =?UTF-8?B?b2jDoXI=?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>


On 03/16/2015 03:42 PM, Jason Ekstrand wrote:
> On Mon, Mar 16, 2015 at 11:50 AM, Mario Limonciello
> <mario_limonciello@dell.com> wrote:
> Thanks,
> I'm now running a hacked up kernel that's Torvalds' tree from Saturday
> morning (same as before) + a patch from Benjamin to fix the touchpad +
> the DSDT hack given above.  With that, I have HDA audio (not I2S)
> which is working.  Also, suspend/resume now works properly with this
> new cocktail.
> --Jason
That's great to hear and definitely confirms that it was the sound card in the funky state causing the suspend/resume issues.  Testing is ongoing with that BIOS and if no issues crop up should be around soon.

Is this the patch from Benjamin that you're running?
http://pkgs.fedoraproject.org/cgit/kernel.git/commit/?h=f21&id=d75cb059558345e47a13881512a1600e3e17ba21
I haven't yet run it myself.  I'm curious, what sort of behavior change do you see with it?
