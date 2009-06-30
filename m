From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] Input: rotary_encoder cleanup
Date: Tue, 30 Jun 2009 11:56:36 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob114.obsmtp.com ([64.18.1.32]:53875 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751379AbZF3P4i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jun 2009 11:56:38 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090630023211.GC10652@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org

On Monday, June 29, 2009 7:32 PM, Dmitry Torokhov wrote:
> On Tue, Jun 23, 2009 at 06:21:26PM +0200, Daniel Mack wrote:
> > On Sat, Jun 20, 2009 at 06:15:51PM -0400, H Hartley Sweeten wrote:
> > > There is no need to carry the two irq numbers in the allocated memory.
> > > They are only needed for the free_irq() calls during the remove.  Since
> > > the driver is already carrying the platform_data we can just call
> > > gpio_to_irq() to get the irq number.
> > > 
> > > Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> > 
> > Acked-by: Daniel Mack <daniel@caiaq.de>
> > 
> 
> Do we know how many encoders we need to have in the system to start
> seeing the benefits (given that all these conversions increase text
> size)?

Hmm.. Didn't think about that. How do you determine the text size?

I am trying to work out a clean way to pass an array of encoders from
the platform init file so that multiple devices can be handled by the
driver.  That was what prompted the change.

Regards,
Hartley
