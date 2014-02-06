From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input synaptics-rmi4: PDT scan cleanup
Date: Wed, 5 Feb 2014 17:13:21 -0800
Message-ID: <20140206011321.GB27770@core.coreip.homeip.net>
References: <1391563997-11155-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34972 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935AbaBFBNZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:13:25 -0500
Received: by mail-pa0-f50.google.com with SMTP id kp14so1044662pab.37
        for <linux-input@vger.kernel.org>; Wed, 05 Feb 2014 17:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1391563997-11155-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

On Tue, Feb 04, 2014 at 05:33:17PM -0800, Christopher Heiny wrote:
> This builds on Dmitry's patch of 2014-01-27, with some bug fixes.  It's been
> tested on a Nexus 4.
> 
> Eliminates copy-paste code that handled scans of the Page Descriptor
> Table, replacing it with a single PDT scan routine that invokes a 
> callback function.
> 
> Updated the copyright dates and eliminate C++ style comments while we
> were at it.
> 
> Signed-off-by: Christopher Heiny <cheiny@synaptics.com>

Applied, thank you.

-- 
Dmitry
