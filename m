From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Support for Stantum multitouch panel
Date: Thu, 10 Dec 2009 23:52:39 -0800
Message-ID: <20091211075238.GA30274@core.coreip.homeip.net>
References: <20091209214928.1E24D9520C@smtp.lii-enac.fr> <20091209231516.GF10138@core.coreip.homeip.net> <25E41E82-8D85-43DB-A47C-4F7FBDA0293F@enac.fr> <20091210182844.GC23717@core.coreip.homeip.net> <20091211000318.GE13607@barra.bne.redhat.com> <20091211001922.GF23717@core.coreip.homeip.net> <20091211003504.GF13607@barra.bne.redhat.com> <20091211004719.GG23717@core.coreip.homeip.net> <20091211005831.GI13607@barra.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:46480 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760882AbZLKHwh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 02:52:37 -0500
Received: by pwj9 with SMTP id 9so440774pwj.21
        for <linux-input@vger.kernel.org>; Thu, 10 Dec 2009 23:52:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091211005831.GI13607@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Benjamin Tissoires <tissoire@cena.fr>

On Fri, Dec 11, 2009 at 10:58:31AM +1000, Peter Hutterer wrote:
> On Thu, Dec 10, 2009 at 04:47:20PM -0800, Dmitry Torokhov wrote:
> > On Fri, Dec 11, 2009 at 10:35:04AM +1000, Peter Hutterer wrote:
> > > On Thu, Dec 10, 2009 at 04:19:22PM -0800, Dmitry Torokhov wrote:
> > > > > are we talking about kernel drivers or userspace drivers here?
> > > > > 
> > > > > not handling ABS_MT_X, ABS_MT_Y properly in evdev is a bug (well,
> > > > > not-yet-implemented feature) but if the kernel hands out both ABS_X and
> > > > > ABS_MT_X that makes it difficult to determine which event is a valid one and
> > > > > which one can be ignored.
> > > > > 
> > > > 
> > > > No, it is pretty simple - all events are valid, otherwise it is kernel
> > > > driver bug. Now, as userspace consumer, if you know how to handle
> > > > multitouch protocol then use it, ignore ABS_X/ABS_Y. Otherwise you'd be
> > > > dropping ABS_MT_* events and naturally handling ABS_X/ABS_Y.
> > > 
> > > Thanks, that's the answer I hoped for - if ABS_MT_X is available, we can
> > > ignore ABS_X.
> > > 
> > > The tricky part would have been if both were equally valid _at the same
> > > time_ but refer to different inputs. at which point you'd have to find out
> > > which one to map to which pointer axis, etc. We already have a problem with
> > > REL_X and ABS_X on the same device, adding the ABS_MT_X to that mess
> > > wouldn't have helped the situation.
> > 
> > What devices report both ABS_X and REL_X events?
> 
> Xen Virtual Pointer
> AlpsPS/2 ALPS GlidePoint

Hmm, ALPS should not be reporting REL_X/REL_Y on touchpad device, only
on the secondary device. I will fix it, thank you for the report.

-- 
Dmitry
