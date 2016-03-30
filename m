From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: How to setup Touchscreen IRQ mode?
Date: Wed, 30 Mar 2016 14:03:04 +0300
Message-ID: <20160330110304.GR2099@lahna.fi.intel.com>
References: <56EF459E.8000808@gmail.com>
 <CA+V1Lzph-W2eXhp22_jjObeu-ywzO===9EYWkKccuGuvdJDYRg@mail.gmail.com>
 <20160329095244.GI2099@lahna.fi.intel.com>
 <CA+V1LzqzMyxoAQv=DDFvWr_MOTThVnhJwTt8uS_piwVhGJtWgQ@mail.gmail.com>
 <20160329125642.GM2099@lahna.fi.intel.com>
 <CA+V1Lzov4WXXjERAwAV03VdMEQKDC_=ADAgr2-0p-k=gYC8i3w@mail.gmail.com>
 <20160329133307.GO2099@lahna.fi.intel.com>
 <CA+V1LzqP+tzQ9b8=6xu9vjgYqM93zQXfJe5sUoYEArgzv+A5fw@mail.gmail.com>
 <20160330094159.GQ2099@lahna.fi.intel.com>
 <CA+V1Lzpkpy4i-t-=C8nSK0T_3cP56CXd0ACmLso-3JbgC0Pt-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53877 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbcC3LDM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Mar 2016 07:03:12 -0400
Content-Disposition: inline
In-Reply-To: <CA+V1Lzpkpy4i-t-=C8nSK0T_3cP56CXd0ACmLso-3JbgC0Pt-Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, Gregor Riepl <onitake@gmail.com>

On Wed, Mar 30, 2016 at 10:28:14AM +0000, sergk sergk2mail wrote:
> "This should create new i2c device for i2c-hid.c."
> Ok - provided code registered platform device, looks like hid device
> and what will be next then? where and how will be setuped irq mode for
> touchscreen? the problem was from the begining - I could not setup irq
> for this touch due absence of gpio or the way of puting it into irq
> mode.

It will create an I2C device for you with the ->irq assigned so
i2c-hid.c should be happy. At least worth a try.

It may be that the interrupt number needs to be passed through
acpi_register_gsi() if it does not work.
