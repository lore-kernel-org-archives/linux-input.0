From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: add new keycodes useful in mobile
	devices
Date: Tue, 27 Oct 2009 09:20:40 -0700
Message-ID: <20091027162040.GB22541@core.coreip.homeip.net>
References: <cover.1256200562.git.ext-jani.1.nikula@nokia.com> <72a6deb76f693b5e50dbfe150154e7a4724d0568.1256200562.git.ext-jani.1.nikula@nokia.com> <20091023071315.GA3986@core.coreip.homeip.net> <1256568215.10718.271.camel@jani-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:34127 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755895AbZJ0QUk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2009 12:20:40 -0400
Received: by pwj9 with SMTP id 9so187841pwj.21
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2009 09:20:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1256568215.10718.271.camel@jani-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jani Nikula <ext-jani.1.nikula@nokia.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, Oct 26, 2009 at 04:43:35PM +0200, Jani Nikula wrote:
> Hi Dmitry -
> 
> On Fri, 2009-10-23 at 09:13 +0200, ext Dmitry Torokhov wrote:
> > Hi Jani,
> > 
> > On Thu, Oct 22, 2009 at 12:32:20PM +0300, Jani Nikula wrote:
> 
> > > +#define SW_PROXIMITY		0x0b  /* set = proximity sensor covered */
> > 
> > Don't quite like the name for this one, any alternatives?
> 
> SW_PROXIMITY is admittedly pretty vague, but I don't quite know how
> specific you'd like it to be. The main idea is to indicate that the
> device is covered, for example because it's in your pocket or near your
> ear, so the UI should probably adapt to the situation (for example
> disable touchscreen and display on some devices). Someone might also use
> it as a "button" you don't have to touch.
> 
> How about one of these?
> 
> SW_FRONT_COVERED
> SW_FRONT_PROXIMITY
> SW_DISPLAY_COVERED
> SW_DISPLAY_PROXIMITY
> SW_EARPIECE_MODE (too specific IMHO)
> 

Actually I like the "earpiece mode" because it describes the intended
use. Another option I think would be SW_HOLSTER_MODE. Proximity made me
think alll kinds of things but not the "phone in a pocket" scenario...

-- 
Dmitry
