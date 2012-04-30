From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3] hid: Enable report fixup on rebind
Date: Mon, 30 Apr 2012 14:06:57 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204301405260.1856@pobox.suse.cz>
References: <1335097300-11881-1-git-send-email-rydberg@euromail.se> <alpine.LNX.2.00.1204222325380.1856@pobox.suse.cz> <4F9D5F43.4000502@gmail.com> <20120430120641.GA3111@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39293 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441Ab2D3MG7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 08:06:59 -0400
In-Reply-To: <20120430120641.GA3111@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 30 Apr 2012, Henrik Rydberg wrote:

> > Regarding the code, could it be the time to fix naming of report
> > descriptor-handling functions to improve distinction from report-handling
> > ones? I'm attaching a patch applying on top of Henrik's changes which should
> > illustrate the proposal.
> 
> The changes you propose force changes to out-of-tree-drivers, without
> any obvious benefit. 

I agree that *_parse_rdesc() would be much better than *_parse_report() 
(we have been having this slight misnomer in the HID code since ever).

I wouldn't care too much about out-of-tree drivers, they have to adapt 
gradually to our random HID API changes anyway.

Thanks to both of you,

-- 
Jiri Kosina
SUSE Labs
