From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atkbd - Add force relese key quirk for HP ProBook
Date: Tue, 28 Feb 2012 17:03:11 -0800
Message-ID: <20120229010311.GA11492@core.coreip.homeip.net>
References: <1330475770-4153-1-git-send-email-manoj.iyer@canonical.com>
 <1330475770-4153-2-git-send-email-manoj.iyer@canonical.com>
 <20120229004604.GB21093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50422 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030228Ab2B2BDT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Feb 2012 20:03:19 -0500
Content-Disposition: inline
In-Reply-To: <20120229004604.GB21093@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Manoj Iyer <manoj.iyer@canonical.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Tue, Feb 28, 2012 at 04:46:04PM -0800, Greg KH wrote:
> On Tue, Feb 28, 2012 at 06:36:10PM -0600, Manoj Iyer wrote:
> > HP ProBooks do not send a key release for brightness keys, as a
> > result, brightness does not move up/down when the brightness key
> > is held down. This quirk makes the brightness keys on HP ProBooks
> > typematic.
> > 
> > Signed-off-by: Manoj Iyer <manoj.iyer@canonical.com>
> > ---
> >  drivers/input/keyboard/atkbd.c |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

Also, this should be handled from userspace by having usev write to
/sys/bus/serio/devices/serioX/force_release attribute on affected boxes.

-- 
Dmitry
