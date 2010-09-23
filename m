From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: for best practices, return -ENOMEM instead of -1
 when returning on mem allocation errors
Date: Thu, 23 Sep 2010 08:44:07 -0700
Message-ID: <20100923154407.GA17807@core.coreip.homeip.net>
References: <1285251245.2127.4.camel@cowboy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35916 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046Ab0IWPoQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Sep 2010 11:44:16 -0400
Content-Disposition: inline
In-Reply-To: <1285251245.2127.4.camel@cowboy>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Davidlohr Bueso <dave@gnu.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Thu, Sep 23, 2010 at 10:14:05AM -0400, Davidlohr Bueso wrote:
> input: for best practices, return -ENOMEM instead of -1 when returning on mem allocation errors.
> 
> Signed-off-by: Davidlohr Bueso <dave@gnu.org>

Applied, thank you Davidlohr.

FWIW there are more code in drivers/input/serio and drivers/input/mouse/
that return -1 instead of a proper error codes.

-- 
Dmitry
