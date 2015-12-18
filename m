From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] HID: Use multitouch driver for Type Covers
Date: Fri, 18 Dec 2015 11:41:30 +0100
Message-ID: <CAN+gG=F6akwwwKRi8s0RiNQf6e+ggEsuZWuR9qOnUfTkmfdT2Q@mail.gmail.com>
References: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
	<1450099368.3358.5.camel@hadess.net>
	<CAOD0F3aeVMBFOhagNsozmuv58qimpKpRiFzx5YjdoG4RATVegA@mail.gmail.com>
	<5673A785.6000306@stu.hosei.ac.jp>
	<5673CE04.90705@stu.hosei.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5673CE04.90705@stu.hosei.ac.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Akihiko Odaki <akihiko.odaki.4i@stu.hosei.ac.jp>
Cc: Donavan Lance <tusklahoma@gmail.com>, Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 18, 2015 at 10:12 AM, Akihiko Odaki
<akihiko.odaki.4i@stu.hosei.ac.jp> wrote:
> The "Charm" keys seem to issue short-cut key combinations.
> I also found Microsoft's document by searching for the combinations.
>
> https://msdn.microsoft.com/en-us/library/windows/hardware/dn614461(v=vs.85).aspx
>
> So the behavior of hid-multitouch is completely fine.

OK, so it looks like there was no need to use hid-microsoft for these covers.

However, I'd rather not add a full batch of the PIDs, but rather a
completed tested environment before migrating these covers from
hid-microsoft to hid-multitouch.

Can you restrict the patch to the covers you actually have and were
able to test?

Cheers,
Benjamin

>
> On 12/18/2015 03:28 PM, Akihiko Odaki wrote:
>>> The search, share, connect(?), and settings keys
>> I tested the patch again with xev and found that those "charm"
>> keys don't respond both on hid-microsoft and hid-multitouch, while
>> other keys respond. I'll have a further look.
>>
>> Anyway, keys working with hid-microsoft also work with
>> hid-multitouch, so It's ready for merging, I think.
>>
>> On 12/15/2015 01:39 AM, Donavan Lance wrote:
>>> On Mon, Dec 14, 2015 at 8:22 AM, Bastien Nocera
>>> <hadess@hadess.net>
>> wrote:
>>>> On Mon, 2015-12-14 at 21:50 +0900, Akihiko Odaki wrote:
>>>>> Use multitouch driver instead of microsoft one for Microsoft
>>>>> Surface Type Covers.
>>>>>
>>>>> By using MT_CLS_EXPORT_ALL_INPUTS, the keyboards function as
>>>>> well as the multitouch pads do.
>>>>
>>>> I've discussed this a couple of weeks back with Benjamin
>>>> Tissoires, and this patch would break the special keys (mute,
>>>> brightness up/down, keyboard backlight up/down and
>>>> play/pause).
>>>>
>>>> The recommended way to fix this was to move multi-touch
>>>> processing into the Microsoft driver, so that it would handle
>>>> the trackpad's multi- touch events.
>>>>
>>>> You should be able to do this by carefully picking up the
>>>> handling code from hid-multitouch, or do something similar to
>>>> what's done in hid- wacom, which has the same problem as the
>>>> Type Cover handling.
>>>>
>>>> Can you confirm that this does indeed break those special
>>>> keys? If it does, it's a NAK from my side.
>>>
>>> For what it's worth the special keys on my keyboard work fine
>>> when using this patch. I'm using a Surface Pro 3, Type Cover 3,
>>> running GNOME and Fedora 23. The search, share, connect(?), and
>>> settings keys are the only ones not mapped to anything out of the
>>> box, but they are recognized by xev.
>>>
