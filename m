From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] hid-multitouch: fix broken eGalax
Date: Sun, 12 Jun 2011 17:29:15 +0200
Message-ID: <20110612152915.GA18794@polaris.bitmath.org>
References: <1307859728-3446-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:44708 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1FLPWW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2011 11:22:22 -0400
Content-Disposition: inline
In-Reply-To: <1307859728-3446-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> With this patch, the detection is made only when the field ContactID
> has been detected inside the collection.

The patch introduces an order dependence by relying on ContactID
occuring early on, which seems unnecessary. How about checking for the
presence of ContactID instead, and simply modify the logic which uses
last_field_index and last_slot_field?

Thanks,
Henrik
