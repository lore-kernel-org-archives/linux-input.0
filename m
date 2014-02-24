From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH v2 0/5] HID: sony: Various fixes and improvements for the
 Sony driver
Date: Mon, 24 Feb 2014 11:25:08 +0100
Message-ID: <CANq1E4T+Mgzi4OJicRAE+Cjzz9eozNLVgvSP3C7V+5jYxkMYBw@mail.gmail.com>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57765 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaBXKZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Feb 2014 05:25:10 -0500
Received: by mail-ie0-f172.google.com with SMTP id rd18so3320499iec.3
        for <linux-input@vger.kernel.org>; Mon, 24 Feb 2014 02:25:08 -0800 (PST)
In-Reply-To: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>

Hi

On Thu, Feb 20, 2014 at 5:35 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> v2 of this patch set addresses the code review issues raised in v1 as well as
> adding a patch that fixes the styling of multi-line comments to conform to
> kernel coding standards, adds a check to protect against a potential
> out-of-bounds read in the Sixaxis battery code and adds a note in hidp/core.c
> that a device module now depends on the current behavior of the uniq string.

Besides some minor comments, the series looks good to me:

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David
