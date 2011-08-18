From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch 2/2 -next] hid-lg4ff: add a kfree() to an error path
Date: Thu, 18 Aug 2011 19:24:47 +0300
Message-ID: <20110818162447.GE21927@shale.localdomain>
References: <20110818134343.GB21927@shale.localdomain>
 <CAMvewQJigdY81gPrpndqV=FxN+cEeif4NkzSbBZKCO4z3guQew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57434 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755428Ab1HRQ1B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Aug 2011 12:27:01 -0400
Content-Disposition: inline
In-Reply-To: <CAMvewQJigdY81gPrpndqV=FxN+cEeif4NkzSbBZKCO4z3guQew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zic Rim <zicrim@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, kernel-janitors@vger.kernel.org

On Thu, Aug 18, 2011 at 07:59:32PM +0530, Zic Rim wrote:
> There is no leak here. If kzalloc fails , it means memory is not allocated.
> It is wrong to free something that is not allocated .

No.  The entry allocation succeeded and the entry->device_id
allocation failed.  Look again.

regards,
dan carpenter

