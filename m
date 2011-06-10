From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/4] Input: New property to indicate that a device's
 report rate may not be consistent
Date: Fri, 10 Jun 2011 22:49:35 +0200
Message-ID: <20110610204935.GA5925@polaris.bitmath.org>
References: <1307735704-30673-1-git-send-email-derek.foreman@collabora.co.uk>
 <1307735704-30673-2-git-send-email-derek.foreman@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:51039 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1FJUm7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2011 16:42:59 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id C1CABE8DC4
	for <linux-input@vger.kernel.org>; Fri, 10 Jun 2011 22:42:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307735704-30673-2-git-send-email-derek.foreman@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Derek Foreman <derek.foreman@collabora.co.uk>
Cc: linux-input@vger.kernel.org

Hi Derek,

> Some (multi-touch) devices are capable of reporting 1 finger at 80Hz or 2 fingers at 40Hz.
> This property allows a user space driver to know that this can happen, and perform extrapolation to present the illusion of fluidity.

Evdev events contain a timestamp, so any rate or rate variation can
easily be detected in userspace.

Thanks,
Henrik
