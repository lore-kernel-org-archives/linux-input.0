From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 01/12 v2] HID: wiimote: Add Nintendo Wii Remote driver stub
Date: Mon, 27 Jun 2011 16:29:00 +0200
Message-ID: <BANLkTin6BVHDYdYJi4u0pO_b7zu6fSw0jA@mail.gmail.com>
References: <1308322162-13953-1-git-send-email-dh.herrmann@googlemail.com>
	<alpine.LNX.2.00.1106241414000.11049@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36980 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab1F0O3B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jun 2011 10:29:01 -0400
Received: by vws1 with SMTP id 1so3335201vws.19
        for <linux-input@vger.kernel.org>; Mon, 27 Jun 2011 07:29:01 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1106241414000.11049@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, oliver@neukum.org

On Fri, Jun 24, 2011 at 2:14 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> The only thing I'd like to ask you -- could you please put a comment into
> the code preceeding all the barrier operations, so that it's clear why
> they have to be there?

I have simplified the locking logic in my new patch series and reduced
the memory-barriers. I've added some inline comments and extended the
commit-messages. I hope all locks are fine now.

> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs

Thanks for your time
David
