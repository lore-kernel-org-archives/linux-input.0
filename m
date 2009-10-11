From: Greg KH <gregkh@suse.de>
Subject: Re: [REGRESSION] "bind" a device to a driver doesn't not work
	anymore
Date: Sat, 10 Oct 2009 20:00:29 -0700
Message-ID: <20091011030029.GA6526@suse.de>
References: <4AD120F2.3020606@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37456 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754369AbZJKDBL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2009 23:01:11 -0400
Content-Disposition: inline
In-Reply-To: <4AD120F2.3020606@tremplin-utc.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ?ric Piel <Eric.Piel@tremplin-utc.net>
Cc: Dmitry Torokhov <dtor@insightbb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Sun, Oct 11, 2009 at 02:04:02AM +0200, ?ric Piel wrote:
> Hello,
>
> After a suspend, I used to do this (to get the PS2 keyboard working again), 
> and it used to work fine:
> echo -n "i8042" > /sys/bus/platform/drivers/i8042/unbind ; sleep 1 ; echo 
> -n "i8042" > /sys/bus/platform/drivers/i8042/bind
>
> Unfortunately since 2.6.32-rc1, the unbind works fine, but the bind returns 
> a "no such device" error now (and the binding is not done). After that, 
> additional unbinds also report the error. I think 2.6.31 worked fine. Any 
> idea what's going wrong?

Odd.  Any chance you can run 'git bisect' to figure out which patch
might have caused it?

thanks,

greg k-h
