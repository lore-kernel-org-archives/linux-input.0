From: Jian-Jhong Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Subject: Re: [PATCH v2] i2c-hid: introduce HID over i2c specification implementation
Date: Thu, 18 Oct 2012 18:16:21 +0800
Message-ID: <87wqyojdai.fsf@emc.com.tw>
References: <1350333533-13366-1-git-send-email-benjamin.tissoires@gmail.com> <87zk3kjghz.fsf@emc.com.tw> <CAN+gG=HLxXJAwZ8mWzuDFVBht4BeWaSEvXOQZEBgS8akyerQEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAN+gG=HLxXJAwZ8mWzuDFVBht4BeWaSEvXOQZEBgS8akyerQEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:
> Hi JJ,
>
> On Thu, Oct 18, 2012 at 11:07 AM, Jian-Jhong Ding <jj_ding-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org> wrote:
>> Hi Benjamin,
>>
>> Some suggestions to make the error messages more "human", and a little
>> question on the return value of i2c_hid_fetch_hid_descriptor.  Please see below:
>
> I fully agree with the more "human" error messages.
>
> However, for i2c_hid_fetch_hid_descriptor return values, I'm affraid I
> can't use -EINVAL.
>
> Jean Delvare (one of the i2c maintainers) told in his review of the v1:
> "
> These should all be -ENODEV in this function
> [i2c_hid_fetch_hid_descriptor]: the device isn't what you
> expected. EINVAL is for invalid argument.
> "

I must have missed that mail.  Thank you for pointing this out.

-JJ

> So ENODEV is the right return value.
>
> Anyway, thanks for the review.
>
> Cheers,
> Benjamin
