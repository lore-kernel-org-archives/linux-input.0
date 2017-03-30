From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Don't add ghost interface as shared data
Date: Thu, 30 Mar 2017 11:31:24 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1703301131100.31814@cbobk.fhfr.pm>
References: <1490808939-22398-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37883 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932265AbdC3Jb2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Mar 2017 05:31:28 -0400
In-Reply-To: <1490808939-22398-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, linux-kernel@vger.kernel.org, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

On Wed, 29 Mar 2017, Aaron Armstrong Skomra wrote:

> A previous commit (below) adds a check for already probed interfaces to
> Wacom's matching heuristic. Unfortunately this causes the Bamboo Pen
> (CTL-460) to match itself to its 'ghost' touch interface. After
> subsequent changes to the driver this match to the ghost causes the
> kernel to crash. This patch avoids calling wacom_add_shared_data()
> for the BAMBOO_PEN's ghost touch interface.
> 
> Fixes: 41372d5d40e7 ("HID: wacom: Augment 'oVid' and 'oPid' with heuristics for HID_GENERIC")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Applied to for-4.11/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

