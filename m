From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] input: misc: delete MPU3050 driver
Date: Tue, 31 Jan 2017 10:30:01 +0100
Message-ID: <CACRpkda_VP=PKDxHyq_v7q2k3Q4XhGV34bgD1ez5Rdg2O1f5cQ@mail.gmail.com>
References: <20170110083141.4103-1-linus.walleij@linaro.org>
 <20170110104333.GB18258@kuha.fi.intel.com> <20170131081433.GB8311@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170131081433.GB8311@dtor-ws>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joseph Lai <joseph_lai-8+ZHUTgF1KZBDgjK7y7TUQ@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 31, 2017 at 9:14 AM, Dmitry Torokhov
<dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> OK, since nobody yelled that they need it I applied the patch.

Thanks!

We need to think about the future of these misc input drivers:

misc/bma150.c
misc/cma3000*
misc/mma8450.c

The first has a partial (or maybe complete) support in
iio/accel/bma180.c and the last seems to be possible to be
supported by iio/accel/mma8452.c with some slight adjustments.

It's not only because I have OCD and want to sort every driver
in the right pigeon-hole... the iio-sensor-proxy GNOME daemon
bugzilla/github has been spamming me with complaints about
problems caused by the accelerometer-as-input drivers.
It would be nice to at least compartmentalize the problems
into one subsystem. Terminating misc/bma150.c has been
mentioned.

Yours,
Linus Walleij
