From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 01/10] modpost: add support for hid
Date: Thu, 5 Jun 2008 11:26:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0806051123300.10085@jikos.suse.cz>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:48399 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752439AbYFEJ0p (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Jun 2008 05:26:45 -0400
In-Reply-To: <1210931362-18422-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com

On Fri, 16 May 2008, Jiri Slaby wrote:

> Generate aliases for hid device modules to support autoloading.

Jiri,

I have rebased the patch series on top of current state of the queued 
patches in my tree and applied them to 'hidbus' branch of my tree. So you 
can base any further respins of the patches on the version you can find in 
this branch right now.

I have not yet pulled that branch into the branch that is pulled into -mm 
and linux-next, there are some things that I think still need sorting out 
-- I have sent you some feedback yesterday.

Thanks a lot,

-- 
Jiri Kosina
SUSE Labs
