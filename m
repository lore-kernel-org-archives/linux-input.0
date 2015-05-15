From: "Junge, Terry" <Terry.Junge@plantronics.com>
Subject: RE: [PATCH] HID: hid-plantronics: Update to map volume up/down
 controls
Date: Fri, 15 May 2015 00:59:22 +0000
Message-ID: <e353463cc3484c53a994b7a20536099f@usscmb04.plt.plantronics.com>
References: <1428779862-31930-1-git-send-email-terry.junge@plantronics.com>
 <alpine.LNX.2.00.1504231017320.3695@pobox.suse.cz>
 <539921aa7dd24d3c801f8d0bfb9ef438@usscmb04.plt.plantronics.com>
 <alpine.LNX.2.00.1505111013360.8186@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail4.plantronics.com ([198.231.10.50]:55549 "EHLO
	mail4.plantronics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423318AbbEOA7i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 14 May 2015 20:59:38 -0400
In-Reply-To: <alpine.LNX.2.00.1505111013360.8186@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Mon, May 11, 2015, Kosina, Jiri wrote:

 [ ... snip ... ]
> I'd like to defer that decision to you. However the patch you submitted
> isn't really consistent; therefore it needs to be modified one way or
> another anyway.
>
> Basically the two options I am fine with, are:
>
> - keep the USB-isms there, but put an explicit CONFIG_USB dependency into
>   the Kconfig and explain in changelog of the patch why this is a good
>   thing to do (like the paragraph you wrote above). If you, as a HW
>   vendor, are certain that there will never ever be any device using
>   non-USB transport, then this is a viable option (not nice, but I can
>   understand the reasons for that)
>
> - fall back to PID-based device identification

I will fall back to using PID to identify multi-HID interface devices.
I will be submitting a v2 patch set tomorrow.

Thanks again for your time,
Terry Junge
Plantronics


________________________________

CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.

For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.
