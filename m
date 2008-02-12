From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: event devices not released
Date: Tue, 12 Feb 2008 11:51:31 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802121151010.7699@twin.jikos.cz>
References: <47B043ED.3020309@slagter.name> <Pine.LNX.4.64.0802112245290.7699@twin.jikos.cz>
 <47B1626A.6000507@slagter.name>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:45536 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbYBLKvw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Feb 2008 05:51:52 -0500
In-Reply-To: <47B1626A.6000507@slagter.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: linux-input@vger.kernel.org

On Tue, 12 Feb 2008, Erik Slagter wrote:

> > this is very likely bug in HAL -- please see
> > https://bugzilla.novell.com/show_bug.cgi?id=344872
> Negative ;-)
> A few moments ago I rebooted with HAL disabled and without going into X. I
> unplugged the hub that has the mouse and keyboard attached and plugged it back
> in again, a few times. Once again every time higher event handlers were
> assigned.

That is OK. But you shouldn't run into the situation when you run out of 
the free evdev devices.

-- 
Jiri Kosina
