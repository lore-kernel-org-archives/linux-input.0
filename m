From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Reported key not released
Date: Mon, 24 Nov 2014 20:04:33 +0000
Message-ID: <20141124200433.GA3459@srcf.ucam.org>
References: <201411231413.30076@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35855 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbaKXUEj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Nov 2014 15:04:39 -0500
Content-Disposition: inline
In-Reply-To: <201411231413.30076@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, Alex Hung <alex.hung@canonical.com>

On Sun, Nov 23, 2014 at 02:13:30PM +0100, Pali Roh=E1r wrote:

> When I enable or disable this switch it correctly enable or=20
> disable devices (and also hard rfkill status is set correctly).

If the switch changes the rfkill state, you shouldn't be emitting any=20
presses - the rfkill state change will notify userspace. Consume the=20
event in the filter and don't pass it through.

--=20
Matthew Garrett | mjg59@srcf.ucam.org
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
