From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: am335x adc & tsc, second batch
Date: Wed, 29 May 2013 19:09:51 +0200
Message-ID: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

this basically fixes a few issues when TSC and ADC are used at the same
time. One issues was found in the TSC part where it used one wrong
coordinate while reading from the FIFO.

This depends on the series I sent the 19 patchset I sent earlier.
The complete series can be found at
 git://git.breakpoint.cc/bigeasy/linux.git am335x_tsc_adc

Sebastian
