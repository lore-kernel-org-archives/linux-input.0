From: Louai Al-Khanji <louai.khanji@gmail.com>
Subject: Support for Logitech Dinovo Edge special keys
Date: Mon, 16 Mar 2009 23:53:31 +0200
Message-ID: <f4a2642e0903161453v447f5fe8idf1e3c58fd800548@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f175.google.com ([209.85.218.175]:44327 "EHLO
	mail-bw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759000AbZCPVxf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2009 17:53:35 -0400
Received: by bwz23 with SMTP id 23so1148076bwz.37
        for <linux-input@vger.kernel.org>; Mon, 16 Mar 2009 14:53:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I recently bought a Logitech Dinovo Edge keyboard. However, it seems
that not all keys are supported by the current HID layer as of
2.6.28.7 - at least, in X I get no reports of keypresses, and for the
special keys that do generate key presses no keycode info is
available. I wonder if anyone can point me in the right direction on
how to fix this, and indeed confirm that this needs to be fixed in the
HID layer rather than in X somewhere.

I did look in hid-input.c, where in the hidinput_configure_usage
function there is a case HID_UP_LOGIVENDOR which is ignored. hid-lg.c
seems to contain some fixes for Logitech keyboards, but I don't quite
see how it all fits together.

I have not worked extensively in kernel space before, so please bear with me. :)

-- 
- Louai Al-Khanji
