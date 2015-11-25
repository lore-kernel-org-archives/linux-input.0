From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] serio: delay resume error handling til PM complete
Date: Wed, 25 Nov 2015 09:39:20 -0800
Message-ID: <20151125173920.GA23632@dtor-ws>
References: <CAKdAkRQk6xQTsY=fH7UNYbxiZeYh4rOZpL6wv6a1QzSy9i=Cpw@mail.gmail.com>
 <Pine.LNX.4.44L0.1511251020430.1679-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34812 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbKYRjX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2015 12:39:23 -0500
Received: by padhx2 with SMTP id hx2so63604110pad.1
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2015 09:39:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1511251020430.1679-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Todd Brandt <todd.e.brandt@linux.intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, todd.e.brandt@intel.com

On Wed, Nov 25, 2015 at 10:24:07AM -0500, Alan Stern wrote:
> On Tue, 24 Nov 2015, Dmitry Torokhov wrote:
> 
> > On Tue, Nov 24, 2015 at 4:58 PM, Todd Brandt
> > <todd.e.brandt@linux.intel.com> wrote:
> > >  Delay the error rescan for serio devices until the PM
> > >  complete phase. PM complete requires locking each device
> > >  before checking for and executing the complete callbacks.
> > >  Serio rescan also locks the device in order to reinit on
> > >  error, so this can cause a conflict which will result in
> > >  unnecessary delay.
> > >
> > >  History:
> > >
> > >  The issue was discovered on an ivy bridge platform with
> > >  i8042 keyboard/mouse. The mouse resume fails
> > 
> > I'd first try to figure out why reconnect failed. What kind of
> > mouse/touchpad is that?
> > 
> > > and the serio
> > >  driver begins a full driver rescan in the resume phase. Since
> > >  the device is locked during re-initialization it conflicts
> > >  with the PM subsystem's attempt to lock the device to check
> > >  for a complete callback. Thus dpm_complete is delayed for
> > >  almost a second.
> > >
> > >  I've tried to fix this by altering the PM subsystem code
> > >  itself so that it doesn't have to lock a device in order to
> > >  check if it has a callback, but this was too much for an
> > >  isolated case. This approach attempts to fix the problem in
> > >  the serio driver itself.
> > 
> > Hmm, there is nothing specific to serio here. Any slow-to-probe device
> > might wedge the process like that.
> 
> USB is a little similar.  Probing can be slow, but it is carried out in 
> a workqueue thread.  Since the workqueue is marked as FREEZABLE, it 
> doesn't run at all during any stage of system sleep, so the problem 
> can't arise.

Serio used to have freezable workqueue, but because PS/2 protocol is
slow we want to start talking to the device as soon as possible to
minimize amount of time where UI is shown but user is "stuck" because
mouse does not move.

Thanks.

-- 
Dmitry
