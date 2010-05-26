From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: ATMEL camera interface
Date: Wed, 26 May 2010 15:04:31 +0200
Message-ID: <4BFD1C5F.5060403@atmel.com>
References: <4BD9AA8A.7030306@atmel.com> <Pine.LNX.4.64.1004291824200.4666@axis700.grange> <4BDED3A8.4090606@atmel.com> <Pine.LNX.4.64.1005031556570.4231@axis700.grange> <4BDEDB06.9090909@atmel.com> <Pine.LNX.4.64.1005031622040.4231@axis700.grange> <4BDEEE38.9070801@atmel.com> <Pine.LNX.4.64.1005031836140.4231@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:1518 "EHLO sjogate2.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922Ab0EZOxF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 26 May 2010 10:53:05 -0400
In-Reply-To: <Pine.LNX.4.64.1005031836140.4231@axis700.grange>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-input@vger.kernel.org

Hi,

So I have decided to go with the v4l2-subdev API.
I have taken the omapxxcam and vivi.c as exemple, but I have some=20
questions...
I still don't understand how to register a v4l2 device. I tried to copy=
=20
the method from vivi.c using v4l2_device_register but it is not working=
?
If I just use video_regiter_device, then it is trying to use the defaul=
t=20
ioctl and open/close functions from v4l2(v4l2_open) instead of the one =
I=20
hae in my driver...
What am I doing wrong?

BR,
Sedji

Le 5/3/2010 6:40 PM, Guennadi Liakhovetski a =E9crit :
> On Mon, 3 May 2010, Sedji Gaouaou wrote:
>
>> Well sorry to bother you again but I am looking at the mx1_camera.c =
file, and
>> I wonder where are implemented the queue and dqueue functions?
>>
>> The atmel IP is using linked list for the buffers, and previously I =
was
>> managing it in the queue and dqueue functions.
>> I am not sure where I should take care of it now?
>
> qbuf and dqbuf are implemented by soc-camera in soc_camera_qbuf() and
> soc_camera_dqbuf() respectively, drivers only implement methods from
> struct videobuf_queue_ops, e.g., a .buf_queue method, which for mx1_c=
amera
> is implemented by mx1_videobuf_queue().
>
> Thanks
> Guennadi
>
>>
>>
>> Regards,
>> Sedji
>>
>> Le 5/3/2010 4:26 PM, Guennadi Liakhovetski a =E9crit :
>>> On Mon, 3 May 2010, Sedji Gaouaou wrote:
>>>
>>>> Well I need contiguous memory, so I guess I will have a look at
>>>> mx1_camera.c?
>>>> Is there another example?
>>>>
>>>> What do you mean by videobuf implementation? As I said I just need=
 a
>>>> contiguous memory.
>>>
>>> I mean, whether you're gping to use videobuf-dma-contig.c or
>>> videobuf-dma-sg.c, respectively, whether you'll be calling
>>> videobuf_queue_dma_contig_init() or videobuf_queue_sg_init() in you=
r
>>> driver.
>>>
>>> Regards
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
