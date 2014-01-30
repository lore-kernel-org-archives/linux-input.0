From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] HID: i2c-hid: add runtime PM support
Date: Thu, 30 Jan 2014 13:41:31 +0200
Message-ID: <20140130114131.GV18029@intel.com>
References: <1389694438-18614-1-git-send-email-mika.westerberg@linux.intel.com>
 <CAN+gG=Fa+H53V1evKXiWK6OpWj29pF4z8rGJAXWs3C7mHm1mLQ@mail.gmail.com>
 <20140128091258.GY18029@intel.com>
 <CAN+gG=GPHyWdM+G=dzswfqVT4Jm8kEbnQs58jq2M_7_-FVB0=w@mail.gmail.com>
 <20140129091313.GK18029@intel.com>
 <CAN+gG=HoPBBkM7v88y-K=q7mkMET-2dn2YcSN6zWi50cLnBqVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15043 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbaA3Le1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 06:34:27 -0500
Content-Disposition: inline
In-Reply-To: <CAN+gG=HoPBBkM7v88y-K=q7mkMET-2dn2YcSN6zWi50cLnBqVA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Jan 29, 2014 at 09:57:00AM -0500, Benjamin Tissoires wrote:
> That's great. I hope this will also fix my Lenovo Miix 2 (the T100 is
> too expensive compared to the Dell Venue pro 8 and the Lenovo one) :)
> I think most of my problems are ACPI related (WIFI card not powered
> up, SD-ext reader not working, suspend/resume not there, etc...), so I
> expect great of you :)

Yeah, those devices use some ACPI features that are not well supported in
Linux. Most notably GPIO/Serialbus operation regions are currently not
supported at all. We are in progress of writing support for them.
