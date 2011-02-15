From: Jordi Pujol <jordipujolp@gmail.com>
Subject: Re: [PATCH] usbmouse: random freeze/hangup; synchronize irq completion
Date: Tue, 15 Feb 2011 11:30:30 +0100
Message-ID: <201102151130.30998.jordipujolp@gmail.com>
References: <Pine.LNX.4.44L0.1102140957180.1913-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54008 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab1BOKaj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Feb 2011 05:30:39 -0500
In-Reply-To: <Pine.LNX.4.44L0.1102140957180.1913-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

A Dilluns 14 Febrer 2011 16:00:24, Alan Stern va escriure:
> 	It calls mutex_lock(), which can sleep, from within an URB
> 	completion routine, which runs with interrupts disabled.
> 
> 	It doesn't synchronize the completion _with_ anything else,
> 	i.e., it calls mutex_lock() in only one place.
this routine is synchronized with himself.
I said synchronize thinking about synchronized routines that are pieces of 
code scheduled to be executed only in a single thread simultaneously; 
therefore a new call to this routine can not be executed until a previous call 
has been completed.

> 
> Whatever is causing your problem, this is not the proper solution.
Yes, that this is not a patch to be included in the kernel, it's only a 
testing patch, but it solves the hangup. and so this probes that there is some 
kind of problem related to the urb update process; I think the problem should 
be external to this routine.

searching the web, some people has found problems like this, example:
- [ubuntu] Ubuntu 10.04 (Lucid Lynx) Random Freeze / Hang-up

Consider this as an idea to point out the problem and, if possible, someone 
more expert help to look for a good solution.

Jordi Pujol

Live never ending Tale
GNU/Linux Live forever!
http://livenet.selfip.com
