From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Fix build failure in hiddev_ioctl with gcc 3.2
Date: Mon, 3 Mar 2008 11:36:01 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803031127530.15209@jikos.suse.cz>
References: <20080302231209.36e2c619@hyperion.delvare>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:33779 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753972AbYCCKgC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 3 Mar 2008 05:36:02 -0500
In-Reply-To: <20080302231209.36e2c619@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-input@vger.kernel.org, Alexander <pikachu@millennium.udm.ru>, bunk@kernel.org, linux-kernel@vger.kernel.org

On Sun, 2 Mar 2008, Jean Delvare wrote:

> Fix build failure in hiddev_ioctl with gcc 3.2:
> http://bugzilla.kernel.org/show_bug.cgi?id=10121
> The trick is to move the handling of ioctls which need to allocate
> memory to separate functions.

Hmm, I can't say I like doing these shuffles just because of gcc 3.2 
behvior ... but as there are apparently already other patches in Linus' 
tree which did just that, I will have to follow this precedent.

Thanks,

-- 
Jiri Kosina
SUSE Labs
