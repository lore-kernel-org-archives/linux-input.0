From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to specify exact irq flags
Date: Tue, 01 Dec 2009 11:08:04 +0100
Message-ID: <873a3v2eij.fsf@tac.ki.iif.hu>
References: <Pine.LNX.4.44L0.0911301658240.4478-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:40840 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851AbZLAKIF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Dec 2009 05:08:05 -0500
In-Reply-To: <Pine.LNX.4.44L0.0911301658240.4478-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon, 30 Nov 2009 16:59:41 -0500 (EST)")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:

> Runtime PM is not well suited for this purpose.

So the question is: is there some other PM framework which would be a
good fit for this "forced manual selective suspend" use case?
-- 
Thanks,
Feri.
