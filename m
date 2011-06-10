From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 2/4] Input: Report defuzzed event once before filtering
 for devices with the INCONSISTENT_RATE property
Date: Fri, 10 Jun 2011 22:56:21 +0200
Message-ID: <20110610205621.GB5925@polaris.bitmath.org>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
 <1307735704-30673-3-git-send-email-derek.foreman@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b12.telenor.se ([62.127.194.21]:60284 "EHLO
	smtprelay-b12.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1FJUtg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 16:49:36 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-b12.telenor.se (Postfix) with ESMTP id 2CD9DEA71B
	for <linux-input@vger.kernel.org>; Fri, 10 Jun 2011 22:49:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307735704-30673-3-git-send-email-derek.foreman@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derek Foreman <derek.foreman@collabora.co.uk>
Cc: linux-input@vger.kernel.org

On Fri, Jun 10, 2011 at 03:55:02PM -0400, Derek Foreman wrote:
> Some input devices have a non-uniform report rate, which can make it difficult for a userspace driver to distinguish between a lack of motion or a lack of new input.
> 
> With this patch, if multiple duplicate events (after defuzz) are received in a row, the first duplicate is posted to userspace.

Every change is already propagated exactly once, which seems to amount
to the same thing your patch is aiming at. The evdev event signifies
the change itself (and when it occurs), so there is actually no
difference between the lack of motion and the lack of input.

Thanks, Henrik
