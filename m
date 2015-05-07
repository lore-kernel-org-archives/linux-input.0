From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 0/5] Support for the Sony Motion Controller and other
 cleanups
Date: Thu, 7 May 2015 10:43:09 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505071043030.8186@pobox.suse.cz>
References: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48655 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbbEGInL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 04:43:11 -0400
In-Reply-To: <1430873253-11765-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input@vger.kernel.org, pavel@ucw.cz

On Tue, 5 May 2015, Frank Praznik wrote:

> This set of patches adds initial support for the Sony Motion Controller via
> cleaned-up initial patches from Pavel Machek, streamlines LED initialization
> and state updates, adds a comment to explain why the Sixaxis has so many axes
> and why they spill over into the multi-touch space and makes some general
> cosmetic corrections.
> 
> v2 fixes a bug in the output report initialization failure path, fixes an
> omitted pointer assignment and removes the global LED on the motion controller.

Applied to for-4.2/sony. Thanks,

-- 
Jiri Kosina
SUSE Labs
