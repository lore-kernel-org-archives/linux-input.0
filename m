From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: am335x: IIO/ADC fixes if used together with TSC, v2
Date: Thu, 19 Dec 2013 16:28:26 +0100
Message-ID: <1387466911-3732-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

The two bigger issues here are fixed by the last patch incuding
- time outs on the iio/adc side while TSC&ADC is used together
- a lockup issue which occurs while TSC&ADC is used together.

v1=E2=80=A6v2:
 - spelled checked and re-read each commit message and formated to
   subject line as Lee suggested.
 - removed am335x_tsc_se_set(), replaced am335x_tsc_se_tsc_set() by=20
   am335x_tsc_se_set_cache() and adc variant is now named
   am335x_tsc_se_set_once()
 - Added Lee Jones' tags

Sebastian                                                           =20
