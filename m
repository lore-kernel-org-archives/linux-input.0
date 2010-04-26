From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: fix picolcd's version parsing
Date: Mon, 26 Apr 2010 11:44:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1004261144170.7579@pobox.suse.cz>
References: <20100425213140.371194b0@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55690 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312Ab0DZJob (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Apr 2010 05:44:31 -0400
In-Reply-To: <20100425213140.371194b0@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, 25 Apr 2010, Bruno Pr=C3=A9mont wrote:

> During grouping of version checking code bootloader mode's version
> bytes got swapped. Fix their order.

Applied, thanks Bruno.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
