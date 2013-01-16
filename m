From: Fernando Luis Vazquez Cao <fernando_b1@lab.ntt.co.jp>
Subject: Re: [PATCH v2] HID: add support for Sony RF receiver with USB product
 id 0x0374
Date: Wed, 16 Jan 2013 14:17:05 +0900
Message-ID: <50F637D1.8070302@lab.ntt.co.jp>
References: <1358221428.9926.1.camel@nexus.lab.ntt.co.jp>  <20130115103638.be566e39f0f5ad7186362dd8@studenti.unina.it>  <50F52986.2080002@lab.ntt.co.jp> <1358246448.4897.3.camel@nexus.lab.ntt.co.jp> <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tama500.ecl.ntt.co.jp ([129.60.39.148]:39799 "EHLO
	tama500.ecl.ntt.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982Ab3APFRz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Jan 2013 00:17:55 -0500
In-Reply-To: <alpine.LNX.2.00.1301151702150.7734@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

Hi Jiri,

On 2013/01/16 01:02, Jiri Kosina wrote:
> On Tue, 15 Jan 2013, Fernando Luis V=C3=A1zquez Cao wrote:
>
>> Some Vaio desktop computers, among them the VGC-LN51JGB multimedia P=
C, have
>> a RF receiver, multi-interface USB device 054c:0374, that is used to=
 connect
>> a wireless keyboard and a wireless mouse.
>>
>> The keyboard works flawlessly, but the mouse (VGP-WMS3 in my case) d=
oes not
>> seem to be generating any pointer events. The problem is that the mo=
use pointer
>> is wrongly declared as a constant non-data variable in the report de=
scriptor
>> (see lsusb and usbhid-dump output below), with the consequence that =
it is
>> ignored by the HID code.
>>
>> Add this device to the have-special-driver list and fix up the repor=
t
>> descriptor in the Sony-specific driver which happens to already have=
 a fixup
>> for a similar firmware bug.
> Applied, thanks.

Thank you.

I noticed that the patch was tagged "for-3.9". Does this mean
that it is too late to get it merged during the current release
cycle?

If possible, I would like to get it backported to 3.7-stable (and
possibly 3.2 stable), since without it a whole family of Sony
desktop computers is unusable under Linux out of the box.
Should I do it myself or do you have a process in place for HID
stable patches?

Regards,
=46ernando
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
