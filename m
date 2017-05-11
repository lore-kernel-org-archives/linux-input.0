From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2.3] HID: hid-elecom: extend to fix the descriptor for
 DEFT trackballs.
Date: Thu, 11 May 2017 10:50:16 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705111050030.26873@cbobk.fhfr.pm>
References: <alpine.LSU.2.20.1704261030230.12121@cbobk.fhfr.pm> <20170426163704.26184-1-flameeyes@flameeyes.eu> <20170426163704.26184-2-flameeyes@flameeyes.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932084AbdEKIuT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 11 May 2017 04:50:19 -0400
In-Reply-To: <20170426163704.26184-2-flameeyes@flameeyes.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Diego_Elio_Petten=F2?= <flameeyes@flameeyes.eu>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Yuxuan Shui <yshuiv7@gmail.com>

On Wed, 26 Apr 2017, Diego Elio Pettenò wrote:

> The ELECOM DEFT trackballs report only five buttons, when the device
> actually has 8. Change the descriptor so that the HID driver can see all of
> them.

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

