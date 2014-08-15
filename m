From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: test program to check usb hid devices
Date: Fri, 15 Aug 2014 11:26:23 -0400
Message-ID: <CAN+gG=E5RDcU=S+of3aCsAkD6e6dZvpg6nQn0k6fpWP8VDJByw@mail.gmail.com>
References: <CANudz+s-2QFtpxDqj2O-tJkhEM0oWoFvjWb=xrt+F_eUmPXaog@mail.gmail.com>
	<063D6719AE5E284EB5DD2968C1650D6D17478786@AcuExch.aculab.com>
	<CANudz+tUuopx=HT0FcKJ8Ak6_K0yz-nRf7=FwtcMDH9WW1MfbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANudz+tUuopx=HT0FcKJ8Ak6_K0yz-nRf7=FwtcMDH9WW1MfbA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: loody <miloody-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: David Laight <David.Laight-JxhZ9S5GRejQT0dZR+AlfA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:HID CORE LAYER" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

If I understood correctly, you just want to dump the hid output.

You can just cat /sys/kernel/debug/hid/*/events if debugfs is mounted.

Or you may want to have a look at these 2 projects:
hid-recorder -> http://bentiss.github.io/hid-replay-docs/
usbhid-dump-> https://github.com/DIGImend/usbhid-dump (part of the
DIGImend project)

Cheers,
Benjamin

On Fri, Aug 15, 2014 at 10:31 AM, loody <miloody-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> hi David:
>
> 2014-08-15 20:54 GMT+08:00 David Laight <David.Laight-JxhZ9S5GRejQT0dZR+AlfA@public.gmane.org>:
>> From: loody
>>> Is there any test program we can use to capture input data send from
>>> usb keyboard/mouse?
>>
>> google usbmon
> Sorry for making you confused.
> What I need is not monitor usb bus data.
> What I need is some user mode program, and when I execute it, it will
> driver usb HID keyboard/mouse to work.
> And I can print out the hex value those device send once user press
> any key on keyboard or moving mouse around.
>
> It should be like I think
> hid_device=hid_open(xxx);
> while(1){
>       data = get input data(hid_device);
>       printf("0x%x\n",data);
> }
>
> Appreciate your kind help,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
