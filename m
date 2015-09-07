From: Mike Mestnik <cheako@mikemestnik.net>
Subject: Re: USB HID devices not linked to RNG
Date: Mon, 7 Sep 2015 15:07:47 -0500
Message-ID: <CAF8px55WFMO54uJT2kME4OauXAUCfsv2K2W1EA0ufuaVjFtXfg@mail.gmail.com>
References: <1735492.1FWVU9y0M8@myon.chronox.de>
	<1461912.H1d3XDk5sm@myon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-crypto-owner@vger.kernel.org>
In-Reply-To: <1461912.H1d3XDk5sm@myon.chronox.de>
Sender: linux-crypto-owner@vger.kernel.org
To: Stephan Mueller <smueller@chronox.de>
Cc: linux-crypto@vger.kernel.org, linux-input@vger.kernel.org, tytso@mit.edu
List-Id: linux-input@vger.kernel.org

This is just an off the wall guess.  Wouldn't such entropy already be
collected at a lower level, like raw usb traffic?

On Sun, Sep 6, 2015 at 7:12 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Montag, 7. September 2015, 02:10:16 schrieb Stephan Mueller:
>
> Hi Stephan,
>
>> Hi,
>>
>> While analyzing the entropy sources for the random number generator in
>> drivers/char/random.c, I saw that a USB mouse and a USB keyboard does
>> trigger the add_input_randomness function to be triggered.
>
> I need to reread what I write :-)
>
> I mean that the USB mouse and USB keyboard does *not* trigger the
> add_input_randomness function.
>
>>
>> Is that intended?
>
>
> --
> Ciao
> Stephan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
