From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-lg4ff: Fix "undefined reference" build issue
 with CONFIG_USB disabled.
Date: Wed, 18 Feb 2015 23:52:56 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502182350290.28769@pobox.suse.cz>
References: <1424296173-22718-1-git-send-email-madcatxster@devoid-pointer.net> <ca6b7db304af2585db3e95a7d81311a0.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44311 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751833AbbBRWw6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 17:52:58 -0500
In-Reply-To: <ca6b7db304af2585db3e95a7d81311a0.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: =?ISO-8859-1?Q?=22Michal_Mal=C3=BD=22?= <madcatxster@devoid-pointer.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 18 Feb 2015, simon@mungewell.org wrote:

> > Fix "undefined reference" build issue with CONFIG_USB disabled.
> 
> Just a newbie question... for a family of devices (the wheels) which can
> only be attached via USB, wouldn't the better approach be to fix the
> dependancy?
> 
> Are there any other devices provided for by 'hid-logitech' which use any
> other transport (HID over Bluetooth or the like)?

Using only HID API (and let it call to the transport driver) is much 
cleaner way and helps a lot with avoiding code duplication, etc.

-- 
Jiri Kosina
SUSE Labs
