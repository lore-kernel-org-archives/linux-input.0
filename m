From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v7 3/5] power: max77843_battery: Add Max77843 fuel gauge
 device driver
Date: Tue, 10 Mar 2015 22:44:14 +0900
Message-ID: <54FEF52E.7060409@samsung.com>
References: <1425291038-18269-1-git-send-email-jaewon02.kim@samsung.com>
 <1425291038-18269-4-git-send-email-jaewon02.kim@samsung.com>
 <20150307201426.GG5233@earth> <54FCEB17.70809@samsung.com>
 <CAJKOXPcLa8jGBS9r=iAbuco5+9=XcjsEFazFtAWinYUQDArkUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <CAJKOXPcLa8jGBS9r=iAbuco5+9=XcjsEFazFtAWinYUQDArkUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaewon Kim <jaewon02.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, SangBae Lee <sangbae90.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 03/09/2015 07:01 PM, Krzysztof Kozlowski wrote:
> 2015-03-09 1:36 GMT+01:00 Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>:
>> On 03/08/2015 05:14 AM, Sebastian Reichel wrote:
>>> Hi,
>>>
>>> On Mon, Mar 02, 2015 at 07:10:36PM +0900, Jaewon Kim wrote:
>>>> From: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>
>>>> This patch adds device driver of max77843 fuel gauge.
>>>> The driver support for battery fuel gauge in Maxim Max77843.
>>>> It is fuel-gauge systems for lithuum-ion batteries in handled and
>>>> portable devices.
>>>>
>>>> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>> Signed-off-by: Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>
>>> Reviewed-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>>>
>>> I can't take it as is, since it depends on the private header file
>>> of PATCH 1.
>>>
>>> -- Sebastian
>>>
>>
>> This patch reviewed by Sebastian.
>> Could you Please merge that your git tree ?
> 
> Hi,
> 
> Sorry for late response, but I finally got some time to look at this.
> This driver looks very similar to max17042_battery.c fuel gauge
> driver. Obtaining some properties looks exactly the same. The
> difference seems to be in new properties. The I2C address is the same.
> 
> I highly recommend to extend the max17042 driver instead. It already
> supports also max17047, max17050 and max77693.
> 
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

OK. I will follow your opinion about fuel gauge. I will extend the max17042 driver.
After test on my board, I will send a new patch set.

Best regards,
Beomho Seo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
