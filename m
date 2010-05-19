From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: Subject: [PATCH] AD7879: Fix spi word size
Date: Wed, 19 May 2010 16:46:22 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712E568FC795@LIMKCMBX1.ad.analog.com>
References: <1274263274.6138.6.camel@mhenneri-D02.ad.analog.com>
 <0D753D10438DA54287A00B0270842697636F1BD0E9@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:33050 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0ESPqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 11:46:39 -0400
In-Reply-To: <0D753D10438DA54287A00B0270842697636F1BD0E9@AUSP01VMBX24.collaborationhost.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: H Hartley Sweeten <hartleys@visionengravers.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>, "Frysinger, Michael" <Michael.Frysinger@analog.com>

H Hartley Sweeten wrote on 2010-05-19:
> On Wednesday, May 19, 2010 3:01 AM, Michael Hennerich wrote:
>> Similar patch as reported by Oskar Schirmer <os@emlix.com> for the
>> AD7877.
>>
>> With no word size given in the users platform data, a generic spi host
>> controller driver will assume a default word size of eight bit. Ensure
>> spi->bits_per_word is set for 16-bit transfers.
>>
>> Signed-off-by: Michael Hennerich <Michael.hennerich@analog.com>
>> ---
>>  drivers/input/touchscreen/ad7879.c |   10 ++++++++++
>>  1 files changed, 10 insertions(+), 0 deletions(-)
>> diff --git a/drivers/input/touchscreen/ad7879.c
>> b/drivers/input/touchscreen/ad7879.c
>> index 794d070..ff490c0 100644
>> --- a/drivers/input/touchscreen/ad7879.c
>> +++ b/drivers/input/touchscreen/ad7879.c
>> @@ -715,6 +715,16 @@ static int __devinit ad7879_probe(struct
>> spi_device
>> *spi)
>>              return -EINVAL;
>>      }
>> +    if (spi->bits_per_word != 16) {
>
> The master never sets this field so this test isn't needed.  The
> platform specific spi_board_info "could" set the field but I don't
> think any currently do.

Blackfin does!
Originally my assumption was that everyone does it - that's why this
haven't been fixed earlier.

>
> If the bits_per_word field is not set when spi_setup is called, it is
> set to the default value (8) before calling the spi master drivers
> setup routine.
> You just need to set the value since that is what the protocol
> requires.  The spi_setup call is still needed since part of the probe
> for this driver does generate a spi transaction, you need to make sure
> the master driver will support the protocol before that happens.
>
>> +            spi->bits_per_word = 16;
>> +            error = spi_setup(spi);
>> +            if (error) {
>> +                    dev_dbg(&spi->dev,
>> +                            "spi master doesn't support 16 bits/word\n");
>> +                    return error;
>> +            }
>> +    }
>> +
>>      ts = kzalloc(sizeof(struct ad7879), GFP_KERNEL);
>>      if (!ts)
>>              return -ENOMEM;
>
> Regards,
> Hartley

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif


