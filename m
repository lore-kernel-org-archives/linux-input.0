From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: HID: Dead ./debug/hid/xxx/events
Date: Wed, 16 Nov 2011 07:41:04 -0600
Message-ID: <CAGzDe_bdyvOnMJb12gQN9wPSn_dk-g_HxgkEP-x_3DRtB+gP1g@mail.gmail.com>
References: <20111116095030.GC3335@slate>
	<CAN+gG=F2aFTkhUVp4Sf8p-PdAj5ft1eotuWbnP=WaYAugA8tVw@mail.gmail.com>
	<20111116102514.GA3831@slate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57832 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab1KPNlG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Nov 2011 08:41:06 -0500
Received: by eye27 with SMTP id 27so431296eye.19
        for <linux-input@vger.kernel.org>; Wed, 16 Nov 2011 05:41:04 -0800 (PST)
In-Reply-To: <20111116102514.GA3831@slate>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cedric Sodhi <manday@gmx.net>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org

On Wed, Nov 16, 2011 at 4:25 AM, Cedric Sodhi <manday@gmx.net> wrote:
> Dear Benjamin,
>
> On Wed, Nov 16, 2011 at 11:17:57AM +0100, Benjamin Tissoires wrote:
>> Hi Cedric,
>>
>> If I understand correctly, your device is an eGalax one with a Wacom
>> VendorID... ;-)
>
> No. The VID is that of DWAV, as it should be. It might have been
> misleading to mention Wacom here, which is - at least with regard to the
> issue at hand - not related. I was just lucky the guys (esp. Chris) at
> linuxwacom-devel would take a look at the issue, since obviously, they
> are experts on touchscreens.
>>
>> I assume that you're the first of a long list that will encounter this
>> kind of problem:
>
> You are right. I'm not the first, either, though. The eGalax is the
> touchdevice of the ASUS EEE Slate, in conjunction with a Wacom for the
> pen (yes, two devices: eGalax for finger and Wacom for pen).
>>
>> Now, hid (the generic hid input layer) can detect if your device is a
>> multitouch one (by relying on the ContactID field in the report
>> descriptor), and it will release it if it's detected.
>> The counter part of this autodetection (in hid-multitouch) has not
>> been judged as enough mature to be included in the kernel, and
>> hid-multitouch can't handle your device automatically.
>>
>> That's why you don't see any event* unless you add the VID:PID in
>> hid-multitouch.
>
> That's what I already did, as I tried to describe by saying that I added
> "MULTITOUCH5" in line with the other MULTITOUCH[1-4] of DWAV VID.
>
>>
>> I'm currently working on a solution to allow end-user to test more
>> efficiently their device with hid-multitouch.
>> If you want to be my guinea pig, it would help me.
>
> I'd happily be your guinea pig. I suggest you browse through the thread
> which I referred to, where Chris helped me solve a bulk of the problems
> already and also told me how to add the VID:PID to the whitelist of
> hid-multitouch.
>
> regards,
> Cedric
>>
>> Cheers,
>> Benjamin
>>
>> On Wed, Nov 16, 2011 at 10:50, Cedric Sodhi <manday@gmx.net> wrote:
>> > Hello everyone,
>> >
>> > the context for this problem is getting the eGalax USB Touchscreen, ID
>> > 056a:0090, to work as such, as it is discussed on the linuxwacom-devel
>> > list (see [1]).
>> >
>> > Quickly summarized:
>> >
>> > Adding the device as USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH5, in line with
>> > the ..._MULTITOUCH[1-4], succeeds in thus far, as that it appears as a
>> > HID Touchscreen. However, as of 3.1.x, clicking, id est touching "jams"
>> > as in the click is never released.
>> >
>> > Updating to 3.2.x-torvalds' kernel should have resolved that jamming,
>> > but instead no clicks or releases are recognized at all.
>> >
>> > The real problem with debugging that, though, is that
>> >
>> > /sys/kernel/debug/hid/<eGalax>/events
>> >
>> > remains dead, in any kernel, 3.1.x-gentoo, 3.1.x-vanilla and
>> > 3.2.x-torvalds alike.
>> >
>> > I hope that you may have an idea as for any of the problems, especially
>> > why there appears no output on the ./events node (the according node for
>> > my keyboard reports events just fine).
>> >
>> > Pasted is .config [2] for 3.2.x-torvalds and ./hid/<eGalax>/rdesc [3] on
>> > 3.2.x-torvalds.
>> >
>> > [1]
>> > http://sourceforge.net/mailarchive/forum.php?thread_name=CAGzDe_Y2cSMxVPm-rcNSrMsew2V5Y0vbVyhXJBFCKraq7EaZ8g@mail.gmail.com&forum_name=linuxwacom-devel
>> > [2] http://paste.pocoo.org/show/508548/
>> > [3] http://paste.pocoo.org/show/508550/
>> > --

And a little extra info.  Cedric tested the patch that is now in
Jiri's upstream-fixes branch for this new 0xa0001 and got success so I
sent in patch.  After several days, he tested closer and realized it
was getting X/Y movement and what I'll call unpredictable Touch
behaviour.  It would either act like a stylus hovering but never
touching or it would always act like touching and never release.

Events are working and you can test with evtest.  I've verified at
least one test stream he emailed that it is not correctly sending
BTN_TOUCH but it is sending good X/Y using MT and pointer emulation
events.

It would probably be easy to see the issue if debug/hid/*/events were
being displayed but for some reason "cat rdesc" outputs stuff but "cat
events" does not.  I couldn't come up with more ideas remotely.

The redesc shows it reports ContactID's range of 0-16 and features
says only 10 touches max (seen in above paste link).  So my last guess
is that we may be using the wrong quirk for this one since it sounds
like ContactID is not 1-to-1 with touches.  Hard to tell without
sample events though.

Chris
