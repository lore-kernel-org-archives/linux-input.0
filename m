From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/4] USB: HID: SRW-S1 Gaming Wheel Driver
Date: Mon, 28 Jan 2013 15:59:00 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1301281557040.23853@pobox.suse.cz>
References: <1359095687-13398-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39862 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab3A1O7M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jan 2013 09:59:12 -0500
In-Reply-To: <1359095687-13398-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rosegardener@freeode.co.uk

On Thu, 24 Jan 2013, Simon Wood wrote:

> From: simon <simon@simon-virtual-machine.(none)>
> 
> Add support the SRW-S1 by patching HID descriptor to read axis
> as Generic Desktop X, Y and Z (rather than Usage page being
> 'Simulation').
> 
> Signed-off-by: Simon Wood <simon@mungewell.org>
> tested-by: John Murphy <rosegardener@freeode.co.uk>

Hi Simon,

thanks for the patch.

> 
> ---
>  drivers/hid/Kconfig     |    6 +++++
>  drivers/hid/Makefile    |    1 +
>  drivers/hid/hid-core.c  |    1 +
>  drivers/hid/hid-ids.h   |    3 +++
>  drivers/hid/hid-srws1.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++

Is hid-srws1 really the best name? My understanding is that the vendor is 
called Steelseries, and we mostly stick to calling the drivers according 
to the device vendors (and grouping the quirks accordingly).

So how about hid-steelseries? 

-- 
Jiri Kosina
SUSE Labs
