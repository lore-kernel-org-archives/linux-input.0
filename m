From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH] input/keyboard: new driver for
	ADP5520 MFD PMICs
Date: Sun, 20 Sep 2009 18:40:41 -0400
Message-ID: <8bd0f97a0909201540t25dd2337o15ebe63a2a9ca4ec@mail.gmail.com>
References: <1253211850-29309-1-git-send-email-vapier@gentoo.org>
	<20090919233044.8361a912.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:60642 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZITWk5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Sep 2009 18:40:57 -0400
In-Reply-To: <20090919233044.8361a912.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Sun, Sep 20, 2009 at 02:30, Andrew Morton wrote:
> On Thu, 17 Sep 2009 14:24:10 -0400 Mike Frysinger wrote:
>> +struct adp5520_keys {
>> + =C2=A0 =C2=A0 struct input_dev *input;
>> + =C2=A0 =C2=A0 struct notifier_block notifier;
>> + =C2=A0 =C2=A0 struct device *master;
>> + =C2=A0 =C2=A0 unsigned short keycode[ADP5520_KEYMAPSIZE];
>
> Where is ADP5520_KEYMAPSIZE defined?

all these things are in the common mfd adp5520 patch.  it introduces a
common adp5520 header.

>> + =C2=A0 =C2=A0 for (i =3D 0; i < ADP5520_MAXKEYS; i++)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (keymask & (1 << i))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 input_report_key(dev->input, dev->keycode[i], value);
>
> It seems odd that keycode is dimensioned with ADP5520_KEYMAPSIZE but
> here we iterate up to ADP5520_MAXKEYS.

ARRAY_SIZE() probably makes more sense
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
