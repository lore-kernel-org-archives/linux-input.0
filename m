From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] hid: sony: Corrections for the DualShock 4 HID
 descriptor
Date: Mon, 15 Sep 2014 13:53:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409151353330.5523@pobox.suse.cz>
References: <1410710199-14383-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35904 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbaIOLxx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 07:53:53 -0400
In-Reply-To: <1410710199-14383-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org

On Sun, 14 Sep 2014, Frank Praznik wrote:

> Fix a few minor issues in the HID descriptor:
>  - A 6 bit entry had a logical maximum of 255 when the largest it can be is 63.
>  - A logical max value was incorrectly being set to -1 instead of 255.
>  - Set the min/max of the gyroscopes to -8192/8191 as that is the range of
>    values which represent the true controller orientation.  Any values beyond
>    those extents are just noise.
> 
> Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

Both applied to for-3.18/sony. Thanks,

-- 
Jiri Kosina
SUSE Labs
