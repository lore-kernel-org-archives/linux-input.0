From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: core: remove phidgets from ignore list
Date: Thu, 7 May 2015 10:47:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505071047130.8186@pobox.suse.cz>
References: <1430944724-3980-1-git-send-email-sean@mess.org> <1430944724-3980-2-git-send-email-sean@mess.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48976 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbbEGIrs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 04:47:48 -0400
In-Reply-To: <1430944724-3980-2-git-send-email-sean@mess.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: linux-input@vger.kernel.org

On Wed, 6 May 2015, Sean Young wrote:

> Once upon a time there were kernel drivers for some of the phidgets devices,
> and for those kernel drivers to work the hid system needed exceptions. Now
> the kernel drivers are long since gone in favour of the user-space drivers
> which don't need the exceptions.

What are the user-space drivers based on? hidraw? libusb?

Also, it'd be nice to have more concrete pointers to the drivers at least 
in the changelog.

Thanks,

-- 
Jiri Kosina
SUSE Labs
