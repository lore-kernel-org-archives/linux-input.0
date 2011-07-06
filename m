From: Nathan Royer <nroyer@invensense.com>
Subject: RE: [PATCH 01/11] misc: inv_mpu primary header file and README file.
Date: Wed, 6 Jul 2011 14:27:48 -0700
Message-ID: <592dafb95382604bd514687f7600cebd@mail.gmail.com>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<4E0D8E94.5030604@cam.ac.uk>	<4d61a92a11e5d83a1cb0094441ae5f5e@mail.gmail.com>
	<4E105284.7030209@cam.ac.uk>	<20110704091658.0d4c8e3f@bob.linux.org.uk>
	<c2189246a279a0e5a1b8599edc94a79a@mail.gmail.com> <20110706115430.3745592c@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110706115430.3745592c@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>, eric.andersson@unixphere.com
List-Id: linux-input@vger.kernel.org

> > It seems that some sensors are in input and but that most are in iio.
> > Obviously I don't want to dissent with both and put ours in misc, so
> > how do we make this better?  Should we work on cleaning this up.  If
> > so should we start moving the drivers that are in input to iio.
>
> IIO provides a lot more flexibility and is rather newer, input provides
> a more focussed interface. In some cases it may make sense to provide
> different interfaces to each (eg atomspheric pressure doesn't fit well
> into input, but 3 axis accelerometers fit perfectly)
>
> > We still need a way to read and write registers and DMP memory during
> > runtime from user space.
>
> You probably want a driver for the MPU itself whih provides the
> needed glue and also control interfaces (firmware load etc). That may
> well be a drivers/misc item as I imagine that part is quite unique and
> specialised.

If I understand you correctly, you are suggesting that we create two
drivers for the mpu3050 part.  An MPU (Motion Processing Unit) driver and
a standalone Gyroscope driver.  The MPU if present would turn each sensor
(accel, compass, gyro, pressure) into an MPU slave, load and configure the
firmware, and provide a user space interface for customization and runtime
communication with the Hideously Complicated Algorithms (HCA's).

Each sensor driver would have two operating modes, standalone, and slave
to the MPU trying to re-use as much code as possible.  Current drivers
that have a standalone interface would need the slave interface added, and
those that we've written would need the stand alone interface added.
