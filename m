From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 6/8] Input: goodix - add support for ESD
Date: Fri, 20 Nov 2015 09:20:48 -0800
Message-ID: <CAKdAkRSzP6VpEs=CvRXgi=YQABAzN-dFfNd3QTOcJ4sra8EbsQ@mail.gmail.com>
References: <1447936001-21420-1-git-send-email-irina.tirdea@intel.com>
	<1447936001-21420-7-git-send-email-irina.tirdea@intel.com>
	<20151120154458.GA12090@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151120154458.GA12090@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Aleksei Mamlin <mamlinav-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Karsten Merker <merker-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Nov 20, 2015 at 7:44 AM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Nov 19, 2015 at 02:26:39PM +0200, Irina Tirdea wrote:
>> Add ESD (Electrostatic Discharge) protection mechanism.
>
> [...]
>
>> This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
>> driver gt9xx.c for Android (publicly available in Android kernel
>> trees for various devices).
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> For the binding: Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> You should not have the "For the binding:" part here. It was just a note
> so it was clear what part I looked at.
>
> It is preferred to split DT bindings to separate patches for this
> reason.
>

It however does not make sense if one wants to research when and why
something was changed. We do not split patches to .h files from .c
either.

Whenever I can I merge the driver and dt binding changes together if
they have been posted and reviewed as separate patches. The
Acks/Reviewed are mostly important for maintainers anyway.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
