From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v4] HID: hid-multitouch: support fine-grain orientation
 reporting
Date: Thu, 12 Oct 2017 08:24:15 +1000
Message-ID: <20171011222415.GA22023@jelly>
References: <20171010041631.22093-1-wnhuang@google.com>
 <20171010065740.GA22909@mars.bitmath.org>
 <CAE_wzQ_jPP54_1GgEuPZWHjs57=owTTP35ygO6dafYmxgDZYPQ@mail.gmail.com>
 <20171011085451.GG865@mail.corp.redhat.com>
 <nycvar.YFH.7.76.1710111529360.14384@jbgna.fhfr.qr>
 <20171011135324.GI865@mail.corp.redhat.com>
 <20171011204324.GA24245@mars.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:12925 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751924AbdJKW7t (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 11 Oct 2017 18:59:49 -0400
Content-Disposition: inline
In-Reply-To: <20171011204324.GA24245@mars.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dtor@chromium.org>, Wei-Ning Huang <wnhuang@chromium.org>, LKML <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>

On Wed, Oct 11, 2017 at 10:43:24PM +0200, Henrik Rydberg wrote:
> > > > , but I'd go for fixing the documentation. And re-reading it, it's not 
> > > > clear that the doc tells us to have [0,90]. It mentions negative values 
> > > > and out of ranges too, so we might just as well simply clarify that we 
> > > > rather have [-90,90], with 0 being "north".
> > > 
> > > ... I'd like the documentation fix to go in together in one go with this 
> > > patch if possible.
> > > 
> > 
> > Sounds like a plan.
> 
> How about this patch?
> 
> Henrik
> 
> ---
> 
> From b14f92066dfab3f8a255ec7b5a30cb1a864dc62f Mon Sep 17 00:00:00 2001
> From: Henrik Rydberg <rydberg@bitmath.org>
> Date: Wed, 11 Oct 2017 22:41:39 +0200
> Subject: [PATCH] Input: docs - clarify the usage of ABS_MT_ORIENTATION
> 
> As more drivers start to support touch orientation, clarify how the
> value range should be set to match the expected behavior in
> userland.
> 
> Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
> ---
>  Documentation/input/multi-touch-protocol.rst | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/input/multi-touch-protocol.rst b/Documentation/input/multi-touch-protocol.rst
> index 8035868..a0c5c03 100644
> --- a/Documentation/input/multi-touch-protocol.rst
> +++ b/Documentation/input/multi-touch-protocol.rst
> @@ -269,15 +269,17 @@ ABS_MT_ORIENTATION
>      The orientation of the touching ellipse. The value should describe a signed
>      quarter of a revolution clockwise around the touch center. The signed value
>      range is arbitrary, but zero should be returned for an ellipse aligned with
> -    the Y axis of the surface, a negative value when the ellipse is turned to
> -    the left, and a positive value when the ellipse is turned to the
> -    right. When completely aligned with the X axis, the range max should be
> -    returned.
> +    the Y axis of the surface (north). A negative value should be returned when
> +    the ellipse is turned to the left (west), 

this bit is good.


> +    with the smallest value reported
> +    when aligned with the negative X axis. The largest value should be returned
> +    when aligned with the positive X axis.

this bit is less precise than before, because 'smallest' doesn't mean
'minimum' but smallest value. so a device announcing -90,90 could think that
returning -120 is a good idea for X alignment. I liked the previous "When
completely aligned with the X axis, the range max should be returned.", it
was less ambiguous.

replacing 'smallest value'/'largest value' with -range_max/range_max should
be sufficient here.


> +
> +    The value range should be specified as [-range_max, range_max].

I'd really like this to be [0, max] == can only detect one quarter/half and
[-max, +max] == can detect both directions. It's one extra bit of
information that may come in useful at some point.

>      Touch ellipsis are symmetrical by default. For devices capable of true 360
> -    degree orientation, the reported orientation must exceed the range max to
> +    degree orientation, the reported orientation will exceed range_max, in order to
>      indicate more than a quarter of a revolution. For an upside-down finger,
> -    range max * 2 should be returned.
> +    +- 2 * range_max should be returned.

ack to this bit

Cheers,
   Peter

>  
>      Orientation can be omitted if the touch area is circular, or if the
>      information is not available in the kernel driver. Partial orientation
> -- 
> 2.14.1
> 
