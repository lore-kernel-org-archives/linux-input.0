From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1 FROM FIXED] Revert "HID: fix unit exponent parsing"
Date: Wed, 09 Oct 2013 21:42:25 +0300
Message-ID: <5255A391.6040501@gmail.com>
References: <1381258791-24966-1-git-send-email-spbnick@gmail.com> <1381259117-25256-1-git-send-email-spbnick@gmail.com> <525507AC.5050807@gmail.com> <CAN+gG=FiMk-EhQi2BE49MXLY71DMJW7cjzGt8wijrAJG_snyHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:35472 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab3JISma (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 14:42:30 -0400
Received: by mail-we0-f177.google.com with SMTP id x55so1329187wes.36
        for <linux-input@vger.kernel.org>; Wed, 09 Oct 2013 11:42:29 -0700 (PDT)
In-Reply-To: <CAN+gG=FiMk-EhQi2BE49MXLY71DMJW7cjzGt8wijrAJG_snyHQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Hi Benjamin,

On 10/09/2013 12:02 PM, Benjamin Tissoires wrote:
> first, I wouldn't revert the patch as this, because I think the patch
> also fixes the nibbles parsing in unit:
> - the part regarding the unit exponent seems blurry
> - the part regarding the unit exponent seems correct to me.

This statement is sure confusing :)

> On Wed, Oct 9, 2013 at 9:37 AM, Nikolai Kondrashov<spbnick@gmail.com>  wrote:
>> On 10/08/2013 10:05 PM, Nikolai Kondrashov wrote:
>>  From what data I have on various non-Wacom graphics tablets, most of the
>>  older ones provide incorrect "unit" item value, so "unit exponent" doesn't
>>  apply.
>
> Yes. The "correct" specification of unit and unit exponent has only be
> a requirements since Windows 8 [1]. (Note, there used to be a pdf [2],
> which I found more convenient to read, but still...).

I've stumbled on the very same document yesterday.

> So definitely, Microsoft considers that the unit exponent is a 4 bits
> two's complement, otherwise, the firmware will not get a Windows 8
> certification.

I think this is due to their use of the "HID Descriptor Tool". Maybe
assuming it is a reference implementation, which it is not, but more likely
just not noticing the discrepancy.

I'll try to reach Microsoft on this and maybe make them correct their
specification.

>> Meanwhile, can I suggest a hybrid approach? As positive unit exponent
>> beyond 7 is unlikely to appear for axes which have their resolution
>> calculated currently, can we assume anything higher than 7 to be
>> nibble-stored negative exponents and anything else normal signed integers?
>
> I would say that the current approach (without the revert) is exactly this:
> - if the data is stored on only 1 byte ( if (!(raw_value&
> 0xfffffff0))), do the two's complement ->  any value less than 7 will
> be the same, above are considered as negative.
> - if not, then use the raw value.

It is not exactly what I suggested. It also considers anything above 15 to be
a normal integer. However, it might be a cleaner way.

All-in-all, I'd say that the relevant hid-core.c code should have its comment
fixed, and the hid-input.c (hidinput_calc_abs_res) change needs to be reverted
as it (incorrectly) takes the component unit power into account for resolution
calculation and makes the "unit" item value handling harder to comprehend.

I'll prepare and test a patch and we can carry on from there.

> Could you please share some of the report descriptors which you found
> problematic, so that I can have a better understanding of the problem?
> If you want to have a look at some multitouch descriptors (and few
> other devices), I started to build a database of hid devices[3].

I have my repository of tablet diagnostics published at
https://github.com/DIGImend/devices

The original report descriptors are in */rd/original*.txt files and their XML
representation is in */rd/original*.xml files. Most (if not all) of them have
the "unit exponent" as nibble.

The XML representation was created by my "hidrd-convert" tool [1], which can
also output binary, specification example format and code from either binary
or XML input.

I use it to generate fixed report descriptors for graphics tablets. Maybe you
can find it useful as well. However, it interprets the "unit exponent" per
specification, i.e. just as an integer.

> [1] http://msdn.microsoft.com/en-us/library/windows/hardware/dn383621.aspx
> [2] http://feishare.com/attachments/article/299/windows-pointer-device-protocol.pdf
> [3] https://github.com/bentiss/hid-devices
>
> PS: I'll be mostly offline until the 1st of November when I'll finish
> my transfer to the RH Westford Office.
> PPS: my nick on the RH internal IRC is bentiss :)

My nick there is "nkondrashov". However, I would prefer to keep this
discussion on the mailing list.

Good luck in the US!

Sincerely,
Nick

[1] https://sf.net/apps/mediawiki/digimend?title=Hidrd
