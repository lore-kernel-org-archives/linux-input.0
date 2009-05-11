From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] hid: add force feedback support for SmartJoy PLUS
	PS2/USB adapter
Date: Mon, 11 May 2009 15:02:00 -0700
Message-ID: <20090511220200.GA17259@kroah.com>
References: <20090508074636.16912.55839.stgit@fate.lan> <alpine.LNX.2.00.0905111712410.22712@wotan.suse.de> <4A0848E7.9080301@suse.cz> <20090511214620.GA22717@kroah.com> <4A08A073.60005@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:56924 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403AbZEKWFb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 18:05:31 -0400
Content-Disposition: inline
In-Reply-To: <4A08A073.60005@suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, May 12, 2009 at 12:02:27AM +0200, Jiri Slaby wrote:
> On 05/11/2009 11:46 PM, Greg KH wrote:
> > On Mon, May 11, 2009 at 05:48:55PM +0200, Jiri Slaby wrote:
> >> Here comes some of my comments to the rest:
> >>
> >> +#define debug(format, arg...) pr_debug("hid-sjoyff: " format "\n" , ## arg)
> >>
> >> Define pr_fmt instead of this.
> > 
> > No, please use dev_dbg() instead of creating a new macro.
> 
> No, unfortunately there is no struct device available in the two
> functions he uses this macro in.
> 
> It should look like
> 
> #define pr_fmt(fmt) "hid-sjoyff: " fmt "\n"
> 
> and then use pr_debug as usual.
> 
> In other places he correctly uses dev_* stuff.

Oh, ok, yes, that's correct, sorry for not looking closer.

greg k-h
