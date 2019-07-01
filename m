From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3] HID: sb0540: add support for Creative SB0540 IR
 receivers
Date: Mon, 01 Jul 2019 12:10:47 +0200
Message-ID: <25207fcb87900100fc00da17b2515fde79ecfb1e.camel@hadess.net>
References: <20190626140618.8944-1-hadess@hadess.net>
         <CAO-hwJJDf68gqgJZHQtAdjZcEzuL+LbOJD=OYHtod1xN6G+GjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAO-hwJJDf68gqgJZHQtAdjZcEzuL+LbOJD=OYHtod1xN6G+GjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Bastien Nocera <bnocera@redhat.com>
List-Id: linux-input@vger.kernel.org

On Mon, 2019-07-01 at 11:45 +0200, Benjamin Tissoires wrote:
> Hi Bastien,
> 
> On Wed, Jun 26, 2019 at 4:07 PM Bastien Nocera <hadess@hadess.net>
> wrote:
> > From: Bastien Nocera <bnocera@redhat.com>
> > 
> > Add a new hid driver for the Creative SB0540 IR receiver. This
> > receiver
> > is usually coupled with an RM-1500 or an RM-1800 remote control.
> > 
> > The scrollwheels on the RM-1800 remote are not bound, as they are
> > labelled for specific audio controls that don't usually exist on
> > most
> > systems. They can be remapped using standard Linux keyboard
> > remapping tools.
> 
> Much better commit message :)
> Thanks!
> 
> I have a few nitpicks however

Most of the checkpatch.pl warnings are now fixed. I ignored the one
about writing docs for the symbol (I have no idea what it wants, looks
like a false positive) and the too long line for the USB device match.

<snip>
> > +       /* force input as some remotes bypass the input
> > registration */
> > +       hid->quirks |= HID_QUIRK_HIDINPUT_FORCE;
> 
> Does this still applies to your remote?

Yes, you mentioned it in your original review as well, and it was
necessary.

v4's been sent.

Thanks!
