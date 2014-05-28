From: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fwd: [PATCH 3/3] IO: hid-sensor-magn-3d: Add in support for
 True/Magnetic North HID usages
Date: Wed, 28 May 2014 16:59:16 -0500
Message-ID: <CA+BWVUR0VJCbi99AEo4v_ZGcPeG_uzjYdr2LUROshUhzzKADsw@mail.gmail.com>
References: <1401311175-12784-1-git-send-email-reyad.attiyat@gmail.com>
 <1401311175-12784-4-git-send-email-reyad.attiyat@gmail.com>
 <CA+BWVUQEsprV1jEzD9D0hidR0jvYeSRVGT=ESzstR4apa+nV1A@mail.gmail.com>
 <53865438.2030901@linux.intel.com> <CA+BWVUT6tC5nn--zUJ83+FvtQ-AAtZ+CmyUN0bnTEuffpTRD2Q@mail.gmail.com>
 <53865B83.8030505@linux.intel.com> <CA+BWVURydjyrnC9ec-POtn5A8gL7C93MH6pObcmmAqD4V=p0Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CA+BWVURydjyrnC9ec-POtn5A8gL7C93MH6pObcmmAqD4V=p0Zg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Forgot to forward to list


---------- Forwarded message ----------
From: Reyad Attiyat <reyad.attiyat-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, May 28, 2014 at 4:57 PM
Subject: Re: [PATCH 3/3] IO: hid-sensor-magn-3d: Add in support for
True/Magnetic North HID usages
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>


Hey Srinivas,

> It shouldn't be an issue for few more attributes. The idea is that
> we don't expose the report level parsing information to the client drivers.
> The client shouldn't worry about which collection or report it belongs to.
>
Makes sense.

> In this way if we have to enhance the parse function for newer
> FW changes or quirks, it is only done at one place. Clients are not
> affected at all.
>
> Alternatively
> we can enhance API, which takes multiple usage ids and fills information
> in a single call. What do you think about this?

Yes this seems like a great idea. I will try and implement this and
resubmit these patches.

Thank You,
Reyad Attiyat
