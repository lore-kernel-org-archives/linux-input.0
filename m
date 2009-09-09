From: "Song, Barry" <Barry.Song@analog.com>
Subject: RE: [Uclinux-dist-devel] [PATCH v2]add analog devices AD714Xcaptouch input driver
Date: Wed, 9 Sep 2009 15:20:15 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04B4C3CE@chinexm1.ad.analog.com>
References: <1252401564-5291-1-git-send-email-21cnbao@gmail.com> <8bd0f97a0909082308y636684dbka0b65af4ed658c7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:36871 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbZIIHUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 03:20:37 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0909082308y636684dbka0b65af4ed658c7b@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, dbrownell@users.sourceforge.net, linux-input@vger.kernel.org

=20

>-----Original Message-----
>From: uclinux-dist-devel-bounces@blackfin.uclinux.org=20
>[mailto:uclinux-dist-devel-bounces@blackfin.uclinux.org] On=20
>Behalf Of Mike Frysinger
>Sent: Wednesday, September 09, 2009 2:09 PM
>To: Barry Song
>Cc: uclinux-dist-devel@blackfin.uclinux.org;=20
>dbrownell@users.sourceforge.net; linux-input@vger.kernel.org
>Subject: Re: [Uclinux-dist-devel] [PATCH v2]add analog devices=20
>AD714Xcaptouch input driver
>
>On Tue, Sep 8, 2009 at 05:19, Barry Song wrote:
>> +config INPUT_AD714X
>> + =A0 =A0 =A0 tristate "Analog Devices AD714X Capacitance Touch Sens=
or"
>> + =A0 =A0 =A0 depends on SPI || I2C
>> + =A0 =A0 =A0 help
>> + =A0 =A0 =A0 =A0 Say Y here if you want to support an AD714X touch =
sensor.
>> +
>> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here:=
 the
>> + =A0 =A0 =A0 =A0 module will be called ad714X.
>
>capital X in define/config is OK, but the desc and user output should
>really be lower case.  plus the module wont be named "ad714X", it'll
>be "ad714x".
=46ixed
>-mike
>_______________________________________________
>Uclinux-dist-devel mailing list
>Uclinux-dist-devel@blackfin.uclinux.org
>https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
