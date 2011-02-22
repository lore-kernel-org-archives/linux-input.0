From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] bma023: Support for Bosch BMA023, BMA150 and SMB380 accelerometers
Date: Tue, 22 Feb 2011 12:15:16 +0000
Message-ID: <4D63A8D4.2070702@cam.ac.uk>
References: <20110214100622.2282.1584.stgit@bob.linux.org.uk>	<4D62B826.2010201@cam.ac.uk> <20110222112958.7802eaea@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:38332 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab1BVMOt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 07:14:49 -0500
In-Reply-To: <20110222112958.7802eaea@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On 02/22/11 11:29, Alan Cox wrote:
>>> +What:		/sys/bus/i2c/devices/<busnum>-<devaddr>/range
>>> +Date:		February 2011
>>> +Contact:	Alan Cox <alan@linux.intel.com>
>>> +Description:	Configure the sensing range of the device
>>> +		0: +/- 2G
>>> +		1: +/- 4G
>>> +		2: +/- 8G
>> Why the magic numbers? It would be trivial to just use the actual values so
>> why not do so?
> 
> That seems sensible, especially if other variants then decided to do
> other frequencies
> 
>>> +		(See the equations in the data sheet)
>> If possible, please direct people to a particular equation. Or given these
> 
> There is a datasheet link for the BMA150 in the driver now.
Yup, that is a welcome addition.  Bosch Sensortech seem to
specialise in incomprehensible data sheets but it's better to
have them than not!
> 
> I don't think duplicating the notes actually helps because you really
> need the data sheet to do the job anyway and it avoids duplicating stuff
> that may then go stale.
Hmm.. I'll let that go as to be honest I'd much rather see these in some
SI units rather than requiring the formula's at all. That would require
a bit more complexity in the driver, but lead to a much more generalizable
interface.  As you've previously stated you aren't interested in general
interfaces until they are defined elsewhere, we can leave that question for
now.  Note the issue of pinning down the equivalent sysfs interfaces for the
lis3 driver has just been raised in a discussion on the lm-sensors list about
finally moving that driver out of hwmon.

However, note that Dmitry has previously blocked merges of drivers into input
precisely because these sysfs interfaces haven't been defined cleanly (in that
case the relevant bits were just dropped from the driver in favour of platform
data). He wants to see something general across all such sensors whatever
subsystem they are actually in.

We can reopen the general interface discussion if people are happy to contribute.
It kind of died out last time without any decisions being taken.  We went with pretty
much what I proposed then in IIO for the event side of things.  Some of what you
cover in this driver has never come up before and hence needs discussion.

Jonathan

