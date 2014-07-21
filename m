From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: Add support for Wacom protocol 4 serial tablets
Date: Mon, 21 Jul 2014 10:56:54 -0700
Message-ID: <20140721175653.GB34322@core.coreip.homeip.net>
References: <1405867583-3321-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35689 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbaGUR46 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2014 13:56:58 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so9613024pdb.31
        for <linux-input@vger.kernel.org>; Mon, 21 Jul 2014 10:56:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1405867583-3321-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Julian Squires <julian@cipht.net>, linux-input@vger.kernel.org

On Sun, Jul 20, 2014 at 04:46:23PM +0200, Hans de Goede wrote:
> Recent version of xf86-input-wacom no longer support directly accessing
> serial tablets. Instead xf86-input-wacom now expects all wacom tablets to
> be driven by the kernel and to show up as evdev devices.
> 
> This has caused old serial Wacom tablets to stop working for people who still
> have such tablets. Julian Squires has written a serio input driver to fix this:
> https://github.com/tokenrove/wacom-serial-iv
> 
> This is a cleaned up version of this driver with improved Graphire support
> (I own an old Graphire myself).
> 
> Signed-off-by: Julian Squires <julian@cipht.net>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied (with minor edits - mostly formatting), thank you.

-- 
Dmitry
