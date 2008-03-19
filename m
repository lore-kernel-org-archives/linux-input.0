From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Patch to add NOGET for DMI/Acomdata
Date: Thu, 20 Mar 2008 00:11:05 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803200010200.19269@twin.jikos.cz>
References: <20080319154331.c670489d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:36573 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639AbYCSXLk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Mar 2008 19:11:40 -0400
In-Reply-To: <20080319154331.c670489d.zaitcev@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-input@vger.kernel.org

On Wed, 19 Mar 2008, Pete Zaitcev wrote:

> This must be the weirdest failure yet. My external disk stops processing 
> the storage commands the moment it receives a GET_REPORT. The firmware 
> does not crash; if I do rmmod hid, then SET-INTERFACE restores normal 
> operations. Still, I cannot live without the keyboard when I want backup 
> my files. Adding the NOGET quirk fixes this problem for me.

Hi Pete,

uhm ... how does the GET_REPORT get delivered to the external disk? Does 
it have any interface that claims itself to be HID class?

Thanks,

-- 
Jiri Kosina
SUSE Labs

