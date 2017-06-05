From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 00/19] Report power supply from hid-logitech-hidpp
Date: Mon, 5 Jun 2017 07:53:07 -0700
Message-ID: <0e394f8a-3663-ba4d-f417-e829e10e7356@intel.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
 <0cdc8dda-de3f-c3d0-07da-65612860a70f@intel.com>
 <1496345185.2570.3.camel@hadess.net>
 <20170602072907.GK1293@mail.corp.redhat.com>
 <02006322-6be2-f169-497e-06fc010a4bdb@intel.com>
 <alpine.LSU.2.20.1706050959500.30709@cbobk.fhfr.pm>
 <1496668174.2570.33.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:39813 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdFEOxJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Jun 2017 10:53:09 -0400
In-Reply-To: <1496668174.2570.33.camel@hadess.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/05/2017 06:09 AM, Bastien Nocera wrote:
>> I agree with Dave. If there is no solution found in time for -rc5, 
>> reverting to previous state would be the proper way to go.
> I don't see how it's possible to retroactively fix user-space.

It's not possible to retroactively change userspace.  That why the
kernel tries so hard not to break it in the first place.  Although this
is in "minor annoyance" territory for me at the moment, this patch
causes a clear, user-visible issue with new kernels.

The right way to do this is to have the kernel export the data in a way
that does not confuse old userspace.  Perhaps we should separate out
"power supplies that run the system" from "power supplies in a perihperal".

And, no, a config option isn't the right thing either.
