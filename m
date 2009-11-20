From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ads7846 touchscreen: fix pressure
Date: Fri, 20 Nov 2009 10:25:28 -0800
Message-ID: <20091120182528.GB16447@core.coreip.homeip.net>
References: <20091120182238.GA1344@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:62123 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbZKTSZa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 13:25:30 -0500
Content-Disposition: inline
In-Reply-To: <20091120182238.GA1344@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

On Fri, Nov 20, 2009 at 07:22:39PM +0100, Pavel Machek wrote:
> 
> On Zaurus, pressure is reported inverted -- the lighter the pressure,
> the bigger numerical value. This should fix it.
> 

Thanks. Didn't you also have a bigger cleanup patch for ads7846?

-- 
Dmitry
