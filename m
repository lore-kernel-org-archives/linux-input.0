From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH v3 4/7] Input - wacom: Check for bluetooth protocol
 while setting OLEDs
Date: Thu, 31 Jul 2014 22:14:26 +0100
Message-ID: <1406841266.11114.5.camel@fedora-lan>
References: <1406659385-3256-1-git-send-email-benjamin.tissoires@redhat.com>
	 <1406659385-3256-5-git-send-email-benjamin.tissoires@redhat.com>
	 <1406674412.24026.1.camel@fedora-lan>
	 <CAF8JNhK1R3mzfJA2OZwZv3-KwqpFBkOjDmzM1JkZW_Wix+Ww8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aso-006-i451.relay.mailchannels.net ([23.91.64.132]:37523 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750906AbaGaVOe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 17:14:34 -0400
In-Reply-To: <CAF8JNhK1R3mzfJA2OZwZv3-KwqpFBkOjDmzM1JkZW_Wix+Ww8g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jason Gerecke <killertofu@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

Dnia 2014-07-31, czw o godzinie 08:56 -0700, Ping Cheng pisze:
[..]
Hi Ping, 
> I'd like to see Przemo's Tested-by tag here as well. Przemo, are you
> done with your testing?

Whole series:
Tested-by: Przemo Firszt <przemo@firszt.eu>

Tested on two Intuos4 Wireless (usb + bt) tablets. Everything works as
expected. 

If someone wants to test icons scrambling in the userspace I added
option to i4oled (switch -B):

https://github.com/PrzemoF/i4oled/tree/v1.3

> Thank you Przemo and Benjamin for your effort in making this
> transition smooth and successful. We, at Wacom, are very grateful to
> be part of this great community.
Thanks! All credit goes to Benjamin :-)
-- 
Kind regards,
Przemo Firszt


