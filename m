From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Input: two merge window build fixes
Date: Thu, 19 May 2016 09:15:18 -0700
Message-ID: <20160519161518.GA38800@dtor-ws>
References: <1463665954-3898044-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33552 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbcESQP0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 May 2016 12:15:26 -0400
Content-Disposition: inline
In-Reply-To: <1463665954-3898044-1-git-send-email-arnd@arndb.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, May 19, 2016 at 03:52:23PM +0200, Arnd Bergmann wrote:
> Hi Dmitry,
> 
> I ran into two new build regressions in the input subsystem with
> today's linux-next, maybe you can apply these fixes before sending
> off the pull request for v4.7.
> 
> 	Arnd
> 
> [PATCH 1/2] Input: atmel captouch depends on i2c
> [PATCH 2/2] Input: migor-ts: mark PM functions as __maybe_unused

Applied both, thank you Arnd.

-- 
Dmitry
