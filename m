From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: rfkill-input understanding help
Date: Sun, 13 Apr 2008 12:23:12 +0100
Message-ID: <200804131223.13417.carlos@strangeworlds.co.uk>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200801220055.39044.carlos@strangeworlds.co.uk> <200804121821.32519.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:58958 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755203AbYDMLXT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Apr 2008 07:23:19 -0400
In-Reply-To: <200804121821.32519.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-input@vger.kernel.org

On Saturday 12 April 2008 18:21:31 Carlos Corbacho wrote:
> Any thoughts at all on how to diagnose why rfkill-input is not able to find
> a device to attach to the first time it loads (or more specifically, why
> input_match_device() fails to return a match the first time around),
> because I'm still scratching my head on this four months later...

I think I've found the problem here.

rfkill-input isn't being attached to a device because it's looking for 
KEY_WLAN. The problem is that at boot time, I don't have a KEY_WLAN - the key 
isn't mapped until HAL & hal-info kick in much later.

I've tested this by blacklisting rfkill-input, waiting until HAL has loaded 
and run setkeycodes, and then loaded rfkill-input, which then works properly 
first time round.

Unfortunately, that's only a workaround, not a real solution, so we're going 
to need a better way of handling this case.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
