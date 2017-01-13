From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] HID: corsair: fix DMA to stack and info leaks
Date: Fri, 13 Jan 2017 12:07:30 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701131202030.25515@cbobk.fhfr.pm>
References: <20170112171743.5972-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52737 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751373AbdAMLHd (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Jan 2017 06:07:33 -0500
In-Reply-To: <20170112171743.5972-1-johan@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?ISO-8859-15?Q?Cl=E9ment_Vuchener?= <clement.vuchener@gmail.com>

On Thu, 12 Jan 2017, Johan Hovold wrote:

> These patches fix DMA buffers on stack and information leaks in the
> corsair HID driver.
> 
> Note that this series has only been compile tested.

Adding Clément to CC, and applying to for-4.10/upstream-fixes branch.

Thanks!

-- 
Jiri Kosina
SUSE Labs

