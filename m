From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] fix crash in synaptics_module_init()
Date: Thu, 31 Mar 2011 00:06:46 -0700
Message-ID: <20110331070646.GA12711@core.coreip.homeip.net>
References: <4D9370F202000078000392A9@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55971 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab1CaHGu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Mar 2011 03:06:50 -0400
Received: by iwn34 with SMTP id 34so2083434iwn.19
        for <linux-input@vger.kernel.org>; Thu, 31 Mar 2011 00:06:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D9370F202000078000392A9@vpn.id2.novell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-input@vger.kernel.org, stable@kernel.org, dilinger@queued.net

On Wed, Mar 30, 2011 at 05:05:38PM +0100, Jan Beulich wrote:
> 'struct dmi_system_id' arrays must always have a terminator to keep
> dmi_check_system() from looking at data (and possibly crashing) it
> isn't supposed to look at.
> 
> The issue went unnoticed until ef8313bb1a22e7d2125d9d758aa8a81f1de91d81,
> but was introduced about a year earlier with
> 7705d548cbe33f18ea7713b9a07aa11047aaeca4 (which also similarly changed
> lifebook.c, but the problem there got eliminated shortly afterwards).
> 
> The first hunk therefore is a stable candidate back to 2.6.33, while
> the full change is needed only on 2.6.38.
> 

Applied, thanks Jan.

-- 
Dmitry
