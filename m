From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 0/5] HID: sony: Various fixes and improvements for
 the Sony driver
Date: Mon, 24 Feb 2014 23:31:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402241739350.1192@pobox.suse.cz>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39613 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664AbaBXWbf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Feb 2014 17:31:35 -0500
In-Reply-To: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, dh.herrmann@gmail.com

On Thu, 20 Feb 2014, Frank Praznik wrote:

> v2 of this patch set addresses the code review issues raised in v1 as well as
> adding a patch that fixes the styling of multi-line comments to conform to
> kernel coding standards, adds a check to protect against a potential
> out-of-bounds read in the Sixaxis battery code and adds a note in hidp/core.c
> that a device module now depends on the current behavior of the uniq string.

Queued in for-3.15/sony, thanks.

-- 
Jiri Kosina
SUSE Labs
