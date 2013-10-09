From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1 FROM FIXED] Revert "HID: fix unit exponent parsing"
Date: Wed, 09 Oct 2013 10:37:16 +0300
Message-ID: <525507AC.5050807@gmail.com>
References: <1381258791-24966-1-git-send-email-spbnick@gmail.com> <1381259117-25256-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:46660 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab3JIHhU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 03:37:20 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so418450wgh.4
        for <linux-input@vger.kernel.org>; Wed, 09 Oct 2013 00:37:19 -0700 (PDT)
In-Reply-To: <1381259117-25256-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>

On 10/08/2013 10:05 PM, Nikolai Kondrashov wrote:
> Revert "HID: fix unit exponent parsing" as it is based on incorrect
> understanding of the HID specification and breaks resolution
> calculation at least on graphics tablets.
>
> There are two "unit exponents" in HID specification and it is important
> not to mix them. One is the global "Unit Exponent" item and another is
> nibble values in the global "Unit" item. See 6.2.2.7 Global Items.
>
> The "Unit Exponent" value is just a signed integer and is used to scale
> the integer resolution unit values, so fractions can be expressed.

I see now that the official "HID Descriptor Tool" writes the "Unit Exponent"
as a two's complement nibble and Microsoft cites binary representations as
such (although they seem to be made with that tool).

This likely means most report descriptors in the wild store it as such. Which
probably means that it is more practical to expect them to be so, but I don't
have any statistically-significant data.

However, I still think that this interpretation of the standard is incorrect
(the standard is vague in this part). First, the specification says about
"Unit Exponent":

     Value of the unit exponent in base 10. See the
     table later in this section for more information.

I.e. nothing about nibbles. It refers to a table, but doesn't say which one.
However, the first table appearing later is a mouse example mentioning an
exponent.

The specification also mentions the one-byte prefix for the item to be
"0101 01 nn", where "nn" is the size value, which would be pointless to have
anything different from 1 byte, if it was limited to a nibble.

And lastly and most importantly there is no point in limiting the "Unit
Exponent" to a nibble where you have a full 32-bit signed integer available,
thus complicating encoding/decoding and limiting the possible reported unit
scale.

 From what data I have on various non-Wacom graphics tablets, most of the older
ones provide incorrect "unit" item value, so "unit exponent" doesn't apply.
However, some recent ones, such as made by Huion, do have correct units,
and nibble-stored "unit exponent". And I was wondering where that strange data
came from. Sigh...

I'll try to reach usb.org for comments on this.

Meanwhile, can I suggest a hybrid approach? As positive unit exponent beyond 7
is unlikely to appear for axes which have their resolution calculated
currently, can we assume anything higher than 7 to be nibble-stored negative
exponents and anything else normal signed integers?

Sincerely,
Nick
