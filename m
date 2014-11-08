From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: elantech - provide a sysfs knob for
 crc_enabled
Date: Sat, 8 Nov 2014 00:25:40 -0800
Message-ID: <20141108082540.GD21475@dtor-ws>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
 <1409407846-15449-5-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62927 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbaKHIZp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Nov 2014 03:25:45 -0500
Received: by mail-ie0-f175.google.com with SMTP id y20so6454017ier.6
        for <linux-input@vger.kernel.org>; Sat, 08 Nov 2014 00:25:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1409407846-15449-5-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>

On Sat, Aug 30, 2014 at 04:10:45PM +0200, Ulrik De Bie wrote:
> The detection of crc_enabled is known to fail for Fujitsu H730. A DMI
> blacklist is added for that, but it can be expected that other laptops
> will pop up with this.
> 
> Here a sysfs knob is provided to alter the behaviour of crc_enabled.
> Writing 0 or 1 to it sets the variable to 0 or 1.
> Writing 2 to it will perform the detection and set the variable to 0
> or 1 according to the result of the detection.
> Reading it will show the crc_enabled variable (0 or 1).
> 

This is over-complicated, please make it straight bool (0/1). If one
wants to redetect it can be done by unbinding and rebinding driver
through sysfs (either at driver level or serio - drvctl attribute -
level).

Thanks.

-- 
Dmitry
