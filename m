From: Ivo van Doorn <ivdoorn@gmail.com>
Subject: Re: rfkill-input understanding help
Date: Wed, 2 Jan 2008 20:10:20 +0100
Message-ID: <200801022010.21109.IvDoorn@gmail.com>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200712301959.42914.IvDoorn@gmail.com> <200712310100.18764.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.190]:8567 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbYABTKd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jan 2008 14:10:33 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6271565fkz.5
        for <linux-input@vger.kernel.org>; Wed, 02 Jan 2008 11:10:31 -0800 (PST)
In-Reply-To: <200712310100.18764.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Monday 31 December 2007, Carlos Corbacho wrote:
> On Sunday 30 December 2007 18:59:42 Ivo van Doorn wrote:
> > So using the sysfs interface you can enable and disable the radios?
> 
> A while ago it could (I'll have to resurrect the code, since I haven't touched 
> it much lately since experimenting with rfkill a few weeks ago).
> 
> > Without a code example I can't say much, but have you looked to the
> > examples in the drivers/net/wireless/rt2x00/ and drivers/net/wireless/b43
> > Those are at least 2 drivers with a working rfkill implementation for WLAN,
> > that should give a good example on how the code should look like.
> 
> I've been looking mostly at the b43 code for inspiration.

Then make sure you update to the latest version, I believe they
had a broken rfkill version for some time. (They based it on the
rt2x00 version which for a time was also broken).
The latest version of both drivers are now working. :)

> Once I beat my own code back into some sort of useable shape again, I'll send 
> it along to see if you can spot where I'm missing something.

Ok.

Ivo


