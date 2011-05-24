From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: Losing events from USB barcode reader
Date: Tue, 24 May 2011 11:55:56 +0200
Message-ID: <20110524095556.GA6805@polaris.bitmath.org>
References: <20110523210228.7738801f@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:47975 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab1EXJut (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 05:50:49 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id CBD53EA886
	for <linux-input@vger.kernel.org>; Tue, 24 May 2011 11:50:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110523210228.7738801f@surf>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-input@vger.kernel.org

Hi Thomas,

> I have a Qt-based application which reads events from a Linux input
> device through /dev/input/eventX. The device I have is an USB barcode
> scanner, which works just like a keyboard.
> 
> Unfortunately, I sometimes lose events coming from this USB barcode
> scanner, and I'm worried about the size of the in-kernel buffer for
> events. The USB barcode scanner acts like a keyboard, but sends events
> much, much faster. For example, when it scans a barcode such as
> "AZERTYUIOP1234", it generates the Shift press, key press, key release,
> Shift release for every character, generating at least 56 events in a
> row, very quickly (and the kernel only buffers 64 events if I'm
> correct).

With 2.6.39, it is possible to tell if events are dropped by looking
for the (EV_SYN, SYN_DROPPED) event in the stream, for instance using
evtest.

The buffer size can be set by the driver in question, which may
utilize information about the device. Is your device exactly a
keyboard, except it has a higher event rate, or are there perhaps
other ques?

> There are even worse cases: I have an USB barcode reader which is
> connected by Bluetooth with the barcode reader itself. When the barcode
> reader is far away from the base station, it just buffers the scanned
> barcodes, and when the barcode reader is again within the Bluetooth
> range from the base station, it sends all the buffered scanned barcode
> in a row. Potentially hundreds and hundreds of Linux input events
> coming in.

Assuming we talk about a hid device, knowing the specification would help.

> Shouldn't the in-kernel buffer be larger for such devices, in order to
> leave more time for the applications to come and fetch the events ?

That seems reasonable, yes.

> As far as I could see, it doesn't seem to be possible to adjust the
> size of the in-kernel buffer from userspace (through some ioctl() call,
> for example). Did I miss something ?

Adjusting internal kernel buffers from userspace seems like the wrong
level of interaction. The kernel should be able to resolve this
internally, either dynamically or using information such as production
rate and consumption rate.

Thanks,
Henrik
