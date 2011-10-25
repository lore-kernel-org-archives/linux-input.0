From: =?utf-8?Q?Denilson_Figueiredo_de_S=C3=A1?= <denilsonsa@gmail.com>
Subject: Re: Linux USB HID should ignore values outside Logical
 Minimum/Maximum range
Date: Tue, 25 Oct 2011 02:03:50 -0200
Message-ID: <op.v3v2wozfdsdv5o@localhost>
References: <op.v3q34la3dsdv5o@localhost> <4EA5913D.7090004@genband.com>
 <CACGt9ymGUAzjkZJCePnO+7cyKsi8-rtpno9ebjKtoCXj-tCALg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45245 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab1JYED4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Oct 2011 00:03:56 -0400
In-Reply-To: <CACGt9ymGUAzjkZJCePnO+7cyKsi8-rtpno9ebjKtoCXj-tCALg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Friesen <chris.friesen@genband.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

On Mon, 24 Oct 2011 14:39:31 -0200, Denilson Figueiredo de S=C3=A1 wrot=
e:
> On Mon, Oct 24, 2011 at 14:24, Chris Friesen wrote:
>> On 10/22/2011 05:42 AM, Denilson Figueiredo de S=C3=A1 wrote:
>>
>>> It may even happen to send an out-of-range value for one axis, but =
a
>>> valid value for another axis. The code should be prepared for that
>>> (ignore one, but keep the other).
>>
>> In this case what should be used for the "invalid" axis value?  The =
=20
>> previous value?

> I haven't tested that on Windows (yet), so I don't know how it
> behaves. If I test it, I'll post my results here.

I've modified the firmware of my device to do some more tests. I've =20
modified it to send invalid values in X axis, but keep Y axis with vali=
d =20
values.

In Linux, the pointer moved to the right-most position of the screen =20
(which is consistent with the behavior I previously described), not =20
ignoring the out-of-range value.

In Windows, the pointer moved to the left-most position of the screen. =
It =20
means Windows can't send a movement of only one axis, and fills the oth=
er =20
axis with zero when receiving an invalid value. This behavior doesn't s=
eem =20
very helpful.


If anyone cares, this was the firmware modification for this test:
https://bitbucket.org/denilsonsa/atmega8-magnetometer-usb-mouse/changes=
et/31027323fa0b

--=20
Denilson Figueiredo de S=C3=A1
Rio de Janeiro - Brasil
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
