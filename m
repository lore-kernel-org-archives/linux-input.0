From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: Re: [PATCH] drivers:input:free the memory before set it to NULL
Date: Thu, 21 Jul 2011 00:08:21 +0800
Message-ID: <1311178101.10111.1.camel@Tux>
References: <1311176496-10026-1-git-send-email-wanlong.gao@gmail.com>
	 <20110720165454.1e67a91f@lxorguk.ukuu.org.uk>
Reply-To: wanlong.gao@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43477 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab1GTQI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 12:08:27 -0400
Received: by iyb12 with SMTP id 12so313370iyb.19
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 09:08:27 -0700 (PDT)
In-Reply-To: <20110720165454.1e67a91f@lxorguk.ukuu.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>

On =E4=B8=89, 2011-07-20 at 16:54 +0100, Alan Cox wrote:
> On Wed, 20 Jul 2011 23:41:36 +0800
> Wanlong Gao <wanlong.gao@gmail.com> wrote:
>=20
> > The memory of the platform driver data should be freed
> > before it was set to NULL.
>=20
> This seems backwards to me. Currently the reference is invalidated be=
fore
> the object, which seems to make more sense.
>=20
> As there is no locking here it really makes no difference anyway
Hmm...
=46YI, I see it. Thanks Alan.
And sorry for making noise.

Wanlong Gao
>=20
> >=20


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
