From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Wed, 8 May 2013 10:05:36 -0700
Message-ID: <20130508170536.GA30057@core.coreip.homeip.net>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
 <1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
 <CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
 <CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
 <CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
 <CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
 <CAFmpkyigapfb52ke-8vvKcwqmF8EVsUF8md-0kFTHHDxDzKxRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f44.google.com ([209.85.210.44]:40075 "EHLO
	mail-da0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab3EHRFl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 May 2013 13:05:41 -0400
Received: by mail-da0-f44.google.com with SMTP id z8so1091630daj.17
        for <linux-input@vger.kernel.org>; Wed, 08 May 2013 10:05:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyigapfb52ke-8vvKcwqmF8EVsUF8md-0kFTHHDxDzKxRA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Wed, May 08, 2013 at 12:40:51PM -0400, Todd Showalter wrote:
> On Wed, May 8, 2013 at 11:33 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> 
> >>     They're digital on the classic pro, but they're analog on the
> >> classic, IIRC.  I believe they also have separate "button" values when
> >> they bottom out, much like the gamecube controller, but that's beyond
> >> the scope of the standard gamepad I'm proposing.
> >
> > What's the problem with using both, ABS _and_ BTN? I don't think we
> > should do any interpretation in the kernel. Devices that have analog
> > triggers report ABS_XTRIG, devices with digital triggers report
> > BTN_TX. Userspace simply needs to listen for both. And if a device
> > exports both (like the Wii classic controller), they simply export
> > both and userspace chooses whatever it prefers.
> 
>     My opinion is that the kernel is the right place to provide
> hardware abstraction, and that a standard gamepad is useful the same
> way a standard mouse, a standard ethernet device or a standard
> filesystem interface are useful abstractions.  That is, I don't want
> to have to care who made it if I want to make normal use of it.  My
> opinion isn't universally shared, however, so I'm working on a library
> to sit between the kernel and things that want a standard gamepad.
> 
> > As long as both ABS_XTRIG and BTN_TX are defined to correspond to the
> > same triggers, I think it's better to use both. Or am I missing
> > something?
> 
>     The problem is the specific thing I'm trying to solve with the
> idea of the standard gamepad.  Right now, if I open() something in
> /dev/input that seems like it ought to be a gamepad, I get a giant
> unsorted bag of events that are only comprehensible via a priori
> knowledge.  I keep coming back to the ps3 controller because it's the
> worst offender that I've found; the right stick maps to ABS_Z, ABS_RZ,
> while the XBox controller right stick maps to ABS_RX, ABS_RY.  This is
> not documented anywhere I've found, and I've no idea what quirks other
> controllers have in their mappings or whether they are documented or
> not.

So PS3 gamepad is such a mess because we simply do not have a driver
that maps the buttons properly. IIRC it gets bound to a generic HID
driver that enumerates absolute axis in a very naive fashion. I think
there were some effort in making PS3 work in userspace (in BT mode), but
I do not know if it was ever completed.

So for PS3 what we need is a HID driver providing proper mapping,
nothing more, nothing less.

> 
>     What I'm trying to do is make it so that there are five categories
> of control, in order of usefulness to games:
> 
> 1) known controls that all sane gamepads will have (left stick, dpad,
> NSEW buttons...)
> 2) known controls that most sane gamepads will have (right stick...)
> 3) known controls that many gamepads have (system/mode button, select button...)
> 4) common things (accelerometers...)
> 5) device-specific controls
> 
>     Right now, almost everything is in bucket 5, and from a game
> development point of view that sucks.  The further up the buckets we
> can move a control, the better.
> 
>     So, the problem that I have with "devices that have analog
> triggers report XTRIG, devices with digital triggers report TX" is
> that absent a common mapping I now potentially have to care about the
> difference when I'm developing a game.  It moves these to bucket 3,
> which means as a developer I likely just don't use them unless my game
> really needs them.

Or you have your library that provides ABS->BTN translation.

You can even have your API structured such that consumer provides list
of events it is interested in and the library tries to synthesize
missing events if it can.

> 
> > As I said before, I don't really care. I will send v2 with a patch
> > that introduces these buttons. Lets see what Dmitry thinks.

So we already have:

#define BTN_A                   0x130
#define BTN_B                   0x131
#define BTN_C                   0x132
#define BTN_X                   0x133
#define BTN_Y                   0x134
#define BTN_Z                   0x135
#define BTN_TL                  0x136
#define BTN_TR                  0x137
#define BTN_TL2                 0x138
#define BTN_TR2                 0x139
#define BTN_SELECT              0x13a
#define BTN_START               0x13b
#define BTN_MODE                0x13c
#define BTN_THUMBL              0x13d
#define BTN_THUMBR              0x13e

So if we really want to have BTN_NORTH, etc, we want to alias existing
ones.

-- 
Dmitry
