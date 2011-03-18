From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: kernel input driver and loadkeys
Date: Fri, 18 Mar 2011 09:05:56 +0100
Message-ID: <AANLkTimKaMQ47+b_1xaHPzUDjwO=dJLAJo-RhKxhsLic@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50891 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab1CRIGR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Mar 2011 04:06:17 -0400
Received: by vws1 with SMTP id 1so3435967vws.19
        for <linux-input@vger.kernel.org>; Fri, 18 Mar 2011 01:06:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

at the moment I am writing my first linux input driver. The keypad is
organized as a matrix, where each edge
should be configured to send a defined keycode.

What needs to be done in the driver to support loadkeys functionality?
If I have read loadkeys examples correctly
it must be possible to support stuff like alphanumeric input - or I am
wrong with this point?

The current state of the driver delivers row and column of the pressed
key - so good so far.

thanks,
--
Christian Gmeiner, MSc
