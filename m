From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH 2/2] Report In Range event according to the spec
Date: Fri, 09 Jan 2015 01:03:09 +0100
Message-ID: <1420761789.24031.10.camel@hadess.net>
References: <1420747603-22545-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53875 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754299AbbAIAEX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 19:04:23 -0500
In-Reply-To: <1420747603-22545-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Thu, 2015-01-08 at 12:06 -0800, Ping Cheng wrote:
> Some Citniq and Intuos tablets report In Range event. This event

Cintiq.

> is sent before valid data is reported when tool enters proximity;
> or before out of proximity event is reported when tool exits.
> 
> While erntering proximity, In Range means a pen is detected. This

entering.

> information can be used for palm/touch rejection on both pen and
> touch enabled devices. While exiting, it means the tool has
> reached its maximum detectable distance.

