From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: IS_INPUT_APPLICATION and tablets
Date: Thu, 21 May 2009 11:05:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0905211105010.13917@wotan.suse.de>
References: <33210D89-9534-4B12-B7C3-E7FAEA3C4A5D@enac.fr> <alpine.LNX.2.00.0905211038350.13917@wotan.suse.de> <4A1514CE.6010600@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54690 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820AbZEUJFv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 May 2009 05:05:51 -0400
In-Reply-To: <4A1514CE.6010600@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>, jirislaby@gmail.com, Greg KH <greg@kroah.com>, linux-input@vger.kernel.org

On Thu, 21 May 2009, Rafi Rubin wrote:

> Is there any downside to letting hiddev to cover all devices, even those 
> that are supported by the hid system?

That's one of the possible solutions, yes. (we could either make that 
behavior configurable, with default settings to always create hiddev 
node, to preserve backwards compatibility with userspace).

-- 
Jiri Kosina
SUSE Labs
