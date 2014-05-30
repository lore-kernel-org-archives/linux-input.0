From: Filippo Sironi <filippo.sironi@gmail.com>
Subject: writing a touchscreen device driver
Date: Fri, 30 May 2014 18:54:21 +0200
Message-ID: <BD5020A8-0B11-446A-B38A-C98EA21773D4@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38473 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531AbaE3Qy0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 May 2014 12:54:26 -0400
Received: by mail-wi0-f182.google.com with SMTP id r20so1516099wiv.9
        for <linux-input@vger.kernel.org>; Fri, 30 May 2014 09:54:25 -0700 (PDT)
Received: from [192.168.0.2] ([95.237.112.39])
        by mx.google.com with ESMTPSA id f6sm7352242wiy.19.2014.05.30.09.54.24
        for <linux-input@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 May 2014 09:54:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi everyone,

I'm writing a touchscreen device driver for the PIXCIR Tango C series (http://www.pixcir.com.cn/english/products.asp?Action=Detail&ID=95) for Linux 4 Tegra 3.1.10 (I'm using a Tegra 2 series platform).

I went through the documentation and I came up with the code you can find in this gist: https://gist.github.com/filipposironi/d9ab11e232d8cae9b8f4 .
To test the touchscreen I'm using a set of X11/Qt applications and a X11/Qt/QtWebKit browser. The touchscreen works fine with Qt controls (e.g., buttons and text areas); unfortunately, the same doesn't happen with HTML controls inside the Qt/QtWebKit browser, they struggle to get the focus (sometimes they do and sometimes they don't). Everything else (scrolling with one finger, pinch and zoom, etc. works great).

I initially thought the problem was inside QtWebKit; however, an eGalax touchscreen working with the device driver implemented inside drivers/hid/hid-multitouch.c behaves like a charm even with the Qt/QtWebKit browser.
The evtest (http://cgit.freedesktop.org/evtest/) output I get from the two touchscreens is definitely the same.

I'm wondering if there is something fundamentally wrong with my device driver (https://gist.github.com/filipposironi/d9ab11e232d8cae9b8f4) that I'm not seeing.

Thanks,
Filippo

PS: I'm using Xorg 1.14.1 and evdev 2.7.3 with mtdev 1.1.3 support.

