From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 0/2] elantech: Additional info reporting with version 2
Date: Wed, 05 May 2010 14:19:31 +0200
Message-ID: <4BE16253.6080308@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:42206 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934347Ab0EEMVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 08:21:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello,

As I eventually got the elantech driver working with my hardware (in a
dell mini 10), I started to observe the raw messages. Here are two small
additions to the reporting of the info with hardware version 2.

Also, from the observations, it seems that when there are three fingers,
some coordinates are also reported, but I have found the format yet...

Patches are against git input-linux for-linus.

See you,
Eric
