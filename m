From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 0/2] hid-mosart: small patches
Date: Mon, 13 Dec 2010 19:52:23 +0100
Message-ID: <4D066B67.9010701@euromail.se>
References: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:48069 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753988Ab0LMSwx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 13:52:53 -0500
In-Reply-To: <1292252353-3029-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org

Benjamin,

Thanks for the patches, I will comment them separately.

> Just a few patch before introducing hid-multitouch. It would be great if

> this could be in 2.6.38 (or even before...) as hid-multitouch is a bit late.


The first patch looks like 2.6.37 material. I know both patches have been tested
for quite some time.

> Henrik, I think that you added a device in your ppa.

> Do you want me to send it?


Yes, please do. There is a hid-core change to go with it as well.

Jiri, I assume these will eventually go through your tree.

Thanks,
Henrik
