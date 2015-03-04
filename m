From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH] HID: Kconfig: add USB_HID dependency to UC-LOGIC
Date: Wed, 04 Mar 2015 18:27:10 +0200
Message-ID: <54F7325E.6040704@gmail.com>
References: <1425486295-27283-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36445 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932631AbbCDQ1I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 11:27:08 -0500
In-Reply-To: <1425486295-27283-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 03/04/2015 06:24 PM, Benjamin Tissoires wrote:
> In commit 08177f4 (HID: uclogic: merge hid-huion driver in hid-uclogic)
> HID_HUION depends explicitely on USB_HID because it contained quite some
> USB-isms.
>
> Now that hid-uclogic is the new home of Huion tablets, we need to also
> add the dependency on USB_HID to this driver.
>
> Reported-by: Jiri Kosina <jkosina@suse.cz>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks, Benjamin, I wasn't fast enough.

Nick
