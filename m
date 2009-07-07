From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH] Input: rotary_encoder cleanup
Date: Tue, 7 Jul 2009 14:32:42 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190901A68522@mi8nycmail19.Mi8.com>
References: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com> <20090623162126.GL29236@buzzloop.caiaq.de> <20090630023211.GC10652@dtor-d630.eng.vmware.com> <BD79186B4FD85F4B8E60E381CAEE190901A1346C@mi8nycmail19.Mi8.com> <20090701183347.GB9464@buzzloop.caiaq.de> <BD79186B4FD85F4B8E60E381CAEE190901A13867@mi8nycmail19.Mi8.com> <20090701184959.GC9464@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og107.obsmtp.com ([64.18.1.208]:49176 "HELO
	exprod6og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751356AbZGGScp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2009 14:32:45 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20090701184959.GC9464@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wednesday, July 01, 2009 11:50 AM, Daniel Mack wrote:
> On Wed, Jul 01, 2009 at 02:45:58PM -0400, H Hartley Sweeten wrote:
> > > Hmm, and then report them all via the very same input device? Or
> > > register one for each encoder? The latter could easily be done by
> > > registering multiple platform_devices with different platform_data,
> > > right?
> > 
> > I suppose each encoder could be registered individually.  Then each would
> > report as a unique input device.  This should work with the driver as it
> > is now.  Then drawback is if there are a number of encoders and a
> > userspace app is opening all of them and doing a EVIOCGRAB it makes the
> > app a bit messy.
> > 
> > I was thinking more or passing an array of encoders to the driver and then
> > having it report all of them as one input device.  That ends up being a
> > lot cleaner.
> 
> I'd be fine with such a change. Just curious: how many encoders do you
> have on your board?

I haven't had a chance to figure out a way to pass the array of encoders yet.

But, to answer your question, I have a couple different control panels with
2, 3, or 4 rotary encoders on them.  To go beyond 4 I think I will need to
work out a patch that only requires 1 interrupt line for each encoder.  My
platform has 24 gpio's that can generate interrupts but I am using a number
of them for other purposes.

Regards,
Hartley
