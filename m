From: simon@mungewell.org
Subject: Re: [PATCH] Add a driver to support InvenSense mpu3050 gyroscope  
 chip.
Date: Wed, 13 Apr 2011 11:21:53 -0400
Message-ID: <bfe2ae4b223ad567ba127b91b9da15df.squirrel@host171.canaca.com>
References: <20110413095049.10407.35173.stgit@localhost.localdomain>
    <9bf2cf8dbd98b3e026d79af99277db63.squirrel@host171.canaca.com>
    <20110413155408.2a1cf73a@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:50024 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757130Ab1DMPVz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Apr 2011 11:21:55 -0400
In-Reply-To: <20110413155408.2a1cf73a@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: simon@mungewell.org, linux-input@vger.kernel.org

>> Without a detailed datasheet for the MPU3050 I can't say for certain;
>> but usually there is another register which is set when a measurement
>> is taken. This can be cleared before and accessed after reading the
>> XYZ values to confirm that they have not been corrupted.
>
> I don't believe the datasheet for the MPU3050 is public, but it's a
> smart device rather than a simple interface.

So are you confirming that the XYZ values can't be corrupted? Even if the
sample rate is set to max...

Maybe a note so others don't copy the driver format to implement 'dumb'
devices.

Simon

