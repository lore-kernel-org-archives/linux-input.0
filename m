From: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Subject: Re: [RFC] Add Input IOCTL for accelerometer devices
Date: Tue, 19 May 2009 14:34:15 +0200
Message-ID: <45cc95260905190534m561d666ds1fd5d38b4a08ba5b@mail.gmail.com>
References: <20090515131636.GE4443@nokia.com> <5d5443650905151106v2fe7ad1ci6c966463a991e732@mail.gmail.com>
	<45cc95260905151230j5485995dpbbd882dc91b25339@mail.gmail.com>
	<20090515200235.GA11829@nokia.com> <4d34a0a70905180045u6619773dt1563fe38b13d46fb@mail.gmail.com>
	<20090518091236.GH4443@nokia.com> <4A121C54.2040205@samsung.com>
	<20090519104202.GB30597@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f224.google.com ([209.85.219.224]:52971 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbZESMef convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 08:34:35 -0400
In-Reply-To: <20090519104202.GB30597@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: ext Kim Kyuwon <q1.kim@samsung.com>, ext Kim Kyuwon <chammoru@gmail.com>, Trilok Soni <soni.trilok@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>, Kyungmin Park <kyungmin.park@samsung.com>, Jean Delvare <khali@linux-fr.org>

Hi,

>>  > But then comes another question: what to do with
>> > magnetometers, gyroscopes, etc etc ??
>>
>> If we make a extensible sensor driver, I think we can add these new =
etc
>> sensors in the future. step by step.
>
> agreed here. But we have to think that this might get extended, so we
> should start thinking of an abstraction layer that could evolve for
> magnetometers, gyroscopes and other sensors

Agree with you, there should be an abstraction layer.

According to this, we should collect similar functionalities in one
module and make sub-module describing exceptions devices or ones that
needs special handling.
But in the end for the user space apps, they should "see" an
accelerometer in a standard way. All exceptions and pre-handling
should be done in the abstraction layer as described.
We can't bring as many full drivers as devices found, but one driver
serving for a group and that can load submodules when necessary.
The way HID is coded in Linux is an example for that, dealing with
many types of devices.
It isn't perfect, but its architecture can be used for other devices.

To stay with accelerometers, they are sensors, and sensors sense
physical properties.
Every device use its own methods but in the end they sense the same
thing and user wait for a similar feedback.

I post a link describing the HID standard, you can see in page 37 to
39 how they define units, and exponents for sensors.
http://www.usb.org/developers/devclass_docs/HID1_11.pdf

Also, we can't imagine all use cases and scenarios, we should bring
useful information to userspace apps and they do what they want with
these informations.
KDE developers may use sensors to automatically rotate the screen
90=B0/180=B0 if the laptop is rotated. Others will use it to play games=
,
Some others will use light sensors to lighten the keyboard or to
change the brightness of the screen,...


What do you think ?

_
ikbel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
