From: Yiannis Marangos <yiannis.marangos@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: synaptics-rmi4 - RMI4 can also use SMBUS
 version 3
Date: Tue, 10 Oct 2017 21:04:20 +0300
Message-ID: <20171010175707.xtdgimmnju7cjlom@dystopia.localdomain>
References: <20171006140630.6398-1-yiannis.marangos@gmail.com>
 <20171006140630.6398-2-yiannis.marangos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55201 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755818AbdJJSEA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Oct 2017 14:04:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id i124so7666419wmf.3
        for <linux-input@vger.kernel.org>; Tue, 10 Oct 2017 11:03:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171006140630.6398-2-yiannis.marangos@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, aduggan@synaptics.com

Hi guys,

As I understand the second part of the patchset will take a while until it get
merged. Is it possible to merge the first part only? Without this, LEN0073 users
can not use psmouse.synaptics_intertouch=1 as a workaround. LEN0073 is not
usable at all unless users patch the kernel manually.

Other options are:

1) Add a kernel flag and if is set to 1 then the version check will be bypassed.
2) Remove the version check completely.

Any suggestions/comments?

Cheers,
Yiannis.
