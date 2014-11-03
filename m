From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: fix negated returns
Date: Mon, 3 Nov 2014 15:41:40 -0500
Message-ID: <CAN+gG=EUPxERcaPjqnDYNJUeQeWxHtJdRiAmyeb4b2g0W_yHqg@mail.gmail.com>
References: <1415044253-18734-1-git-send-email-benjamin.tissoires@redhat.com>
	<20141103203230.GV6890@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141103203230.GV6890@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Nov 3, 2014 at 3:32 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Mon, Nov 03, 2014 at 02:50:52PM -0500, Benjamin Tissoires wrote:
>> @@ -524,8 +541,11 @@ static int hidpp_touchpad_get_raw_info(struct hidpp_device *hidpp,
>>       ret = hidpp_send_fap_command_sync(hidpp, feature_index,
>>               CMD_TOUCHPAD_GET_RAW_INFO, NULL, 0, &response);
>>
>> -     if (ret)
>> -             return -ret;
>> +     if (ret > 0) {
>> +             hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
>> +                     __func__, ret);
>> +             return -EPROTO;
>> +     }
>
> We should handle -ENOMEM and -EINVAL here as well.  Something like:
>
>         if (ret > 0) {
>                 hid_err(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
>                         __func__, ret);
>                 ret = -EPROTO;
>         }
>         if (ret)
>                 return ret;

Ouch. my bad...
No, I don't have any excuses for that.

Thanks for the review.

Cheers,
Benjamin
