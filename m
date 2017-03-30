From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Bamboo One Medium does not have touch
Date: Thu, 30 Mar 2017 11:32:05 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1703301131570.31814@cbobk.fhfr.pm>
References: <1490818056-9841-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37938 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932265AbdC3JcH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Mar 2017 05:32:07 -0400
In-Reply-To: <1490818056-9841-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

On Wed, 29 Mar 2017, Aaron Armstrong Skomra wrote:

> Commit 3b164a00a9fc ("HID: wacom: Cleanup unsupported device_type
> for BAMBOO_PT") cleaned up Bamboo devices which our driver falsely
> claimed had touch. Bamboo One Medium also does not have touch.
> 
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Applied to for-4.12/wacom. Thanks,

-- 
Jiri Kosina
SUSE Labs

