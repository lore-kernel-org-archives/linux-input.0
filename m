From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] hid/apple: constify arrays of struct apple_key_translation
 and adjust users
Date: Wed, 18 Mar 2009 13:59:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0903181358540.12145@wotan.suse.de>
References: <49B19FF3.2000605@gmail.com> <1236398835-8211-1-git-send-email-paul@burly.ondioline.org> <1236398835-8211-2-git-send-email-paul@burly.ondioline.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:41552 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250AbZCRNII (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Mar 2009 09:08:08 -0400
In-Reply-To: <1236398835-8211-2-git-send-email-paul@burly.ondioline.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Collins <paul@burly.ondioline.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 7 Mar 2009, Paul Collins wrote:

> Mark arrays of struct apple_key_translation const so that they may be placed in
> .rodata, and adjust users to suit.
> 
> Signed-off-by: Paul Collins <paul@ondioline.org>

Applied, thanks Paul.

-- 
Jiri Kosina
SUSE Labs
