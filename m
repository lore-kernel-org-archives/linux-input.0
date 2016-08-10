From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 1/2] HID: wacom: Add WACOM_DEVICETYPE_DIRECT for
 Cintiqs and similar
Date: Wed, 10 Aug 2016 11:45:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608101145340.22028@cbobk.fhfr.pm>
References: <20160711180711.17537-1-killertofu@gmail.com> <20160808190630.7641-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40950 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932926AbcHJSdo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Aug 2016 14:33:44 -0400
In-Reply-To: <20160808190630.7641-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 8 Aug 2016, Jason Gerecke wrote:

> "Direct" input devices like Cintiqs and Tablet PCs set the INPUT_PROP_DIRECT
> property to notify userspace that the sensor and screen are overlaid. This
> information can also be useful elsewhere within the kernel driver, however,
> so we introduce a new WACOM_DEVICETYPE_DIRECT that signals this to other
> kernel code.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Both patches applied to for-4.9/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs

