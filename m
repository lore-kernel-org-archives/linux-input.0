From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] Input: rotary_encoder cleanup
Date: Wed, 1 Jul 2009 14:45:58 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901A13867@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com> <20090701183347.GB9464@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6ob109.obsmtp.com ([64.18.1.22]:38143 "HELO psmtp.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752819AbZGASp5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jul 2009 14:45:57 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090701183347.GB9464@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wednesday, July 01, 2009 11:34 AM, Daniel Mack wrote:
> On Tue, Jun 30, 2009 at 11:56:36AM -0400, H Hartley Sweeten wrote:
> > On Monday, June 29, 2009 7:32 PM, Dmitry Torokhov wrote:
> > > Do we know how many encoders we need to have in the system to start
> > > seeing the benefits (given that all these conversions increase text
> > > size)?
> > 
> > Hmm.. Didn't think about that. How do you determine the text size?
> 
> 'objdump -h'?

Thanks.

> > I am trying to work out a clean way to pass an array of encoders from
> > the platform init file so that multiple devices can be handled by the
> > driver.  That was what prompted the change.
> 
> Hmm, and then report them all via the very same input device? Or
> register one for each encoder? The latter could easily be done by
> registering multiple platform_devices with different platform_data,
> right?

I suppose each encoder could be registered individually.  Then each would
report as a unique input device.  This should work with the driver as it
is now.  Then drawback is if there are a number of encoders and a
userspace app is opening all of them and doing a EVIOCGRAB it makes the
app a bit messy.

I was thinking more or passing an array of encoders to the driver and then
having it report all of them as one input device.  That ends up being a
lot cleaner.

Regards,
Hartley
