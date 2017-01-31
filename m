From: "Robert R. Howell" <rhowell@uwyo.edu>
Subject: Re: PROBLEM: Baytrail tablet touchscreen fails after pinctrl commit
 [3ae02c14d964499da76b5ef4d8912710902e64f8]
Date: Tue, 31 Jan 2017 10:11:16 -0700
Message-ID: <d9ae0add-cf5b-2008-0fc9-ee14c478ecec@uwyo.edu>
References: <6306d18a-d5d3-3e89-5f41-2a45d3de1398@uwyo.edu>
 <1483812841.26691.7.camel@linux.intel.com>
 <CAKdAkRRHJ+FVKV3o38gpZQ5R2Q6uuV+TPnuwHLvGJ7QehNHWuQ@mail.gmail.com>
 <20170131102113.GR17297@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170131102113.GR17297@lahna.fi.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-input@vger.kernel.org

On 01/31/2017 03:21 AM, Mika Westerberg wrote:
> On Mon, Jan 30, 2017 at 04:52:27PM -0800, Dmitry Torokhov wrote:
>> On Sat, Jan 7, 2017 at 10:14 AM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>>> On Fri, 2017-01-06 at 02:30 -0700, Robert R. Howell wrote:
>>>> [1.]  Baytrail tablet touchscreen fails after pinctrl commit
>>>> [3ae02c14d964499da76b5ef4d8912710902e64f8]
>>>>
>>>> [2.]  Beginning with kernel 4.10-rc1 (and continuing with 4.10-rc2)
>>>> the
>>>> touchscreen on two Baytrail devices, an ASUS T100TA and a Toshiba
>>>> Encore
>>>> 8, no longer works.  They did work properly up though at least 4.9.0.
>>>> As
>>>> indicated in the DMESG output appended below, the ATML1000
>>>> touchscreen
>>>> controller fails to reset and initialize properly on boot. The reset
>>>> command issued through i2c_hid appears to time out after its 5 second
>>>> wait for completion.  (There are similar problems with an i2c
>>>> orientation sensor.)  Using git bisect I've found that the problem
>>>> begins with commit [3ae02c14d964499da76b5ef4d8912710902e64f8]
>>>> pinctrl: intel: set default handler to be handle_bad_irq()
>>>>
>>>> I've appended the git bisect log output at the end.  Reverting that
>>>> single commit (tested with 4.10-rc2) fixes the problem.
>>>
>>> Thanks for the report. For me it looks like that commit actually
>>> discovers other problems we have in the code somewhere.
>>>
>>> Yeah, I confirm the issue on T100TA. I will investigate this next week.
>>
>> This still happens on chromeOS Baytrail devices with -rc6 here as
>> well. Can we revert this and try again in 4.11 timeframe?
>
> Are you sure you have commit 49c030962638 ("pinctrl: baytrail: Do not
> add all GPIOs to IRQ domain")? That is supposed to fix the issue if I
> understand correctly.
>

I've just tested 4.10-rc6 on an ASUS T100-TAM, a T100-TA, and a Toshiba 
Encore 8 and the i2c connected touchscreen is working on all of them. 
RC-6 DOES incorporate Andy Shevchenko's "[PATCH v1 1/2] pinctrl: 
baytrail: Do not add all GPIOs to IRQ domain", which is what seems to 
fix the problem.

In tests a couple weeks ago on 4.10-rc4, before that patch was added to 
the mainline kernel, I did manually apply that patch (plus also his 
"[PATCH v1 2/2] pinctrl: baytrail: Convert to use devm_*()" to rc4 and 
that also produced a kernel where the touchscreen worked.  It looks like 
that second patch isn't incorporated in rc6, but apparently isn't 
critical to fixing the touchscreen issue.

Bob Howell
