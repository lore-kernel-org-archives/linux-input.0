From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: am335x: IIO/ADC fixes if used together with TSC
Date: Wed, 18 Dec 2013 17:52:52 +0100
Message-ID: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

this series got a little bigger than expected with a biggy at the end.
I didn't managed to split the patches across the three subsystems it
touches due to the changes are required to keep it working and break the
logic.
Even in 5/5 which does three logical changes I didn't manage to split it
in three patches because the driver would not be functional (sometimes it would
get worse than before). This is all documented in the changelog. 
Thefore I ask to get this series applied via one tree, the iio tree which contains
or depends on the most changes.

The two bigger issues here are fixed by the last patch incuding
- time outs on the iio/adc side while TSC&ADC is used together
- a lockup issue which occurs while TSC&ADC is used together.

Sebastian
