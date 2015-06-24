From: simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org
Subject: Re: [RFC_v2 0/4] HID: hid-sony: Add IIO Suport for Motion
 Controllers
Date: Wed, 24 Jun 2015 11:14:49 -0400
Message-ID: <438f185903eb23358f027ba90e9e980b.squirrel@mungewell.org>
References: <1435105830-2297-1-git-send-email-simon@mungewell.org>
    <20150624110608.65a31e2a52bb2752352605db@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150624110608.65a31e2a52bb2752352605db-qKGr9MkilAE@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Antonio Ospite <ao2-qKGr9MkilAE@public.gmane.org>
Cc: Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Frank Praznik <frank.praznik-oKii7tqusJgAvxtiuMwx3w@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

> the SixAxis also have a gyroscope, I don't know how useful/reliable it
> is, but it's there.

I had a recollection that there was a gyro, but didn't see it when looking
at the 'hidraw' stream.

It might be affected by the 'multi-touch axes' bug.
Simon
