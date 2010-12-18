From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] psmouse: disable the synaptics extension on OLPC
 machines.
Date: Fri, 17 Dec 2010 23:02:06 -0800
Message-ID: <20101218070205.GA15847@core.coreip.homeip.net>
References: <20101217210939.19b6111a@queued.net>
 <20101218054927.GA14718@core.coreip.homeip.net>
 <20101217221447.375b9977@queued.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:48537 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751686Ab0LRHCM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Dec 2010 02:02:12 -0500
Content-Disposition: inline
In-Reply-To: <20101217221447.375b9977@queued.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andres Salomon <dilinger@queued.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dsd@laptop.org, pgf@laptop.org, James Cameron <quozl@laptop.org>

On Fri, Dec 17, 2010 at 10:14:47PM -0800, Andres Salomon wrote:
> On Fri, 17 Dec 2010 21:49:28 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Fri, Dec 17, 2010 at 09:09:39PM -0800, Andres Salomon wrote:
> > > 
> > > OLPC has switched to a Synaptics touchpad.  It turns out that it's
> > > pretty useless in absolute mode.  This patch looks for an OLPC
> > > system (via DMI tables), and refuses to init Synaptics mode in
> > > that scenario (falling back to relative mode).
> > > 
> > > Signed-off-by: Andres Salomon <dilinger@queued.net>
> > 
> > Andres,
> > 
> > Can we do what hgpk does and add "depend on !OLPC" to the Kconfig
> > instead?
> > 
> > Thanks.
> > 
> 
> That wouldn't work for distro kernels, unfortunately.  Currently the
> kernels that OLPC releases disable CONFIG_MOUSE_PS2_SYNAPTICS.  I'd
> like to use a stock distribution kernel, which would need to enable
> both CONFIG_OLPC *and* CONFIG_MOUSE_PS2_SYNAPTICS.. Hence the
> motivation for this patch. :)

What about just adding psmouse.proto=exps then?

-- 
Dmitry
