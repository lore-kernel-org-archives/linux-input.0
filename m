From: Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Fri, 15 Jan 2016 19:22:31 +0100
Message-ID: <569938E7.3090509@vmware.com>
References: <20160115123928.d06e1fed.cand@gmx.com>
 <5698D343.3000606@vmware.com> <20160115132312.654ad5aa.cand@gmx.com>
 <56991418.1070701@vmware.com> <20160115175040.GA5664@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:50923 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753620AbcAOSWi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 13:22:38 -0500
In-Reply-To: <20160115175040.GA5664@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lauri Kasanen <cand@gmx.com>, linux-input@vger.kernel.org

On 01/15/2016 06:50 PM, Dmitry Torokhov wrote:
> On Fri, Jan 15, 2016 at 04:45:28PM +0100, Thomas Hellstrom wrote:
>> On 01/15/2016 12:23 PM, Lauri Kasanen wrote:
>>> On Fri, 15 Jan 2016 12:08:51 +0100
>>> Thomas Hellstrom <thellstrom@vmware.com> wrote:
>>>
>>>>> Seems the new and shiny VMWare mouse driver does not pass events
>>>>> to /dev/input/mice, rudely breaking userspace that doesn't
>>>>> support absolute input devices.
>>>>>
>>>>> Can this be changed? Would there be any downside to passing those
>>>>> events?
>>>> Hi, Lauri.
>>>> What particular use-case is broken?
>>> VMWare + 4.2 kernel + Xvesa. This was reported for the current TinyCore
>>> beta, which has that kernel.
> Although we will make vmmouse work with /dev/input/mice, could you
> please tell TinyCore that 90s are calling and they want their mouse
> technology back? And tell them to switch to switch to evdev X driver.
>
>>>> I'm assuming what's happening is that only the relative device gets
>>>> recognized as a mouse, and by default we don't send events through that
>>>> device.
> No, this is not correct, mousedev (the one that provides
> /dev/input/mouseX and /dev/input/mice) should bind to absolute device
> exported by vmmouse on this rule:
>
> 	{
> 		.flags = INPUT_DEVICE_ID_MATCH_EVBIT |
> 			INPUT_DEVICE_ID_MATCH_KEYBIT |
> 			INPUT_DEVICE_ID_MATCH_ABSBIT,
> 		.evbit = { BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS) },
> 		.keybit = { [BIT_WORD(BTN_LEFT)] = BIT_MASK(BTN_LEFT) },
> 		.absbit = { BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) },
> 	},	/* Mouse-like device with absolute X and Y but ordinary
> 		   clicks, like hp ILO2 High Performance mouse */
>
> and it should convert absolute events to relative motion.
>
Ah. Thanks for clarifying!

/Thomas

