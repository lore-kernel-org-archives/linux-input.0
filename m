From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: Remove Jabra speakerphone devices from ignore
 list
Date: Wed, 13 Sep 2017 10:11:33 -0700 (PDT)
Message-ID: <nycvar.YFH.7.76.1709131009350.4703@jbgna.fhfr.qr>
References: <CAP_ceTxM-Rgz=i6Zy_iBOa1Cs5D=5Hi0BgWzQKmXoWmL_9TBWA@mail.gmail.com> <VI1PR0701MB2991A0071AE574E241AD37D6DA680@VI1PR0701MB2991.eurprd07.prod.outlook.com> <CAP_ceTz-9vYpo1xqUnEF=LtWcGhxx5FiTo7xJwLreL5vYx7xww@mail.gmail.com>
 <VI1PR0701MB299142D55AF9734A4BC5CADADA690@VI1PR0701MB2991.eurprd07.prod.outlook.com> <CAP_ceTzwOgA6e2gO2fc8vzps4mUJkxC=LzoGEACHcLKkoygXpA@mail.gmail.com> <20170913170238.GB13863@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751054AbdIMRLf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 13 Sep 2017 13:11:35 -0400
In-Reply-To: <20170913170238.GB13863@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Cc: Vincent Palatin <vpalatin@chromium.org>, Niels Skou Olsen <nolsen@jabra.com>, Richard Hughes <richard@hughsie.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "mnilsson@chromium.org" <mnilsson@chromium.org>

On Wed, 13 Sep 2017, benjamin.tissoires@redhat.com wrote:

> I do not see a reason not to. Maybe Jiri will, but the fact that one
> version works and one doesn't seem enough to allow such specific
> blacklisting.

The blacklist matching currently doesn't support that, but it'd be trivial 
to match, and I actually think it generally makes sense to me. So feel 
free (once you guys settle on solution that both Chromium and Jabr folk 
find acceptable) to send this together with a hid-core patch that'd add a 
possibility to perform per-fw-version matching.

Thanks,

-- 
Jiri Kosina
SUSE Labs

