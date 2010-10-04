From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] Input: hgpk - enable advanced mode through module
 parameter
Date: Mon, 4 Oct 2010 11:33:47 -0700
Message-ID: <20101004183347.GF8321@core.coreip.homeip.net>
References: <20101002204235.052959D401B@zog.reactivated.net>
 <20101004174533.GC8321@core.coreip.homeip.net>
 <23406.1286216874@foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45676 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab0JDSdz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Oct 2010 14:33:55 -0400
Received: by iwn5 with SMTP id 5so7225219iwn.19
        for <linux-input@vger.kernel.org>; Mon, 04 Oct 2010 11:33:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <23406.1286216874@foxharp.boston.ma.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Fox <pgf@laptop.org>
Cc: Daniel Drake <dsd@laptop.org>, linux-input@vger.kernel.org

On Mon, Oct 04, 2010 at 02:27:54PM -0400, Paul Fox wrote:
> dmitry wrote:
>  > Hi Daniel,
>  > 
>  > On Sat, Oct 02, 2010 at 09:42:34PM +0100, Daniel Drake wrote:
>  > > +
>  > > +	/*
>  > > +	 * The first packet after the finger goes down only establishes the
>  > > +	 * baseline for relative movement.
>  > > +	 * (ignore possibility of finger going down and button being pressed
>  > > +	 * simultaneously.)
>  > > +	 */
>  > > +	if (!priv->isdown) {
>  > > +		priv->abs_x = *x;
>  > > +		priv->abs_y = *y;
>  > > +		priv->isdown = true;
>  > > +		return false;
>  > > +	}
>  > > +
>  > > +	tmp = *x; *x -= priv->abs_x; priv->abs_x = tmp;
>  > > +	tmp = *y; *y -= priv->abs_y; priv->abs_y = tmp;
>  > 
>  > Why do you use abs->rel conversion in driver and not rely on the
>  > standard userspace component handling thouchpads in absolute mode?
> 
> the driver can (and does, on user request)) switch modes between
> "glidesensor" and "pen tablet" mode on the fly.  (userspace requests
> this with a write to the "ptmode" sysfs node).  changing the device
> from relative to absolute at that point would also require that
> userspace close/reopen, or use a separate device, wouldn't it?
> 

I'd allow selecting the mode only once, upon device initialization.
This can be done by setting module parameter and [re]loading the
module or setting the parameter and then instructing driver to
reconnect:

	echo -n "rescan" > /sys/bus/serio/devices/serioX/drvctl

or asking psmouse to select sepcific protocol for the device (I believe
absolute mode of HGPK warrants a separate protocol entry).

Thanks.

-- 
Dmitry
