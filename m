From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 1/4] HID: uclogic: Set quirks from inside the driver
Date: Wed, 25 Feb 2015 23:04:37 +0200
Message-ID: <54EE38E5.5090209@gmail.com>
References: <1424822730-14938-1-git-send-email-benjamin.tissoires@redhat.com> <1424822730-14938-2-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:43433 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbbBYVEo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 16:04:44 -0500
In-Reply-To: <1424822730-14938-2-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

On 02/25/2015 02:05 AM, Benjamin Tissoires wrote:
> Based on a patch from: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
>
> Most of the tablets handled by hid-uclogic already uses MULTI_INPUT.

*use

> Fot the ones which are not quirked in usbhid/hidquirks, they have a

*For

> custom report descriptor which contains only one report per HID
> interface. For those tablets HID_QUIRK_MULTI_INPUT is transparent.
>
> According to https://github.com/DIGImend/tablets, the only problematic
> tablet currently handled by hid-uclogic is the TWHA60 v3. This tablet
> presents different report descriptors from the ones currently quirked.
> This is not a problem per se, given that this tablet is not supported
> currently in this version (it needs the same command than a Huion to

*as a Huion

> start forwarding events).

Thanks, Benjamin. this will make further merges easier.
Regardless of the Grammar Nazi comments above (fixing is up to you):

Reviewed-by: Nikolai Kondrashov <spbnick@gmail.com>

Nick
