From: Jiri Kosina <jkosina@suse.cz>
Subject: RE: [PATCH 3/3] HID: hid-sensor-hub: Call hid_hw_close() before
 hid_hw_stop()
Date: Mon, 17 Sep 2012 12:58:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1209171257260.31149@pobox.suse.cz>
References: <1347573801.8974.2.camel@phoenix> <1347574001.8974.6.camel@phoenix> <4FA419E87744DF4DAECD5BCE1214B7A919D523B1@ORSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43117 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755620Ab2IQK6M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 06:58:12 -0400
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A919D523B1@ORSMSX108.amr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: Axel Lin <axel.lin@gmail.com>, Jonathan Cameron <jic23@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, 13 Sep 2012, Pandruvada, Srinivas wrote:

> I think you can merge this patch with your patch 2/3 as both are 
> addressing hid_hw_close and hid_hw_stop.

Agreed. In addition to that, I am fine with the changes. As this whole lot 
is going through Jonathan to Greg, I just add my

	Acked-by: Jiri Kosina <jkosina@suse.cz>

and let Jonathan take it. Thanks,

-- 
Jiri Kosina
SUSE Labs
