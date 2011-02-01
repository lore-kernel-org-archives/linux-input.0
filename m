From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3] Input: add support for DragonRise PID 0011 gamepad
Date: Tue, 1 Feb 2011 11:03:56 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1102011103480.5725@pobox.suse.cz>
References: <1296215454-2586-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:58762 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838Ab1BAKD6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Feb 2011 05:03:58 -0500
In-Reply-To: <1296215454-2586-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>

On Fri, 28 Jan 2011, Nikolai Kondrashov wrote:

> These three patches add support for DragonRise Inc. USB PID 0x0011 gamepad.
> This version is based on recent Linus' master (namely bffb276) and is using
> single file for both generic and force feedback support.
> 
> [PATCH 1/3] Input: rename hid-drff.c to hid-dr.c
> [PATCH 2/3] Input: add support for DragonRise PID 0011 gamepad
> [PATCH 3/3] Input: update dragonrise Kconfig description
> 
>  drivers/hid/Kconfig    |    7 +-
>  drivers/hid/Makefile   |    2 +-
>  drivers/hid/hid-core.c |    1 +
>  drivers/hid/hid-dr.c   |  312 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/hid/hid-drff.c |  197 ------------------------------
>  5 files changed, 320 insertions(+), 199 deletions(-)

Applied, thanks Nikolai.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
