From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [PATCH] input/keyboard: new driver for ADP5520 MFD PMICs
Date: Tue, 22 Sep 2009 08:53:19 +0100
Message-ID: <8A42379416420646B9BFAC9682273B6D0DFAD237@limkexm3.ad.analog.com>
References: <1253211850-29309-1-git-send-email-vapier@gentoo.org> <20090922055954.GB9658@core.coreip.homeip.net> <alpine.LRH.2.00.0909220933090.27145@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:43280 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbZIVHxT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2009 03:53:19 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <alpine.LRH.2.00.0909220933090.27145@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Bryan Wu <cooloney@kernel.org>


>From: Jiri Kosina
>Sent: Tuesday, September 22, 2009 9:33 AM
>
>On Mon, 21 Sep 2009, Dmitry Torokhov wrote:
>
>> > +	if (event & KP_INT) {
>> > +		adp5520_read(dev->master, KP_INT_STAT_1, &reg_val_low);
>> > +		adp5520_read(dev->master, KP_INT_STAT_2, &reg_val_high);
>> > +
>> > +		keymask =3D (reg_val_high << 8) | reg_val_low;
>> > +		/* Read twice to clear */
>> > +		adp5520_read(dev->master, KP_INT_STAT_1, &reg_val_low);
>> > +		adp5520_read(dev->master, KP_INT_STAT_2, &reg_val_high);
>> > +		keymask |=3D (reg_val_high << 8) | reg_val_low;
>> > +		adp5520_keys_report_event(dev, keymask, 1);
>> > +	}
>> > +
>> > +	if (event & KR_INT) {
>>
>> Why do you check the same condition twice?
>
>It actually doesn't seem to be the same condition (KP_INT vs. KR_INT),=
 but
>it's difficult to say, as these constants are apparently added in some
>other patch I have no idea about.

KP Key-Press versus Key-Release=20

>And the same for other constants used in the code ... the patch seems =
to
>be quite incomplete.

The missing constants are in include/linux/mfd/adp5520.h

This file was sent in a different patch, adding support for the Multi F=
unction Device Core=20
(drivers/mfd/adp5520.c)

-Michael

------------------------------------------------------------------
********* Analog Devices GmbH
**  ***** Systems Engineering
**     ** Wilhelm-Wagenfeld-Strasse 6=20
**  ***** D-80807 Munich
********* Germany=20
Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wesse=
l, William A. Martin, Margaret K. Seif

>
>--
>Jiri Kosina
>SUSE Labs, Novell Inc.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
