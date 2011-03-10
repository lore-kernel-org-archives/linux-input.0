From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Keycode for "main hardware button" on slate?
Date: Thu, 10 Mar 2011 00:00:43 -0800
Message-ID: <20110310080043.GA9985@core.coreip.homeip.net>
References: <1299520075.18332.146.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab1CJIAt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 03:00:49 -0500
Received: by iwn34 with SMTP id 34so1282004iwn.19
        for <linux-input@vger.kernel.org>; Thu, 10 Mar 2011 00:00:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1299520075.18332.146.camel@novo.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Mon, Mar 07, 2011 at 05:47:54PM +0000, Bastien Nocera wrote:
> Heya,
> 
> I've installed Fedora 15 onto a WeTab slate, and it has 2 "hardware"
> buttons. One is power (already used to come in and out of suspend), and
> another one that I'd like to use to get the interface running on it to
> go back to its "home" screen.
> 
> Any ideas what KEY_* I should use for this functionality?
> 

Hmm, I am not sure. This will probably device specific, but I guess you
could use KEY_COMPUTER or KEY_HOMEPAGE for this. Not ideal, but should
do.

Thanks.

-- 
Dmitry
