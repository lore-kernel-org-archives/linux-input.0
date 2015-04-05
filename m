From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - preliminary support for GT801-2+1
Date: Sun, 05 Apr 2015 18:04:24 +0200
Message-ID: <1428249864.28443.4.camel@hadess.net>
References: <1428181693-25362-1-git-send-email-plaes@plaes.org>
	 <1428181693-25362-2-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56638 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbDEQFO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 5 Apr 2015 12:05:14 -0400
In-Reply-To: <1428181693-25362-2-git-send-email-plaes@plaes.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

On Sun, 2015-04-05 at 00:08 +0300, Priit Laes wrote:
> This patch implements GT801x2 touchscreen support.
> Unfortunately, there is a big difference between GT801 and GT9xx 
> series
> chips, therefore some advice is needed on how to proceed.
> 
> Differences between GT801x2 and GT9xx series:
> 
> 1. I2C registers: 1 byte (GT801x2) vs 2 bytes (GT9xx)
> 2. Different configuration layout and version info
> 3. Different touch report protocol

That doesn't seem like an awful lot of differences. Approximately 80 
line changes for 500 lines of driver code. You could add an enum for 
the 8xx and 9xx types near the top, add that as driver data in the 
match arrays (both the ACPI and OF ones). Then have if statements 
choose the correct init, read and report functions.

I would think that that would grow the driver by a further 50 lines, 
which would certainly be acceptable.

Don't forget to add your name to the copyright header mentioning 
you're the author for the 8xx support :)

> Signed-off-by: Priit Laes <plaes@plaes.org>

There's really no need to sign it off if you know it's not going to be 
accepted upstream ;)

Cheers
