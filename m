From: Dmitry <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] RFKILL: fix input layer initialisation
Date: Tue, 28 Oct 2008 15:33:49 +0300
Message-ID: <bc64b4640810280533x445e7869m444dac909f8be1d2@mail.gmail.com>
References: <1224694375-29318-1-git-send-email-dbaryshkov@gmail.com>
	 <200810221905.58169.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200810221905.58169.IvDoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

2008/10/22 Ivo van Doorn <ivdoorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Wednesday 22 October 2008, Dmitry Baryshkov wrote:
>> Initialise correctly last fields, so tasks can be actually executed.
>> On some architectures the initial jiffies value is not zero, so later
>> all rfkill incorrectly decides that rfkill_*.last is in future.
>>
>> Signed-off-by: Dmitry Baryshkov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  net/rfkill/rfkill-input.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/rfkill/rfkill-input.c b/net/rfkill/rfkill-input.c
>> index e5b6955..cd93f48 100644
>> --- a/net/rfkill/rfkill-input.c
>> +++ b/net/rfkill/rfkill-input.c
>> @@ -255,6 +255,11 @@ static struct input_handler rfkill_handler = {
>>
>>  static int __init rfkill_handler_init(void)
>>  {
>> +     unsigned long last_run = jiffies - msecs_to_jiffies(500);
>> +     rfkill_wlan.last = last_run;
>> +     rfkill_bt.last = last_run;
>> +     rfkill_uwb.last = last_run;
>> +     rfkill_wimax.last = last_run;
>>       return input_register_handler(&rfkill_handler);
>>  }
>
> I believe Dmitry Torokhov recently moved the rfkill structures for wlan, bt, etc
> into an array which allowed for easy looping through all structures. That would
> make updating all entries easier (and less prone to errors when a new structure
> is added).

I can't find the patch in question. Could you please point me to it?

>
> Could you rebase thise patch on top of that one?
> Thanks,

-- 
With best wishes
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
