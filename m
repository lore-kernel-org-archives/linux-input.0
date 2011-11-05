From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH]  Input: add newer HP Pavilion dv4s to 'notimeout' and
 'nomux' blacklists
Date: Fri, 4 Nov 2011 23:58:46 -0700
Message-ID: <20111105065846.GC31111@core.coreip.homeip.net>
References: <1536567.07NNFmgTxM@hp-tmm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49414 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1KEG6v (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Nov 2011 02:58:51 -0400
Received: by ggnb2 with SMTP id b2so3279334ggn.19
        for <linux-input@vger.kernel.org>; Fri, 04 Nov 2011 23:58:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1536567.07NNFmgTxM@hp-tmm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomas =?utf-8?Q?Miljenovi=C4=87?= <TomasM@tomasm.tk>
Cc: linux-input@vger.kernel.org

On Thu, Nov 03, 2011 at 12:37:26PM +1000, Tomas Miljenovi=C4=87 wrote:
> Touchpad input doesn't work with newer HP Pavilion dv4 laptops due to=
 bad i8042
> timeout data.  Booting with i8042.notimeout and i8042.nomux successfu=
lly works
> around the problem.
>=20
> This patch adds the devices to the i8042 notimeout and nomux blacklis=
ts.
>=20

Applied, thanks Tomas.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
