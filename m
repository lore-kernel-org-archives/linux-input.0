From: Anthony Kim <Anthony.Kim-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v2 resend 0/1] Input: add support HiDeep touchscreen.
Date: Mon, 6 Nov 2017 04:00:02 +0000
Message-ID: <93AED97F53D7B941873C33A3FA30928855B9DA@mbox02.hideep.com>
References: <1509445077-19246-1-git-send-email-anthony.kim@hideep.com>
 <20171104003552.ve2elx6s4azzyd6q@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171104003552.ve2elx6s4azzyd6q@dtor-ws>
Content-Language: ko-KR
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Dmitry Torokhov' <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "'robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org'" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "'linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "'linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org'" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dennis Hong <Dennis.Hong-7TZDMcjUQMzQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

Thanks for your mention.

>Hi Anthony,

>On Tue, Oct 31, 2017 at 07:17:56PM +0900, Anthony Kim wrote:
>> Hi,
>> 
>> I remake patch to base on dmitry's modified code.
>> Please refer as follow.
>> http://www.spinics.net/lists/linux-input/msg53724.html
>> 
>> That code is working well almost, but needed to some modified.
>> 
>> - v2
>>   - Our fw binary data is little endian, but our IC protocol
>>     for fw update use big endian. So it need to convert to big endian data
>>     and I added about it.

>I understand that _currently_ your firmware binary is little endian, however it is easily remedied on your side. I do not understand why you would want to encumber the kernel running on many devices to do that conversion on fly.

As your mention, I will don't convert to another endian again. I didn't know whether it affected. Just I hoped our IC work well.
And I will test again using big endian binary. If there need to modify, I will send modified patch.

Thanks! 

>Thanks.

>--
>Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
