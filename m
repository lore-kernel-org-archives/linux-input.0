From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 07/12] HID: hid-lg4ff: Protect concurrent access to the
 output HID report values with a spinlock.
Date: Tue, 31 Mar 2015 16:44:17 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1503311642070.21441@pobox.suse.cz>
References: <1426938462-884-1-git-send-email-madcatxster@devoid-pointer.net> <1426938462-884-8-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48918 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbbCaOoS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 10:44:18 -0400
In-Reply-To: <1426938462-884-8-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org

On Sat, 21 Mar 2015, Michal Mal=C3=BD wrote:

> Since all functions that need to send some data to the device they
> manage share the same HID report some synchronization is needed to
> prevent sending bogus data to the device.

This patch is doing much more than just adding a mutual exclusion=20
mechanisms (for example the wdata indirection), so more descriptive=20
changelog is needed.

Looking at the patch it's actually not clear at all what are all the=20
things it's trying to do, so please resend v2 of this patch with much m=
ore=20
verbose changelog, so that I am able to review it properly. Thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
