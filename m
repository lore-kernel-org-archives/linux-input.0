From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/1] Support for CMedia CM6533 HID audio jack
 controls
Date: Thu, 21 Jan 2016 14:08:23 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601211405050.21446@cbobk.fhfr.pm>
References: <1451460904-7959-1-git-send-email-ben_chen@bizlinktech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43514 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759071AbcAUNI2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 08:08:28 -0500
In-Reply-To: <1451460904-7959-1-git-send-email-ben_chen@bizlinktech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Chen <ben_chen@bizlinktech.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, 30 Dec 2015, Ben Chen wrote:

> The C-Media CM6533 is a USB audio chip featuring it's jack detection capability.The device originates an interrupt transfer via HID interface each time when a jack event occurs.
> The purpose of this patch is to handle hid raw events to keep the operating system informed of user interactions.
> 
> Signed-off-by: Ben Chen <ben_chen@bizlinktech.com>
> ---
> Changes in v2:
> - The return type of input_configured callback has been changed from void to be int.
> 
>  drivers/hid/Kconfig      |   6 ++
>  drivers/hid/Makefile     |   1 +
>  drivers/hid/hid-cm6533.c | 168 +++++++++++++++++++++++++++++++++++++++++++++++

We usually name the drivers according to the vendor name. IOW, I'd suggest 
you rename the driver to hid-cmedia.

Thanks,

-- 
Jiri Kosina
SUSE Labs

