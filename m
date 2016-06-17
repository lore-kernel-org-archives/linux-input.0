From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Fri, 17 Jun 2016 23:24:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606172315370.6874@cbobk.fhfr.pm>
References: <1466070357-5315-1-git-send-email-masaki.ota@jp.alps.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50828 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbcFQVYK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jun 2016 17:24:10 -0400
In-Reply-To: <1466070357-5315-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Masaki Ota <012nexus@gmail.com>
Cc: benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com

On Thu, 16 Jun 2016, Masaki Ota wrote:

> From Masaki Ota <masaki.ota@jp.alps.com>
> 
> <ChangeList>
> - Add hid-alps.c for Support Alps I2C HID Touchpad and Stick device.
> - Add hid-alps.txt to check this device spec.
> - Add Alps-JP vendor ID to hid-idh.h for support this device. 
> - To build this module, add Alps module definition to Makefile.

I have now applied this to hid.git#for-4.8/alps with the following 
remarks:

- the above is, again, not how usual kernel changelog looks like, so I 
  have slightly modified it

- struct u1_dev *priv is very internal to the driver, no need for 
  polluting global namespace with 'priv' symbol :) So I've marked it 
  static

- I previously asked for clearly documenting the fact that it can't happen 
  to have two physical devices connected to one system (as that'd break 
  the driver as-is), but I don't see that documented anywhere; please 
  submit a followup patch that'd explicitly be stating this in 
  documentation

Thanks,

-- 
Jiri Kosina
SUSE Labs

