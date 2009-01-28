From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]reversed logic in disconnect testing of hiddev
Date: Wed, 28 Jan 2009 09:38:11 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0901280937320.5377@jikos.suse.cz>
References: <200901280930.16072.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:55820 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752755AbZA1IiN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 03:38:13 -0500
In-Reply-To: <200901280930.16072.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org

On Wed, 28 Jan 2009, Oliver Neukum wrote:

> The logic for testing for disconnection is reversed in an ioctl leading
> to false reports of disconnection.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> Tested-by: Folkert van Heusden <folkert@vanheusden.com>
> 
> this should go into the next rc of 2.6.29

Applied, thanks Oliver.

-- 
Jiri Kosina
SUSE Labs
