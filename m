From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] USB: HID: Fix fields from pen report ID being
 interpreted for multitouch.
Date: Wed, 8 Jul 2015 11:30:38 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507081130160.10183@pobox.suse.cz>
References: <1434732815-5172-1-git-send-email-brentadam@smarttech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:57604 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932932AbbGHJax (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Wed, 8 Jul 2015 05:30:53 -0400
In-Reply-To: <1434732815-5172-1-git-send-email-brentadam@smarttech.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brent Adam <brentadamdev@gmail.com>
Cc: benjamin.tissoires@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Brent Adam <brentadam@smarttech.com>

On Fri, 19 Jun 2015, Brent Adam wrote:

> Fields like HID_DG_CONTACTCOUNT are outside of the physical collection,
> but within the application collection and report ID.  Make sure to catch
> those fields that are not part of the mt_report_id and return 0 so they
> can be processed with the pen.  Otherwise, the wrong HID_DG_CONTACTCOUNT
> will be applied to cc_index and result in dereferencing a null pointer in
> mt_touch_report.
> 
> Signed-off-by: Brent Adam <brentadam@smarttech.com>

I am applying this to for-4.2/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs
