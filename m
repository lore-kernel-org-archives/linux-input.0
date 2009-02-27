From: "hartleys" <hartleys@visionengravers.com>
Subject: RE: [PATCH] generic driver for rotary encoders on GPIOs
Date: Fri, 27 Feb 2009 13:30:15 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901349198@mi8nycmail19.Mi8.com>
References: <20090227064314.GB32470@buzzloop.caiaq.de> <1235757652-16514-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og101.obsmtp.com ([64.18.1.181]:47575 "HELO
	exprod6og101.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755285AbZB0Sa4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 13:30:56 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1235757652-16514-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Friday, February 27, 2009 11:01 AM, Daniel Mack wrote:
> This patch adds a generic driver for rotary encoders connected to
> GPIO pins of a system. It relies on gpiolib and generic hardware
> irqs. The documentation that also comes with this patch explains
> the concept and how to use the driver.
>
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
>  new version as discussed on linux-input.

Works great now on the ep93xx with no changes.

I have a minor patch to it that allows the platform init to configure
the absolute/relative axis to report the encoder on.  If you would like
to see it I can put together a patch.

Also, any ideas if the driver could be modified to support more that one
rotary encoder?

It might be possible to load driver multiple times, once for each
encoder, but then all the events show up in different /dev/input/event*
places.

BTW, pretty cool.  I was handling a rotary encoder in my FPGA but this
makes it much cleaner.

Regards,
Hartley
