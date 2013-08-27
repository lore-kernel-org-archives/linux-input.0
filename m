From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: Rotary encoder platform device driver code examples
Date: Tue, 27 Aug 2013 12:39:14 +0200
Message-ID: <CAH9NwWfo0Y5ngy48Qn0wM+Lgs88bfe3+ASyUBy4d=tX8H56U1g@mail.gmail.com>
References: <52152808.1000608@rs2i.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:43010 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143Ab3H0Kje convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Aug 2013 06:39:34 -0400
Received: by mail-qe0-f43.google.com with SMTP id t7so2448937qeb.16
        for <linux-input@vger.kernel.org>; Tue, 27 Aug 2013 03:39:34 -0700 (PDT)
In-Reply-To: <52152808.1000608@rs2i.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?R1JFTk9OIExvw69j?= <difool@rs2i.net>
Cc: linux-input@vger.kernel.org

2013/8/21 GRENON Lo=C3=AFc <difool@rs2i.net>:
> Hi guys,
>
> I want to interface a magnetic scale position sensor with a BeagleBon=
e Black
> (an ARM development platform).
> While I was reading this following article :
> http://bwgz57.wordpress.com/2012/04/11/beaglebone-with-a-rotary-encod=
er/ I
> discovered that linux has built-in support for rotary encoders connec=
ted via
> GPIO.
>
> The magnetic scale position sensor can be considered like a rotary en=
coder
> so I would use the rotary_encoder platform device driver.
>
> I've read the code example at the end of this document :
> https://www.kernel.org/doc/Documentation/input/rotary-encoder.txt
> But I don't know how to access to the "pos" value of the rotary encod=
er.
>
> Do you have some code example of use of this driver ? Or anything tha=
t can
> be helpful for me.
>

As the rotary encoder is an input device it is accessible via
/dev/input/eventX where X is
a number. Have a look at evtest user space application.

greets
--
Christian Gmeiner, MSc
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
