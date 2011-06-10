From: Chih-Wei Huang <cwhuang@android-x86.org>
Subject: Re: ET1602 Touchscreen doesn't work
Date: Fri, 10 Jun 2011 10:23:06 +0800
Message-ID: <BANLkTinnGiu_qWnCTq-1peyEw4=xUdnAkw@mail.gmail.com>
References: <BANLkTikX9njth-jP6PpQuwL9sTUciu1nQA@mail.gmail.com>
	<20110602144146.GB3508@nautilus.holoscopio.com>
	<BANLkTimen=6OXOTww48CAn-ULaRVP_7zUw@mail.gmail.com>
	<20110603124428.GA2379@nautilus.holoscopio.com>
	<BANLkTimw2pV2Cv6pG2HJiD5AGrqJpOCXjw@mail.gmail.com>
	<BANLkTikiX4X2OEET5qmejdWhs1XY7e3HWw@mail.gmail.com>
	<20110608125758.GA2465@nautilus.holoscopio.com>
	<BANLkTin1YhxCE5J9suR93eWcWEtviFNLtg@mail.gmail.com>
	<20110608153146.GG2465@nautilus.holoscopio.com>
	<BANLkTin3MyXsDHOK+BgdXvKO5YBH=Cv5DA@mail.gmail.com>
	<20110609133943.GA2439@nautilus.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60995 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697Ab1FJCXH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jun 2011 22:23:07 -0400
Received: by vws1 with SMTP id 1so1739705vws.19
        for <linux-input@vger.kernel.org>; Thu, 09 Jun 2011 19:23:06 -0700 (PDT)
In-Reply-To: <20110609133943.GA2439@nautilus.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

2011/6/9 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>:
> Nice. That was one of the tests. But have you tested without the quirck
> in hid-quirks and without the suggested change by Benjamin? Considering
> the device would indicate it supports RX and Z axis, but not X and Y
> axis, it should not work either in Android.

Did you mean just remove this line in hid-quirks.c?

{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },

That's what I've tried (with and without Benjamin's change) .
Yes, it works in Android 2.2.

-- 
Chih-Wei
Android-x86 project
http://www.android-x86.org
