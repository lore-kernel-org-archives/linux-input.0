From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 01/11] misc: inv_mpu primary header file and README
 file.
Date: Wed, 6 Jul 2011 11:54:30 +0100
Message-ID: <20110706115430.3745592c@bob.linux.org.uk>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<4E0D8E94.5030604@cam.ac.uk>
	<4d61a92a11e5d83a1cb0094441ae5f5e@mail.gmail.com>
	<4E105284.7030209@cam.ac.uk>
	<20110704091658.0d4c8e3f@bob.linux.org.uk>
	<c2189246a279a0e5a1b8599edc94a79a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26747 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397Ab1GFKyJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Jul 2011 06:54:09 -0400
In-Reply-To: <c2189246a279a0e5a1b8599edc94a79a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nathan Royer <nroyer@invensense.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>, eric.andersson@unixphere.com

> It seems that some sensors are in input and but that most are in iio.
> Obviously I don't want to dissent with both and put ours in misc, so
> how do we make this better?  Should we work on cleaning this up.  If
> so should we start moving the drivers that are in input to iio.

IIO provides a lot more flexibility and is rather newer, input provides
a more focussed interface. In some cases it may make sense to provide
different interfaces to each (eg atomspheric pressure doesn't fit well
into input, but 3 axis accelerometers fit perfectly)

> We still need a way to read and write registers and DMP memory during
> runtime from user space.

You probably want a driver for the MPU itself whih provides the
needed glue and also control interfaces (firmware load etc). That may
well be a drivers/misc item as I imagine that part is quite unique and
specialised.
