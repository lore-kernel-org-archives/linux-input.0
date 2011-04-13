From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope
 chip.
Date: Wed, 13 Apr 2011 15:54:08 +0100
Message-ID: <20110413155408.2a1cf73a@bob.linux.org.uk>
References: <20110413095049.10407.35173.stgit@localhost.localdomain>
	<9bf2cf8dbd98b3e026d79af99277db63.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:51696 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757112Ab1DMPLj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 11:11:39 -0400
In-Reply-To: <9bf2cf8dbd98b3e026d79af99277db63.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

> Without a detailed datasheet for the MPU3050 I can't say for certain;
> but usually there is another register which is set when a measurement
> is taken. This can be cleared before and accessed after reading the
> XYZ values to confirm that they have not been corrupted.

I don't believe the datasheet for the MPU3050 is public, but it's a
smart device rather than a simple interface.

> Also some I2C hosts (such as the Intel SCH) don't support I2C block
> read/writes, and thus the access will be broken into separate
> reads/writes and be much slower.

Yes - but for those that can do it in one, it's a win to do so.

> Hope I'm not speaking out of turn

Nope - all good points to double check.

Alan
