From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] hid: corsair: Driver simplification and new supported
 device
Date: Thu, 24 Mar 2016 15:42:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1603241540110.3656@cbobk.fhfr.pm>
References: <cover.1458744569.git.clement.vuchener@gmail.com> <20160324143750.GA7602@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44757 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147AbcCXOma (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Mar 2016 10:42:30 -0400
In-Reply-To: <20160324143750.GA7602@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20Vuchener?= <clement.vuchener@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, 24 Mar 2016, Benjamin Tissoires wrote:

> I would say you can not do this this way. Even if you believe you are the
> only user of the API, there might be someone who uses it, and you will end
> up breaking his keyboard.
> 
> Jiri will correct me, but the proper way to follow is to mark the API as
> deprecated, make sure your driver uses the deprecated API only for the
> K40, and then add the K90 in the driver, without implementing the API.
> 
> After a few months (years?) with your API marked as deprecated, you then
> will be able to remove it. This is one of the many reasons we wrote
> libratbag in pure user-space, to avoid having to maintain complex API in
> the kernel forever.

You are right that this is the right way to deprecate the API.

Fortunately this one is "officially" marked as testing, so we might be a 
little bit more relaxed, but still we'd really need to take care not to 
break users left and right.

That's why I first asked whether also the remapping shouldn't be moved to 
userspace, to make sure that we eventuall start the depreciation of as 
many features as possible at the same time.

Thanks,

-- 
Jiri Kosina
SUSE Labs

