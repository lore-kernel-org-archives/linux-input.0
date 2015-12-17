From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid-input: ignore the battery in OKLICK Laser BTmouse
Date: Fri, 18 Dec 2015 00:11:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1512180011470.9922@cbobk.fhfr.pm>
References: <1450096946-1376-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48811 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbbLQXMB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Dec 2015 18:12:01 -0500
In-Reply-To: <1450096946-1376-1-git-send-email-patrakov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 14 Dec 2015, Alexander E. Patrakov wrote:

> This mouse, when asked about the battery, ceases to report movements and
> clicks. So just don't ask.
> 
> Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>

Applied to for-4.5/core branch, thanks.

-- 
Jiri Kosina
SUSE Labs

