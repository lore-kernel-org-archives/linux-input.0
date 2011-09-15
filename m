From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Thu, 15 Sep 2011 09:16:49 -0700
Message-ID: <CAF8JNhKFz8-bJ4HMguU2qReageX4WBB1bWR0amRbYmaujNVX8A@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
	<20110913080911.GA4986@polaris.bitmath.org>
	<CAPHpN5OAPdPQ1SmwrGT6pMvgWESBOSnRvb0jKUszkU_31MFXWg@mail.gmail.com>
	<20110914071524.GA3422@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56878 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934067Ab1IOQQu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Sep 2011 12:16:50 -0400
Received: by ywb5 with SMTP id 5so2286045ywb.19
        for <linux-input@vger.kernel.org>; Thu, 15 Sep 2011 09:16:49 -0700 (PDT)
In-Reply-To: <20110914071524.GA3422@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Linux Input <linux-input@vger.kernel.org>

On Wed, Sep 14, 2011 at 12:15 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
> On Tue, Sep 13, 2011 at 10:18:28AM +0200, Mohamed Ikbel Boulabiar wrote:
>> Hi,
>>
>> On Tue, Sep 13, 2011 at 10:09 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> >
>> > . The question is then what behavior should be assigned to
>> > a large tablet without an embedded screen. It should have POINTER set
>> > for sure, but should it also have DIRECT set?
>>
>> Any large tablet without an embedded screen can be used in the 2 different ways:
>> 1. The projection on top of it so it becomes a direct device.
>> (this case is also used when you project 3d 120hz on top of multitouch
>> devices: iMuts)
>>
>> 2. Simple indirect device, even if it's large:
>> http://10gui.com/video/
>
> Two-finger scroll is actually used in a direct manner in that
> video. (Which, btw, does display some fresh concepts. :-))
>
> I think the bottom line is that even if the "directness" of a device
> is configurable, it still needs to have a default. Moreover, the
> notion of kernel mode settings could be applicable here too.

Talking about default mode, there are cases that the mode is decided
by the tools running on the device/tablet, instead of the tablet
itself.

Take Wacom's Intuos and Graphire series for example, those tablets
support both styli and mice. For styli, the default is absolute mode;
while for mice, it is relative. So, only valid property the tablet can
tell the user-land is: I am a tablet, i.e., not a touchscreen. Clients
have to check the tool types to set the default mode to relative
(BTN_TOOL_MOUSE/LENS) or absolute (BTN_TOOL_PEN/AIRBRUSH/RUBBER...).

Ping
