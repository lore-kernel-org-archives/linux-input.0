From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-lg4ff add support for new version of DFGT
 wheel
Date: Sat, 27 Apr 2013 21:11:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304272111170.17743@pobox.suse.cz>
References: <1367026194-2103-1-git-send-email-simon@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40532 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752894Ab3D0TLb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Apr 2013 15:11:31 -0400
In-Reply-To: <1367026194-2103-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, djovic78@gmail.com, madcatxster@gmail.com

On Fri, 26 Apr 2013, Simon Wood wrote:

> It has been reported that there is a new version (different USB rev)
> of the Logitech DFGT in the 'wild'.
> 
> This patch allows the kernel to recognise this wheel and send it the
> command to enter native mode.
> 
> Reported-by: "Denis Jovic" <djovic78@gmail.com>
> Signed-off-by: Simon Wood <simon@mungewell.org>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
