From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: alps: fix stick device not working after resume
Date: Thu, 22 Sep 2016 11:08:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1609221108160.22028@cbobk.fhfr.pm>
References: <20160919074139.2551-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752591AbcIVJIb (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Sep 2016 05:08:31 -0400
In-Reply-To: <20160919074139.2551-1-kai.heng.feng@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

On Mon, 19 Sep 2016, Kai-Heng Feng wrote:

> The stick device does not work after resume, add U1_SP_ABS_MODE flag can
> make the device work after resume.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied with ammended changelog. Thanks,

-- 
Jiri Kosina
SUSE Labs

