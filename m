From: "David Christen" <davidchristen@gmail.com>
Subject: Enable addition function keys
Date: Mon, 16 May 2011 21:54:49 +0200
Message-ID: <000001cc1403$1e0ede10$5a2c9a30$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35637 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab1EPTyx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 15:54:53 -0400
Received: by wwa36 with SMTP id 36so5513109wwa.1
        for <linux-input@vger.kernel.org>; Mon, 16 May 2011 12:54:52 -0700 (PDT)
Content-Language: de-ch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

I have a custom made keyboard with 48 Function keys attached to an embedded
PC running on a RISC CPU. With hid module in the kernel the regular part of
the keyboard (i.e. all letters, num pad and Fxx keys up to F12) are working
perfectly fine. However with the additional keys I don't get any events in
/dev/input/event0. This is the same behavior as found on a regular Linux PC
and also under Windows. Although the manufacturer of the keyboard confirmed
that those keys do send proper HID codes (0x68 to 0x8b for F13 to F48).
I don't have any experience in programming on the Kernel level. Could you
maybe direct me in how to get the input events of those keys running?

Thank you in advance,
David

