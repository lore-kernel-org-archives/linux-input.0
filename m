From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Declare tool ID 0x84a as an Intuos eraser
Date: Tue, 15 Nov 2016 12:15:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611151215210.29400@cbobk.fhfr.pm>
References: <20161111230552.4221-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752149AbcKOLPb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 15 Nov 2016 06:15:31 -0500
In-Reply-To: <20161111230552.4221-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, 11 Nov 2016, Jason Gerecke wrote:

> The eraser end of the 8K pen available for the MobileStudio Pro has a tool
> ID of 0x84a. The 'wacom_intuos_get_tool_type' function does not currently
> recognize this ID, causing it to return BTN_TOOL_PEN rather than
> BTN_TOOL_RUBBER. This does not cause a problem for the MobileStudio Pro
> since, as a HID_GENERIC device, the driver relies on the state of the
> HID_DG_INVERT usage instead. It would, however, cause problems if the pen
> is used with devices that use the traditional 'wacom_intuos_irq' codepath
> instead.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

