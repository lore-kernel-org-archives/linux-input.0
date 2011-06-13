From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: roccat: Correction and cleanup of hid feature
 reports
Date: Mon, 13 Jun 2011 12:55:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1106131255490.22872@pobox.suse.cz>
References: <1306936457.2486.7.camel@neuromancer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53455 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab1FMKz4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jun 2011 06:55:56 -0400
In-Reply-To: <1306936457.2486.7.camel@neuromancer>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Achatz <erazor_de@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 1 Jun 2011, Stefan Achatz wrote:

> Removed analog feature report enums and modified code in roccat_common
> to reflect this. Non standard conform Kone got its own copy of the old
> code. That helps extracting more generalizations for newer devices.

Applied.

-- 
Jiri Kosina
SUSE Labs
