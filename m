From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: Changed keyreset to act as a wrapper for
 keycombo.
Date: Tue, 27 Oct 2015 19:04:46 -0700
Message-ID: <20151028020446.GC11237@localhost>
References: <1445934785-5659-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35406 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbJ1CEx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2015 22:04:53 -0400
Content-Disposition: inline
In-Reply-To: <1445934785-5659-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?B=E1lint?= Czobor <czoborbalint@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Daniel Rosenberg <drosen@google.com>

On Tue, Oct 27, 2015 at 09:33:05AM +0100, B=E1lint Czobor wrote:
> From: Daniel Rosenberg <drosen@google.com>
>=20
> keyreset now registers a keycombo driver that acts as the old
> keyreset driver acted.

There is no such driver in mainline kernel (and I do not think we shoul=
d
have it - userspace is probably better place for it).

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
