From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: your mail
Date: Thu, 15 Apr 2010 21:21:04 -0700
Message-ID: <20100416042104.GA20916@core.coreip.homeip.net>
References: <20100414125234.23507.42816.stgit@localhost.localdomain>
 <20100414231604.GA12281@core.coreip.homeip.net>
 <4BC7A422.7050601@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52757 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740Ab0DPEVL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Apr 2010 00:21:11 -0400
Content-Disposition: inline
In-Reply-To: <4BC7A422.7050601@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Alan Cox <alan@linux.intel.com>, linux-i2c@vger.kernel.org, khali@linux-fr.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 15, 2010 at 07:41:22PM -0400, Rafi Rubin wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >> +	if (ts->tc.event_sended == false) {
> > 
> > We set "event_sended" to false immediately before calling
> > cy8ctmg110_send_event() so I do not see the point of this flag.
> 
> On that note:
> 
> $ git grep -n sended
> drivers/net/eth16i.c:1295:
> 		how many packets there is to be sended */
> drivers/net/wan/sbni.c:638:
> 		/* if frame was sended but not ACK'ed - resend it */
> drivers/net/wan/sbni.c:659:
> 		* frame sended then in prepare_to_send next frame
> drivers/usb/serial/aircable.c:13:
> 		* next two bytes must say how much data will be sended.
> 

Well, if you want to go down that path...

[dtor@hammer work]$ grep -r -e "\(setted\|setuped\|split\+ed\)" . | wc -l
54
[dtor@hammer work]$ 

-- 
Dmitry
