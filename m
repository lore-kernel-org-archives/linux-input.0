From: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Subject: Re: Report ID problem with HID-RAW interface usage
Date: Wed, 30 Jun 2010 10:32:25 -0400
Message-ID: <4C2B5579.8060104@signal11.us>
References: <AANLkTinrmRsB39gj7Ie4xCr3fhP3jU1dfYuVrkiKv347@mail.gmail.com>	<4C2A1FA0.6020704@signal11.us>	<alpine.LNX.2.00.1006301126130.13809@pobox.suse.cz>	<AANLkTilf1JU_GPlqE-FeaRon6IMqgA68WZ964PJfLpSP@mail.gmail.com>	<alpine.LNX.2.00.1006301252380.13809@pobox.suse.cz>	<AANLkTil-hNWeWbLQqE0ezlmZhO1w402NClaT_tayPJra@mail.gmail.com>	<4C2B3E6B.7060703@signal11.us>	<AANLkTilzYu3mA3vDzuVyxngTcltgKEoNKYrdenz1Z-VG@mail.gmail.com>	<alpine.LNX.2.00.1006301505490.13809@pobox.suse.cz> <AANLkTil0S747k-MomthJW4dv2WwB-abjZmGmxf3fH59y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <AANLkTil0S747k-MomthJW4dv2WwB-abjZmGmxf3fH59y-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiaofan Chen <xiaofanc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Amit Nagal <helloin.amit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 06/30/2010 10:09 AM, Xiaofan Chen wrote:
> Some of us in the libusb mailing list have this desire to
> create a real cross-platform HID API (which libhid is
> trying to do but without real success -- at least under
> Windows since there is no real Windows port) on top
> of libusb-1.0.
>
> The new libusb-1.0 Windows backend can directly
> use the native HID API. And I create a ticket to ask
> for a native HID backend for Mac OS X and I believe
> it can be done.
> http://www.libusb.org/ticket/33
>
> I am not so sure if it is necessary to create a native hidraw
> backend for Linux or not. But the advantage of transport-independent
> HID device seems to be a good one. I think Windows native HID API
> also support non-USB device. Not so sure about Mac OS X though
> since I do not use Mac and do not know Mac.
>
>    

I've had the same ideas of creating a cross-platform HID api, and 
started a similar project. Maybe we could benefit from one another. What 
I've got so far is at:
     www.signal11.us/oss/hidapi

Of course, what's up there right now only supports Windows, and was 
originally intended to get around the fact that the HID headers and 
import lib aren't part of the Platform SDK, but part of the Driver Kit 
(It's all explained on the web page). I have a working backend for 
hidraw, which I need to get cleaned up and committed. Of course, the 
Hidraw backend depends on some of the queued changes which won't get in 
the mainline kernel until 2.6.36.

I have a Mac here and intend to make it work on OS X as well.

I did not realize that libusb-1.0 would talk to the native Windows HID 
backend. I don't see anything like that in the git version of libusb-1.0 
or libusb-win32. Is this on another branch or something, or did I miss it?

Alan.


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
