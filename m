From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1 v2] DRM: fix radeon suspend/resume oops
Date: Thu, 13 Nov 2008 23:11:07 +0100
Message-ID: <491CA5FB.7060000@gmail.com>
References: <491CA495.7010007@gmail.com> <1226614196-17019-1-git-send-email-jirislaby@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:21835 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753991AbYKMWLP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Nov 2008 17:11:15 -0500
Received: by ey-out-2122.google.com with SMTP id 6so475417eyi.37
        for <linux-input@vger.kernel.org>; Thu, 13 Nov 2008 14:11:11 -0800 (PST)
In-Reply-To: <1226614196-17019-1-git-send-email-jirislaby@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andi Kleen <andi@firstfloor.org>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@sisk.pl>

Sorry, wrong patch, wrong destination.

On 11/13/2008 11:09 PM, Jiri Slaby wrote:
> me wrote:
>> As the accesses to the mmio member are not protected by anything, they
>> seem to be racy with the open/clsoe anyways, setting this down there
>> too.
> 
> On the second though it should be protected. Updated patch below...

