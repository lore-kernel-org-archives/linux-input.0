From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] Documentation: Add evdev type and code definitions
Date: Thu, 24 Mar 2011 22:50:23 -0700
Message-ID: <20110325055023.GB4137@core.coreip.homeip.net>
References: <1300988652-25353-1-git-send-email-chase.douglas@canonical.com>
 <AANLkTimv3ZVQmgB-tbMthCYdEsK3Spk0WY9Vs9VLQEVs@mail.gmail.com>
 <4D8B9F6F.5010705@canonical.com>
 <20110325003602.GA14035@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48713 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab1CYFu3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 01:50:29 -0400
Content-Disposition: inline
In-Reply-To: <20110325003602.GA14035@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Chase Douglas <chase.douglas@canonical.com>, Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>, Nikolai Kondrashov <spbnick@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 25, 2011 at 10:36:02AM +1000, Peter Hutterer wrote:
> On Thu, Mar 24, 2011 at 03:45:51PM -0400, Chase Douglas wrote:
> > On 03/24/2011 02:44 PM, Chris Bagwell wrote:
> > > Looking good.  Minor comments at end.
> > > 
> > > On Thu, Mar 24, 2011 at 12:44 PM, Chase Douglas
> > > <chase.douglas@canonical.com> wrote:
> > >> +Touchscreens:
> > >> +----------
> > >> +ABS_{X,Y} must be reported with the location of the touch. BTN_TOUCH must be
> > >> +used to report when a touch is active on the screen.
> > >> +BTN_{MOUSE,LEFT,MIDDLE,RIGHT} must not be reported. BTN_TOOL_<name> events
> > >> +should be reported where possible.
> > > 
> > > Does the real button event restriction solve something?  I know
> > > majority of touchscreens are not sending a button today but usually
> > > there is a button on the touchscreen frame that I'd image at least
> > > some devices hooking it up to touchscreen interface.
> > >
> > > stylus+touchscreen combo devices are surely going to want to do this.
> > 
> > Perhaps this should be more clearly for touchscreen-only devices (not
> > tablets or a mix). The problem we end up seeing is drivers who use
> > BTN_LEFT because they want a touch to generate a primary button press in
> > X. I want to prevent people from doing this.
> 
> suggest that they use BTN_0 instead then?
> 

Umm, I'd hope X evdev driver could handle BTN_TOUCH without
BTN_LEFT/BTN_0 to indicate primary button. Legacy mode (mousedev)
already translateds BTN_TOUCH/BTN_LEFT/BTN_0 into "left PS/2 button".

Thanks.

-- 
Dmitry
