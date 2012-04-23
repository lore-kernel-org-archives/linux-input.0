From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 08:42:14 -0700
Message-ID: <4F957856.1070107@canonical.com>
References: <alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz> <4f95669e.a0e7d80a.2ef7.6710SMTPIN_ADDED@mx.google.com> <CAN+gG=EYXHegM+BTEuDvAT_cmvZCT5u38hY+Woe_No3V0rDfWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41473 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab2DWPmH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 11:42:07 -0400
In-Reply-To: <CAN+gG=EYXHegM+BTEuDvAT_cmvZCT5u38hY+Woe_No3V0rDfWA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Ming Lei <tom.leiming@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 04/23/2012 08:34 AM, Benjamin Tissoires wrote:
> The problem relies in the upper layers and not in the kernel: nobody
> took the time to code a X.org driver that handles true multitouch
> direct devices. You can eventually use the synaptics one, but you will
> have to deal with absolute/relative coordinates, and the last time I
> played with it, it was not convenient as I was not able to make GDM
> use the absolute coordinate system (I kow I should have patched the
> synaptics X.org driver).

X now supports direct multitouch devices using the X evdev driver. This
may be a bug in the X server.

-- Chase
