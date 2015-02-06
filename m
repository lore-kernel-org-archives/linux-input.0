From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [RFC] Input - synaptics: re-route tracksticks buttons on the
 Lenovo 2015 series
Date: Thu, 5 Feb 2015 21:19:28 -0500
Message-ID: <CAN+gG=E0KYbp_2mg1Nph8bK=bhpz=SnGPfx4DPpAzekeLpNB+Q@mail.gmail.com>
References: <1423168683-12507-1-git-send-email-benjamin.tissoires@redhat.com>
	<54D419D3.5080807@synaptics.com>
	<20150206014924.GB21288@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:39817 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbBFCT3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 21:19:29 -0500
In-Reply-To: <20150206014924.GB21288@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Feb 5, 2015 at 8:49 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Feb 05, 2015 at 05:33:07PM -0800, Andrew Duggan wrote:
>> On 02/05/2015 12:38 PM, Benjamin Tissoires wrote:
>> >Lenovos 2015 series has the physical tracktick buttons wired
>> >through the touchpad. The kernel should re-route them through
>> >the pass-through interface.
>> >
>> >Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>> >---
>> >
>> >Hi Dmitry,
>> >
>> >Well, in one of your replies regarding the Synaptics Lenovo 2015
>> >series, you mentioned that you wouldn't mind having the trackstick
>> >buttons re-routed through the trackstick (pass-through interface).
>> >
>> >I came out with this patch (checkpatch complains a lot about it but
>> >today's setup is not that convenient), and I'd like to hear what you
>> >think of it.
>> >
>> >If you agree to go this path, I'll remove the warnings from checkpatch
>> >and do a proper submission.
>> >
>> >The patch is still not future proof (if Synaptics updates the board like
>> >they did for the *40 series, we will need to fix this all over again),
>> >so I might have a little bit more of work to do. Anyway, it works.
>>
>> I discovered that there is a firmware query to determine if the
>> touchpad has stick buttons which are wired to the touchpad and are
>> reported as extended buttons. Query $01 bit 17 indicates that Query
>> $10 exists. Then Query $10 bit 0 indicates indicates the extended
>> buttons should be mapped to the guest stick buttons.
>>
>> Additional information and some diagrams are in the pdf here:
>> https://www.dropbox.com/s/vv1j4zsytgrw7mm/synaptics-tp-stick-buttons.pdf?dl=0
>
> Awesome, thanks Andrew.
>

Yep, definitively awesome. Also the firmware bump when you will fix
the auto-repeat key will greatly help us.

I'll prepare a patch series tomorrow!

Cheers,
Benjamin
