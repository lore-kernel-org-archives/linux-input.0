From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: move HID_REPORT_TYPES closer to the
 report-definitions
Date: Wed, 4 Sep 2013 12:13:53 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1309041213450.3684@pobox.suse.cz>
References: <1378123205-4032-1-git-send-email-dh.herrmann@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48500 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756652Ab3IDKN4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 06:13:56 -0400
In-Reply-To: <1378123205-4032-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 2 Sep 2013, David Herrmann wrote:

> HID_REPORT_TYPES defines the number of available report-types. Move it
> closer to the actualy definition of the report-types so we can see the
> relation more clearly (and hopefully will never forget to update it).

Makes sense. Applied, thanks.

-- 
Jiri Kosina
SUSE Labs
