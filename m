From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Losing events from USB barcode reader
Date: Mon, 23 May 2011 21:02:28 +0200
Message-ID: <20110523210228.7738801f@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53698 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756215Ab1EWTJs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 May 2011 15:09:48 -0400
Received: from surf (humanoidz.org [82.247.183.72])
	by mail.free-electrons.com (Postfix) with ESMTPA id 511D8135
	for <linux-input@vger.kernel.org>; Mon, 23 May 2011 21:02:29 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I have a Qt-based application which reads events from a Linux input
device through /dev/input/eventX. The device I have is an USB barcode
scanner, which works just like a keyboard.

Unfortunately, I sometimes lose events coming from this USB barcode
scanner, and I'm worried about the size of the in-kernel buffer for
events. The USB barcode scanner acts like a keyboard, but sends events
much, much faster. For example, when it scans a barcode such as
"AZERTYUIOP1234", it generates the Shift press, key press, key release,
Shift release for every character, generating at least 56 events in a
row, very quickly (and the kernel only buffers 64 events if I'm
correct).

There are even worse cases: I have an USB barcode reader which is
connected by Bluetooth with the barcode reader itself. When the barcode
reader is far away from the base station, it just buffers the scanned
barcodes, and when the barcode reader is again within the Bluetooth
range from the base station, it sends all the buffered scanned barcode
in a row. Potentially hundreds and hundreds of Linux input events
coming in.

Shouldn't the in-kernel buffer be larger for such devices, in order to
leave more time for the applications to come and fetch the events ?

As far as I could see, it doesn't seem to be possible to adjust the
size of the in-kernel buffer from userspace (through some ioctl() call,
for example). Did I miss something ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
