From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [RFC v2 02/10] hid: set HID_MAX_FIELD at 128
Date: Thu, 6 Jan 2011 17:28:15 +0100
Message-ID: <20110106162815.GC1790@polaris.bitmath.org>
References: <1294248468-19979-1-git-send-email-benjamin.tissoires@enac.fr>
 <1294248468-19979-3-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57604 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751281Ab1AFQ2e (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Jan 2011 11:28:34 -0500
Content-Disposition: inline
In-Reply-To: <1294248468-19979-3-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 05, 2011 at 06:27:40PM +0100, Benjamin Tissoires wrote:
> Stantums multitouch panels sends more than 64 reports and this results
> in not being able to handle all the touches given by this device.
> 
> This patch is required to be able to include Stantum panels in the
> unified hid-multitouch driver.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>

This one could go in anytime, it seems.

Acked-by: Henrik Rydberg <rydberg@euromail.se>

Henrik
