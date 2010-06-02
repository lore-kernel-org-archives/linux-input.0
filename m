From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846: Fix warning about output format
Date: Wed, 2 Jun 2010 00:39:56 -0700
Message-ID: <20100602073955.GH3713@core.coreip.homeip.net>
References: <1275461429-4838-1-git-send-email-weber@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38007 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab0FBHkA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 03:40:00 -0400
Content-Disposition: inline
In-Reply-To: <1275461429-4838-1-git-send-email-weber@corscience.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thomas Weber <weber@corscience.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 02, 2010 at 08:50:29AM +0200, Thomas Weber wrote:
> This patch fixes a compiler warning about wrong output format.
> 
> drivers/input/touchscreen/ads7846.c: In function 'ads7846_probe':
> drivers/input/touchscreen/ads7846.c:1167: warning: format '%ld' expects
> type 'long int', but argument 4 has type 'int'
> 
> Introduced by commit 067fb2f648543894ce775082c5636f4c32b99e4f ("Input:
> ads7846 - return error on regulator_get() failure").
> 
> The ERR_PTR returns a long so the variable err needs to be long.

No, int works just as well. I have a patch that simply fixes format
specification.

Thanks.

-- 
Dmitry
