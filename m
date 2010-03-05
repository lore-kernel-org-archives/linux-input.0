From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] gamecon: fix off by one range check
Date: Fri, 5 Mar 2010 00:36:59 -0800
Message-ID: <20100305083658.GB20245@core.coreip.homeip.net>
References: <20100303070544.GB5086@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f217.google.com ([209.85.217.217]:60179 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab0CEIhG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Mar 2010 03:37:06 -0500
Content-Disposition: inline
In-Reply-To: <20100303070544.GB5086@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>, Scott Moreau <oreaus@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Wed, Mar 03, 2010 at 10:05:44AM +0300, Dan Carpenter wrote:
> It should be >= GC_MAX not > GC_MAX.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Applied, thank you Dan.

-- 
Dmitry
