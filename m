From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers/input/keyboard: Move a dereference below a
	NULL test
Date: Sun, 30 Aug 2009 11:26:57 -0700
Message-ID: <20090830185928.613DB526EA5@mailhub.coreip.homeip.net>
References: <Pine.LNX.4.64.0908301117010.17060@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f204.google.com ([209.85.223.204]:50105 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbZH3S1B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Aug 2009 14:27:01 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0908301117010.17060@ask.diku.dk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Sun, Aug 30, 2009 at 11:18:13AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> If the NULL test is necessary, then the dereference should be moved below
> the NULL test.
> 

Applied, thank you Julia.

-- 
Dmitry
