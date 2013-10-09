From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1 FROM FIXED] Revert "HID: fix unit exponent parsing"
Date: Wed, 09 Oct 2013 22:04:54 +0300
Message-ID: <5255A8D6.1000707@gmail.com>
References: <1381258791-24966-1-git-send-email-spbnick@gmail.com> <1381259117-25256-1-git-send-email-spbnick@gmail.com> <525507AC.5050807@gmail.com> <CAN+gG=FiMk-EhQi2BE49MXLY71DMJW7cjzGt8wijrAJG_snyHQ@mail.gmail.com> <5255A391.6040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45989 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab3JITE6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 15:04:58 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so1329897wgh.29
        for <linux-input@vger.kernel.org>; Wed, 09 Oct 2013 12:04:57 -0700 (PDT)
In-Reply-To: <5255A391.6040501@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

On 10/09/2013 09:42 PM, Nikolai Kondrashov wrote:
>> I would say that the current approach (without the revert) is exactly this:
>> - if the data is stored on only 1 byte ( if (!(raw_value&
>> 0xfffffff0))), do the two's complement -> any value less than 7 will
>> be the same, above are considered as negative.
>> - if not, then use the raw value.
>
> It is not exactly what I suggested. It also considers anything above 15 to be
> a normal integer. However, it might be a cleaner way.
>
> All-in-all, I'd say that the relevant hid-core.c code should have its comment
> fixed, and the hid-input.c (hidinput_calc_abs_res) change needs to be reverted
> as it (incorrectly) takes the component unit power into account for resolution
> calculation and makes the "unit" item value handling harder to comprehend.

On a second glance at the test data, hid-core.c needs to be fixed as well, as
for the non-nibble case it loses the sign by reading the item value as
unsigned. So a perfectly valid 1 byte 0xFD value becomes 253, instead of -3.

I'll include that into the patch.

Sincerely,
Nick
