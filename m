From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 24/26] HID: wiimote: support Nintendo Wii U Pro Controller
Date: Wed, 8 May 2013 10:26:04 -0700
Message-ID: <20130508172604.GB30057@core.coreip.homeip.net>
References: <1367788390-29835-1-git-send-email-dh.herrmann@gmail.com>
 <1367788390-29835-25-git-send-email-dh.herrmann@gmail.com>
 <CAFmpkyhFHS1CHDLTRbGdYe5B5XkW-JyavZotvffZT3BnkQSdOA@mail.gmail.com>
 <CANq1E4Q9X7+e_HSbB2Y0GykgJAuF9ui1x1GtssiwOXWKhVUfvQ@mail.gmail.com>
 <CAFmpkyiSw3_mXG-bokbcu-wTUAQmMDBYvqpKQg5eT8Ke+vAPrA@mail.gmail.com>
 <CANq1E4T9eoBVvbq8J+2ps5CJ-9G1782j7TjanqWLJVUCQ1k60g@mail.gmail.com>
 <CAFmpkyigapfb52ke-8vvKcwqmF8EVsUF8md-0kFTHHDxDzKxRA@mail.gmail.com>
 <20130508170536.GA30057@core.coreip.homeip.net>
 <CAFmpkyj90KoGgLeOqb3x00qBQ7Hmj3Fd_tXuWujx08QueV_9uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:43047 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab3EHR0I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 May 2013 13:26:08 -0400
Received: by mail-pb0-f53.google.com with SMTP id un1so1365827pbc.12
        for <linux-input@vger.kernel.org>; Wed, 08 May 2013 10:26:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFmpkyj90KoGgLeOqb3x00qBQ7Hmj3Fd_tXuWujx08QueV_9uQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Todd Showalter <todd@electronjump.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

On Wed, May 08, 2013 at 01:20:58PM -0400, Todd Showalter wrote:
> On Wed, May 8, 2013 at 1:05 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> 
> > Or you have your library that provides ABS->BTN translation.
> >
> > You can even have your API structured such that consumer provides list
> > of events it is interested in and the library tries to synthesize
> > missing events if it can.
> 
>     That's in the plans.
> 
> > So we already have:
> >
> > #define BTN_A                   0x130
> > #define BTN_B                   0x131
> > #define BTN_C                   0x132
> > #define BTN_X                   0x133
> > #define BTN_Y                   0x134
> > #define BTN_Z                   0x135
> > #define BTN_TL                  0x136
> > #define BTN_TR                  0x137
> > #define BTN_TL2                 0x138
> > #define BTN_TR2                 0x139
> > #define BTN_SELECT              0x13a
> > #define BTN_START               0x13b
> > #define BTN_MODE                0x13c
> > #define BTN_THUMBL              0x13d
> > #define BTN_THUMBR              0x13e
> >
> > So if we really want to have BTN_NORTH, etc, we want to alias existing
> > ones.
> 
>     The problem is that the alias differs with hardware.  BTN_A would be:
> 
> - BTN_SOUTH on xbox gamepads
> - BTN_EAST on nintendo gamepads and ouya
> 
>     Nintendo is:
> 
> A -> WEST
> B -> SOUTH
> X -> NORTH
> Y -> EAST
> 
>    While Microsoft is:
> 
> A -> SOUTH
> B -> EAST
> X -> WEST
> Y -> NORTH
> 
>     They're mirror images of each other. So just aliasing is going to
> break something.

We should take existing in-kernel mapping (that would be XBOX and other
less advanced gamepads in drivers/input/joystick), alias
NORTH/SOUTH/EAST/WEST accordingly, have new users use NSEW button
definitions.

Thanks.

-- 
Dmitry
