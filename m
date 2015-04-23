From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4] Input: set INPUT_PROP_POINTING_STICK in hid-lenovo
Date: Thu, 23 Apr 2015 10:28:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1504231027490.3695@pobox.suse.cz>
References: <1429006197.2676.2@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40070 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756098AbbDWI2f (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Apr 2015 04:28:35 -0400
In-Reply-To: <1429006197.2676.2@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andreas Fleig <andreasfleig@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Tue, 14 Apr 2015, Andreas Fleig wrote:

> Set flags INPUT_PROP_POINTER and INPUT_PROP_POINTING_STICK for the
> trackpoint integrated in Lenovo USB and Bluetooth keyboards. Libinput checks
> these flags to enable features such as middle-button-scrolling by default.
> 
> Signed-off-by: Andreas Fleig <andreasfleig@gmail.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Jiri Kosina <jkosina@suse.cz>

Andreas,

your patch has been severely damaged by your mail client. I have fixed 
everything by hand for now and applied the patch to for-4.2/lenovo branch, 
but please fix your workflow for your future submissions.

Thanks,

-- 
Jiri Kosina
SUSE Labs
