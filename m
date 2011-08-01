From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Add Nintendo extension controller driver
Date: Mon, 1 Aug 2011 09:38:24 -0700
Message-ID: <20110801163823.GA3905@core.coreip.homeip.net>
References: <20110527081251.3992.27574.stgit@ponder>
 <CACxGe6vO=dtFmG4r5Da+T1EOknEofjEHqg_Jc_TCagju-no9mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:50409 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab1HAQia (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Aug 2011 12:38:30 -0400
Content-Disposition: inline
In-Reply-To: <CACxGe6vO=dtFmG4r5Da+T1EOknEofjEHqg_Jc_TCagju-no9mQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Fabien Marteau <fabien.marteau@armadeus.com>, Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Grant,

On Mon, Aug 01, 2011 at 05:04:37PM +0100, Grant Likely wrote:
> Hi Dmitry,
> 
> Any thoughts on this patch?  Can you send it on to Linus?
> 

I thought I responded earlier but apparently not...

The issue with the driver is that it pre-registers an input device with
a super-set of capabilities instead of waiting until the device is
properly identified and registering input device with the exact
capabilities.

The input policy is that device's stated capabilities should match the
physical device (within the constraints of input framework).

Thanks.

-- 
Dmitry
