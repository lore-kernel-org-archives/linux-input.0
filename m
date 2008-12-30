From: Dmitry Torokhov <dtor@mail.ru>
Subject: Re: [PATCH] Input: atkbd - broaden the Dell DMI signatures
Date: Mon, 29 Dec 2008 20:15:33 -0800
Message-ID: <200812292015.34296.dtor@mail.ru>
References: <20081111074702.75e71055@sauron.linicks.net> <20081229113621.1a64caea@sauron.linicks.net> <20081229142902.GC31266@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:57177 "EHLO
	QMTA07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751718AbYL3EQA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Dec 2008 23:16:00 -0500
In-Reply-To: <20081229142902.GC31266@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Nick Warne <nick@ukfsn.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Monday 29 December 2008 06:29:02 Matthew Garrett wrote:
> Some Dells need the dell input quirk applied but have a different vendor
> string in their DMI tables. Add an extra entry to cover these machines as
> well.
>
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
> ---
>
> Dmitry, any chance of getting this queued for .29? Probably suitable for
> -stable as well.

Yep, will send with the rest of stuff for .29. Thank you Matthew.

-- 
Dmitry
