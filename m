From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH v3] bcm5974: Set BUTTONPAD property
Date: Wed, 11 Jan 2012 22:36:16 +0100
Message-ID: <4F0E00D0.4060201@canonical.com>
References: <20120110102211.GA7682@polaris.bitmath.org> <1326193009-7361-1-git-send-email-jussi.pakkanen@canonical.com> <20120110114212.GA2142@polaris.bitmath.org> <20120111073812.GB18668@core.coreip.homeip.net> <4F0D5521.5030808@canonical.com> <20120111100444.GA5573@polaris.bitmath.org> <4F0D5FCE.6080809@canonical.com> <20120111171848.GA21047@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56215 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933947Ab2AKVgS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Jan 2012 16:36:18 -0500
In-Reply-To: <20120111171848.GA21047@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jussi Pakkanen <jussi.pakkanen@canonical.com>, linux-input@vger.kernel.org

On 01/11/2012 06:18 PM, Dmitry Torokhov wrote:
> On Wed, Jan 11, 2012 at 11:09:18AM +0100, Chase Douglas wrote:
>> On 01/11/2012 11:04 AM, Henrik Rydberg wrote:
>>>>> Applied, however I removed stable notation as this change IMO does not
>>>>> qualify for the stable since it does not address a regression.
>>>>
>>>> It's not a regression per-se, but we want to fix buttonpad support, and
>>>> we can't do that without this patch. It's a clear bug that when the
>>>> property was added we did not set the property in the devices that need it.
>>>
>>> The current behavior depends on userspace and is not a kernel bug,
>>> please stop the nonsense already.
>>>
>>> For bcm5974 devices, extracting buttonpad properties has been possible
>>> since early 2009 (158e9287). The mechanism, predating the input
>>> properties interface by nearly two years, has been used in the
>>> multitouch and mtrack X drivers ever since. To those users, the
>>> present patch has no effect at all.
>>
>> Just because an alternative interface has existed does not mean there
>> isn't a bug. 
> 
> No, there isn't a bug. The driver simply does not support new interface
> yet. In all our discussions, AFAIR, property bits were always supposed
> to carry only advisory role, i.e. if a driver sets them up then
> userspace has it easy and can act upon them. Absence of a property does
> not guarantee anything.

The problem is that we can't determine "absence" from "false". If
EVIOCGPROP returned an error when the driver did not support property
bits, then that would be different. However, if a driver does not set
property bits it appears to userspace as though all properties are false.

Henrik's proposal of using the bcm5974-specific driver capabilities
interface would require code like:

Get props
if (props == 0) {
  try bcm5974-specific interface
  try ...-specific interface
  try ...-specific interface
}

This is not a reasonable solution for userspace. If you're going to
argue that we need a thread-safe ioctl to get the current touch slot
state, you can't honestly ask userspace to do this :).

Because we can't determine "absence" separate from "falseness", the
interface can't really be "advisory", which I don't remember being the
case anyways. To illustrate the point, proper click and drag support in
X will require knowing whether a trackpad is a buttonpad. It may be
required for multitouch support (we're still working out the details for
trackpads). We will be filing more patches to add buttonpad properties
to hid-magicmouse, synaptics, and maybe more.

Any distro that will ship a new X.org with multitouch support and a
kernel that is 3.2 or earlier will require these patches to function
properly. Think of all the android devices out there with older kernels.
People may want to flash distros with latest X.org on top of android
kernels. Locked bootloaders means we can't be sure we can replace the
kernel, even when we actually get the sources :).

> Hmm, speaking of properties, shouldn't we set INPUT_PROP_POINTER on
> bcm5974 while we are at it?

I'm still confused on what INPUT_PROP_POINTER means, and how it is
different from INPUT_PROP_DIRECT. I *think* we all agree on what
INPUT_PROP_DIRECT means, but I don't want to set INPUT_PROP_POINTER on
any devices before we have a clear definition.

Henrik, can you comment on the documentation patches? You wrote the
patch, so you hopefully know what's going on :).

>> A device that has a physical property, but does not set the
>> property bit in the driver is a real bug that needs to be fixed.
>> Userspace should not have to quirk around broken implementations.
>>
>> It's true that userspace can quirk around things in a kernel that
>> predates the property bits, but where the property bits are available
>> the devices *must* set them or else things will break.
> 
> If you are already supporting older kernels that do not support property
> bits then you should already be set.
>
> Anyway, this is not a regression and not even new hardware enablement:
> 
> " - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>    security issue, or some "oh, that's not good" issue.  In short,
>    something critical.
>  - New device IDs and quirks are also accepted."
> 
> Therefore I do not feel that stable nomination is warranted. You may
> still send it to stable, I'll add similar comment to that request and
> leave it up to Greg to decide if he still wants to put it into stable.

It doesn't fit exactly any of the categories, but stable isn't really
cut-and-dry. What do you think should happen if a patch is not
"critical" according to the above definitions, but would nonetheless be
required by many distros because without it things would not work
properly. Should every distro apply the patch individually, after
hitting bugs and spending valuable developer time tracking down the fix,
or should the patch be sent through the stable queue so everyone can
benefit?

Obviously, I think it makes sense to send a safe patch like this through
the stable queue so everyone benefits (and I still believe this is a
"bug fix" due to the inability to determine "absence" of a property). If
you disagree, we can easily distro-patch this and every other patch we
send for property bits.

-- Chase
