From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [RFC][PATCH] input: Introduce device information ioctl
Date: Wed, 08 Dec 2010 21:37:05 +0100
Message-ID: <4CFFEC71.8060103@euromail.se>
References: <1291706726-8835-1-git-send-email-rydberg@euromail.se> <25336.1291839964@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:55434 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756388Ab0LHUh1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 8 Dec 2010 15:37:27 -0500
In-Reply-To: <25336.1291839964@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>

>

>>  /*
>> + * Device types
>> + */
>> +
>> +#define DEVTYPE_KEYBOARD	0
>> +#define DEVTYPE_MOUSE		1
>> +#define DEVTYPE_JOYSTICK	2
>> +#define DEVTYPE_TOUCHPAD	3
>> +#define DEVTYPE_TABLET		4
>> +#define DEVTYPE_TOUCHSCREEN	5
> 
> Add a #define DEVTYPE_UNKNOWN 0 and push everybody else down one. That way,
> an uninitialized 'struct input_devinfo' won't claim to be a keyboard.


Since types is a bitmask, the initial value will actually be unclaimed already.
To be explicit, for a keyboard, types = 1 << 0 = 1.

Thanks,
Henrik
