From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 01/11] misc: inv_mpu primary header file and README
 file.
Date: Thu, 7 Jul 2011 08:40:26 +0100
Message-ID: <20110707084026.4562ab94@lxorguk.ukuu.org.uk>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<4E0D8E94.5030604@cam.ac.uk>
	<4d61a92a11e5d83a1cb0094441ae5f5e@mail.gmail.com>
	<4E105284.7030209@cam.ac.uk>
	<20110704091658.0d4c8e3f@bob.linux.org.uk>
	<c2189246a279a0e5a1b8599edc94a79a@mail.gmail.com>
	<20110706115430.3745592c@bob.linux.org.uk>
	<592dafb95382604bd514687f7600cebd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:49988 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284Ab1GGHir convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 03:38:47 -0400
In-Reply-To: <592dafb95382604bd514687f7600cebd@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nathan Royer <nroyer@invensense.com>
Cc: Alan Cox <alan@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>, eric.andersson@unixphere.com

> If I understand you correctly, you are suggesting that we create two
> drivers for the mpu3050 part.  An MPU (Motion Processing Unit) driver=
 and
> a standalone Gyroscope driver.  The MPU if present would turn each se=
nsor
> (accel, compass, gyro, pressure) into an MPU slave, load and configur=
e the
> firmware, and provide a user space interface for customization and ru=
ntime
> communication with the Hideously Complicated Algorithms (HCA's).

Its hard to judge with what has been explained so far but the device
appears to be very different in the two operating modes so it might mak=
e
sense to have it as two drivers (or one driver with two very distinct
modes)

> Each sensor driver would have two operating modes, standalone, and sl=
ave
> to the MPU trying to re-use as much code as possible.  Current driver=
s
> that have a standalone interface would need the slave interface added=
, and
> those that we've written would need the stand alone interface added.

Can the slave interface appears to be an i=B2c bus too or is the interf=
ace
too different (ie could the smart mode create an i=B2c bus that it uses=
 to
talk to the drivers to configure them for 'smart' mode)

I'm not entirely sure at this point I understand quite how all the piec=
es
fit together.

Alan
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
