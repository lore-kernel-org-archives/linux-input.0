From: simon@mungewell.org
Subject: Re: Sony DualShock4 - basic functions work, but looking to improve
 support
Date: Mon, 9 Dec 2013 21:50:43 -0500
Message-ID: <7f868cfea581a565001fe18bb08b8abb.squirrel@mungewell.org>
References: <61a33717137a02a1d0eac5a2d1cb257e.squirrel@mungewell.org>
    <a26fde1f94cf430dd54a5045f82ac260.squirrel@mungewell.org>
    <CANq1E4Q=4DEDFibVtifMVE-2wq7Bt0KOPRRE5nFy9Hu-tgy_Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20131209215042_46795"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:36501 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab3LJCuo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Dec 2013 21:50:44 -0500
In-Reply-To: <CANq1E4Q=4DEDFibVtifMVE-2wq7Bt0KOPRRE5nFy9Hu-tgy_Cg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Antonio Ospite <ospite@studenti.unina.it>

------=_20131209215042_46795
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

> The report descriptor actually describes a lot more report-IDs than
> just "0x01" which you describe in hidraw.txt. Are you sure the
> report-descriptors are the same for USB and BT?

The report descriptor when connected via BT is different, or at least what
I found at '/sys/bus/hid/devices/0005\:054C\:05C4.0006/report_descriptor'.

Unfortunately I wasn't able to decode it.
--
simon@womble:~/dualshock4$ ~/hidrd-0.2.0/src/hidrd-convert des_bt.bin -o code
Failed to read input item at offset 356:
invalid item encountered
--

Thanks for the other suggestions.
Simon
------=_20131209215042_46795
Content-Type: application/octet-stream; name="des_bt.bin"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="des_bt.bin"

BQEJBaEBhQEJMAkxCTIJNRUAJv8AdQiVBIECCTkVACUHdQSVAYFCBQkZASkOFQAlAXUBlQ6BAnUG
lQGBAQUBCTMJNBUAJv8AdQiVAoECBgT/hQIJJJUksQKFowkllTCxAoUFCSaVKLEChQYJJ5U0sQKF
BwkolTCxAoUICSmVL7ECBgP/hQMJIZUmsQKFBAkilS6xAoXwCUeVP7EChfEJSJU/sQKF8glJlQ+x
AgYA/4URCSAVACb/AHUIlU2BAgkhkQKFEgkilY2BAgkjkQKFEwkklc2BAgklkQKFFAkmlg0BgQIJ
J5EChRUJKJZNAYECCSmRAoUWCSqWjQGBAgkrkQKFFwksls0BgQIJLZEChRgJLpYNAoECCS+RAoUZ
CTCWIgKBAgkxkQIGgP+FggkilT+xAoWDCSOxAoWECSSxAoWQCTCxAoWRCTGxAoWSCTKxAoWTCTOx
AoWgCUCxAoWkCUSxAsAA
------=_20131209215042_46795--


