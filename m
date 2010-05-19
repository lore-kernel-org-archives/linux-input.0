From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: Subject: [PATCH] AD7879: Fix spi word size
Date: Wed, 19 May 2010 11:00:27 -0500
Message-ID: <0D753D10438DA54287A00B0270842697636F1BD17B@AUSP01VMBX24.collaborationhost.net>
References: <1274263274.6138.6.camel@mhenneri-D02.ad.analog.com>
 <0D753D10438DA54287A00B0270842697636F1BD0E9@AUSP01VMBX24.collaborationhost.net>
 <544AC56F16B56944AEC3BD4E3D5917712E568FC795@LIMKCMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from p01c12o149.mxlogic.net ([208.65.145.72]:49549 "EHLO
	p01c12o149.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab0ESQHm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 12:07:42 -0400
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E568FC795@LIMKCMBX1.ad.analog.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>, "Frysinger, Michael" <Michael.Frysinger@analog.com>

On Wednesday, May 19, 2010 8:46 AM, Hennerich, Michael wrote:
> H Hartley Sweeten wrote on 2010-05-19:
>> On Wednesday, May 19, 2010 3:01 AM, Michael Hennerich wrote:
>>> Similar patch as reported by Oskar Schirmer <os@emlix.com> for the
>>> AD7877.
>>>
>>> With no word size given in the users platform data, a generic spi host
>>> controller driver will assume a default word size of eight bit. Ensure
>>> spi->bits_per_word is set for 16-bit transfers.
>>>
>>> Signed-off-by: Michael Hennerich <Michael.hennerich@analog.com>
>>> ---
>>>  drivers/input/touchscreen/ad7879.c |   10 ++++++++++
>>>  1 files changed, 10 insertions(+), 0 deletions(-)
>>> diff --git a/drivers/input/touchscreen/ad7879.c
>>> b/drivers/input/touchscreen/ad7879.c
>>> index 794d070..ff490c0 100644
>>> --- a/drivers/input/touchscreen/ad7879.c
>>> +++ b/drivers/input/touchscreen/ad7879.c
>>> @@ -715,6 +715,16 @@ static int __devinit ad7879_probe(struct
>>> spi_device
>>> *spi)
>>>              return -EINVAL;
>>>      }
>>> +    if (spi->bits_per_word != 16) {
>>
>> The master never sets this field so this test isn't needed.  The
>> platform specific spi_board_info "could" set the field but I don't
>> think any currently do.
>
> Blackfin does!
> Originally my assumption was that everyone does it - that's why this
> haven't been fixed earlier.

Hmm... It appears they do ;-)

But, it's passed as controller_data that would be specific to the Blackfin
spi master driver.

Regards,
Hartley