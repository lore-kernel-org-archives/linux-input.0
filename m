From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH] hid: usbhid: add quirk for SB arena headset v2
Date: Mon, 05 Nov 2012 15:32:25 -0600
Message-ID: <50983069.5080404@canonical.com>
References: <1352145945-8035-1-git-send-email-chris.j.arges@canonical.com> <alpine.LNX.2.00.1211052117210.24253@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:44671 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499Ab2KEVcM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 16:32:12 -0500
In-Reply-To: <alpine.LNX.2.00.1211052117210.24253@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org

On 11/05/2012 02:18 PM, Jiri Kosina wrote:
> On Mon, 5 Nov 2012, Chris J Arges wrote:
> 
>> When an SB Arena USB headset is plugged in, it registers the volume
>> keys on the headset as a keyboard and continually sends events causing
>> issues with normal keyboard input. This quirk disables the volume keys.
> 
> I don't know how the device looks like, but wouldn't it make more sense to 
> actually remap the bogus keys it's sending to produce KEY_VOLUMEUP and 
> KEY_VOLUMEDOWN?
> 

Yes, if I can track this hardware down or get data I'll fix it like
this. This happened to be a do-no harm fix for the following bug:
https://bugs.launchpad.net/ubuntu/+source/xorg-server/+bug/1007575

Thanks for the feedback.
--chris j arges
