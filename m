From: =?UTF-8?B?U8OpYmFzdGllbiBCb3VyZGVhdWR1Y3E=?= <sb@m-labs.hk>
Subject: Re: "i2c_hid: Could not register for interrupt, irq = -1" on Thinkpad
 Tablet 10
Date: Mon, 02 Feb 2015 23:55:08 +0800
Message-ID: <54CF9DDC.4090104@m-labs.hk>
References: <54CCEE3D.9040306@m-labs.hk>	<CAN+gG=Gzi-gm1Hxvb1dt8xjLe4d_tBXEruu9HAru0x73dMAMCw@mail.gmail.com>	<54CD9D0D.20402@m-labs.hk>	<20150202100031.GP22740@lahna.fi.intel.com>	<54CF7977.1090105@m-labs.hk>	<20150202134805.GT22740@lahna.fi.intel.com>	<54CF9883.10701@m-labs.hk> <CAN+gG=FOTiX+VXM1F49jrhnCM1uZt7Vv=Rr6W2mTHYuX+rKjPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ssl.serverraum.org ([88.198.40.39]:34742 "EHLO
	ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbbBBQAL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2015 11:00:11 -0500
In-Reply-To: <CAN+gG=FOTiX+VXM1F49jrhnCM1uZt7Vv=Rr6W2mTHYuX+rKjPw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input <linux-input@vger.kernel.org>

On 02/02/2015 11:42 PM, Benjamin Tissoires wrote:
> There has been a patch floating around last year which tried to pull
> all the available reports after the IRQ was triggered. I rejected it
> for the sake of not breaking existing devices, but maybe your device
> needs it.
> http://www.spinics.net/lists/linux-input/msg31342.html

Thanks, but no, it still doesn't work.

I just noticed another thing: when I use the stylus the first time (and
it successfully moves the cursor), it prints:
i2c_hid_get_input: incomplete report (76/8194)

S=C3=A9bastien

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
