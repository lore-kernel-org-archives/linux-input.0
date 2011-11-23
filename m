From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH RFC] hid-input: add support for HID devices reporting
 Battery Strength
Date: Wed, 23 Nov 2011 21:52:23 +0000
Message-ID: <1322085148.27731.6.camel@pldmachine>
References: <4EC75224.7070207@goop.org>
	 <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz>
	 <4EC820F8.4070900@goop.org>
	 <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz>
	 <4ECA7E7D.80207@goop.org>
	 <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz>
	 <4ECAE019.4000409@goop.org>
	 <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz>
	 <4ECCB38A.8000503@goop.org> <4ECD20FB.7030705@canonical.com>
	 <4ECD6081.6080003@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.delivery.mysitehosted.com ([216.67.234.143]:38566 "HELO
	mail.delivery.mysitehosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751698Ab1KWWUT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 17:20:19 -0500
In-Reply-To: <4ECD6081.6080003@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, vojtech@ucw.cz


Dnia 2011-11-23, =C5=9Bro o godzinie 13:07 -0800, Jeremy Fitzhardinge p=
isze:
[..]
> The Wacom driver's version of this also has its own user-visible
config
> option; I don't know if there's any reason you'd turn it off.

Hi Jeremy,
It was just one of the options. See here:
http://www.spinics.net/lists/linux-bluetooth/msg04750.html

There is a bit more why wacom driver is reporting battery/power thriugh
sysfs. Search for "[PATCH] Expose wacom pen tablet battery and ac thru
power_supply class" on linux-bluetooth list.

--=20
Regards,
Przemo Firszt

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
