From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] HID: rmi: check for the existence of some optional
 queries before reading query 12
Date: Tue, 13 May 2014 16:41:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405131641010.16459@pobox.suse.cz>
References: <1399054456-4594-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57704 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933237AbaEMOlP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 May 2014 10:41:15 -0400
In-Reply-To: <1399054456-4594-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Christopher Heiny <cheiny@synaptics.com>

On Fri, 2 May 2014, Andrew Duggan wrote:

> The rmi4 spec defines some optional query registers in F11 which appear before
> query 12. This patch checks for the existence of some of the lesser used queries to
>  compute the location of query12 and all subsequent query registers.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
