From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/2] HID: wacom: set ABS_MISC bit for Intuos4 WL
Date: Mon, 27 Feb 2012 15:30:34 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202271530210.31150@pobox.suse.cz>
References: <1330091269-8765-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47119 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab2B0Oaf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Feb 2012 09:30:35 -0500
In-Reply-To: <1330091269-8765-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: pinglinux@gmail.com, chris@cnpbagwell.com, linuxwacom-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, 24 Feb 2012, Przemo Firszt wrote:

> ABS_MISC has to be set for Intuos4 WL otherwise xorg driver won't use proper
> protocol and the information about tool id and serial is lost.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
