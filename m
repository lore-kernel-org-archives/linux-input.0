From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] UBUNTU: [Upstream] Input: Add keyboard quirk for
	Samsung R59P/R60P/R61P laptops
Date: Thu, 10 Sep 2009 22:13:12 -0700
Message-ID: <20090911051312.GD23210@core.coreip.homeip.net>
References: <1252488035-20118-1-git-send-email-keng-yu.lin@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:51139 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZIKFNN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:13:13 -0400
Content-Disposition: inline
In-Reply-To: <1252488035-20118-1-git-send-email-keng-yu.lin@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Keng-Yu Lin <keng-yu.lin@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Keng-Yu,

On Wed, Sep 09, 2009 at 05:20:35PM +0800, Keng-Yu Lin wrote:
> OriginalAuthor: Moiseev Vladimir <cdb@linkycat.com>, Alexander Huhlaev <sancheolz@gmail.com>
> BugLink: http://bugs.launchpad.net/bugs/253874
> 
> Add quirk for Samsung R59P/R60P/R61P to make the hotkeys work
> 

I will not be accepting any more patches adding the force-release quirks
to atkbd, in .32 there will be a way to adjust the bitmap through sysfs.

Thanks.

-- 
Dmitry
