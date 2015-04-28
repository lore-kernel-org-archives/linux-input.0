From: Friedrich Strohmaier <damokles4-listen@bits-fritz.de>
Subject: Re: Logitech wireless adaptor ID 046d:c52b not showing up xfce-powermanager
 since kernel 3.19
Date: Tue, 28 Apr 2015 02:01:33 +0200
Message-ID: <553ECDDD.4060405@bits-fritz.de>
References: <553D24AA.8030804@bits-fritz.de> <CAN+gG=FWbgZBa8cj5a_q=Q3N1A2yyZ0_bBNgdobQBEn0HBkf-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zweiblum.4m2.net ([81.169.187.171]:45308 "EHLO smtp.4m2.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840AbbD1ABf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 20:01:35 -0400
In-Reply-To: <CAN+gG=FWbgZBa8cj5a_q=Q3N1A2yyZ0_bBNgdobQBEn0HBkf-A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Benjamin, *,

thanks for Your quick reply..

Am 27.04.2015 um 00:08 schrieb Benjamin Tissoires:
> On Sun, Apr 26, 2015 at 1:47 PM, Friedrich Strohmaier:

[..]

>> this appears plugging in the mouse:
>> Bus 007 Device 010: ID 046d:c52f Logitech, Inc. Unifying Receiver

>> those appear plugin in trackball and keyboard :
>> Bus 007 Device 006: ID 046d:c52b Logitech, Inc. Unifying Receiver
>> Bus 007 Device 011: ID 046d:c52b Logitech, Inc. Unifying Receiver

>> All devices work fine regarding functionality.

[..]

> The patch in question:
> http://cgit.freedesktop.org/upower/commit/?id=f8104a112eb967cd4c2aaf57b5a59aafe7c4738f

did apply manually..

> You can directly grab the file
> http://cgit.freedesktop.org/upower/tree/rules/95-upower-csr.rules,
> replace the one in /usr/lib/udev/rules.d/, reboot and you should be
> all set.

This solved the issue - thanks for Your work!

> Sorry again,
> Benjamin

All fine, thanks again.

Friedrich

[..]
