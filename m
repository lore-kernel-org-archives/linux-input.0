From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH 2/4] Input - synaptics: do not release extra buttons once
 they are pressed
Date: Thu, 5 Feb 2015 17:54:44 -0800
Message-ID: <54D41EE4.50402@synaptics.com>
References: <1422475807-15033-1-git-send-email-benjamin.tissoires@redhat.com> <1422475807-15033-3-git-send-email-benjamin.tissoires@redhat.com> <20150202214640.GC23909@dtor-ws> <CAN+gG=HBw6FYtVbgm=rLNEK5amxHkEqwTRtagTj14_Uf_iUv2Q@mail.gmail.com> <20150204212926.GD16434@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:33750 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751974AbbBFB5O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2015 20:57:14 -0500
In-Reply-To: <20150204212926.GD16434@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 02/04/2015 01:29 PM, Benjamin Tissoires wrote:
> On Feb 02 2015 or thereabouts, Benjamin Tissoires wrote:
>> On Mon, Feb 2, 2015 at 4:46 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>> On Wed, Jan 28, 2015 at 03:10:05PM -0500, Benjamin Tissoires wrote:
>>>> The current code releases the extra buttons right after they are pressed.
>>>> As soon as a new serio report comes in, the hw state is reset to 0
>>>> and so the buttons are released.
>>>>
>>>> Check for the report type before acting on the current extra buttons
>>>> state.
>>> No:
>>>
>>> "If Ext is 0 (if bit 1 of bytes 1 and 4 are the same) then there are no
>>> external buttons being pressed (or all external buttons have been
>>> released)." - Synaptics PS/2 TouchPad Interfacing Guide PN:
>>> 511-000275-01 Rev. B
>>>
>> Hmm, indeed, the current code follows the spec. Yeah! a new firmware bug!
>>
>> So when I dumped the ps/2 reports, I clearly saw the release report
>> being sent with the Ext bit to 1, and other reports were in between
>> with no information (because no fingers were on the touchpad).
>>
> OK, so with the hardware, here are the results:
>
> After each incoming event (being a button or touch), when there is no
> more information to send (i.e. touch released or button pressed or
> released), I receive 80 times the following buffer:
> 80 00 00 c0 00 00
>
> The number 80 seems quite consistant, though I got once 96.
> Not sure that this repeated buffer might be of interest however.
>
> When a finger is touched on the sensor, I receive the following:
>
> b0 ba 35 c0 8d ed <- first finger down on the sensor
> ....
> b0 ba 3b c0 6f d0
> b0 ba 3b c2 6d d0 <- button 1 pressed
> b0 ba 3b c0 6f d0
> ....
> b0 ba 3b c0 6f d0
> b0 ba 3c c2 6c d0 <- button 1 released
> b0 ba 3c c0 6f d0
> ....
> 90 ba 26 c0 6f d0
> 80 00 00 c0 00 00 <- first finger released from the sensor
> 80 00 00 c0 00 00 <- repeated 80 times
>
> So here, either the spec is wrong, either the Synaptics with FW 8.1 in
> the Lenovos are not following it. But I clearly see that the extended
> buttons are reported only when the Ext bit is 1.
>
> Andrew, could you help us determine which way to go?
> Ideally, could you point out at a firmware version where we could be
> sure that the spec has not been followed so we can add a quirk in the
> driver?

I got confirmation that this is a firmware bug and that it has probably 
been there since 2011. This bug is definitely in 8.1 and probably 
several versions before it. But, we haven't shipped anything with 
extended buttons in a long time, so applying the quirk to firmware 
revision 8.1 should be adequate. When we fix the bug we will bump the 
minor version.

Andrew

> Cheers,
> Benjamin

