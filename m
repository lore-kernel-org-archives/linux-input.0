From: Oliver Neukum <oneukum@suse.de>
Subject: Re: USB gamepad driver
Date: Mon, 18 Oct 2010 11:56:10 +0200
Message-ID: <201010181156.10592.oneukum@suse.de>
References: <7AFAEEFB-5CAD-4624-8C7E-4C5CF95C3C78@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:57852 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754531Ab0JRKqo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 06:46:44 -0400
In-Reply-To: <7AFAEEFB-5CAD-4624-8C7E-4C5CF95C3C78@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavlos Vinieratos <pvinis@gmail.com>, linux-input <linux-input@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

Am Montag, 18. Oktober 2010, 11:39:19 schrieben Sie:
> hello. I am writing a USB gamepad driver for Linux.
> I am having problems binding the driver to the device.
> should I try libusb?
> 
> all I want to do is be able to set the LEDs on the gamepad, and get the buttons pressed and print them. 

Generally for input devices it is best to write a kernel driver.
Unless the LEDs are on a completely separate interface,
you should write a kernel driver.

	HTH
		Oliver
