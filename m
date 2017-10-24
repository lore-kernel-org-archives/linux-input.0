From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS
 version 3
Date: Tue, 24 Oct 2017 11:19:24 -0700
Message-ID: <20171024181924.ib3oybrxdq42h5f3@dtor-ws>
References: <20171006140630.6398-1-yiannis.marangos@gmail.com>
 <20171006140630.6398-2-yiannis.marangos@gmail.com>
 <20171010175707.xtdgimmnju7cjlom@dystopia.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44458 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751817AbdJXST3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 24 Oct 2017 14:19:29 -0400
Received: by mail-oi0-f67.google.com with SMTP id v132so38901251oie.1
        for <linux-input@vger.kernel.org>; Tue, 24 Oct 2017 11:19:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171010175707.xtdgimmnju7cjlom@dystopia.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
Cc: linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, aduggan@synaptics.com

On Tue, Oct 10, 2017 at 09:04:20PM +0300, Yiannis Marangos wrote:
> Hi guys,
> 
> As I understand the second part of the patchset will take a while until it get
> merged. Is it possible to merge the first part only? Without this, LEN0073 users
> can not use psmouse.synaptics_intertouch=1 as a workaround. LEN0073 is not
> usable at all unless users patch the kernel manually.

Benjamin, Andrew, any comments/objections on expanding the acceptable
version range?

Thanks.

-- 
Dmitry
