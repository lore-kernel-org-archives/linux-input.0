From: Chris Wolfe <cwolfe@chromium.org>
Subject: Re: [PATCH 01/11] misc: inv_mpu primary header file and README file.
Date: Thu, 30 Jun 2011 20:59:46 -0700
Message-ID: <CAN_12A9pWNTjetV2wDzhO8OTopECC78b38zBxjku+gpR4QwFoA@mail.gmail.com>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Royer <nroyer@invensense.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>, Jiri Kosina <jkosina@suse.cz>, Alan Cox <alan@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jun 30, 2011 at 7:18 PM, Nathan Royer <nroyer@invensense.com> w=
rote:
> The mpu3050 has an i2c master interface designed to control an accele=
rometer
> and a Digital Motion Processor (DMP) used to perform sensor fusion on=
 the
> gyroscope and accelerometer. =C2=A0This data is then read out of the =
mpu3050 fifo
> and sent to userspace for distribution and optional propritary proces=
sing, such
> as fusion with a compass to produce a 9 axis quaternion.

Sorry, just took a quick pass so I may be missing changes. Is this
driver to the stage where someone can practically initialize the 3050
and read low-level data without having the InvenSense MPL already
installed? (and without basically doing I2C reads and writes from
userspace)

As Greg K-H pointed out, IIO provides a lot of the support code for
this kind of driver. Have a look at drivers/staging/iio/imu and the
sibling directories. They provide a framework for reporting the
low-level data in a standard fashion, and some extra attributes to
load the DMP firmware would be easy to add.

I'm disconnected over the weekend, but will touch base with you and
Mike Housholder on Tuesday. Getting this upstream would be great, so
we ought to share notes.

Chris
