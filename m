From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Dell ALPS patches for Dell Latitude 7250 & 7450
Date: Sun, 15 Feb 2015 17:40:48 +0100
Message-ID: <54E0CC10.2000401@redhat.com>
References: <201502101419.53861@pali> <54DB0712.4050306@redhat.com> <201502151738.36559@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201502151738.36559@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>
List-Id: linux-input@vger.kernel.org

Hi,

On 15-02-15 17:38, Pali Roh=C3=A1r wrote:
> On Wednesday 11 February 2015 08:38:58 Hans de Goede wrote:
>> Thanks for this and the other related mail. I also have an
>> alps.c directly from alps themselves which adds support for
>> v8 and v9 protocols. The problem is that like with v7 the
>> code is not really in a state where we want to take it as is,
>> e.g. it does clickpad softbutton emulation in the kernel
>> instead of leaving it to userspace.
>>
>> I spend a considerable amount of time cleaning up the alps
>> code itself and then adding a cleaner version of the v7 code,
>> we should do the same for the v8 and v9 code probably but
>> that requires someone with hardware access so that we can
>> actually test the end result.
>>
>> Regards,
>>
>> Hans
>
> Ok. Hans, can you look at least on second one patch?
> http://www.spinics.net/lists/linux-input/msg36554.html
>
> This is a bit shorter patch and maybe easier to review and decide
> if is needed or not...

I think you no that particular bit of the code better then me know,
given the recent fixes you've been doing there. I think it is best
to not take that patch / hack until we actually have reports from
someone with a machine where such a fix is needed.

Regards,

Hans
