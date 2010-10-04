From: Paul Fox <pgf@laptop.org>
Subject: Re: [PATCH 1/3] Input: hgpk - enable advanced mode through module parameter
Date: Mon, 04 Oct 2010 14:27:54 -0400
Message-ID: <23406.1286216874@foxharp.boston.ma.us>
References: <20101002204235.052959D401B@zog.reactivated.net> <20101004174533.GC8321@core.coreip.homeip.net> (sfid-20101004_134544_591018_E8723B32)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from colo4.heeltoe.com ([207.210.93.145]:54900 "EHLO
	colo4.heeltoe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566Ab0JDSvt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Oct 2010 14:51:49 -0400
In-reply-to: <20101004174533.GC8321@core.coreip.homeip.net> (sfid-20101004_134544_591018_E8723B32)
Content-ID: <23403.1286216874.1@foxharp.boston.ma.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-input@vger.kernel.org

dmitry wrote:
 > Hi Daniel,
 > 
 > On Sat, Oct 02, 2010 at 09:42:34PM +0100, Daniel Drake wrote:
 > > +
 > > +	/*
 > > +	 * The first packet after the finger goes down only establishes the
 > > +	 * baseline for relative movement.
 > > +	 * (ignore possibility of finger going down and button being pressed
 > > +	 * simultaneously.)
 > > +	 */
 > > +	if (!priv->isdown) {
 > > +		priv->abs_x = *x;
 > > +		priv->abs_y = *y;
 > > +		priv->isdown = true;
 > > +		return false;
 > > +	}
 > > +
 > > +	tmp = *x; *x -= priv->abs_x; priv->abs_x = tmp;
 > > +	tmp = *y; *y -= priv->abs_y; priv->abs_y = tmp;
 > 
 > Why do you use abs->rel conversion in driver and not rely on the
 > standard userspace component handling thouchpads in absolute mode?

the driver can (and does, on user request)) switch modes between
"glidesensor" and "pen tablet" mode on the fly.  (userspace requests
this with a write to the "ptmode" sysfs node).  changing the device
from relative to absolute at that point would also require that
userspace close/reopen, or use a separate device, wouldn't it?

paul

 > 
 > Thanks.
 > 
 > -- 
 > Dmitry

=---------------------
 paul fox, pgf@laptop.org
