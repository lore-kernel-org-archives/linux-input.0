From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] new driver for SGI volume buttons
Date: Thu, 17 Jul 2008 12:05:11 -0400
Message-ID: <20080717120337.ZZRA012@mailhub.coreip.homeip.net>
References: <20080715110436.7E8F2C312F@solo.franken.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.241]:50004 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757393AbYGQQFP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jul 2008 12:05:15 -0400
Received: by hs-out-0708.google.com with SMTP id 4so1698757hsl.5
        for <linux-input@vger.kernel.org>; Thu, 17 Jul 2008 09:05:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080715110436.7E8F2C312F@solo.franken.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-input@vger.kernel.org

On Tue, Jul 15, 2008 at 01:04:36PM +0200, Thomas Bogendoerfer wrote:
> This driver adds support for the volume buttons on the front of every
> SGI Indy and O2 workstation.

Looks very nice. Do you think we could pass a pointer to
button_status() in device's platform data and get rid of ifdefs
altogether?

Thanks.

-- 
Dmitry
