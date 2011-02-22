From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380
 accelerometers
Date: Tue, 22 Feb 2011 11:29:58 +0000
Message-ID: <20110222112958.7802eaea@lxorguk.ukuu.org.uk>
References: <20110214100622.2282.1584.stgit@bob.linux.org.uk>
	<4D62B826.2010201@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:40497 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751860Ab1BVL2a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 06:28:30 -0500
In-Reply-To: <4D62B826.2010201@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-input@vger.kernel.org

> > +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/range
> > +Date:		February 2011
> > +Contact:	Alan Cox <alan@linux.intel.com>
> > +Description:	Configure the sensing range of the device
> > +		0: +/- 2G
> > +		1: +/- 4G
> > +		2: +/- 8G
> Why the magic numbers? It would be trivial to just use the actual values so
> why not do so?

That seems sensible, especially if other variants then decided to do
other frequencies

> > +		(See the equations in the data sheet)
> If possible, please direct people to a particular equation. Or given these

There is a datasheet link for the BMA150 in the driver now.

I don't think duplicating the notes actually helps because you really
need the data sheet to do the job anyway and it avoids duplicating stuff
that may then go stale.
