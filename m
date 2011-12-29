From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/2] HID: multitouch: add support of Atmel multitouch panels
Date: Thu, 29 Dec 2011 19:26:47 +0100
Message-ID: <CAN+gG=HgdgNt4x8V7XgN5J-enQDWfDP3urEn8e7QTipWpFNL9A@mail.gmail.com>
References: <1324651260-4067-1-git-send-email-benjamin.tissoires@gmail.com>
	<1324651260-4067-2-git-send-email-benjamin.tissoires@gmail.com>
	<4EF4CE4A.1020907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48125 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1L2S0u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Dec 2011 13:26:50 -0500
In-Reply-To: <4EF4CE4A.1020907@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chasedouglas@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Chase,

Well, this is the "Atmel maXTouch Digitizer" found on Samsung "Series
7 Slate" XE700T1A.

Same device here:
http://www.spinics.net/lists/xorg/msg53376.html

Cheers,
 and happy new year,
Benjamin

On Fri, Dec 23, 2011 at 19:54, Chase Douglas <chasedouglas@gmail.com> w=
rote:
> On 12/23/2011 06:40 AM, Benjamin Tissoires wrote:
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> ---
>> =A0drivers/hid/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0 =A0 =A0| =A0 =A03 +++
>> =A0drivers/hid/hid-multitouch.c | =A0 =A05 +++++
>> =A03 files changed, 9 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 5d6eb4e..e95b07c 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -335,6 +335,7 @@ config HID_MULTITOUCH
>> =A0 =A0 =A0 =A0 Say Y here if you have one of the following devices:
>> =A0 =A0 =A0 =A0 - 3M PCT touch screens
>> =A0 =A0 =A0 =A0 - ActionStar dual touch panels
>> + =A0 =A0 =A0 - Atmel panels
>> =A0 =A0 =A0 =A0 - Cando dual touch panels
>> =A0 =A0 =A0 =A0 - Chunghwa panels
>> =A0 =A0 =A0 =A0 - CVTouch panels
>
> I'm guessing this is different than the Atmel maXTouch chips. If so, =
can
> you figure out a model name so people aren't confused on which driver=
 to
> use?
>
> -- Chase
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
