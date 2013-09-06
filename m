From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [GIT] HID for 3.12 merge window
Date: Fri, 6 Sep 2013 23:59:10 +0200
Message-ID: <20130906215910.GA356@x4>
References: <alpine.LNX.2.00.1309061202050.26934@pobox.suse.cz>
 <20130906202022.GA353@x4>
 <CANq1E4Rf4c4zj1mD1aPr93Q2_M65DCEJhuLqcBWa5uH9tcKuWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANq1E4Rf4c4zj1mD1aPr93Q2_M65DCEJhuLqcBWa5uH9tcKuWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On 2013.09.06 at 23:50 +0200, David Herrmann wrote:
> Hi
> 
> On Fri, Sep 6, 2013 at 10:20 PM, Markus Trippelsdorf
> <markus@trippelsdorf.de> wrote:
> > On 2013.09.06 at 14:00 +0200, Jiri Kosina wrote:
> >>
> >> David Herrmann (12):
> > ...
> >>       HID: wiimote: add support for Guitar-Hero drums
> >
> >  commit 61e00655e9cb82e034eb72b95a51072e718d14a7
> >  Author: David Herrmann <dh.herrmann@gmail.com>
> >  Date:   Mon Aug 26 19:14:46 2013 +0200
> >
> >      Input: introduce BTN/ABS bits for drums and guitars
> >
> > The commit above breaks my Logitech mouse. The mouse cursor just sits in
> > the middle of the screen and doesn't react to movements. dmesg is
> > normal, but Xorg.0.log says:
> 
> Ok, the issue is the kernel assumes ABS_MAX to be a power-of-2 minus 1
> (used as mask). That wasn't really obvious to me. Attached is a patch
> which should fix that. Could you apply it on top of linus/master and
> give it a try?

Your patch fixes the issue. Thanks.

-- 
Markus
