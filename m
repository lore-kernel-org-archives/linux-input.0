From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usbmouse: random freeze/hangup; synchronize irq completion
Date: Mon, 14 Feb 2011 10:00:24 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1102140957180.1913-100000@iolanthe.rowland.org>
References: <201102140951.00866.jordipujolp@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55687 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755604Ab1BNPAZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Feb 2011 10:00:25 -0500
In-Reply-To: <201102140951.00866.jordipujolp@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jordi Pujol <jordipujolp@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Mon, 14 Feb 2011, Jordi Pujol wrote:

> Hello,
> 
> usbmouse: synchonize the irq completion for each urb.
> 
> Without this patch the mouse was a bit erratic and when
> using the mouse the system gets freezed/hangup randomly (one or two times a 
> day).

Your patch is no good, for quite a few reasons.  I'll state only two of 
them:

	It calls mutex_lock(), which can sleep, from within an URB
	completion routine, which runs with interrupts disabled.

	It doesn't synchronize the completion _with_ anything else,
	i.e., it calls mutex_lock() in only one place.

Whatever is causing your problem, this is not the proper solution.

Alan Stern

