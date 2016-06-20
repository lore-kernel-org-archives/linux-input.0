From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: thingm: simplify debug output code
Date: Mon, 20 Jun 2016 11:27:29 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1606201127130.6874@cbobk.fhfr.pm>
References: <fafa8814-1e61-1560-c44d-6c31c576fec2@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55111 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752053AbcFTKOL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2016 06:14:11 -0400
In-Reply-To: <fafa8814-1e61-1560-c44d-6c31c576fec2@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Sun, 19 Jun 2016, Heiner Kallweit wrote:

> Kernel printf format %*ph allows to print small buffers up to 64 bytes.
> Make use of it to simplify the debug output code.

Applied to hid.git#for-4.8/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

