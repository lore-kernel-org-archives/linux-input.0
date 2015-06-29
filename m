From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v2] HID: microsoft: Add quirk for MS Surface Type/Touch
 cover
Date: Mon, 29 Jun 2015 14:30:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1506291430040.10183@pobox.suse.cz>
References: <1435537357-2771-1-git-send-email-reyad.attiyat@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:54207 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbbF2Mau (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Mon, 29 Jun 2015 08:30:50 -0400
In-Reply-To: <1435537357-2771-1-git-send-email-reyad.attiyat@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 28 Jun 2015, Reyad Attiyat wrote:

> The newer firmware on MS Surface 2 tablets causes the type and touch cover keyboards to timeout when waiting for reports.
> The quirk HID_QUIRK_NO_INIT_REPORTS allows them to function normally.
> 
> Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>

Applied to for-4.2/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs
