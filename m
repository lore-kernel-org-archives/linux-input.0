From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH RFC V1 0/3] da9062: Add DA9062 RTC support using the
 existing DA9063 RTC driver
Date: Thu, 9 Jul 2015 11:06:50 +0200
Message-ID: <CAMuHMdWYJyzrBsMMJciyvkopAfA-omrD-eEsC2XhCvCeDBd+uQ@mail.gmail.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
	<CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw@mail.gmail.com>
	<6ED8E3B22081A4459DAC7699F3695FB7014B23FDDA@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B23FDDA-68WUHU125fLzLL1Oxlh9IgLouzNaz+3S@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 9, 2015 at 10:42 AM, Opensource [Steve Twiss]
<stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org> wrote:
>> > S Twiss (3):
>> >   mfd: da9062: Support for the DA9063 RTC in the DA9062 core
>>
>> "DA9062 RTC"?
>>
>
> Hi Geert,
>
> It's the support for the "DA9063 RTC *driver* in the DA9062 MFD driver core".

Ah, I read "core" as in "hardware IP core".

And as the full patch description for [1/3] doesn't say "da9063" elsewhere,
I thought it was a typo.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
