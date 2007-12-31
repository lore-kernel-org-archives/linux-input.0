From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: rfkill-input understanding help
Date: Mon, 31 Dec 2007 01:00:18 +0000
Message-ID: <200712310100.18764.carlos@strangeworlds.co.uk>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200712301959.42914.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:54677 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbXLaBAW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Dec 2007 20:00:22 -0500
In-Reply-To: <200712301959.42914.IvDoorn@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Sunday 30 December 2007 18:59:42 Ivo van Doorn wrote:
> So using the sysfs interface you can enable and disable the radios?

A while ago it could (I'll have to resurrect the code, since I haven't touched 
it much lately since experimenting with rfkill a few weeks ago).

> Without a code example I can't say much, but have you looked to the
> examples in the drivers/net/wireless/rt2x00/ and drivers/net/wireless/b43
> Those are at least 2 drivers with a working rfkill implementation for WLAN,
> that should give a good example on how the code should look like.

I've been looking mostly at the b43 code for inspiration.

Once I beat my own code back into some sort of useable shape again, I'll send 
it along to see if you can spot where I'm missing something.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
