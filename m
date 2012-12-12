From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] HID: i2c-hid: add mutex protecting open/close race
Date: Wed, 12 Dec 2012 17:54:21 +0100
Message-ID: <CAN+gG=Fb4Y+H+rqaxquBv6OSM__Y9Z7ww+mpRZpBThwDVExDQQ@mail.gmail.com>
References: <1355328736-31418-1-git-send-email-benjamin.tissoires@gmail.com>
	<20121212173444.471d5cc6@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121212173444.471d5cc6-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 12, 2012 at 5:34 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> Hi Benjamin,
>
> On Wed, 12 Dec 2012 17:12:16 +0100, Benjamin Tissoires wrote:
>> We should not enter close function while someone else is in open.
>> This mutex prevents this race.
>>
>> There is also no need to override the ret value with -EIO in case of
>> a failure of i2c_hid_set_power.
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>
> Looks good to me except that you forgot to include <linux/mutex.h> and
> this could cause build failures on some architectures/configs.
>
> Once this is fixed, you can add:
>
> Reviewed-by: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>

Thanks, I will resend it right now.

Cheers,
Benjamin

>
> --
> Jean Delvare
