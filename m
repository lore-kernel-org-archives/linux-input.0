From: Patrik Fimml <patrikf@chromium.org>
Subject: Re: Power-managing devices that are not of interest at some point in
 time
Date: Wed, 16 Jul 2014 16:17:07 -0700
Message-ID: <20140716231707.GA24781@google.com>
References: <20140716013206.GA13409@google.com>
 <5611777.bNi5p029gt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:62026 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbaGPXRK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jul 2014 19:17:10 -0400
Received: by mail-pa0-f44.google.com with SMTP id eu11so2161060pac.3
        for <linux-input@vger.kernel.org>; Wed, 16 Jul 2014 16:17:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5611777.bNi5p029gt@vostro.rjw.lan>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Patrik Fimml <patrikf@chromium.org>, linux-pm@vger.kernel.org, Dmitry Torokhov <dtor@google.com>, Benson Leung <bleung@google.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 17, 2014 at 01:11:31AM +0200, Rafael J. Wysocki wrote:
> Let me try to understand the scenario in the first place.
> 
> To start with, a number of devices is in use (that is, open, there are
> applications listening/talking to them etc).  Now, an event happens, such
> as a laptop lid close and you want some of those devices, but possibly
> not all of them, to quiesce themselves and go into low-power states.
> 
> Is that correct?

Yes, that is accurate.

The primary example is a laptop with an external monitor and mouse
attached which you're using with the lid closed. You want the mouse to
work, but input from the touchpad that might result from the lid being
close to it should be skipped. Also, the touchpad should enter a
low-power state.

We think that triggering this is probably best done in userspace, but
we would need a way of telling devices to quiesce themselves.

And as Oliver has pointed out, it might be desirable to preserve some
state/settings of devices. And it's probably undesirable to go through
the whole process of completely unregistering the device and then
probing/resetting/configuring it again.

Kind regards,
Patrik
