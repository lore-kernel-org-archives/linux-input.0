From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH resend] input: fix sur40.c dependency/build errors
Date: Sat, 17 Oct 2015 11:37:16 -0700
Message-ID: <5622955C.2060204@infradead.org>
References: <559FE1AD.5020907@infradead.org> <20150710170328.GB35720@dtor-ws>
 <20150710170853.GC35720@dtor-ws> <20151017171354.GF13470@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151017171354.GF13470@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Florian floe Echtler <floe@butterbrot.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-input@vger.kernel.org

On 10/17/15 10:13, Dmitry Torokhov wrote:
> On Fri, Jul 10, 2015 at 10:08:53AM -0700, Dmitry Torokhov wrote:
>> On Fri, Jul 10, 2015 at 10:03:28AM -0700, Dmitry Torokhov wrote:
>>> On Fri, Jul 10, 2015 at 08:15:57AM -0700, Randy Dunlap wrote:
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Fix build errors due to missing Kconfig dependency.
>>>>
>>>> drivers/built-in.o: In function `sur40_disconnect':
>>>> sur40.c:(.text+0x22be6e): undefined reference to `video_unregister_device'
>>>> sur40.c:(.text+0x22be77): undefined reference to `v4l2_device_unregister'
>>>> drivers/built-in.o: In function `sur40_process_video':
>>>> sur40.c:(.text+0x22c1d4): undefined reference to `v4l2_get_timestamp'
>>>> drivers/built-in.o: In function `sur40_probe':
>>>> sur40.c:(.text+0x22ca82): undefined reference to `v4l2_device_register'
>>>> sur40.c:(.text+0x22cb1a): undefined reference to `v4l2_device_unregister'
>>>> sur40.c:(.text+0x22cbf7): undefined reference to `video_device_release_empty'
>>>> sur40.c:(.text+0x22cc53): undefined reference to `__video_register_device'
>>>> sur40.c:(.text+0x22cc90): undefined reference to `video_unregister_device'
>>>> drivers/built-in.o: In function `sur40_vidioc_querycap':
>>>> sur40.c:(.text+0x22ccb0): undefined reference to `video_devdata'
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Applied, thank you.
>>
>> Actually, Mauro, can this go through media tree for now?
> 
> Do we still need this patch?

Yes, I just tested 4.3-rc5 and it still has this problem.

> Thanks.
(reuse bits)


> 
>>
>>>
>>>> ---
>>>>  drivers/input/touchscreen/Kconfig |    1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> --- linux-next-20150710.orig/drivers/input/touchscreen/Kconfig
>>>> +++ linux-next-20150710/drivers/input/touchscreen/Kconfig
>>>> @@ -993,6 +993,7 @@ config TOUCHSCREEN_SUN4I
>>>>  config TOUCHSCREEN_SUR40
>>>>  	tristate "Samsung SUR40 (Surface 2.0/PixelSense) touchscreen"
>>>>  	depends on USB && MEDIA_USB_SUPPORT && HAS_DMA
>>>> +	depends on VIDEO_V4L2
>>>>  	select INPUT_POLLDEV
>>>>  	select VIDEOBUF2_DMA_SG
>>>>  	help
>>>
>>> -- 
>>> Dmitry
>>
>> -- 
>> Dmitry
> 


-- 
~Randy
