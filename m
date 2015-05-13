From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
Date: Wed, 13 May 2015 06:46:41 -0700
Message-ID: <555355C1.9090907@roeck-us.net>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com> <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com> <20150510095838.GF3338@piout.net> <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com> <20150513125858.GX3338@piout.net> <55534BEF.7020409@roeck-us.net> <20150513133741.GY3338@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150513133741.GY3338-m++hUPXGwpdeoWH0uzbU5w@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: "Opensource [Steve Twiss]" <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/13/2015 06:37 AM, Alexandre Belloni wrote:
> On 13/05/2015 at 06:04:47 -0700, Guenter Roeck wrote :
>> Don't know how this is handled for rtc drivers, but in other subsystems
>> we just live with the original name. I don't see a need to rename a driver
>> just because it starts supporting more hardware, and xxx is weird anyway
>> since it suggests everything from 000 to 999, which is much worse than
>> just sticking with 9063.
>>
>
> Yes, in particular if at some point in time a new IP matching those xxx
> is completely different from the previous one. I'm not fond of renaming
> the driver either but if diasemi thinks that what they want, I'm open to
> let it happen. But clearly, I don't want to end up in a situation like
> the tlv320aic where you don't know which driver correspond to which
> chip:
>
> sound/soc/codecs/tlv320aic31xx.c
> sound/soc/codecs/tlv320aic31xx.h
> sound/soc/codecs/tlv320aic32x4.c
> sound/soc/codecs/tlv320aic32x4.h
> sound/soc/codecs/tlv320aic3x.c
> sound/soc/codecs/tlv320aic3x.h
> sound/soc/codecs/tlv320dac33.c
> sound/soc/codecs/tlv320dac33.h
>
> Go figure that the tlv320aic3104 can be supported by both tlv320aic3x.c
> and tlv320aic32x4.c but not tlv320aic31xx.c...
>

Unfortunately that is exactly what is going to happen.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
