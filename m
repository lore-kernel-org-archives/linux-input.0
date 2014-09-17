From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Tue, 16 Sep 2014 18:44:02 -0700
Message-ID: <5418E762.5040802@valvesoftware.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>	<CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>	<CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>	<20140915215728.GB13468@core.coreip.homeip.net>	<CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>	<20140915225809.GA31798@core.coreip.homeip.net>	<CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>	<8227f0fc35950a902241a8e053924ef3.squirrel@mungewell.org> <CAON4U=PT9k9j15QyuA-qjDtPQcXMz4Y9_Z0wFV4ydMqoOk8CAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.valvesoftware.com ([208.64.203.181]:45248 "EHLO
	smtp01.valvesoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbaIQCRo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Sep 2014 22:17:44 -0400
In-Reply-To: <CAON4U=PT9k9j15QyuA-qjDtPQcXMz4Y9_Z0wFV4ydMqoOk8CAg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Wright <michaelwr@android.com>, simon@mungewell.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, HID CORE LAYER <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

My issue with the LED subsystem is that to my knowledge, the only thing 
that it currently exposes is an opaque brightness value that has plenty 
of different meanings depending on what is actually being exposed. It 
would need to be overhauled to support the usecase at hand, which would 
be a lot more work than just applying this patch, on top of all the 
other problems already mentioned with finding and using the sysfs LED 
interface.

With this change all the gamepad drivers could easily plumb through 
their device-specific way of exposing player IDs, and a userspace 
component could easily ensure consistency between logical player IDs and 
their LEDs.

If such a thing was attempted currently with gamepads that are wired up 
to LED classes, the userspace component would need to have special 
knowledge of each driver to be able to know which special brightness 
value to set to get player N to light up on the controller. This isn't 
solvable without significantly expanding the interface to the LED subsystem.

Michael, I assume such a userspace component is what you're shooting for 
with this work?

In SteamOS the individual gamepad drivers are modified to automatically 
apply player IDs from the joydev device IDs, which in turn are the 
logical game controller IDs that are exposed by libraries such as SDL to 
games and as such are reflected through their UI.

This was deemed too ad-hoc to be upstreamable and your patch seems like 
the right first step towards a cleaner, albeit slightly more complex 
solution. Trying to leverage the LED system seems a lot more complex, 
without adding any value to this solution.

Thanks,
  - Pierre-Loup

On 09/15/2014 09:06 PM, Michael Wright wrote:
> On Mon, Sep 15, 2014 at 7:00 PM,  <simon@mungewell.org> wrote:
>> One problem that exists is that many HID devices don't have an (embedded)
>> serial number, so identification can be confused if you have more that one
>> identical device.
>
>
> That's a pretty serious problem since this is explicitly for multiple
> gamepads connected to the same device, which will most likely be all
> the same type.
>

