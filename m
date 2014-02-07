From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: PROBLEM: [Dell LATITUDE E7440] ALPS touchpad events are not
 routed into /dev/input/mice and /dev/input/mouseX
Date: Fri, 7 Feb 2014 12:44:49 -0500
Message-ID: <20140207174449.GA5540@ubuntu-build.winmagic.local>
References: <CA+F6ckO02oxrgx3-9Fhu3XQFX_8WrUFL5_LTjA8-mUpZMy7QaQ@mail.gmail.com>
 <CABSveYhh-3WVnEUKDaYjdbTBQLwPJ1YnJ3toT0kxXd=9aECHyA@mail.gmail.com>
 <CAJiQ=7BgrY2aASfv0N4xx6TnZa1DSgvZdAzcg5XNYiMcpeFkjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35113 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753582AbaBGRo6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Feb 2014 12:44:58 -0500
Received: by mail-ie0-f169.google.com with SMTP id to1so1888828ieb.28
        for <linux-input@vger.kernel.org>; Fri, 07 Feb 2014 09:44:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJiQ=7BgrY2aASfv0N4xx6TnZa1DSgvZdAzcg5XNYiMcpeFkjA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: Tommy Will <tommywill2011@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi all,

On Fri, Feb 07, 2014 at 08:46:08AM -0800, Kevin Cernekee wrote:
> On Fri, Feb 7, 2014 at 7:18 AM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> > Hi Tommy,
> >
> > [    2.674857] input: AlpsPS/2 ALPS GlidePoint as
> > /devices/platform/i8042/serio1/input/input6
> 
> Could you confirm that you're seeing actual ALPS V5 absolute reports
> with the patched driver, not just emulated PS/2 mouse reports?
> 
> Do edge scrolling and multitouch work correctly on the patched driver?
What is the easiest way to do it?

> 
> > ...and before my patch (current kernel behavior):
> > [    1.604029] input: Lid Switch as
> > /devices/LNXSYSTM:00/device:00/PNP0C0D:00/input/input0
> > [    1.606813] input: Power Button as
> > /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input1
> > [    1.608991] input: Sleep Button as
> > /devices/LNXSYSTM:00/device:00/PNP0C0E:00/input/input2
> > [    1.610997] input: Power Button as
> > /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> > [    3.636959] input: AT Translated Set 2 keyboard as
> > /devices/platform/i8042/serio0/input/input4
> > [    8.377859] input: DualPoint Stick as
> > /devices/platform/i8042/serio1/input/input5
> > [    8.542194] input: AlpsPS/2 ALPS DualPoint TouchPad as
> > /devices/platform/i8042/serio1/input/input6
> 
> This laptop does have a trackstick, correct?
> 
> (I see it on the Dell spec sheet but I'd like to confirm your unit has it.)
Yes, it does. There is a trackstick beetween G,H,B keys.

--
  Vasily
