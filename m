From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: rfkill-input understanding help
Date: Sat, 12 Apr 2008 18:21:31 +0100
Message-ID: <200804121821.32519.carlos@strangeworlds.co.uk>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200801120032.41263.carlos@strangeworlds.co.uk> <200801220055.39044.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:47616 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464AbYDLRhF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Apr 2008 13:37:05 -0400
In-Reply-To: <200801220055.39044.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ivo van Doorn <ivdoorn@gmail.com>, linux-input@vger.kernel.org

Dmitry,

On Tuesday 22 January 2008 00:55:37 Carlos Corbacho wrote:
> Shoving some printk's into input.c shows that it fails in
> input_match_handler() on:
>
> 	id = input_match_device(handler->id_table, dev);
> 	if (!id)
> 		return -ENODEV;
>
> This test always fails for every call of input_match_handler() in
> input_register_handler().
>
> Unloading and reloading rfkill-input then somehow causes this test to not
> fail, and rfkill-input is then properly registered...

Any thoughts at all on how to diagnose why rfkill-input is not able to find a 
device to attach to the first time it loads (or more specifically, why 
input_match_device() fails to return a match the first time around), because 
I'm still scratching my head on this four months later...

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
