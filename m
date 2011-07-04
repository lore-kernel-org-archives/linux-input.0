From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 01/11] misc: inv_mpu primary header file and README
 file.
Date: Mon, 4 Jul 2011 09:16:58 +0100
Message-ID: <20110704091658.0d4c8e3f@bob.linux.org.uk>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>
	<4E0D8E94.5030604@cam.ac.uk>
	<4d61a92a11e5d83a1cb0094441ae5f5e@mail.gmail.com>
	<4E105284.7030209@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57461 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab1GDIQt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Jul 2011 04:16:49 -0400
In-Reply-To: <4E105284.7030209@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Nathan Royer <nroyer@invensense.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Chris Hudson <chudson@kionix.com>, eric.andersson@unixphere.com, eric.miao@linaro.org

> > accel/bma150.c
> An input driver exists for that one. (cc'd Eric)

[Two input drivers - bma023 which I posted covers it too ;)]

> > # sensors - compass
> > compass/ak8975.c

We have a driver for this (I posted a while back)

> > compass/ak8972.c

> > compass/ami30x.c

AMI304 is identical to the AK8974 which we already have - Gram Hsieh
posted patches for this a while ago

