From: R0b0t1 <r030t1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: UHID Device Reports Do Not Generate OS Activity
Date: Sun, 11 Feb 2018 14:22:04 -0600
Message-ID: <CAAD4mYio0Ke__0WM15J1yVWwWYeaJSGHUebJOupTkRe9uqou-w@mail.gmail.com>
References: <CAAD4mYj0pUUbwX8mKDP2qTn=QZM9ubk3f9FsabefK4xntY7bFA@mail.gmail.com>
 <CAEc3jaAyQiNDLbOvNkT65n-Vju-LOHjoSuiOqDunBFna0YDaBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAEc3jaAyQiNDLbOvNkT65n-Vju-LOHjoSuiOqDunBFna0YDaBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roderick Colenbrander <thunderbird2k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Feb 11, 2018 at 1:46 PM, Roderick Colenbrander
<thunderbird2k-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> It is hard to say what is wrong. I would start with reading the uhid /
> hid code and see where you are getting stuck (and double check uhid
> docs). Even for others we would need to do that as it is not easy to
> see what is wrong.
>

The issue was that the device is not immediately able to give input to
userspace programs after being opened by the kernel.

Waiting 32ms (2 timeslices?) gives a 100% success rate, with 16ms
having a 50% success rate. Checking modern kernel sources timeslices
may no longer be 16ms.

> I'm not sure what your goal is obvious you want to simulate a keyboard
> for some purpose, but do you really need to operate at the HID layer?
> If not it is much more convenient to use uinput, which will create a
> evdev device for you.
>

My kernel was not originally compiled with uinput. I used uhid to
avoid rebooting. (I have since rebooted and ended 199 days of uptime.)

There were other reasons for doing it this way, one of them being that
I am going to be prototyping an HID device. A software model will
help. I also wanted more control of the keystrokes initially to see if
it would be necessary to maintain that control.

It might be best to switch to uinput, but once you have USB
descriptors USB is actually very simple.

Cheers,
     R0b0t1

> Thanks,
> Roderick
>
> On Sat, Feb 10, 2018 at 1:33 AM, R0b0t1 <r030t1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hello,
>>
>> I am trying to simulate a keyboard using the uhid interface. The fake
>> device shows up in dmesg, but attempting to press the "a" key does
>> nothing I can see. No input appears in the active terminal, nor in an
>> xev window.
>>
>> The program receives UHID_OPEN, UHID_START, and UHID_CLOSE.
>>
>> Many different report descriptors were tried. The one currently
>> uncommented is the one distributed with the USB implementor forum's
>> HID report descriptor tool. The other is one found in a description of
>> a boot device compatible keyboard.
>>
>> Thanks in advance,
>>      R0b0t1
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
