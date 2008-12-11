From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 2.6.28-rc7] hid: "default y" considered evil
Date: Thu, 11 Dec 2008 14:55:12 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0812111454450.21089@jikos.suse.cz>
References: <200812031301.11475.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:33214 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755802AbYLKNzO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Dec 2008 08:55:14 -0500
In-Reply-To: <200812031301.11475.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org

On Wed, 3 Dec 2008, David Brownell wrote:

> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Fix the obnoxious "default y" for all the "special" HID code,
> which forces folk with EMBEDDED defined to manually override
> that inappropriate default for almost 20 choices.  The general
> policy is against "default y"; it should apply here too.

Fixed up to reflect the current state of HID patch queue, and applied. 
Thanks.

-- 
Jiri Kosina
SUSE Labs
