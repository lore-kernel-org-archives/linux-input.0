From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: am335x: touch & adc patches
Date: Mon, 27 May 2013 21:11:47 +0200
Message-ID: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

this is basicall a repost of the recent series. It dependent on a few
patches which were not merged yet but I assuemd otherwise.
This series now includes a reworked version of them and contains:
- pending touchscreen patche (patches 1-3, 5)
- support device tree and removal of platform device structres. The am335x
  platform is DT so there is no need for it.
- small clean ups here and there.

Sebastian
