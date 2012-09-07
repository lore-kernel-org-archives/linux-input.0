From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Re: [PATCH 2/2] HID: waltop: Remove waltop_probe() and
 waltop_remove() functions
Date: Fri, 7 Sep 2012 10:29:06 +0300
Message-ID: <CALu8Fe83G0ojtB44eLbGF2kqiv45ZmwSBvSSisgR-_rcKc9e5w@mail.gmail.com>
References: <1347001910.30222.1.camel@phoenix>
	<1347002004.30222.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:47993 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab2IGH3H (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Sep 2012 03:29:07 -0400
Received: by qaas11 with SMTP id s11so1925707qaa.19
        for <linux-input@vger.kernel.org>; Fri, 07 Sep 2012 00:29:06 -0700 (PDT)
In-Reply-To: <1347002004.30222.3.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Fri, Sep 7, 2012 at 10:13 AM, Axel Lin <axel.lin@gmail.com> wrote:
> The waltop_probe() and waltop_remove() functions do not have any special
> initialization and cleanup. Remove them and let HID core handle the default
> probe/remove actions.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>

Thanks, Axel.

Sincerely,
Nick
