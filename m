From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] Drivers: hid: Makefile: Cleaned up Makefile
Date: Mon, 15 Nov 2010 15:58:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011151557510.7420@pobox.suse.cz>
References: <1289141188-1447-1-git-send-email-tdent48227@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:41039 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435Ab0KOO6K (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Nov 2010 09:58:10 -0500
In-Reply-To: <1289141188-1447-1-git-send-email-tdent48227@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tracey Dent <tdent48227@gmail.com>
Cc: dmitry.torokhov@gmail.com, chatty@enac.fr, spbnick@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 7 Nov 2010, Tracey Dent wrote:

> Changed Makefile to use <modules>-y instead of <modules>-objs because 
> -objs is deprecated and should now be switched. According to 
> (documentation/kbuild/makefiles.txt).

Actually, where exactly does this file document it?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
