From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid-gfrm: Google Fiber TV Box remote controls
Date: Thu, 22 Oct 2015 11:00:32 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510221055030.21100@pobox.suse.cz>
References: <1445454286-134412-1-git-send-email-pgynther@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55651 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756487AbbJVJAd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Oct 2015 05:00:33 -0400
In-Reply-To: <1445454286-134412-1-git-send-email-pgynther@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petri Gynther <pgynther@google.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Wed, 21 Oct 2015, Petri Gynther wrote:

> Add HID driver for Google Fiber TV Box remote controls

I am not particularly happy with drvdata not being actually used "the 
usual way", i.e. to store a pointer, but apart from being unusual, I don't 
see a real issue with it.

Dmitry, as this depends on a patch queued in your tree, would you be okay 
with taking the patch with my signoff?

Thanks.

-- 
Jiri Kosina
SUSE Labs

