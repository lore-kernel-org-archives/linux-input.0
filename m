From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Documentation: Add evdev type and code definitions
Date: Thu, 24 Mar 2011 22:53:07 -0700
Message-ID: <20110325055307.GC4137@core.coreip.homeip.net>
References: <1300988652-25353-1-git-send-email-chase.douglas@canonical.com>
 <20110325004240.GA13453@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53525 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab1CYFxN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 01:53:13 -0400
Content-Disposition: inline
In-Reply-To: <20110325004240.GA13453@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 25, 2011 at 10:42:40AM +1000, Peter Hutterer wrote:
> On Thu, Mar 24, 2011 at 01:44:12PM -0400, Chase Douglas wrote:
> > This commit adds the file Documentation/input/evdev-codes.txt.
> > 
> > Cc: Henrik Rydberg <rydberg@euromail.se>
> > Cc: Chris Bagwell <chris@cnpbagwell.com>
> > Cc: Peter Hutterer <peter.hutterer@who-t.net>
> > Cc: Nikolai Kondrashov <spbnick@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Acked-by: Henrik Rydberg <rydberg@euromail.se>
> > Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
> > ---
> > This revision has been a long time coming. Sorry for the delay! Changes from the
> > previous revision:
> > 
> > * Use EVIOCG* to retrieve evdev state and note sysfs capabilities info
> > * Clarify wording of BTN_TOOL_<name> and BTN_TOUCH usage for multi-finger modes
> > * Remove KEY_POWER, KEY_SUSPEND documentation
> > * State that EV_PWR is not well defined and will be addressed later
> > * Add text about reporting switch state when binding or resuming
> > * Add a "Guidelines" section describing basic mouse, touchscreen, and trackpad
> >   protocol usage
> > 
> > This is perhaps more important than ever before. We're seeing a lot of new
> > drivers that were obviously only written to support Android and do not conform
> > to the evdev protocol that X.org's input modules need and expect. I've had
> > multiple people come to me asking why their android derived touchscreen driver
> > isn't working properly in Ubuntu, only to find that the driver is only reporting
> > ABS_MT_POSITION_{X,Y} and ABS_MT_TOUCH_MAJOR. Hopefully this will help others
> > understand what is required for a full window management system based on
> > historical X.org usage.
> > 
> >  Documentation/input/evdev-codes.txt |  238 +++++++++++++++++++++++++++++++++++
> >  1 files changed, 238 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/input/evdev-codes.txt
> > 
> > diff --git a/Documentation/input/evdev-codes.txt b/Documentation/input/evdev-codes.txt
> > new file mode 100644
> > index 0000000..473ce9d
> > --- /dev/null
> > +++ b/Documentation/input/evdev-codes.txt
> > @@ -0,0 +1,238 @@
> > +The evdev protocol uses a map of types and codes to express input device values
> > +to userspace. This document describes the types and codes and how and when they
> > +may be used.
> 
> the term "event" is overloaded. You use EV_SYN to "separate events" but
> EV_REL to "describe relative input events". some explanation before you
> start with the Types would be useful. e.g.
> 
>     A single hardware event may result in multiple struct input_event. Each
>     such event contains the new value of a single data item. EV_SYN is used
>     to separate between hardware events. In the following, the term "event"
>     refers to a single struct input_event and the term "hardware event" to
>     an a series of struct input_events that reflect the hardware state
>     change.
> 
> and then use some other word instead of events for the remainder.

I was trying to use "packet" for a set of events between and including
EV_SYN/SYN_REPORT.

-- 
Dmitry
