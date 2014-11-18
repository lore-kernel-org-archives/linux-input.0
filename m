From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: print the correct data in dbg msg
Date: Tue, 18 Nov 2014 22:11:12 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411182209320.4454@pobox.suse.cz>
References: <1416149143-25703-1-git-send-email-borneo.antonio@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38612 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805AbaKRVLH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 16:11:07 -0500
In-Reply-To: <1416149143-25703-1-git-send-email-borneo.antonio@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Borneo <borneo.antonio@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

On Sun, 16 Nov 2014, Antonio Borneo wrote:

> From: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> 
> Report is received in "buffer"; fix the following i2c_hid_dbg()
> to dump data from the correct pointer.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> [Antonio Borneo: cleanup and rebase to v3.17]
> Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>

Added Benjamin's Reviewed-by and applied, thanks.

-- 
Jiri Kosina
SUSE Labs
