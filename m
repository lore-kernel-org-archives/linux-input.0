From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/2] hid: corsair: Driver simplification and new supported
 device
Date: Tue, 29 Mar 2016 15:52:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1603291552300.3656@cbobk.fhfr.pm>
References: <cover.1458744569.git.clement.vuchener@gmail.com> <alpine.LNX.2.00.1603241527510.3656@cbobk.fhfr.pm> <CAM4jgCp5yPeRXHukGBLKYXOJev2VbrW5H4dREb_u=AX9vER_Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44814 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756137AbcC2NxA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 09:53:00 -0400
In-Reply-To: <CAM4jgCp5yPeRXHukGBLKYXOJev2VbrW5H4dREb_u=AX9vER_Tg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Cl=E9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

On Thu, 24 Mar 2016, Cl=C3=A9ment VUCHENER wrote:

> Thanks for the tip, is it possible to ignore some usages with this=20
> method (done in the default case)?

mapping to 0xff is a bit hackish way to achieve this.

--=20
Jiri Kosina
SUSE Labs

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
