From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: Re: [RFC PATCH 1/1] Input: add new keycodes useful in mobile
	devices
Date: Mon, 26 Oct 2009 16:43:35 +0200
Message-ID: <1256568215.10718.271.camel@jani-desktop>
References: <cover.1256200562.git.ext-jani.1.nikula@nokia.com>
	 <72a6deb76f693b5e50dbfe150154e7a4724d0568.1256200562.git.ext-jani.1.nikula@nokia.com>
	 <20091023071315.GA3986@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:52217 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbZJZOoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2009 10:44:16 -0400
In-Reply-To: <20091023071315.GA3986@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry -

On Fri, 2009-10-23 at 09:13 +0200, ext Dmitry Torokhov wrote:
> Hi Jani,
> 
> On Thu, Oct 22, 2009 at 12:32:20PM +0300, Jani Nikula wrote:

> > +#define SW_PROXIMITY		0x0b  /* set = proximity sensor covered */
> 
> Don't quite like the name for this one, any alternatives?

SW_PROXIMITY is admittedly pretty vague, but I don't quite know how
specific you'd like it to be. The main idea is to indicate that the
device is covered, for example because it's in your pocket or near your
ear, so the UI should probably adapt to the situation (for example
disable touchscreen and display on some devices). Someone might also use
it as a "button" you don't have to touch.

How about one of these?

SW_FRONT_COVERED
SW_FRONT_PROXIMITY
SW_DISPLAY_COVERED
SW_DISPLAY_PROXIMITY
SW_EARPIECE_MODE (too specific IMHO)


BR,
Jani.


