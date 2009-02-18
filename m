From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]fix USB HID devices after STD with autosuspend
Date: Wed, 18 Feb 2009 11:48:07 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0902181147420.18874@jikos.suse.cz>
References: <200902180946.15593.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:57918 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751660AbZBRKsK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2009 05:48:10 -0500
In-Reply-To: <200902180946.15593.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>, Laurent Riffard <laurent.riffard@free.fr>

On Wed, 18 Feb 2009, Oliver Neukum wrote:

> This patch fixes a bug caused by reset_resume not changing the internal
> status flags for a device that is resumed via reset_resume. To do so the
> reset handlers, which correctly assume that a device is awake, can no longer
> do all the work of reset_resume handling.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.de>
> Tested-by: Laurent Riffard <laurent.riffard@free.fr>

Applied, thanks a lot Oliver.

-- 
Jiri Kosina
SUSE Labs
