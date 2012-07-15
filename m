From: Yann Cantin <yann.cantin@laposte.net>
Subject: On the fly input_set_abs_params changes
Date: Sun, 15 Jul 2012 21:13:40 +0200
Message-ID: <50031664.6090302@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:34221 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2GOTNj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Jul 2012 15:13:39 -0400
Received: from [192.168.1.100] (coyote.ysoft.org [192.168.1.100])
	by nestor.ysoft.org (Postfix) with ESMTP id 6596D2023F
	for <linux-input@vger.kernel.org>; Sun, 15 Jul 2012 21:13:36 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I'm working on a kernel input driver for eBeam devices (see http://www.e-beam.com).

This hardware is very special, and his handling don't fit in any existing category
(or i've not found it yet).

I'm wondering if it's ok to change min/max parameters after registration, and how
it should be handled by xorg's evdev.

I've some other input related questions, is it the right place to post ?

-- 
Yann Cantin
A4FEB47F
--
