From: "Junge, Terry" <Terry.Junge@plantronics.com>
Subject: RE: [PATCH v2 1/2] HID: hid-plantronics: Update to map volume
 up/down controls
Date: Wed, 27 May 2015 22:37:52 +0000
Message-ID: <66d390f22fa1470d9362c6675d268718@usscmb04.plt.plantronics.com>
References: <1431736512-23161-1-git-send-email-terry.junge@plantronics.com>
 <alpine.LNX.2.00.1505251344260.13817@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail4.plantronics.com ([198.231.10.50]:49861 "EHLO
	mail4.plantronics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbbE0WiS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 18:38:18 -0400
In-Reply-To: <alpine.LNX.2.00.1505251344260.13817@pobox.suse.cz>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Jiri,

Thanks for the time. I sent the patch to myself before submitting and I
was able to git-am it without error. However, it seems that the mail server is
further mangling plain text email when it is sent to email addresses outside
plantronics.com.

Our IT folks are looking into the issue. I will resend once it is straightened out.

In the meantime, if you haven't deleted it, could you forward back just to me
the original patch email so we can see what type of damage occurred?

Thanks again,
Terry

-----Original Message-----
From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Jiri Kosina
Sent: Monday, May 25, 2015 4:45 AM
To: Junge, Terry
Cc: linux-input@vger.kernel.org
Subject: Re: [PATCH v2 1/2] HID: hid-plantronics: Update to map volume up/down controls

On Fri, 15 May 2015, Terry Junge wrote:

> Update Kconfig with enhanced help text for hid-plantronics driver.
>
> Update hid-plantronics.c to identify device type and correctly map
> either the vendor unique or consumer control volume up/down usages
> to KEY_VOLUMEUP and KEY_VOLUMEDOWN events. Unmapped usages are ignored
> to prevent core mapping of unknown usages to random mouse events.
>
> Patched against git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git
>
> Tested on ChromeBox/ChromeBook with various Plantronics devices.
>
> Signed-off-by: Terry Junge <terry.junge@plantronics.com>

The patch is whitespace-damaged and can't really be applied. Could you
please fix your mail setup and resubmit?

Thanks.

--
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

________________________________

CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.

For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.
