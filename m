From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2/2] Input: kxtj9: fix locking typo in kxtj9_set_poll()
Date: Tue, 19 Jul 2011 23:19:08 -0700
Message-ID: <20110720061908.GB28816@core.coreip.homeip.net>
References: <20110720053108.GE6445@shale.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51656 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab1GTGTN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 02:19:13 -0400
Received: by iwn6 with SMTP id 6so4692675iwn.19
        for <linux-input@vger.kernel.org>; Tue, 19 Jul 2011 23:19:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110720053108.GE6445@shale.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: Chris Hudson <chudson@kionix.com>, linux-input@vger.kernel.org

On Wed, Jul 20, 2011 at 08:31:08AM +0300, Dan Carpenter wrote:
> According to the comments we want to call mutex_lock() here instead
> of mutex_unlock().  That makes more sense.
> 

Applied both, thanks Dan.

-- 
Dmitry
