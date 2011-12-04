From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: adp5588-keys datasheet and driver question
Date: Sun, 4 Dec 2011 21:12:17 +0000
Message-ID: <544AC56F16B56944AEC3BD4E3D59177148733EAB39@LIMKCMBX1.ad.analog.com>
References: <1322928007.11453.32.camel@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:12333
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754521Ab1LDVL4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 4 Dec 2011 16:11:56 -0500
In-Reply-To: <1322928007.11453.32.camel@mars>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Christoph Fritz wrote on 2011-12-03:
> Hi Michael,
>
>  I had a look at the adp5588-keys driver and its datasheet.
> There are some "slips of the pen" in it (adp5588 Rev.b):

Hi Christoph,

Good catch - however typos in datasheets shouldn't be discussed here, unless it
influences the vital state of this driver.

>   - Page 8, Table 12, "E4 pressed" refers to binary 1000 instead of 100

Not only this obvious one - all others are wrong as well...

>   - Page 17, Table 22, Register Descriptions are mostly wrong

What's wrong with Table 22?


> Another thing I'm curious about is in adp5588_report_events():
>
> int key = adp5588_read(kpad->client, Key_EVENTA + i); int key_val = key
> & KEY_EV_MASK; [...] input_report_key(kpad->input, kpad->keycode[key_val
> - 1], key & KEY_EV_PRESSED);
>
> Why is there a -1 for key_val?

Key_val == 0, is not a valid event code!
The part emits 1..80 for keys and 97..114 for GPI events.

So bottom line - the driver is correct but Table 12 is completely wrong.

Best regards,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif



