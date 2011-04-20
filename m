From: Oliver Neukum <oneukum@suse.de>
Subject: Re: Linux Input Devices
Date: Wed, 20 Apr 2011 10:01:50 +0200
Message-ID: <201104201001.50463.oneukum@suse.de>
References: <BANLkTin0cpZdEZ9=C90jcjppmBn43jBrpg@mail.gmail.com> <BANLkTim7GmpS9ZqxMAQXk99i40R_Qcj=rg@mail.gmail.com> <BANLkTinBKXArNg0O7voFdQ-AZ0hYpLUBhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37313 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab1DTIAd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Apr 2011 04:00:33 -0400
In-Reply-To: <BANLkTinBKXArNg0O7voFdQ-AZ0hYpLUBhw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Khachik Shahzadyan <qwerity@gmail.com>
Cc: linux-input@vger.kernel.org

Am Mittwoch, 20. April 2011, 08:05:57 schrieb Khachik Shahzadyan:
> Hello!
> I found your email in a kernel sources and i think that i can seek help to you)
> I try to write a virtual joystick driver for my project, how can i do it?
> Can i create only a char device (/dev/input/js0)
> 
> with fops: {ioctl, write, read, open}
> 
> or i need to create something like joydev.c ?
> p.s. i have one application that must write moves to /dev/input/js0
> and other applications can read this events from it, and they does not
> understand that it's a virtual joystick!

There's the uinput subsystem for devices feeding back from user space
http://thiemonge.org/getting-started-with-uinput

	HTH
		Oliver
