From: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] IIO: Add iio_chan modifier for True/Magnetic North
 HID usages
Date: Mon, 2 Jun 2014 14:54:40 -0500
Message-ID: <CA+BWVUSHUT9r=RHX3ubn6Byq=cX4wkfHsoc4Kh1FFFuLvW6GSw@mail.gmail.com>
References: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com>
 <1401311175-12784-3-git-send-email-reyad.attiyat@gmail.com> <5389AB89.9080305@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5389AB89.9080305-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hey Jonathan,
>
> I think we need the naming to explicitly mention north_magnetic instead
> of just north.  Whilst it is obvious what north means when you have north
> true alongside it, it won't be so obvious if one just has the north
> attribute
> to see in a particular driver - if anything I'd have the true as the one
> that was simply called north (as it might not be coming from a magnetometer
> thought obviously that's the most common source)   I'd also rather the enum
> entries
> were
> IIO_MOD_NORTH_MAGN
> IIO_MOD_NORTH_TRUE
> IIO_MOD_NORTH_MAGN_TILT_COMP
> IIO_MOD_NORTH_TRUE_TILT_COMP
>
> It is definitely feasible that they will not come from magnetometers -
> a differential bearing is common on GPS units.

Makes sense to me. I will update the patches with your suggestions. Thanks.
