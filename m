From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch 0/2] Make the touchpad on the MSI Wind netbook work
Date: Wed, 11 Feb 2009 13:17:02 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0902111315360.22097@twin.jikos.cz>
References: <20090204191540.2d6abd87@infradead.org> <20090211014506.GA5075@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:46916 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754820AbZBKMRV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Feb 2009 07:17:21 -0500
In-Reply-To: <20090211014506.GA5075@srcf.ucam.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>

On Wed, 11 Feb 2009, Matthew Garrett wrote:

> https://lists.ubuntu.com/archives/kernel-team/2009-February/004335.html 
> be related? It seems quite plausible that we want to do this on all 
> hardware.

Actually I have also hit this on several machines. Dmitry, I would propose 
to take Andy's patch (maybe even for 2.6.29?), it would save us a lot of 
bugreports in the future.

-- 
Jiri Kosina
SUSE Labs

