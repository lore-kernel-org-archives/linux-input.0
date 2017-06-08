From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: apple: Use country code to detect ISO
 keyboards
Date: Thu, 8 Jun 2017 14:03:14 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706081402540.30709@cbobk.fhfr.pm>
References: <20170602152839.7810-1-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750822AbdFHMDS (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 8 Jun 2017 08:03:18 -0400
In-Reply-To: <20170602152839.7810-1-alexhenrie24@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: benjamin.tissoires@redhat.com, jirislaby@gmail.com, stefan@glasen-hardt.de, ryan@finnie.org, morbidrsa@gmail.com, dan@pwienterprises.com, andreas.krist@gmail.com, rydberg@bitmath.org, lukas@wunner.de, linux-input@vger.kernel.org

On Fri, 2 Jun 2017, Alex Henrie wrote:

> At least on newer laptops, Apple uses the same USB ID for both ISO and
> ANSI keyboards. However, they have been good about filling in the
> bCountryCode field in the HID descriptor on all of their keyboards. A
> value of 13 indicates an ISO layout and other values indicate various
> country-specific ANSI layouts.
> 
> With this patch, users of Apple US keyboards will no longer have to run
> `echo 0 > /sys/module/hid_apple/parameters/iso_layout` to get a working
> tilde key.
> 
> Please test this patch and send feedback if you have a Macbook or an
> Apple keyboard.
> 
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>

Applied to for-4.13/apple. Thanks,

-- 
Jiri Kosina
SUSE Labs

