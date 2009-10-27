From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work
	anymore
Date: Tue, 27 Oct 2009 09:16:39 -0700
Message-ID: <20091027161638.GA22541@core.coreip.homeip.net>
References: <20091012173551.GC10557@suse.de> <20091012183313.GC8345@core.coreip.homeip.net> <20091012185417.GA30342@suse.de> <20091013031741.GB2887@core.coreip.homeip.net> <20091018075127.GH3935@core.coreip.homeip.net> <20091018080238.GA13810@suse.de> <20091023020150.GA26723@core.coreip.homeip.net> <20091026205953.GB11665@suse.de> <20091026213450.GA19119@core.coreip.homeip.net> <20091026235908.GA12974@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:53136 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830AbZJ0QQm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2009 12:16:42 -0400
Content-Disposition: inline
In-Reply-To: <20091026235908.GA12974@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: ?ric Piel <eric.piel@tremplin-utc.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Mon, Oct 26, 2009 at 04:59:08PM -0700, Greg KH wrote:
> On Mon, Oct 26, 2009 at 02:34:50PM -0700, Dmitry Torokhov wrote:
> > 
> > It will prevent unbind from happening so that users who have suspend and
> > resume working properly but who have bind/unbind in their suspend/resume
> > scripts regardless will not run into trouble.
> > 
> > This still leaves users whose suspend/resume don't work by default but I
> > would rather fix their boxes properly instead of relying on that
> > workaround.
> 
> Ok, fair enough, I'll queue it up for .32.
> 

Thanks Greg, much appreciated.

-- 
Dmitry
