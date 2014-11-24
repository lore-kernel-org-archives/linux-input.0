From: Alexander Varnin <fenixk19@mail.ru>
Subject: qt2160: applying settings
Date: Mon, 24 Nov 2014 20:17:35 +0300
Message-ID: <5473682F.3060101@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback7.mail.ru ([94.100.181.128]:55654 "EHLO
	fallback7.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbaKXRUI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Nov 2014 12:20:08 -0500
Received: from smtp36.i.mail.ru (smtp36.i.mail.ru [94.100.177.96])
	by fallback7.mail.ru (mPOP.Fallback_MX) with ESMTP id 53F7711FA7E4E
	for <linux-input@vger.kernel.org>; Mon, 24 Nov 2014 20:17:44 +0300 (MSK)
Received: from [77.247.181.163] (port=17808 helo=[0.0.0.0])
	by smtp36.i.mail.ru with esmtpa (envelope-from <fenixk19@mail.ru>)
	id 1XsxGe-0004m6-Vm
	for linux-input@vger.kernel.org; Mon, 24 Nov 2014 20:17:42 +0300
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!
My work task now is related with AT42QT2160 [1] chip, that has qt2160
driver in linux kernel.

There is some settings of this chip, that is required to be set to
registers during initialization or at runtime.

These settings are totally unimplemented in current driver. For example
this are registers 12, 13, 20, 38-53, 54-69.

Registers 38-69 are related to calibration, that is required to be
passed on initialization, and 12 is related to power saving, and need to
be changed at runtime.

Of course, I can just write a hack for my purposes, but I want to solve
it in a rightful (and upstream applicable) way.

I suppose that initialization parameters should be passed in a kinda
platform data and that what is need to be set at runtime should go as a
sysfs node.

Could you please hint me the right way?

[1]
http://www.atmel.com/Images/Atmel-9502-AT42-QTouch-BSW-AT42QT2160_Datasheet.pdf

