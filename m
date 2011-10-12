From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Wed, 12 Oct 2011 15:26:21 +0100
Message-ID: <20111012142621.GA25803@srcf.ucam.org>
References: <20111012135439.GA25266@srcf.ucam.org>
 <Pine.LNX.4.44L0.1110121014550.2093-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:36528 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537Ab1JLO0Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 10:26:25 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1110121014550.2093-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

Sorry, yes, you're right. In that case it's probably working for me 
because the keyboard is another interface on the same device, so the 
wakeup bit is being set from there.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
