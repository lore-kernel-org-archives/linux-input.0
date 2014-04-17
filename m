From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3] synaptics: Add min/max quirk for ThinkPad T431s, L440,
 L540, S1 Yoga and X1
Date: Thu, 17 Apr 2014 17:53:10 +0200
Message-ID: <534FF8E6.7060305@redhat.com>
References: <1397734903-26088-1-git-send-email-hdegoede@redhat.com> <1397734903-26088-2-git-send-email-hdegoede@redhat.com> <20140417153500.GA17495@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20140417153500.GA17495@core.coreip.homeip.net>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <btissoir@redhat.com>, Peter Hutterer <peter.hutterer@redhat.com>, linux-input@vger.kernel.org, stable@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

On 04/17/2014 05:35 PM, Dmitry Torokhov wrote:
> Hi Hans,
> 
> On Thu, Apr 17, 2014 at 01:41:43PM +0200, Hans de Goede wrote:
>> We expect that all the Haswell series will need such quirks, sigh.
> 
> Given this statement do we really want this to be handled in kernel?

I know this answer won't make you happy, but short term: Yes, we are
getting many many bugreports about this, ie:

https://bugzilla.redhat.com/show_bug.cgi?id=1060885
https://bugzilla.redhat.com/show_bug.cgi?id=1068716
https://bugzilla.redhat.com/show_bug.cgi?id=1085582
https://bugzilla.redhat.com/show_bug.cgi?id=1085697
https://bugzilla.redhat.com/show_bug.cgi?id=1086227

And by extending the *already present* quirk table we can get this
issue resolved quickly, and also resolve it for people running
older kernels through the various stable series.

> Maybe we simply want udev to fix up the limits with EVIOSABS(),

Ah, I did not know that it is possible to fixup the min/max values
from user space, that is good to know.

> similarly to how we adjust keymaps for laptops?

We're currently looking into various ways to make this less painful,
specifically for most laptops the problem seems to be the min value
and not the max value. And the troublesome min value is the synaptics
driver default, not the one we get from the firmware. The problem is
we never ask the firmware because even though it has the "I can report
min values" capability bit, its "maximum understood request" number
is too low, so one of our 2 checks for getting the min value is
failing. If we remove that check some models do give us a proper
range (but not all, ie the T440s is still wrong).

We're currently trying to figure out if it will be safe for all models
to remove the "maximum understood request" number check. That should ie
remove the quirk for the x240 and possible others.

An other option to make this better is to switch the quirks to using
pnp-ids, ie the L440 and L540 share the same pnp-id. Once you've
merged the firmware_id patches I can take a shot at simplifying the
quirk table that way. Downside is that we then probably need to
put the firmware_id patches in the various stable kernels.

Note that even if we end up moving this to userspace, then we still
need the firmware_id, because I believe any userspace solution should
be using pnp-ids too.

TL;DR: It is complicated and for now we would like to continue with
the quirks as we've done sofar. We are aware that this is undesirable
from a maintenance pov and are looking into making this better.

Regards,

Hans
