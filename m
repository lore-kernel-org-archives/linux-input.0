From: Gregor Riepl <onitake@gmail.com>
Subject: Re: [PATCH] Add generic driver for Silead tochscreens
Date: Sat, 11 Jul 2015 23:23:37 +0200
Message-ID: <55A18959.7050502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34480 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbGKVYa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 17:24:30 -0400
Received: by wibud3 with SMTP id ud3so1260039wib.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2015 14:24:29 -0700 (PDT)
Received: from ?IPv6:2a02:168:56e8:b00b:6e88:14ff:fe9f:e85c? ([2a02:168:56e8:b00b:6e88:14ff:fe9f:e85c])
        by smtp.googlemail.com with ESMTPSA id ez4sm5198517wid.14.2015.07.11.14.24.27
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jul 2015 14:24:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello.

You beat me to it - I noticed the lack of a generic Silead driver that works
with Baytrail tablets (and ACPI) and started writing one myself, adapting the
code by Joe Burmeister (https://github.com/jabjoe/sunxi-gslx680). You can find
my endeavors (so far) here: https://github.com/onitake/gslx680-acpi

While writing the driver, I noticed that my controller or the firmware (which
I got from the Windows 8 driver for the tablet) does not seem to support
finger tracking. If I look at the data packets, almost all of them carry 0 as
the finger ID, while some carry 4. Lifting a finger simply removes the record,
without providing a way to correlate it with the next data set.

The code I worked with seems to support some kind of finger tracking, but it
still uses the ID field of each touch record as finger ID. And that does not
work with my touchscreen.

In the meantime, I just implemented type A multitouch support, leaving the
finger tracking out.

Can you help me look into the problem?
