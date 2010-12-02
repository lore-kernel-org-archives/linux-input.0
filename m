From: Bill Gatliff <bgat@billgatliff.com>
Subject: Synchronizing evdev readers and drivers?
Date: Thu, 2 Dec 2010 11:26:53 -0600
Message-ID: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51614 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757178Ab0LBR0y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Dec 2010 12:26:54 -0500
Received: by vws16 with SMTP id 16so1168956vws.19
        for <linux-input@vger.kernel.org>; Thu, 02 Dec 2010 09:26:53 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Guys:


Is there any  way for an input device driver (e.g. something that
calls input_report_abs() and input_sync()) to know when there is a
reader of its associated /dev/input/eventX?

I would love to know when something calls evdev_read() and/or
evdev_poll(), so that I could then initiate a sampling operation on
the hardware itself.  Otherwise, I'm forced to periodically poll the
hardware and that means I'm either gathering data that no application
wants, or I'm gathering it before (or faster than) an application is
actually asking for it.

I have stared at a lot of the evdev and related code, and can't find
anything that looks like what I want.  Am I just not seeing it, or am
I looking in the wrong place?


Thanks!


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
