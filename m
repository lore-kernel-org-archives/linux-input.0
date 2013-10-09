From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/1 FROM FIXED] Revert "HID: fix unit exponent parsing"
Date: Thu, 10 Oct 2013 00:13:39 +0300
Message-ID: <5255C703.6080804@gmail.com>
References: <1381258791-24966-1-git-send-email-spbnick@gmail.com> <1381259117-25256-1-git-send-email-spbnick@gmail.com> <525507AC.5050807@gmail.com> <CAN+gG=FiMk-EhQi2BE49MXLY71DMJW7cjzGt8wijrAJG_snyHQ@mail.gmail.com> <5255A391.6040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:54537 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3JIVNn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 17:13:43 -0400
Received: by mail-we0-f174.google.com with SMTP id u56so1536638wes.33
        for <linux-input@vger.kernel.org>; Wed, 09 Oct 2013 14:13:41 -0700 (PDT)
In-Reply-To: <5255A391.6040501@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

On 10/09/2013 09:42 PM, Nikolai Kondrashov wrote:
>> So definitely, Microsoft considers that the unit exponent is a 4 bits
>> two's complement, otherwise, the firmware will not get a Windows 8
>> certification.
>
> I think this is due to their use of the "HID Descriptor Tool". Maybe
> assuming it is a reference implementation, which it is not, but more likely
> just not noticing the discrepancy.
>
> I'll try to reach Microsoft on this and maybe make them correct their
> specification.

I've started my attempts with a post on Microsoft's official hardware
development forums:

http://social.msdn.microsoft.com/Forums/windowshardware/en-US/e87d0db1-486e-42ae-bf95-d1ac5ffc0b02/unit-exponent-item-value-encoding-in-hid-report-descriptors?forum=whck

Let's see how it goes.

Sincerely,
Nick
