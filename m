From: Jeremy Slater <jasl8r@gmail.com>
Subject: Matrix keypad driver
Date: Wed, 30 Dec 2009 13:57:00 -0500
Message-ID: <3e5be67b0912301057t58296329g7bdc09dd4c031c7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:41088 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZL3S5C (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2009 13:57:02 -0500
Received: by ey-out-2122.google.com with SMTP id 25so1786655eya.19
        for <linux-input@vger.kernel.org>; Wed, 30 Dec 2009 10:57:00 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I am using the matrix keypad driver and I have noticed an issue where
when pressing multiple keys in the same row, only the first key is
detected.

In this driver, the logic is that we are driving the columns and
listening for interrupts on the rows.  If you press one key on row y
the following events occur:

* row y is asserted
* interrupt is generated
* debounce timeout expires
* interrupts are disabled
* matrix is scanned one column at a time
* all columns are activated
* interrupts are enabled

The problem is that if I hold this first key down and press another
key in row y, no interrupt is generated since there is now no signal
change.

If we look at the corgi driver as an example, a timer is scheduled at
the end of the scan any time a key is down.  The comment indicates
this is to catch released keys, but this method will also catch
additional key presses in the same row.  This comes at the expense of
constant scanning at some ms interval, but only when a key is held.

Another way to implement a similar process is to let the interrupt
handler continue to schedule the scan by re-enabling interrupts before
driving the columns.  This way, if any key is held down during the
scan, a new scan will be scheduled by the interrupt handler after the
debounce period.
