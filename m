From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: roccat: check cdev_add return values
Date: Tue, 18 Jun 2013 11:01:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1306181101150.6750@pobox.suse.cz>
References: <1371222997-4933-1-git-send-email-michael.rissi@dectris.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54364 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754325Ab3FRJBj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Jun 2013 05:01:39 -0400
In-Reply-To: <1371222997-4933-1-git-send-email-michael.rissi@dectris.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Rissi <michael.rissi@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Rissi <michael.rissi@dectris.com>

On Fri, 14 Jun 2013, Michael Rissi wrote:

> Return value of cdev_add in hid_roccat.c init was not checked.
> 
> Signed-off-by: Michael Rissi <michael.rissi@dectris.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
