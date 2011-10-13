From: Daniel Drake <dsd@laptop.org>
Subject: Re: Problem statement: Opportunistic suspend and i8042 wakeups
Date: Thu, 13 Oct 2011 15:25:04 +0100
Message-ID: <CAMLZHHTjZdxiRsEP=tQyQafkPHftOtq6XRgd09MdCJowSxKCvA@mail.gmail.com>
References: <CAMLZHHQH=vWDnQH-Gnz01yDFv=wqG1de5nezb2B+H6VSJieg5A@mail.gmail.com>
	<20111010203815.GA25314@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62071 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab1JMOZF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Oct 2011 10:25:05 -0400
Received: by gyb13 with SMTP id 13so58283gyb.19
        for <linux-input@vger.kernel.org>; Thu, 13 Oct 2011 07:25:04 -0700 (PDT)
In-Reply-To: <20111010203815.GA25314@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: rjw@sisk.pl, Paul Fox <pgf@laptop.org>, linux-input@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org

Hi,

Thanks for not getting bored of this :)

On Mon, Oct 10, 2011 at 9:38 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> I think input layer releasing keys at resume time is actually in the
> wrong here, as it meddles with device state after physical device
> (i8042, atkbd, etc) are fully woken up.

Yes, that's whats happening here.

> IIRC I put releasing originally in resume because I was concerned
> with events getting discarded after S2D because we thew away the state
> that happens after taking snapshot and there weren't enough granularity
> in PM callbacks to differentiate between S2D and S2R.
>
> I believe if we move release of the keys into suspend handlers then
> input core should not get into the middle of things for your case as you
> said that the OLPC device will not suspend with a key still pressed and
> upon release we would not be doing anything with key state (but
> restore LED/SOUND only) which you do not care about.

Not quite.

The system will suspend, but will resume immediately (because of an
incoming key press interrupt, which are repeated when the key is held
down). So, if Linux fabricates a key release event in the suspend
handler, userspace would see two key release events: the fabricated
one, and the one that comes from when the user later releases the key
resulting in a break interrupt.  This would cause two characters to be
printed on screen when the user only pressed the key once.

Daniel
