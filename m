From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] hid: migrate USB LED driver from usb misc to
 hid
Date: Fri, 17 Jun 2016 22:33:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172232180.6874@cbobk.fhfr.pm>
References: <a136c591-8c2f-983a-aa89-25c51fa3b806@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48298 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbcFQUdG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2016 16:33:06 -0400
In-Reply-To: <a136c591-8c2f-983a-aa89-25c51fa3b806@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, Linux USB Mailing List <linux-usb@vger.kernel.org>

On Fri, 17 Jun 2016, Heiner Kallweit wrote:

> This patch migrates the USB LED driver to the HID subsystem.
> Supported are Dream Cheeky Webmail Notifier / Friends Alert
> and Riso Kagaku Webmail Notifier.

I have dropped the mentions of this being specific to USB from the Kconfig 
help text as well, and applied. Thanks,

-- 
Jiri Kosina
SUSE Labs

