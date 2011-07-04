From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 03/12] Input: synaptics - fix minimum reported
 ABS_TOOL_WIDTH
Date: Mon, 4 Jul 2011 23:14:20 +0200
Message-ID: <20110704211420.GB23915@polaris.bitmath.org>
References: <1309324042-22943-1-git-send-email-djkurtz@chromium.org>
 <1309324042-22943-4-git-send-email-djkurtz@chromium.org>
 <BANLkTinX-mkjQ=qMXra5GLeMK+cb9w+9_Q@mail.gmail.com>
 <CAGS+omCXmc-4WXJDeQKY3uo8h7xBgqfZi=rmDHg2xwWK2OQxMg@mail.gmail.com>
 <BANLkTimuYi0UNjJG_mrHE+fF7UDgPSVwbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:60219 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab1GDVMb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 17:12:31 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimuYi0UNjJG_mrHE+fF7UDgPSVwbQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Daniel Kurtz <djkurtz@chromium.org>, dmitry.torokhov@gmail.com, chase.douglas@canonical.com, rubini@cvml.unipv.it, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, derek.foreman@collabora.co.uk, daniel.stone@collabora.co.uk, olofj@chromium.org

> > Yup, good catch. =A0I now see that this is true for the legacy sing=
le-touch case.
> > For consistency with the existing implementation, I'm ok to drop th=
is patch.

Thank you.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
