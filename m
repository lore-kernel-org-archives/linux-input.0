From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCHv2 4/7] input/cma3000_d0x: Add CMA3000 spi support
Date: Tue, 18 Oct 2011 17:50:13 +0200
Message-ID: <CAPybu_1v+=GYWvVP4ua7XWjSor-WQ_TW7PdBJJ7dnbCJpH3Q3Q@mail.gmail.com>
References: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com>
 <1318939596-27330-5-git-send-email-ricardo.ribalda@gmail.com>
 <4E9D7BD2.8090101@cam.ac.uk> <CAPybu_0kxqfo9Lx9V_oOXfBjOG2dnR0NLCV6=PM6cnUYmVb_iQ@mail.gmail.com>
 <4E9D843A.5020001@cam.ac.uk> <CAPybu_1epNidGGrn7FKVCF78wvUBvNPScaMCz2L1Pb4DJ82DEg@mail.gmail.com>
 <4E9D9AC8.9090302@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59424 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611Ab1JRPuy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 11:50:54 -0400
In-Reply-To: <4E9D9AC8.9090302@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, hemanthv@ti.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Jonathan

 I just send the mail with the latest patch version. I will wait for
hermanthv to see if he wants to replace the msg from the read/write
functions, and I will follow his style for the cmr3000. I have testest
the latest changes on my board and it looks ok.

  Thanks for your feedback, and I hope it is ok now :)

On Tue, Oct 18, 2011 at 17:27, Jonathan Cameron <jic23@cam.ac.uk> wrote=
:
> On 10/18/11 16:18, Ricardo Ribalda Delgado wrote:
>> Hello Jonathan
>>
>> =A0I have separated the read and write commands... but when I was
>> implementing the spi_write I found that most of the drivers just use
>> stack variables for spi_write. Like drivers/hwmon/ads7871.c,
>> drivers/gpio/max7301.c and others... Am I missing something or it is=
 a
>> general "bug"?
> bug unless I am also missing where they prevent dma
> transfers. =A0spi_read_then_write is fine
> as it does a copy, but spi_write doesn't.
> Documentation/spi/spi-summary
>
> "Note that there are two types of memory your driver must manage as p=
art
> of interacting with SPI devices.
>
> =A0- I/O buffers use the usual Linux rules, and must be DMA-safe.
> =A0 =A0You'd normally allocate them from the heap or free page pool.
> =A0 =A0Don't use the stack, or anything that's declared "static".
> "
>
> This was an issue many people (including me) weren't aware of until
> a year or two ago when it was picked up in reviews of a number of dri=
vers.
> It was around that time the ___cacheline_aligned trick was used by
> Michael Hennerich and everyone else picked up on that as often the
> easiest way of doing this in a driver.
>
> Don't suppose there is anything stopping you doing
> spi_write_then_read(tx, 2, NULL, 0)
> and using the buffers helpfully allocated in the spi core?
> This'll allocate extra space if someone else is using the core
> bounce buffers though...
>
>>
>> As you say, it is better to not rewrite the cma3000 driver until
>> Hemanth says so, lets leave it for a future patch.
>>
>>
>>
>>
>> On Tue, Oct 18, 2011 at 15:50, Jonathan Cameron <jic23@cam.ac.uk> wr=
ote:
>>> On 10/18/11 14:43, Ricardo Ribalda Delgado wrote:
>>>> Hello Jonathan
>>>>
>>>> =A0 First of all, thanks for your messages :).
>>>>
>>>>> To make my point about these functions being more complex than ne=
eded
>>>>> in more detail....
>>>>>
>>>>> If this were two functions and you drop the zero and 1 mask
>>>>> (which I'm not convinced make any sense. I've also killed the mes=
sage.
>>>>> We both agree it is the wrong way to go, so post a patch fixing t=
he i2c
>>>>> interface as well.
>>>>
>>>> Of course your functions are much more simpler and beautiful than =
the
>>>> fat one I wrote, no doubt about it :). Just three comments
>>>>
>>>> - Checking the one mask and the zero mask is the only way we have =
to
>>>> know if the chip is still there, The absense of that reply should
>>>> trigger an IO error or at least a retry. As you point out, the
>>>> zero/one mask is only violated on startup. =A0I just wanted to mak=
e it
>>>> more risk free, but if you believe it is more clear that way, lets
>>>> remove it
>>> It's somewhat unconventional to verify the existence of a chip like=
 this.
>>> Usually you assume that if it was there once it still is unless the=
re
>>> is a very good reason to think otherwise. =A0Worth doing an initial=
 check
>>> in your spi_probe and indeed verify there against these known bits.
>>> No need to do it every time though.
>>>>
>>>> - I am not very fun of kmallocing data per write, specially when i=
t is
>>>> part of the irq handler, and you expect this to be low latency. Wh=
at
>>>> about allocating a buffer on init time, and use it with a mutex?
>>> That's absolutely fine and the right way to do it. You could poke i=
t
>>> into the cma3000_accl_data then use the cachline aligned magic. Its
>>> is tiny so I doubt anyone will mind the overhead for the i2c side o=
f
>>> things.
>>>>
>>>> -I dont like the push error message to the bottom, but that will m=
ean
>>>> a rewrite of the cma3000 driver, shall I go for it?
>>> I would. Though probably worth getting Hemanth to say if he minds f=
irst
>>> given it's his driver!
>>>>
>>>>
>>>> Thanks again, and =A0I will post the new version when you reply th=
is :)
>>>>
>>>>
>>>
>>>
>>
>>
>>
>
>



--=20
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
