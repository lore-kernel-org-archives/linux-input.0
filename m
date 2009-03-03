From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: lockdep and threaded IRQs (was: ...)
Date: Tue, 03 Mar 2009 08:45:42 +0100
Message-ID: <1236066342.18955.21.camel@twins>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	 <200903021440.58712.david-b@pacbell.net>
	 <1236034289.5330.1745.camel@laptop>
	 <200903021529.07894.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viefep17-int.chello.at ([62.179.121.37]:22586 "EHLO
	viefep17-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZCCHqM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Mar 2009 02:46:12 -0500
In-Reply-To: <200903021529.07894.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: dbrownell@users.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, dmitry.torokhov@gmail.com, sameo@openedhand.com

On Mon, 2009-03-02 at 15:29 -0800, David Brownell wrote:

> That patch did no such thing.  It added a BUG_ON(),
> which has nothing to do with removing IRQF_DISABLED.

http://lkml.org/lkml/2009/3/2/33


