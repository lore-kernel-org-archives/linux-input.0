From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v3 7/7] input: wacom - add 0xE5 (MT device) support
Date: Mon, 20 Feb 2012 09:24:15 +0100
Message-ID: <20120220082415.GA6525@polaris.bitmath.org>
References: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:57975 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2BTIV3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Feb 2012 03:21:29 -0500
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 0AF3D14036
	for <linux-input@vger.kernel.org>; Mon, 20 Feb 2012 09:21:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1328997334-24140-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pingc@wacom.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Hi Chris,

The input_mt_report_slot_state should be used instead of directly
setting the tracking id. If the id reported by the hardware is not
bounded by some small number (so that it maps to slots), you will have
to keep the translation table in the driver.

Also, the commit message could need some love.

Thanks,
Henrik
