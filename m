From: Ricky Liang <jcliang@chromium.org>
Subject: Re: [PATCH] Input: uinput - handle compat ioctl for UI_SET_PHYS
Date: Sat, 21 May 2016 01:50:34 +0800
Message-ID: <CAAJzSMcXVGUCRTaBfLLn426aoNoWGPS=ZWya9_kVQB-=rHtPsQ@mail.gmail.com>
References: <1463499587-21346-1-git-send-email-jcliang@chromium.org> <20160520163210.GB14951@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160520163210.GB14951@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Elias Vanderstuyft <elias.vds@gmail.com>, Anshul Garg <aksgarg1989@gmail.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

On Sat, May 21, 2016 at 12:32 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Ricky,
>
> On Tue, May 17, 2016 at 11:39:45PM +0800, Ricky Liang wrote:
>> When running a 32-bit userspace on a 64-bit kernel, the UI_SET_PHYS
>> ioctl needs to be treated with special care, as it has the pointer
>> size encoded in the command.
>>
>> Signed-off-by: Ricky Liang <jcliang@chromium.org>
>> ---
>>  drivers/input/misc/uinput.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
>> index abe1a92..b4d1b1d 100644
>> --- a/drivers/input/misc/uinput.c
>> +++ b/drivers/input/misc/uinput.c
>> @@ -984,6 +984,15 @@ static long uinput_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>  static long uinput_compat_ioctl(struct file *file,
>>                               unsigned int cmd, unsigned long arg)
>>  {
>> +     switch (_IOC_NR(cmd)) {
>> +             case _IOC_NR(UI_SET_PHYS):
>> +                     if (_IOC_SIZE(cmd) == sizeof(compat_uptr_t)) {
>> +                             cmd &= ~IOCSIZE_MASK;
>> +                             cmd |= sizeof(void *) << IOCSIZE_SHIFT;
>> +                     }
>> +                     break;
>> +     }
>> +
>
> This looks quite complicated... Can we do this:
>
> #define UI_SET_PHYS_COMPAT __IOW(UINPUT_IOCTL_BASE, 108, compat_uptr_t)
>
> ...
>
>         if (cmd == UI_SET_PHYS_COMPAT)
>                 cmd = UI_SET_PHYS;
>
>>       return uinput_ioctl_handler(file, cmd, arg, compat_ptr(arg));
>>  }
>>  #endif
>
> We can use the local define instead of manipulating cmd size because we
> will never going to change UI_SET_PHYS definition, since it is part of
> uapi.

Sounds good. I'll send v2 to implement this.

Thanks,
Ricky

>
> Thanks.
>
> --
> Dmitry
