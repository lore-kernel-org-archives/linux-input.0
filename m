From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v4] HID: Add full support for Logitech Unifying receivers
Date: Sun, 11 Sep 2011 10:39:04 +0200
Message-ID: <CAN+gG=H2jfT2zdn5H19hyn9JtDU7U1ensX_aUDgv0jk4d81jXg@mail.gmail.com>
References: <1315638713-3731-1-git-send-email-benjamin.tissoires@gmail.com>
	<20110910072826.GA1611@x4.trippels.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110910072826.GA1611@x4.trippels.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, rtitmuss@logitech.com, ogay@logitech.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>
List-Id: linux-input@vger.kernel.org

Hi Markus,

On Sat, Sep 10, 2011 at 09:28, Markus Trippelsdorf
<markus@trippelsdorf.de> wrote:
> On 2011.09.10 at 09:11 +0200, Benjamin Tissoires wrote:
>> From: Nestor Lopez Casado <nlopezcasad@logitech.com>
>>
>> From: Nestor Lopez Casado <nlopezcasad@logitech.com>
>>
>> With this driver, all the devices paired to a single Unifying
>> receiver are exposed to user processes in separated /input/dev
>> nodes.
>>
>> Keyboards with different layouts can be treated differently,
>> Multiplayer games on single PC (like home theater PC) can
>> differentiate input coming from different kbds paired to the
>> same receiver.
>
> Nice. Does this mean I will be able to use the thumb-button of my M705
> mouse in the near future?
>
> (Someone asked the same question 1.5 years ago, but nothing happened
> till then:
> http://thread.gmane.org/gmane.linux.kernel.input/11791 )

This is quite weird. I was going to say that it will work, but with
the M705 I've got at home,this thumb button doesn't work at all
(anything is emitted from the usb, even with this driver).
But I'm pretty sure I made it work with the one I got at work.

I'll give a try on Monday unless people at Logitech gave us the solution.

Cheers,
Benjamin

>
> --
> Markus
>
