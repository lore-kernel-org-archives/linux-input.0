From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] HID: Add support for Macbook Pro 8 keyboards and sort
 entries.
Date: Fri, 28 Oct 2011 14:53:22 +0200
Message-ID: <20111028125322.GA3461@polaris.bitmath.org>
References: <20111022120426.GA2281@polaris.bitmath.org>
 <1319312346-2676-1-git-send-email-gokcen@pardus.org.tr>
 <4EAA39FA.8040006@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:58607 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755661Ab1J1Mog (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 08:44:36 -0400
Received: from iph5.telenor.se (iph5.telenor.se [195.54.127.136])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id A32A9DE6E
	for <linux-input@vger.kernel.org>; Fri, 28 Oct 2011 14:44:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4EAA39FA.8040006@pardus.org.tr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?B?R/Zr52Vu?= Eraslan <gokcen@pardus.org.tr>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Fri, Oct 28, 2011 at 08:13:30AM +0300, G=F6k=E7en Eraslan wrote:
> G=F6k=E7en Eraslan wrote On 10/22/2011 10:39 PM:
> > This patch adds keyboard support for Macbook Pro 8 models which has
> > WELLSPRING5A model name and 0x0252, 0x0253 and 0x0254 USB IDs. Trac=
kpad
> > support for those models are added to bcm5974 in
> > c331eb580a0a7906c0cdb8dbae3cfe99e3c0e555.
> >=20
>=20
> Any feedback on that?

Your patch does not address previous comments and contains bogus
duplicates. Please double-check before sending again.

Thanks.
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
