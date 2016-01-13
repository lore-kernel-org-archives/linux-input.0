From: Roberto Alejandro Espi Munoz <raespi@icid.cu>
Subject: uinput on headless system ...
Date: Wed, 13 Jan 2016 09:19:39 -0500
Message-ID: <56965CFB.3020401@icid.cu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.icid.cu ([200.55.133.90]:55369 "EHLO mail.icid.cu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755512AbcAMOto (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 09:49:44 -0500
Received: from icid.cu ([10.10.0.3])
	by mail.icid.cu (8.13.8/8.13.8) with ESMTP id u0DD8W0h016805
	for <linux-input@vger.kernel.org>; Wed, 13 Jan 2016 08:08:39 -0500
Received: from [10.10.8.78] by icid.cu
	(Cipher TLSv1:RC4-MD5:128) (MDaemon PRO v9.6.1)
	with ESMTP id md50008528549.msg
	for <linux-input@vger.kernel.org>; Wed, 13 Jan 2016 08:37:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello ... I've been searching around the web for a specific mailing list 
for the uinput driver but couldn't find any.  I managed to create an 
example app that injects keyboard events to the running linux kernel 
succesfully when I have a keyboard attached to the computer.  However if 
I run it on a keyboardless machine, like a standalone motherboard, the 
uinput device fails to open.

Any thoughts on this? or can you redirect me to an ongoing mailing list 
about the kernel input system

Thanks in advance ...

