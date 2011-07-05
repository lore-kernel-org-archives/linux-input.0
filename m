From: Nathan Royer <nroyer@invensense.com>
Subject: RE: [PATCH 01/11] misc: inv_mpu primary header file and README file.
Date: Tue, 5 Jul 2011 11:08:33 -0700
Message-ID: <07b17ccddfb568316d0628298d076211@mail.gmail.com>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com> <CAN_12A9pWNTjetV2wDzhO8OTopECC78b38zBxjku+gpR4QwFoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:40229 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752610Ab1GESIf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2011 14:08:35 -0400
In-Reply-To: <CAN_12A9pWNTjetV2wDzhO8OTopECC78b38zBxjku+gpR4QwFoA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Wolfe <cwolfe@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>, Jiri Kosina <jkosina@suse.cz>, Alan Cox <alan@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

> Is this
> driver to the stage where someone can practically initialize the 3050
> and read low-level data without having the InvenSense MPL already
> installed? (and without basically doing I2C reads and writes from
> userspace)

Yes, this driver could be used to initialize the 3050 and do raw data reads
without the MPL library.  I haven't actually tried it, but you would set the
dmp_enable = 0, fifo_enable = 0 and on each IRQ do a read of
MPUREG_GYRO_XOUT_H..MPUREG_GYRO_ZOUT_L using the IOCTL MPU_READ.

To take advantage of the DMP, and the Master I2C bus you will need the MPL
library in user space.
