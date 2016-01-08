From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: core: add managed version of hid_hw_start
Date: Fri, 8 Jan 2016 10:51:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601081050520.3402@cbobk.fhfr.pm>
References: <568D26B0.9080301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54675 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbcAHJvg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 8 Jan 2016 04:51:36 -0500
In-Reply-To: <568D26B0.9080301@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 6 Jan 2016, Heiner Kallweit wrote:

> Most calls to hid_hw_stop are boilerplate code. The function comment
> states: "This is usually called from remove function or from probe
> when something failed and hid_hw_start was called already."
> 
> A managed version of hid_hw_start allows to avoid this boilerplate
> code in most cases (similar to the other devm_ functions). 
> hid_hw_stop is called automatically before the device is deleted.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Generally I agree with the idea, but I'll be merging this only together 
with patches that are converting drivers to actually use this API.

Thanks,

-- 
Jiri Kosina
SUSE Labs

