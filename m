From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] linux-2.6.32-tsc2008.patch
Date: Tue, 26 Jan 2010 01:38:40 -0800
Message-ID: <20100126093840.GB3480@core.coreip.homeip.net>
References: <68FBE0F3CE97264395875AC1C468F22C220789@mail03.cyberswitching.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:37360 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0AZJiq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Jan 2010 04:38:46 -0500
Received: by pwi21 with SMTP id 21so2869960pwi.21
        for <linux-input@vger.kernel.org>; Tue, 26 Jan 2010 01:38:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <68FBE0F3CE97264395875AC1C468F22C220789@mail03.cyberswitching.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Verges <chrisv@cyberswitching.com>
Cc: linux-input@vger.kernel.org

Hi Chris,

On Wed, Jan 20, 2010 at 11:39:58AM -0800, Chris Verges wrote:
> Hi Dmitry and fellow input driver developers,
> 
> Attached is an updated driver for the tsc2008.  This new driver
> completely replaces older versions, and has been confirmed to work on
> actual hardware.  The TSC2008 is an SPI touchscreen controller produced
> by Texas Instruments.
> 

This is another example of a driver that is very similar (not
surprisingly of course) to TSC2007. Could we look into turning TSC2007 a
core module with I2C and SPI transports? Mike Frysinger was doing
similar work for ad7879 if you'd like to take a look.

Thanks.

-- 
Dmitry
