From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1 v2] HID: don't grab devices with no input
Date: Fri, 14 Nov 2008 12:02:27 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811141201450.19853@jikos.suse.cz>
References: <491CA495.7010007@gmail.com> <1226614221-17118-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:46435 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751492AbYKNLC2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Nov 2008 06:02:28 -0500
In-Reply-To: <1226614221-17118-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andi Kleen <andi@firstfloor.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 13 Nov 2008, Jiri Slaby wrote:

> Some devices have no input interrupt endpoint. These won't be handled
> by usbhid, but currently they are not refused and reside on hid bus.
> Perform this checking earlier so that we refuse to control such
> a device early enough (and not pass it to the hid bus at all).
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

As the patch is obviously correct(tm) :) I have queued it in my tree, but 
Andi, please still report back whether it fixes the issue you are seeing.

Thanks.

-- 
Jiri Kosina
SUSE Labs
