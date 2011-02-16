From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] HID: add IRTOUCH infrared USB to hid_have_special_driver
Date: Wed, 16 Feb 2011 18:54:54 +0100
Message-ID: <AANLkTinbHq7yusE1nk-FCmf76foUcpUeU37wpHg-tsUN@mail.gmail.com>
References: <1297780428-3805-1-git-send-email-benjamin.tissoires@enac.fr>
	<alpine.LNX.2.00.1102160003420.2160@pobox.suse.cz>
	<AANLkTi=QF-9QtGK8V795R9ZO4-c6sQ8MSTW+JMxwd2+d@mail.gmail.com>
	<alpine.LNX.2.00.1102161837140.2160@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58871 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab1BPRy4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Feb 2011 12:54:56 -0500
In-Reply-To: <alpine.LNX.2.00.1102161837140.2160@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 16, 2011 at 18:38, Jiri Kosina <jkosina@suse.cz> wrote:
> On Wed, 16 Feb 2011, Benjamin Tissoires wrote:
>
>> Thanks for applying those two patches.
>> BTW I'm a little worried: apparently you applied this patch in the
>> branch upstream-fixes but you didn't applied "HID: hid-multitouch:
>> introduce IrTouch Infrared USB..." and it's parents in this branch....
>> I'm afraid this will broke compilation of the upstream branch
>> (USB_VENDOR_ID_IRTOUCHSYSTEMS and USB_DEVICE_ID_IRTOUCH_INFRARED_USB
>> are not defined).
>
> Hi,
>
> yes, I pushed the patch to wrong remote branch yesterday, but apparently
> sync to git.kernel.org in which I fixed it hasn't made it yet for some
> reason.
>
> Sorry for the noise,

No problem, and after all it was my fault at the beginning ;)

Thanks for taking care of this.

Cheers,
Benjamin
