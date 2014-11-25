From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2] hid-multitouch: Add quirk for VTL touch panels
Date: Tue, 25 Nov 2014 15:29:38 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1411251529300.23174@pobox.suse.cz>
References: <1416654127-2433-1-git-send-email-mathieu.magnaudet@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42188 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750852AbaKYO32 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Nov 2014 09:29:28 -0500
In-Reply-To: <1416654127-2433-1-git-send-email-mathieu.magnaudet@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mathieu Magnaudet <mathieu.magnaudet@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, 22 Nov 2014, Mathieu Magnaudet wrote:

> VTL panels do not switch to the multitouch mode until the input mode
> feature is read by the host. This should normally be done by
> usbhid, but it looks like an other bug prevents usbhid to properly
> retrieve the feature state. As a workaround, we force the reading of
> the feature in mt_set_input_mode for such devices.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
