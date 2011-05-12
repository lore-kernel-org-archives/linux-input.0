From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH 1/5] input: misc: AD714x: The interrupt status registers
 should be read in row.
Date: Thu, 12 May 2011 09:39:37 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF1B7DBE@LIMKCMBX1.ad.analog.com>
References: <1305027309-17637-1-git-send-email-michael.hennerich@analog.com>
 <20110511211541.GB11178@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:28055 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310Ab1ELIjr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2011 04:39:47 -0400
In-Reply-To: <20110511211541.GB11178@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>, Drivers <Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>

Dmitry Torokhov wrote on 2011-05-11:
> Hi Michael,
>
> On Tue, May 10, 2011 at 01:35:05PM +0200, michael.hennerich@analog.com
> wrote:
>>
>> +static int ad714x_i2c_read_seq(struct device *dev, unsigned short reg,
>> +                            unsigned short *data, unsigned len) { + struct i2c_client *client
>> = to_i2c_client(dev); +      int ret = 0, i; +       u8 *_reg = (u8 *)&reg; + +      u8
>> tx[2] = { +          _reg[1], +              _reg[0] +       };
>
> Eww... I think this will also break on arches with different endianness.
> Can we pass the commands to be sent to the device as u8 array?
>

Hi Dmitry,

Right - this is not endianness save, like the rest of the driver.
I'll add a patch to the end of the sequence, which fixes both bus options.

For SPI - also need to force the bus to spi->bits_per_word = 8 (which is the default),
however some Blackfin boards set bits_per_word = 16, so we don't break them...

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


