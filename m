From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: make sensor autodetection independent of underlying
 bus
Date: Mon, 25 Feb 2013 13:43:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1302251342570.2128@pobox.suse.cz>
References: <51221AFD.1090108@ahsoftware.de> <1361265753-17541-1-git-send-email-mika.westerberg@linux.intel.com> <CAN+gG=GqPzvD89rno1btJKACDo6E0KTJR3_JW9dOMFqR8DaoYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46253 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756622Ab3BYMnJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Feb 2013 07:43:09 -0500
In-Reply-To: <CAN+gG=GqPzvD89rno1btJKACDo6E0KTJR3_JW9dOMFqR8DaoYg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, Alexander Holler <holler@ahsoftware.de>, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com

On Thu, 21 Feb 2013, Benjamin Tissoires wrote:

> > Instead of limiting HID sensors to USB and I2C busses we can just make
> > everything that has usage page of HID_UP_SENSOR to be included in
> > HID_GROUP_SENSOR_HUB group. This allows the sensor-hub to work over
> > bluetooth (and other transports) as well.
> >
> > Reported-by: Alexander Holler <holler@ahsoftware.de>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Reviewed-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied.

-- 
Jiri Kosina
SUSE Labs
