From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: Unusual Focaltech driver behavior
Date: Fri, 17 Apr 2015 11:44:02 +0300
Message-ID: <5530C7D2.8090106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36341 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbbDQIoF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Apr 2015 04:44:05 -0400
Received: by lbbqq2 with SMTP id qq2so77316458lbb.3
        for <linux-input@vger.kernel.org>; Fri, 17 Apr 2015 01:44:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mgottschlag@gmail.com

I noticed that myself and got some complaints like this.
https://github.com/hanipouspilot/ubuntu-fixes/issues/2

General issue is that when one finger is on the touchpad, movement of a second finger is ignored, if the first finger does not move.
Usually with other touchpads, when you have one finger on the touchpad and move the other, it is recognized as two-finger scrolling.
The device itself sends relative packages as normal in that case, but linux driver ignores them, until first finger is moved.

I guess, Windows driver behaves same way. I can't test it, since I do not have Windows installed on that laptop.

As I understood, Windows driver ignores that one finger is on button area and recognizes movement of the other as one-finger movement.

It is clear that we do not know the full protocol or parameters of all touchpad models to have that button area always correct.
But it looks like button area is set when 3rd byte in abs package is 00. There is a good chance that it is common for all touchpad models.

Do you have ideas how to fix it the easiest way?

Regards,

Dmitry
