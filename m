From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/1 FROM FIXED] Revert "HID: fix unit exponent parsing"
Date: Wed, 9 Oct 2013 11:02:37 +0200
Message-ID: <CAN+gG=FiMk-EhQi2BE49MXLY71DMJW7cjzGt8wijrAJG_snyHQ@mail.gmail.com>
References: <1381258791-24966-1-git-send-email-spbnick@gmail.com>
	<1381259117-25256-1-git-send-email-spbnick@gmail.com>
	<525507AC.5050807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:38055 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853Ab3JIJCj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 05:02:39 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so406658lab.7
        for <linux-input@vger.kernel.org>; Wed, 09 Oct 2013 02:02:37 -0700 (PDT)
In-Reply-To: <525507AC.5050807@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Hi Nikolai,

first, I wouldn't revert the patch as this, because I think the patch
also fixes the nibbles parsing in unit:
- the part regarding the unit exponent seems blurry
- the part regarding the unit exponent seems correct to me.

On Wed, Oct 9, 2013 at 9:37 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> On 10/08/2013 10:05 PM, Nikolai Kondrashov wrote:
>>
>> Revert "HID: fix unit exponent parsing" as it is based on incorrect
>> understanding of the HID specification and breaks resolution
>> calculation at least on graphics tablets.

I have re-read the HID spec, and indeed, it is not clear at all.
However, as you mentioned later in this mail, I based this assumption
by looking at the report descriptors I have in hand for hid-multitouch
(which is still quite a lot), and it looked correct this way.

>>
>> There are two "unit exponents" in HID specification and it is important
>> not to mix them. One is the global "Unit Exponent" item and another is
>> nibble values in the global "Unit" item. See 6.2.2.7 Global Items.
>>
>> The "Unit Exponent" value is just a signed integer and is used to scale
>> the integer resolution unit values, so fractions can be expressed.
>
>
> I see now that the official "HID Descriptor Tool" writes the "Unit Exponent"
> as a two's complement nibble and Microsoft cites binary representations as
> such (although they seem to be made with that tool).
>
> This likely means most report descriptors in the wild store it as such.
> Which
> probably means that it is more practical to expect them to be so, but I
> don't
> have any statistically-significant data.
>
> However, I still think that this interpretation of the standard is incorrect
> (the standard is vague in this part). First, the specification says about
> "Unit Exponent":
>
>     Value of the unit exponent in base 10. See the
>     table later in this section for more information.
>
> I.e. nothing about nibbles. It refers to a table, but doesn't say which one.
> However, the first table appearing later is a mouse example mentioning an
> exponent.

>From what I read, the unit exponent has nothing to do with nibbles.
Only "Unit" has them.
However, my experience says that the unit exponent is often used as a
two's complement :(

>
> The specification also mentions the one-byte prefix for the item to be
> "0101 01 nn", where "nn" is the size value, which would be pointless to have
> anything different from 1 byte, if it was limited to a nibble.

It could be, as it allows the firmware maker to avoid to add padding
bits... Which seems a convenient way to do it.

>
> And lastly and most importantly there is no point in limiting the "Unit
> Exponent" to a nibble where you have a full 32-bit signed integer available,
> thus complicating encoding/decoding and limiting the possible reported unit
> scale.

sure.

>
> From what data I have on various non-Wacom graphics tablets, most of the
> older
> ones provide incorrect "unit" item value, so "unit exponent" doesn't apply.

Yes. The "correct" specification of unit and unit exponent has only be
a requirements since Windows 8 [1]. (Note, there used to be a pdf [2],
which I found more convenient to read, but still...).

So definitely, Microsoft considers that the unit exponent is a 4 bits
two's complement, otherwise, the firmware will not get a Windows 8
certification.

> However, some recent ones, such as made by Huion, do have correct units,
> and nibble-stored "unit exponent". And I was wondering where that strange
> data
> came from. Sigh...

See above... Microsoft certification.

>
> I'll try to reach usb.org for comments on this.
>
> Meanwhile, can I suggest a hybrid approach? As positive unit exponent beyond
> 7
> is unlikely to appear for axes which have their resolution calculated
> currently, can we assume anything higher than 7 to be nibble-stored negative
> exponents and anything else normal signed integers?

I would say that the current approach (without the revert) is exactly this:
- if the data is stored on only 1 byte ( if (!(raw_value &
0xfffffff0))), do the two's complement -> any value less than 7 will
be the same, above are considered as negative.
- if not, then use the raw value.

Could you please share some of the report descriptors which you found
problematic, so that I can have a better understanding of the problem?
If you want to have a look at some multitouch descriptors (and few
other devices), I started to build a database of hid devices[3].

Cheers,
Benjamin

[1] http://msdn.microsoft.com/en-us/library/windows/hardware/dn383621.aspx
[2] http://feishare.com/attachments/article/299/windows-pointer-device-protocol.pdf
[3] https://github.com/bentiss/hid-devices

PS: I'll be mostly offline until the 1st of November when I'll finish
my transfer to the RH Westford Office.
PPS: my nick on the RH internal IRC is bentiss :)
