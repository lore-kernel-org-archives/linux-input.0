From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: add two missing usages for digitizer
Date: Thu, 30 Mar 2017 11:07:16 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1703301107060.31814@cbobk.fhfr.pm>
References: <e974c5f4-1c4a-4c24-2874-af6cc40514a2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932191AbdC3JHX (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 30 Mar 2017 05:07:23 -0400
In-Reply-To: <e974c5f4-1c4a-4c24-2874-af6cc40514a2@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Xiaolei Yu <dreifachstein@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org

On Sat, 25 Mar 2017, Xiaolei Yu wrote:

> They are part of HUTRR34 for multi-touch digitizers:
> 
> 0x0E    Device configuration    CA      16.7
> 0x23    Device settings         CL      16.7
> 
> Signed-off-by: Xiaolei Yu <dreifachstein@gmail.com>

Applied to for-4.12/upstream. Thanks,

-- 
Jiri Kosina
SUSE Labs

