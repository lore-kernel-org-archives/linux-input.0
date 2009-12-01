From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [PATCH v2 1/2] Input: gpio-keys - allow platform to
 specify exact irq flags
Date: Tue, 1 Dec 2009 10:11:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0912011011390.2983-100000@iolanthe.rowland.org>
References: <873a3v2eij.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34362 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753567AbZLAPLp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Dec 2009 10:11:45 -0500
In-Reply-To: <873a3v2eij.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pm@lists.linux-foundation.org, Mika Westerberg <mika.westerberg@iki.fi>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 1 Dec 2009, Ferenc Wagner wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > Runtime PM is not well suited for this purpose.
> 
> So the question is: is there some other PM framework which would be a
> good fit for this "forced manual selective suspend" use case?

None that I know of.

Alan Stern

