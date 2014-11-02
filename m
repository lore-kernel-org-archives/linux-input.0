From: Luis Henriques <luis.henriques@canonical.com>
Subject: Re: [PATCH v2] Input: i8042 - add mux quirk for HP EliteBook
Date: Sun, 2 Nov 2014 15:42:41 +0000
Message-ID: <20141102154241.GA5273@hercules>
References: <1414535232-4780-1-git-send-email-luis.henriques@canonical.com>
 <20141028230841.GB19675@dtor-ws>
 <20141101025737.GA20884@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:59709 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaKBPmo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Nov 2014 10:42:44 -0500
Content-Disposition: inline
In-Reply-To: <20141101025737.GA20884@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Oct 31, 2014 at 07:57:37PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 28, 2014 at 04:08:41PM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 28, 2014 at 10:27:12PM +0000, Luis Henriques wrote:
> > > This laptop requires active multiplexing to be enabled in order t=
o be able
> > > to separate the PS/2 mouse and the touchpad.
> > >=20
> > > Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
> >=20
> > Applied, thank you.
>=20
> Actually I am reverting the nomux patch, so unapplied ;)

That works for me as well :-)  Thanks!

Cheers,
--
Lu=EDs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
