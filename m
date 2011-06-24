From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/3] hid-multitouch: corrections for 3.0-rc4
Date: Fri, 24 Jun 2011 13:42:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106241341220.11049@pobox.suse.cz>
References: <1308661315-6240-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56007 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab1FXLml (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2011 07:42:41 -0400
In-Reply-To: <1308661315-6240-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 21 Jun 2011, Benjamin Tissoires wrote:

> This is a set of patches for 3.0:
> - the first (ensure slots are initialized) corrects a bug with some 
> Ilitek panels not working properly
> - the second (correct VID for Stantum) corrects a mistake in the merge 
> of hid-stantum
> - the last one is a new PID for Lumio products (not a bug, but as new 
> PID are accepted in the stable branch, I thought we can make it there)

Hi Benjamin,

thanks for the fixes. I have now applied them and will be pushing them to 
Linus over weekend or on monday.

-- 
Jiri Kosina
SUSE Labs
