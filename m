From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - preliminary support for GT801-2+1
Date: Wed, 08 Apr 2015 16:24:48 +0200
Message-ID: <1428503088.28443.12.camel@hadess.net>
References: <1428181693-25362-1-git-send-email-plaes@plaes.org>
	 <1428181693-25362-2-git-send-email-plaes@plaes.org>
	 <1428249864.28443.4.camel@hadess.net> <1428253576.29867.7.camel@plaes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60831 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbbDHOZs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Apr 2015 10:25:48 -0400
In-Reply-To: <1428253576.29867.7.camel@plaes.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Priit Laes <plaes@plaes.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

On Sun, 2015-04-05 at 20:06 +0300, Priit Laes wrote:
> On Sun, 2015-04-05 at 18:04 +0200, Bastien Nocera wrote:
> > On Sun, 2015-04-05 at 00:08 +0300, Priit Laes wrote:
> > > This patch implements GT801x2 touchscreen support.
> > > Unfortunately, there is a big difference between GT801 and GT9xx 
> > > series
> > > chips, therefore some advice is needed on how to proceed.
> > > 
> > > Differences between GT801x2 and GT9xx series:
> > > 
> > > 1. I2C registers: 1 byte (GT801x2) vs 2 bytes (GT9xx)
> > > 2. Different configuration layout and version info
> > > 3. Different touch report protocol
> > 
> > That doesn't seem like an awful lot of differences. Approximately 
> > 80 
> > line changes for 500 lines of driver code. You could add an enum 
> > for 
> > the 8xx and 9xx types near the top, add that as driver data in the 
> > match arrays (both the ACPI and OF ones). Then have if statements 
> > choose the correct init, read and report functions.
> 
> How should I handle the version readout?
> 
> Currently the driver has following info in its registers (starting 
> from 0xf0):
> 
> f0: 47 54 38 30 31 4e 49 5f 33 52 31 35 5f 31 41 56    
> GT801NI_3R15_1AV

Version info is only used for debug anyway, so you'd have a 
goodix_read_version() call for gt8xx devices.

.driver_data = GT9XX
for the existing code
or
.driver_data = GT8XX
for the new one

And do:
if (driver_data == GT9XX)
  goodix_read_version_9xx();
else
  goodix_read_version_8xx();

etc.

Cheers
