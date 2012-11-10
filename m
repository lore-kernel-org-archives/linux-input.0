From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HIL: remove one goto
Date: Sat, 10 Nov 2012 00:47:49 -0800
Message-ID: <20121110084749.GC14761@core.coreip.homeip.net>
References: <2837529.xgu9k1gmUb@eto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:41319 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745Ab2KJIrx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Nov 2012 03:47:53 -0500
Content-Disposition: inline
In-Reply-To: <2837529.xgu9k1gmUb@eto>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-parisc@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Oct 31, 2012 at 08:24:34PM +0100, Rolf Eike Beer wrote:
> This goto is only used to skip the next instruction, which can easily be done
> without a goto.
> 
> Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

Applied, thank you Rolf.

-- 
Dmitry
