From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v4 00/14] Win 8 support for digitizers
Date: Wed, 14 Nov 2012 21:01:41 +0100
Message-ID: <20121114200141.GA15074@polaris.bitmath.org>
References: <1352908766-4492-1-git-send-email-benjamin.tissoires@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b31.telenor.se ([213.150.131.20]:43035 "EHLO
	smtprelay-b31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab2KNTzO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Nov 2012 14:55:14 -0500
Content-Disposition: inline
In-Reply-To: <1352908766-4492-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> * patches 1-9 has already been reviewed and are ready for inclusion I would say.
> * Jiri, I kept your ack on patch 4 even if I changed the place of the comment in hid.h
> * patch 10 is half new as it is splitted from a patch of the v3
> * patch 11 has been changed according to Henrik's comments
> * patches 12-13 have been splitted since v3 to introduce QUIRK_HOVERING and setup WIN 8
> devices in a better way.
> * patch 14 has been copied from the v3 as Dmitry wanted to use a MSC event for the timestamp.

Everything but the last patch looks good now, me thinks. Thanks!

Henrik
