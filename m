From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042-io - Exclude mips platforms when
 allocating/deallocating IO regions.
Date: Sun, 26 Jan 2014 13:49:53 -0800
Message-ID: <20140126214952.GD18840@core.coreip.homeip.net>
References: <1390676514-30880-1-git-send-email-raghu.gandham@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:40713 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753370AbaAZVt4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Jan 2014 16:49:56 -0500
Content-Disposition: inline
In-Reply-To: <1390676514-30880-1-git-send-email-raghu.gandham@imgtec.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Raghu Gandham <raghu.gandham@imgtec.com>
Cc: aaro.koskinen@iki.fi, linux-input@vger.kernel.org, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org

Hi Raghu,

On Sat, Jan 25, 2014 at 11:01:54AM -0800, Raghu Gandham wrote:
> The standard IO regions are already reserved by the platform code on most MIPS
> devices(malta, cobalt, sni). The Commit 197a1e96c8be5b6005145af3a4c0e45e2d651444
> ("Input: i8042-io - fix up region handling on MIPS") introduced a bug on these
> MIPS platforms causing i8042 driver to fail when trying to reserve IO ports.
> Prior to the above mentioned commit request_region is skipped on MIPS but
> release_region is called.
> 
> This patch reverts commit 197a1e96c8be5b6005145af3a4c0e45e2d651444 and also
> avoids calling release_region for MIPS.

The problem is that IO regions are reserved on _most_, but not _all_
devices. MIPS should figure out what they want to do with i8042
registers and be consistent on all devices.

I do not want to apply this patch because it will be breaking devices
using the other configuration.

Thanks.

-- 
Dmitry
