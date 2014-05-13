From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: rmi: fix duplicated argument to && or ||
Date: Tue, 13 May 2014 21:18:51 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1405132118200.16459@pobox.suse.cz>
References: <1400008501-7165-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37106 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbaEMTSz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 13 May 2014 15:18:55 -0400
In-Reply-To: <1400008501-7165-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 13 May 2014, Benjamin Tissoires wrote:

> This resulted from an unfortunate copy/paste.
> 
> Detected automagically by kbuild.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I have already fixed this in the tree after seeing Dan's email.

Thanks, good catch!

-- 
Jiri Kosina
SUSE Labs
