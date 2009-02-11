From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: duplicate usb device ids
Date: Thu, 12 Feb 2009 00:11:31 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902120010260.31014@jikos.suse.cz>
References: <4993342E.4050008@nicce.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:47462 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbZBKXLe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 18:11:34 -0500
In-Reply-To: <4993342E.4050008@nicce.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Friedl <linux@nicce.at>, Remi Cattiau <remi@cattiau.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 11 Feb 2009, Michael Friedl wrote:

> I got a new CCD 800B barcode scanner, but it has the same device id like
> an other product from Tenx, which is on the ignore list for hid devices.
> 
> Found nothing about the old product so I report it here.
> If the old one get removed from the ignore list the bardcode scanner
> works perfect!

The device IDs were added by Remi, added to CC.

Remi, are these really different devices with the same VID/PID? You were 
stating that the devices are not HID-compilant, which contradicts what 
Michael is saying ...

Thanks,

-- 
Jiri Kosina
SUSE Labs
