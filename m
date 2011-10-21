From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] input:ad7879-i2c use swapped varient of
 i2c_smbus_read_word_data
Date: Fri, 21 Oct 2011 11:40:31 +0100
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E75C18D9@LIMKCMBX1.ad.analog.com>
References: <1319191407-23362-1-git-send-email-jic23@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:35527
	"EHLO AM1EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754020Ab1JUKkS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Oct 2011 06:40:18 -0400
In-Reply-To: <1319191407-23362-1-git-send-email-jic23@cam.ac.uk>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>

Jonathan Cameron wrote on 2011-10-21:
> This varient was introduced in
> i2c: boilerplate function for byte swapped smbus_write/read_word_data
>
> This also has the side effect of ensuring any errors from the i2c
> read and no longer mangled.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>
> ---
> The patch introducing this swapped function is working its way through
> the i2c
> tree.
>
>  drivers/input/touchscreen/ad7879-i2c.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> diff --git a/drivers/input/touchscreen/ad7879-i2c.c
> b/drivers/input/touchscreen/ad7879-i2c.c index 4e4e58c..1c1683e 100644
> --- a/drivers/input/touchscreen/ad7879-i2c.c +++
> b/drivers/input/touchscreen/ad7879-i2c.c @@ -47,7 +47,7 @@ static int
> ad7879_i2c_read(struct device *dev, u8 reg)
>  {
>       struct i2c_client *client = to_i2c_client(dev);
> -     return swab16(i2c_smbus_read_word_data(client, reg));
> +     return i2c_smbus_read_word_swapped(client, reg);
>  }
>
>  static int ad7879_i2c_multi_read(struct device *dev,

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



