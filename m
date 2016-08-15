From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 5/7] iio: hid-sensors: use asynchronous resume
Date: Mon, 15 Aug 2016 16:49:51 +0100
Message-ID: <6ee7950c-8602-a4a1-b87c-0e6a60752c50@kernel.org>
References: <1470561939-14278-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <1470561939-14278-6-git-send-email-srinivas.pandruvada@linux.intel.com>
 <alpine.LNX.2.00.1608071214500.22028@cbobk.fhfr.pm>
 <884e74df-569e-8218-fbda-f9c7ecfe1e5a@kernel.org>
 <af2d1c90-a0ec-0888-8048-76463bf98ece@kernel.org>
 <CAKdAkRS-sVHqQ1tUZWVxNTfX5=ZxFzbCAxvsJPHV4=85mdEeRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdAkRS-sVHqQ1tUZWVxNTfX5=ZxFzbCAxvsJPHV4=85mdEeRA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 15/08/16 16:45, Dmitry Torokhov wrote:
> On Mon, Aug 15, 2016 at 7:52 AM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On 15/08/16 15:07, Jonathan Cameron wrote:
>>> On 07/08/16 11:15, Jiri Kosina wrote:
>>>> On Sun, 7 Aug 2016, Srinivas Pandruvada wrote:
>>>>
>>>>> Some platforms power off sensor hubs during S3 suspend, which will require
>>>>> longer time to resume. This hurts system resume time, so resume
>>>>> asynchronously.
>>>>>
>>>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>>>>
>>>> Jonathan, are you going to cherry-pick this patch from the series?
>>>> Alternatively, if you're okay with it, I can pull it in together with the
>>>> whole set with your Acked-by or Reviewed-by.
>>>>
>>> I'll take it via IIO. Got a bit of catching up to do (been on holiday)
>> Applied to the togreg branch of iio.git - initially pushed out as
>> testing for the autobuilders to play with it.
>> This one is not really connected to the others so makes sense to
>> take it separately.
>>
>> I'm out of my depth on the rest of the patches in this series
>> and don't have time to learn enough to follow them! Sorry I
>> can't help on that front.
> 
> About this patch: me sees a new work, me does not see new calls to
> cancel_work_sync() or flush_work() anywhere, me gets worried.
> 
> Thanks.
Good point.

Backed out for now...

Jonathan
> 
