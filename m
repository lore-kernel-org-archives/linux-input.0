From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH] input: Add wiichuck driver
Date: Sat, 14 May 2011 21:20:04 +0200
Message-ID: <BANLkTi=4oCehWLXrKbd6bj2CuoxDXdBHAg@mail.gmail.com>
References: <20110512042218.12859.66600.stgit@localhost6.localdomain6> <201105142117.50529.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35309 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab1ENTUY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 15:20:24 -0400
In-Reply-To: <201105142117.50529.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, May 14, 2011 at 9:17 PM, Oliver Neukum <oliver@neukum.org> wrot=
e:
> Am Donnerstag, 12. Mai 2011, 06:29:44 schrieb Grant Likely:
>> +static void wiichuck_poll(struct input_polled_dev *poll_dev)
>> +{
>> + =A0 =A0 =A0 struct wiichuck_device *wiichuck =3D poll_dev->private=
;
>> + =A0 =A0 =A0 struct i2c_client *i2c =3D wiichuck->i2c_client;
>> + =A0 =A0 =A0 static uint8_t cmd_byte =3D 0;
>> + =A0 =A0 =A0 struct i2c_msg cmd_msg =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { .addr =3D i2c->addr, .len =3D 1, .bu=
f =3D &cmd_byte };
>> + =A0 =A0 =A0 uint8_t b[6];
>> + =A0 =A0 =A0 struct i2c_msg data_msg =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { .addr =3D i2c->addr, .flags =3D I2C_=
M_RD, .len =3D 6, .buf =3D b };
>
>
> Do you need these buffers to be capable of DMA?

Good point.  Yes, these buffers should be DMA capable.  I'll pull them
off the stack.

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
