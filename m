From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: wacom: Declare tool ID 0x84a as an Intuos eraser
Date: Mon, 14 Nov 2016 09:35:49 +0100
Message-ID: <20161114083549.GA21746@mail.corp.redhat.com>
References: <20161111230552.4221-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755183AbcKNIfy (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Nov 2016 03:35:54 -0500
Content-Disposition: inline
In-Reply-To: <20161111230552.4221-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Nov 11 2016 or thereabouts, Jason Gerecke wrote:
> The eraser end of the 8K pen available for the MobileStudio Pro has a tool
> ID of 0x84a. The 'wacom_intuos_get_tool_type' function does not currently
> recognize this ID, causing it to return BTN_TOOL_PEN rather than
> BTN_TOOL_RUBBER. This does not cause a problem for the MobileStudio Pro
> since, as a HID_GENERIC device, the driver relies on the state of the
> HID_DG_INVERT usage instead. It would, however, cause problems if the pen
> is used with devices that use the traditional 'wacom_intuos_irq' codepath
> instead.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

