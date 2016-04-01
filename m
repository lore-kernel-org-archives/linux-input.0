From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: thingm: change driver to use RGB LED core
 extension
Date: Fri, 1 Apr 2016 11:40:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604011139170.16158@cbobk.fhfr.pm>
References: <56D749D2.80101@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44419 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbcDAJkH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Apr 2016 05:40:07 -0400
In-Reply-To: <56D749D2.80101@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2 Mar 2016, Heiner Kallweit wrote:

> Based on the proposed RGB LED core extension the thingm driver was
> changed to make use of this extension. It allows to simplify
> the code a lot. For now primary purpose of this patch is to facilitate
> testing of the RGB LED core extension.
> 
> I didn't find a way to split the patch into smaller parts as either
> you use the RGB LED extension or not. However this shouldn't be really
> an issue as the resulting code is relatively short and simple.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

This patch clearly depends on some LED subsystem API that's not currently 
merged. Please let me know once this changes so that we could proceed with 
this patch.

I'm putting it on hold for now.

-- 
Jiri Kosina
SUSE Labs

