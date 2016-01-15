From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Fwd: ALPS v7 TrackStick detected wrongly
Date: Fri, 15 Jan 2016 12:42:53 +0100
Message-ID: <20160115114253.GX11560@pali>
References: <1452773083.4165.0@smtp.gmail.com>
 <20160114121118.GU11560@pali>
 <20160114200726.GW11560@pali>
 <1452857236.32706.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37102 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbcAOLm4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 06:42:56 -0500
Received: by mail-wm0-f46.google.com with SMTP id f206so20480785wmf.0
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 03:42:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452857236.32706.0@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin <madstitz@gmail.com>
Cc: linux-input@vger.kernel.org

On Friday 15 January 2016 12:27:16 Martin wrote:
> So I can't be sure if it even detects the trackstick, because it just
> creates the device anyway?

Yes, this is how alps driver for v7 protocol worked before my patch.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
