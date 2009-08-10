From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: HTC Dream for staging: add support for input on GPIO pins
Date: Mon, 10 Aug 2009 13:01:28 +0530
Message-ID: <5d5443650908100031t5240daa4h76ef2a7863cc4403@mail.gmail.com>
References: <20090808130315.GA12930@elf.ucw.cz>
	 <5d5443650908080942l50d91d31qb23c494affdf6850@mail.gmail.com>
	 <20090808214454.GB24153@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:28629 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbZHJHb2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Aug 2009 03:31:28 -0400
In-Reply-To: <20090808214454.GB24153@elf.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, kernel list <linux-kernel@vger.kernel.org>, swetland@google.com, linux-input@vger.kernel.org

Hi Pavel,

On Sun, Aug 9, 2009 at 3:14 AM, Pavel Machek<pavel@ucw.cz> wrote:
> On Sat 2009-08-08 22:12:46, Trilok Soni wrote:
>> Hi Pavel,
>>
>> On Sat, Aug 8, 2009 at 6:33 PM, Pavel Machek<pavel@ucw.cz> wrote:
>> > From: Arve Hj?nnev?g <arve@android.com>
>> >
>> > Support for input devices connected to GPIO pins. This adds support
>> > for HTC Dream's keyboard and its trackball. Generic support already
>> > exists for keyboard on GPIO, but this one is more advanced because it
>> > can detect shadow key presses (and actually works with Dream :-).
>> >
>> > (It also contains Kconfig/Makefile changes, including some that were
>> > missing from previous commit. Sorry.)
>>
>> I don't see any importance of gpio_matrix.c when we already have
>> generic gpio matrix driver mainlined. I would suggest to remove those
>> bits from this patch. I have added linux-input ML.
>
> Well, I'm trying for staging merge at this point. Reasons why
> gpio_matrix is there are:
>
> 1) it is non-trivial to remove
>
> 2) it has some features mainline lacks
>
> 3) HTC Dream actually works with it
>
> (and 4) I'd like to submit code as Arve wrote it, then transform/clean
> it up in staging).
>
> Of course, relevant features will need to be extracted from
> gpio_matrix and merged at the right places, and that needs to happen
> before move from staging/, but I'd like to have working keyboard in
> the meantime.

gpio_matrix in mainline should work with HTC G1 with few proper
platform data and input name eventhough ghost key clearance code is
not yet in mainline driver.

I know you want HTC dream to work through staging but I would prefer
that such drivers should be discussed and reviewed on
linux-input/linux-kernel ML and not just dumped in staging.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
