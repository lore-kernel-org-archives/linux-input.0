From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: ATMEL camera interface
Date: Mon, 03 May 2010 16:17:42 +0200
Message-ID: <4BDEDB06.9090909@atmel.com>
References: <4BD9AA8A.7030306@atmel.com> <Pine.LNX.4.64.1004291824200.4666@axis700.grange> <4BDED3A8.4090606@atmel.com> <Pine.LNX.4.64.1005031556570.4231@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:33813 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759033Ab0ECORs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 May 2010 10:17:48 -0400
In-Reply-To: <Pine.LNX.4.64.1005031556570.4231@axis700.grange>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org

Well I need contiguous memory, so I guess I will have a look at=20
mx1_camera.c? Is there another example?

What do you mean by videobuf implementation? As I said I just need a=20
contiguous memory.

Le 5/3/2010 4:03 PM, Guennadi Liakhovetski a =E9crit :
> On Mon, 3 May 2010, Sedji Gaouaou wrote:
>
>> Hi,
>>
>> I will try to write a soc driver(it seems easier ;)).
>>
>> Are the mx?_camera.c a good starting point?
>
> In principle - yes. But think about one pretty important distinction =
-
> what videobuf implementation is your driver going to use? Are you goi=
ng to
> support scatter-gather or only contiguous buffers? If SG - the only s=
uch
> example in the mainline is pxa_camera.c. If contiguous - feel free to=
 use
> any one of the rest. Further, mx3_camera uses the dmaengine API, othe=
rs
> don't. Hope, this will simplify your choice a bit;)
>
> Thanks
> Guennadi
>
>> Regards,
>> Sedji
>>
>> Le 4/29/2010 6:35 PM, Guennadi Liakhovetski a =E9crit :
>>> Hi Sedji
>>>
>>> On Thu, 29 Apr 2010, Sedji Gaouaou wrote:
>>>
>>>> Hi,
>>>>
>>>> I need to re-work my driver so I could commit it to the community.
>>>> Is there a git tree that I can use?
>>>
>>> Nice to hear that! As far as soc-camera is concerned, the present A=
PIs are
>>> pretty stable. Just use the Linus' git tree, or, if you like, you c=
an use
>>> the v4l-dvb git tree at git://linuxtv.org/v4l-dvb.git. In fact, you=
 don't
>>> have to use the soc-camera API these days, you can just write a com=
plete
>>> v4l2-device driver, using the v4l2-subdev API to interface to video
>>> clients (sensors, decoders, etc.) However, you can still write your=
 driver
>>> as an soc-camera host driver, which would make your task a bit easi=
er at
>>> the cost of some reduced flexibility, it's up to you to decide.
>>>
>>> Thanks
>>> Guennadi
>>> ---
>>> Guennadi Liakhovetski, Ph.D.
>>> Freelance Open-Source Software Developer
>>> http://www.open-technology.de/
>>>
>>
>>
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
