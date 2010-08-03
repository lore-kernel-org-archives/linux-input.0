From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: A usage for BTN_STYLUS2
Date: Tue, 03 Aug 2010 15:35:39 +0400
Message-ID: <4C57FF0B.6000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37465 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755641Ab0HCLfz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Aug 2010 07:35:55 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Hello,

As far as I could see, there is no mapping to BTN_STYLUS2 (a second button
on the pen barrel, AFAIK) in hidinput_configure_usage, however some specific
drivers use it.

Is it because there is really no usage code for it in the HID Usage Tables
document? If so, maybe there is some widely used usage code for such
button, which we could use?

So far I've seen "Eraser", "Tablet Pick" and, possibly, "Invert" used in
UC-Logic, Kye and Waltop tablets respectively. To me, "Tablet Pick" looks the
least of evils.

I'm asking because many tablets have these buttons and having all of them
using input_mapping just for this would be too much, IMHO.

I'm looking forward to adding support for several, at least, and attempting
to do so by only providing fixed report descriptors, if possible.

Thank you.

Sincerely,
Nick
