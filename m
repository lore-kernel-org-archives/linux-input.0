From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] patches for Innomedia INNEX GENESIS/ATARI adapter
Date: Mon, 19 Dec 2016 11:45:07 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1612191144240.19203@cbobk.fhfr.pm>
References: <20161216213130.19303-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48964 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753500AbcLSKpJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Dec 2016 05:45:09 -0500
In-Reply-To: <20161216213130.19303-1-tk@the-tk.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 16 Dec 2016, Tomasz Kramkowski wrote:

> This is a couple of patches which fix issues with the (1292:4745)
> Innomedia INNEX GENESIS/ATARI controller USB adapter. I've personally
> tested these patches against the master of the hid tree.
> 
> Patch 2 depends on patch 1.
> 
> I wasn't sure if adding a new config symbol meant I needed to add it to
> some default config so I left that alone.
> 
> Hopefully I didn't screw anything up.

All looks good, except I'd probably squash both the patches into one 'add 
adapter support', as I don't really see a value with separating this into 
two patches. If you agree, I can do that myself and apply.

Thanks,

-- 
Jiri Kosina
SUSE Labs

