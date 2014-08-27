From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [BUG] hid-multitouch ignores all event after recent patch in
 3.17-rc1 to input_mt_sync_frame()
Date: Wed, 27 Aug 2014 08:20:28 +0200
Message-ID: <53FD78AC.6060006@euromail.se>
References: <CA+BWVURnxeQUJnDDhO=q=67sCK2NGq7_W=8wAN5qDjTKk14yAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:34743 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbaH0GnH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Aug 2014 02:43:07 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 72EE284090
	for <linux-input@vger.kernel.org>; Wed, 27 Aug 2014 08:17:54 +0200 (CEST)
In-Reply-To: <CA+BWVURnxeQUJnDDhO=q=67sCK2NGq7_W=8wAN5qDjTKk14yAg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>, bleung@chromium.org, dmitry.torokhov@gmail.com, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input <linux-input@vger.kernel.org>

> What would be the best way to solve this, is it ok to simply re add that line?

Not quite, but put an "else" in front and it is ok. A patch to that effect is
already on its way to Linus, so you will soon be able to cherry-pick it.

Thanks,
Henrik

