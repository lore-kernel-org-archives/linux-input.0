From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] Add a quirk for the Dell XPS 13 (2015) when in PS/2 mode.
Date: Mon, 16 Mar 2015 17:07:09 -0400
Message-ID: <CAN+gG=Hg7u27PXryAt37+dgvwr4SHG9Bf_woNNxd7=nQVvZDAA@mail.gmail.com>
References: <1424310180-2512-1-git-send-email-mario_limonciello@dell.com>
	<201502202141.16017@pali>
	<54EE1917.4020805@dell.com>
	<201502252145.22577@pali>
	<CAN+gG=EY-gyNKyEyfXw8hTDL8L4TR8OQLM2g+uLUUv_HM3mHWA@mail.gmail.com>
	<5506E8D2.60207@dell.com>
	<CAOFGe97na_mw-_AHJn6zyxVb-kDAxntjEgvXRcy6eg7uPfhQ8A@mail.gmail.com>
	<550725D9.20805@dell.com>
	<CAOFGe95VzKhvrFES9DHD4TB08XVd+pEMbDGVZ=fdAiDFLT9gVg@mail.gmail.com>
	<5507422B.5000805@dell.com>
	<CAOFGe94xt0i-if+SP3Y7EtQ+0TkW4i41SXV1g3RyRQZW+ssDDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:33876 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbbCPVHK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 17:07:10 -0400
In-Reply-To: <CAOFGe94xt0i-if+SP3Y7EtQ+0TkW4i41SXV1g3RyRQZW+ssDDg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Ekstrand <jason@jlekstrand.net>
Cc: Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Rob <robr.bensson@gmail.com>

On Mon, Mar 16, 2015 at 4:57 PM, Jason Ekstrand <jason@jlekstrand.net> wrote:
> On Mon, Mar 16, 2015 at 1:50 PM, Mario Limonciello
> <mario_limonciello@dell.com> wrote:
>>
>> On 03/16/2015 03:42 PM, Jason Ekstrand wrote:
>>>
>>> On Mon, Mar 16, 2015 at 11:50 AM, Mario Limonciello
>>> <mario_limonciello@dell.com> wrote:
>>> Thanks,
>>> I'm now running a hacked up kernel that's Torvalds' tree from Saturday
>>> morning (same as before) + a patch from Benjamin to fix the touchpad +
>>> the DSDT hack given above.  With that, I have HDA audio (not I2S)
>>> which is working.  Also, suspend/resume now works properly with this
>>> new cocktail.
>>> --Jason
>>
>> That's great to hear and definitely confirms that it was the sound card in
>> the funky state causing the suspend/resume issues.  Testing is ongoing with
>> that BIOS and if no issues crop up should be around soon.
>
> Thanks!  I look forwarding to *not* running a hacked-up kernel soon.
>
>> Is this the patch from Benjamin that you're running?
>> http://pkgs.fedoraproject.org/cgit/kernel.git/commit/?h=f21&id=d75cb059558345e47a13881512a1600e3e17ba21
>> I haven't yet run it myself.  I'm curious, what sort of behavior change do
>> you see with it?
>
> It reports as touchpad with a single button.  This makes the kernel
> report it as a "clickpad".  In particular, this means that libinput
> knows to make clicking in the lower-right turn into a right-click.
> With out that, there was no way to right-click since it reports as
> having a single button.  Benjamin could tell you more than me.

Yes, that's the gist of it.
Mario, you might not have seen the problem because you are not running
wayland and/or libinput. The xorg synaptics driver is much more
relaxed concerning what it received from the kernel and I think it
sets most of the time the right software button area if it sees only
one button.

Cheers,
Benjamin
