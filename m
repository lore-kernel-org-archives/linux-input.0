From: Yann Cantin <yann.cantin@laposte.net>
Subject: [ebeam] Specific usb driver vs hid generic-usb for an input device
Date: Thu, 26 Jul 2012 02:53:00 +0200
Message-ID: <501094EC.70906@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:22087 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab2GZAxF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 20:53:05 -0400
Received: from [192.168.1.100] (coyote.ysoft.org [192.168.1.100])
	by nestor.ysoft.org (Postfix) with ESMTP id 3F54E2055D
	for <linux-input@vger.kernel.org>; Thu, 26 Jul 2012 02:52:59 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I've coded a usb driver for a device (eBeam) that is currently blindly handled by the hid generic-usb.

The driver itself is pure usb+input, mostly based on usbtouchscreen.c

My question : Is it sufficient to add an entry in hid_ignore_list[] (hid/hid-core.c) to get
hid out of the way and let my driver be picked to handle the device ?

-- 
Yann Cantin
A4FEB47F
--
