From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: keyboard: Staticise non-exported symbols
Date: Sun, 11 Dec 2011 23:45:47 -0800
Message-ID: <20111212074547.GC4682@core.coreip.homeip.net>
References: <1323394677.3740.2.camel@phoenix>
 <1323394752.3740.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49924 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1LLHpy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Dec 2011 02:45:54 -0500
Content-Disposition: inline
In-Reply-To: <1323394752.3740.3.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Michael Hennerich <hennerich@blackfin.uclinux.org>, Naveen Kumar G <naveen.gaddipati@stericsson.com>, Sundar Iyer <sundar.iyer@stericsson.com>, linux-input@vger.kernel.org

On Fri, Dec 09, 2011 at 09:39:12AM +0800, Axel Lin wrote:
> These symbols are not used outside it's driver so no need to
> make the symbol global.
> 

Applied, thank you Axel.

-- 
Dmitry
