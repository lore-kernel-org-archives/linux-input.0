From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 001/002] linux-input:  bcm5974-0.31: fixed resource
	leak, removed work struct, device data struct introduced
Date: Wed, 02 Jul 2008 09:46:39 +0200
Message-ID: <1214984799.11086.6.camel@alnilam>
References: <1214653629.10495.11.camel@alnilam>
	 <20080701155925.a4c00a8e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:39109 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754329AbYGBHsV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jul 2008 03:48:21 -0400
In-Reply-To: <20080701155925.a4c00a8e.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, robfitz@273k.net, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, linux-usb@vger.kernel.org

On Tue, 2008-07-01 at 15:59 -0700, Andrew Morton wrote:
> > Subject: [PATCH 001/002] linux-input:  bcm5974-0.31: fixed resource leak, removed work struct, device data struct introduced
> 
> hm, I wonder where [002/002] went.

Thank you very much for your comments, I will return shortly with a new
version. I did not fully grasp, from reading
Documentation/SubmitPatches, how the numbering in the subject should
work; when I submit my new version in reply to your mail, should I
submit a complete patch against the vanilla kernel, with number 001/003?

Best Regards,
Henrik Rydberg


