From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Wed, 13 Apr 2011 15:46:30 +0100
Message-ID: <20110413154630.0cb0355e@bob.linux.org.uk>
References: <20110413095049.10407.35173.stgit@localhost.localdomain>
	<4DA57B40.2000402@cam.ac.uk>
	<20110413140711.260e04b8@bob.linux.org.uk>
	<544AC56F16B56944AEC3BD4E3D59177137546EFA20@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23899 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756504Ab1DMPDz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 11:03:55 -0400
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177137546EFA20@LIMKCMBX1.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, 13 Apr 2011 15:30:21 +0100
"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

> Alan Cox wrote on 2011-04-13:
> >> Could just fix the length in this. You only ever use it with the
> >> value 6. Hardly seems worth it's own function.  I guess this may
> >> be because it gets used for other things in the full version?  If
> >> so it doesn't do any harm here so might as well leave it alone.
> >
> > In its current form, but there may well be future reasons for people
> > to update that depending upon their application of the device.
> >
> >>> +   u8 buffer[6];
> >>> +   buffer[0] = MPU3050_XOUT_H;
> >>> +   mpu3050_xyz_read_reg(client, buffer, 6);
> >>> +   coords->x = buffer[0];
> >>> +   coords->x = coords->x << 8 | buffer[1];
> >>
> >> Better to use le16_tocpu or similar rather than hand rolling these.
> >
> > le16_to_cpu takes an u16 or similar input which means buffer then
> > has to be a u16[] array for alignment which means you need a
> > separate input and output buffer or to do uglies setting XOUT_H
> 
> How about get_unaligned_be16(&buffer[0]) ?

I never knew about that - yes that looks ideal.

New patch to follow shortly with some of this tidied up as per
Jonathans suggestion too
