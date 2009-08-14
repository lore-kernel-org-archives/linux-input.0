From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Problem with Acer Bluetooth Optical Rechargeable Mouse
Date: Fri, 14 Aug 2009 13:08:18 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0908141306240.25797@wotan.suse.de>
References: <200908062247.29254.lamarque@gmail.com> <alpine.LNX.2.00.0908131343290.25797@wotan.suse.de> <200908132052.01012.lamarque@gmail.com> <200908132230.30833.lamarque@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48289 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754882AbZHNLIS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Aug 2009 07:08:18 -0400
In-Reply-To: <200908132230.30833.lamarque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lamarque Vieira Souza <lamarque@gmail.com>
Cc: linux-input@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 13 Aug 2009, Lamarque Vieira Souza wrote:

> 	Actually there is an error in the patch I sent in my last e-mail, this one 
> works (just one line change patch :-)). It was more simpler fix than I have 
> thought.

The debugging output was better, still it didn't contain enough 
information for me to find out what exactly is happening (probably too 
small buffer still?).

>From your patch I guess that there is a separate HID device in the system 
which only produces the confusing usages and nothing else, and is 
completely separate from the "normal" system mouse, right? I'd need this 
described in the patch changelog.

-- 
Jiri Kosina
SUSE Labs
