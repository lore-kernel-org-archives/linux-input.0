From: K900 <k0009000@gmail.com>
Subject: I want to add support for the Logitech G710+ keyboard
Date: Fri, 19 Apr 2013 08:34:44 +0400
Message-ID: <CAK0ehjG+Lkp__cw-251Hk-1sa_ZLFa9DD93Rmp0NJE-bzUsrVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ia0-f177.google.com ([209.85.210.177]:57026 "EHLO
	mail-ia0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab3DSEep (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Apr 2013 00:34:45 -0400
Received: by mail-ia0-f177.google.com with SMTP id y26so516399iab.22
        for <linux-input@vger.kernel.org>; Thu, 18 Apr 2013 21:34:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,
So I have this keyboard, and it mostly works, but some Logitech
specific features (programmable keys, etc) don't. I've been playing
around with it, and I've figured out pretty much everything
(interrupts and some GetFeature/SetFeature requests for things like
backlight levels). I have some proof of concept Python+PyUSB code at
https://github.com/K900/g710 , but I'm getting confused when it comes
to implementing that in the kernel. Is there something like a 'HID
drivers for dummies' guide? Sorry for the noobish questions.

Thanks in advance,
Ilya
