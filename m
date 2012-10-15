From: Benjamin Tissoires <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1] i2c-hid: introduce HID over i2c specification implementation
Date: Mon, 15 Oct 2012 22:42:41 +0200
Message-ID: <CAN+gG=H9OfEyVaOD6r3Q5CZHNY2d1gAUr=kBAgXs-qacUDqsOw@mail.gmail.com>
References: <1347630103-4105-1-git-send-email-benjamin.tissoires@gmail.com>
	<20121007162838.01f36b7c@endymion.delvare>
	<CAN+gG=E3nmXZ9RL3wN2tvKqSOu5hWYLXLf+Z=ag7VvZGJfhQ-w@mail.gmail.com>
	<20121007210359.29f40ecf@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121007210359.29f40ecf-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Stephane Chatty <chatty-rXV5z7KbLFk@public.gmane.org>, fabien.andre-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 7, 2012 at 9:03 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
> On Sun, 7 Oct 2012 18:57:36 +0200, Benjamin Tissoires wrote:
>> On Sun, Oct 7, 2012 at 4:28 PM, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org> wrote:
>> > On Fri, 14 Sep 2012 15:41:43 +0200, benjamin.tissoires wrote:
>> >> +     u16 readRegister = ihid->hdesc.wDataRegister;
>> >
>> > This is missing le16_to_cpu().
>>
>> I agree this is awful, but not putting it allows me to not have to
>> check the endianness when I'm using it.
>> But I may be totally wrong on this.
>
> I'm afraid I don't follow you. I want to see:
>
>         u16 readRegister = le16_to_cpu(ihid->hdesc.wDataRegister);
>
> If you don't do that, your driver is broken on bigendian systems. And
> there's no need to "check the endianness when you're using it", the
> above should be enough for things to work just fine.
>

a little bit late, but yes, you are entirely right. I was confused by
the fact that I only wanted to use the number coming from the device
to communicate with it, but as I made bit shifting within the CPU, I
need to convert it.
So forget my previous words here, it is fixed in v2.

Thanks
Benjamin

> --
> Jean Delvare
