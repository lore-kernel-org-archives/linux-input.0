From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: remove use of DRIVER_LICENSE
Date: Fri, 6 Jan 2017 14:33:34 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701061433200.28985@cbobk.fhfr.pm>
References: <20170105190704.56654-1-grundler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48619 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752602AbdAFNe2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 6 Jan 2017 08:34:28 -0500
In-Reply-To: <20170105190704.56654-1-grundler@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dtor@chromium.org>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-usb <linux-usb@vger.kernel.org>, Grant Grundler <grundler@google.com>

On Thu, 5 Jan 2017, Grant Grundler wrote:

> Local "#define DRIVER_LICENSE" obfuscates which license is used
> in MODULE_LICENSE().  "fgrep -R MODULE_LICENSE" is more informative
> when the string is hard coded in MODULE_LICENSE.

Applied to hid.git#for-4.11/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

