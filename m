From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] export hid.h and hidraw.h to userspace
Date: Tue, 8 Apr 2008 23:35:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0804082335430.26562@twin.jikos.cz>
References: <1207624936-16328-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:59568 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912AbYDHVgo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 8 Apr 2008 17:36:44 -0400
In-Reply-To: <1207624936-16328-1-git-send-email-vapier@gentoo.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, akpm@linux-foundation.org

On Mon, 7 Apr 2008, Mike Frysinger wrote:

> I have people whining about using these headers in userspace, and they have
> __KERNEL__ markings which implies they're supposed to be exported.  I also
> added the required linux/types.h include to hidraw.h since it uses the __u##
> kernel types.
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Hi Mike,

applied to my tree, thanks.

-- 
Jiri Kosina
SUSE Labs

